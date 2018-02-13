Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:24545
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966002AbeBMXGu (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 13 Feb 2018 18:06:50 -0500
Subject: Re: [PATCH] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180212185915.25041-1-david.daney@cavium.com>
 <CAHp75VeMhKvv0SdMgy+ZdLcK7+aOTyKweg9VKOTYcb84vsn+NA@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <9df50a4c-c73f-e66a-d5ed-ab381d743c32@caviumnetworks.com>
Date: Tue, 13 Feb 2018 15:06:46 -0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VeMhKvv0SdMgy+ZdLcK7+aOTyKweg9VKOTYcb84vsn+NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/13/2018 07:54 AM, Andy Shevchenko wrote:
[...]
>> diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
>> new file mode 100644
>> index 000000000000..a5f04e0faceb
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-isl12026.c
>> @@ -0,0 +1,550 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * An I2C driver for the Intersil ISL 12026
>> + *
>> + * Copyright (c) 2018 Cavium, Inc.
>> + */
> 
>> +#include <linux/types.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/bcd.h>
>> +#include <linux/i2c.h>
>> +#include <linux/rtc.h>
>> +#include <linux/of.h>
> 
> Perhaps in alphabetical order.

Done.

> 
>> +/* register offsets */
>> +#define ISL12026_REG_SC                0x30
>> +
>> +#define ISL12026_REG_SR                0x3f
>> +# define ISL12026_REG_SR_RTCF  BIT(0)
>> +# define ISL12026_REG_SR_WEL   BIT(1)
>> +# define ISL12026_REG_SR_RWEL  BIT(2)
>> +# define ISL12026_REG_SR_MBZ   BIT(3)
>> +# define ISL12026_REG_SR_OSCF  BIT(4)
>> +
>> +/* ISL register bits */
>> +#define ISL12026_HR_MIL                BIT(7)  /* military or 24 hour time */
>> +
> 
>> +#define ISL12026_REG_PWR       0x14
> 
> Perhaps keep it ordered? (0x14 < 0x30 obviously)

Done.

> 
>> +# define ISL12026_REG_PWR_BSW  BIT(6)
>> +# define ISL12026_REG_PWR_SBIB BIT(7)
> 
[...]
>> +
>> +static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +       struct i2c_client *client = to_i2c_client(dev);
>> +       struct isl12026 *priv = i2c_get_clientdata(client);
> 
>> +       int rv = 0;
> 
>> +       u8 op[10];
>> +
>> +       struct i2c_msg msg = {
>> +               .addr   = client->addr,
>> +               .flags  = 0,
>> +               .len    = 1,
>> +               .buf    = op
>> +       };
> 
>> +
> 
> Redundant.
> 
>> +       int ret;
> 
> rv, ret, ... ???

I changed everything to use 'ret' to contain values returned from 
function calls, and 'rv' for the value the current function will return.

> 
>> +
>> +       mutex_lock(&priv->lock);
>> +
>> +       /* Set SR.WEL */
>> +       op[0] = 0;
>> +       op[1] = ISL12026_REG_SR;
>> +       op[2] = ISL12026_REG_SR_WEL;
>> +       msg.len = 3;
> 
>> +       ret = i2c_transfer(client->adapter, &msg, 1);
>> +       if (ret != 1) {
> 
> Can it return < 0? If so, why do you shadow the error code?

I think I fixed this driver wide.

> 
[...]
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +               rv = -EIO;
>> +               goto out;
>> +       }
>> +
> 
>> +       if (sr & ISL12026_REG_SR_RTCF)
>> +               dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
>> +       if (sr & ISL12026_REG_SR_OSCF)
>> +               dev_warn(&client->dev, "Oscillator Failure on read\n");
> 
> Can you get them together?
> if not, perhaps consider 'else' keyword.

They are independent error indicators, I think it is best to test for 
them unconditionally like this.

> 
>> +
>> +       /* Second, CCR regs */
>> +       addr[0] = 0;
>> +       addr[1] = ISL12026_REG_SC;
>> +       msgs[1].len = sizeof(ccr);
>> +       msgs[1].buf = ccr;
>> +
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +               rv = -EIO;
>> +               goto out;
>> +       }
>> +
> 
>> +       dev_dbg(&client->dev,
>> +               "raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, y2k=%02x\n",
>> +               ccr[0], ccr[1], ccr[2], ccr[3],
>> +               ccr[4], ccr[5], ccr[6], ccr[7]);
> 
> Ouch.
> 

Not essential, I removed it.


>> +
>> +       tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
>> +       tm->tm_min = bcd2bin(ccr[1] & 0x7F);
>> +       if (ccr[2] & ISL12026_HR_MIL)
>> +               tm->tm_hour = bcd2bin(ccr[2] & 0x3F);
>> +       else
>> +               tm->tm_hour = bcd2bin(ccr[2] & 0x1F) +
>> +                       ((ccr[2] & 0x20) ? 12 : 0);
>> +       tm->tm_mday = bcd2bin(ccr[3] & 0x3F);
>> +       tm->tm_mon = bcd2bin(ccr[4] & 0x1F) - 1;
>> +       tm->tm_year = bcd2bin(ccr[5]);
>> +       if (bcd2bin(ccr[7]) == 20)
>> +               tm->tm_year += 100;
>> +       tm->tm_wday = ccr[6] & 0x07;
>> +
>> +       dev_dbg(&client->dev, "secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
>> +               tm->tm_sec, tm->tm_min, tm->tm_hour,
>> +               tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>> +       rv = rtc_valid_tm(tm);
> 
>> +out:
>> +       mutex_unlock(&priv->lock);
> 
> Here one pattern, below another...
> 
> Hey, you have to learn being consistent.

I made them all like this one.  Single function exit point, with the 
unlock immediately before the return.


> 
>> +       return rv;
>> +}
>> +
>> +static const struct rtc_class_ops isl12026_rtc_ops = {
>> +       .read_time      = isl12026_rtc_read_time,
>> +       .set_time       = isl12026_rtc_set_time,
>> +};
>> +
>> +static int isl12026_nvm_read(void *p, unsigned int offset,
>> +                            void *val, size_t bytes)
>> +{
>> +       struct isl12026 *priv = p;
>> +       int r;
>> +       u8 addr[2];
>> +       struct i2c_msg msgs[] = {
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = 0,
>> +                       .len    = sizeof(addr),
>> +                       .buf    = addr
>> +               },
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = I2C_M_RD,
>> +                       .buf    = val
>> +               }
>> +       };
>> +
>> +       if (offset >= priv->nvm_cfg.size)
>> +               return 0; /* End-of-file */
>> +       if (offset + bytes > priv->nvm_cfg.size)
>> +               bytes = priv->nvm_cfg.size - offset;
>> +
> 
>> +       addr[0] = (offset >> 8) & 0xff;
>> +       addr[1] = offset & 0xff;
> 
> Useless & 0xff:s.

They may be redundant, but they clearly should the intention of shifting 
and masking the individual address component bytes out of the specified 
offset.  I would like to leave them in for clarity.

> 
> Isn't endianess handled by i2c core?


There is no concept of endianess in i2c, at the protocol level it it 
just an array of bytes transmitted to and from the device.  We have to 
put the bytes in the order expected by the target.

> 
>> +       msgs[1].len = bytes;
>> +       mutex_lock(&priv->lock);
> 
>> +       r = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
>> +
>> +       mutex_unlock(&priv->lock);
>> +
>> +       if (r != ARRAY_SIZE(msgs)) {
> 
> A bit unusual pattern,
> 
> what about
> 
> mutex_lock();
> r = ...;
> if (r...) {
>   ...
>   mutex_unlock();
>   return -Exxx;
> }
> mutex_unlock();

Multiple exit points when using locks invites coding errors where you 
miss the unlock in some error path that is not tested.


> 
> ?
> 
>> +               dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", r);
>> +               return -EIO;
>> +       }
>> +
>> +       return bytes;
>> +}
>> +
>> +static int isl12026_nvm_write(void *p, unsigned int offset,
>> +                             void *val, size_t bytes)
>> +{
>> +       struct isl12026 *priv = p;
> 
>> +       int r;
> 
> Use consistent style, either r everywhere, or ret, or rc, or rval.

I hope it is better in the next version.

> 
>> +       u8 *v = val;
>> +       size_t chunk_size, num_written;
>> +       u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
>> +       struct i2c_msg msgs[] = {
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = 0,
>> +                       .buf    = payload
>> +               }
>> +       };
>> +
>> +       if (offset >= priv->nvm_cfg.size)
>> +               return 0; /* End-of-file */
>> +       if (offset + bytes > priv->nvm_cfg.size)
>> +               bytes = priv->nvm_cfg.size - offset;
>> +
>> +       mutex_lock(&priv->lock);
>> +
>> +       num_written = 0;
>> +       while (bytes) {
>> +               chunk_size = round_down(offset, ISL12026_PAGESIZE) +
>> +                       ISL12026_PAGESIZE - offset;
>> +               chunk_size = min(bytes, chunk_size);
>> +               memcpy(payload + 2, v + num_written, chunk_size);
> 
>> +               payload[0] = (offset >> 8) & 0xff;
>> +               payload[1] = offset & 0xff;
> 
> Useless & 0xff:s.
> 
> Isn't endianess handled by i2c core?

See above.

> 
>> +               msgs[0].len = chunk_size + 2;
>> +               r = i2c_transfer(priv->nvm_client->adapter,
>> +                                msgs, ARRAY_SIZE(msgs));
>> +               if (r != ARRAY_SIZE(msgs)) {
>> +                       dev_err(priv->nvm_cfg.dev,
>> +                               "nvmem write error, ret=%d\n", r);
>> +                       break;
>> +               }
>> +               bytes -= chunk_size;
>> +               offset += chunk_size;
>> +               num_written += chunk_size;
>> +               msleep(ISL12026_NVMEM_WRITE_TIME);
>> +       }
>> +
>> +       mutex_unlock(&priv->lock);
>> +
>> +       return num_written > 0 ? num_written : -EIO;
>> +}
>> +
>> +static int isl12026_probe(struct i2c_client *client,
>> +                         const struct i2c_device_id *id)
>> +{
>> +       struct isl12026 *priv;
>> +       int pwr, requested_pwr;
>> +       int ret;
>> +       u32 bsw_val, sbib_val;
>> +       bool set_bsw, set_sbib;
> 
>> +       priv = devm_kzalloc(&client->dev, sizeof(struct isl12026), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
> 
> sizeof(*priv) ?

sure.

> 
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-bsw", &bsw_val);
>> +       set_bsw = (ret == 0);
>> +
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-sbib", &sbib_val);
>> +       set_sbib = (ret == 0);
>> +
>> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
>> +
>> +       if (set_bsw || set_sbib) {
>> +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
>> +               if (pwr < 0)
>> +                       dev_err(&client->dev,
>> +                               "Error: Failed to read PWR %d\n", pwr);
> 
> ...and what? No recovery? No nothing except the message?

I will bail out of this setting or power handling if this happens, that 
seems like all that we could do.


> 
>> +
>> +               requested_pwr = pwr;
>> +
>> +               if (set_bsw) {
>> +                       if (bsw_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
>> +               }
>> +               if (set_sbib) {
>> +                       if (sbib_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
>> +               }
>> +
>> +               if (pwr >= 0 && pwr != requested_pwr) {
>> +                       dev_info(&client->dev, "PWR: %02x\n", pwr);
>> +                       dev_info(&client->dev,
>> +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
>> +                       isl12026_write_reg(client,
>> +                                          ISL12026_REG_PWR, requested_pwr);
>> +               }
>> +       }
> 
> Can you refactor above to a separate function?

Done.

> 
>> +       priv->rtc = devm_rtc_device_register(&client->dev, "rtc-isl12026",
>> +                                            &isl12026_rtc_ops, THIS_MODULE);
> 
>> +
> 
> Redundant empty line.
> 
>> +       ret = PTR_ERR_OR_ZERO(priv->rtc);
>> +       if (ret)
>> +               return ret;
> 
> 
>> +       if (IS_ENABLED(CONFIG_NVMEM)) {
> 
> I think you don't need this, see below.
> 
>> +               priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
>> +               if (!priv->nvm_client)
>> +                       return -ENOMEM;
> 
> i2c_new_secondary_device() ?
> 
>> +               priv->nvm_dev = nvmem_register(&priv->nvm_cfg);
>> +
> 
> Redundant empty line.
> 
>> +               if (!priv->nvm_dev)
> 
> Should it be IS_ERR() ?
> 
>> +                       return -ENOMEM;
> 
> After all rtc_nvmem_register() ?


Yes, I switched to using that.

> 
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int isl12026_remove(struct i2c_client *client)
>> +{
>> +       struct isl12026 *priv = i2c_get_clientdata(client);
>> +
> 
>> +       if (priv->nvm_dev)
> 
> How is it
> 
>> +               nvmem_unregister(priv->nvm_dev);
> 
> 
>> +       if (priv->nvm_client)
> 
> Check with v4.16-rc1. This is duplicate check.

Yes.


> 
>> +               i2c_unregister_device(priv->nvm_client);
>> +
>> +       return 0;
>> +}
> 
>> +#ifdef CONFIG_OF
> 
> Useless.
> 
>> +static const struct of_device_id isl12026_dt_match[] = {
>> +       { .compatible = "isil,isl12026" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
>> +#endif
>> +
> 
>> +static const struct i2c_device_id isl12026_id[] = {
>> +       { "isl12026", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, isl12026_id);
> 
> Useless. Use ->probe_new() approach.
> 
>> +#ifdef CONFIG_OF
> 
> Ugly and useless.
> 
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
>> +#endif
> 


Should be better in the next version.

Thanks for the review,
David Daney
