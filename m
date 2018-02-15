Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:42276
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161315AbeBOTBP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 15 Feb 2018 14:01:15 -0500
Subject: Re: [PATCH v2] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180214005536.22739-1-david.daney@cavium.com>
 <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <4047b1de-40c6-813e-c410-543954190413@caviumnetworks.com>
Date: Thu, 15 Feb 2018 11:01:10 -0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/15/2018 04:45 AM, Andy Shevchenko wrote:
> On Wed, Feb 14, 2018 at 2:55 AM, David Daney <david.daney@cavium.com> wrote:
>> The ISL12026 is a combination RTC and EEPROM device with I2C
>> interface.  The standard RTC driver interface is provided.  The EEPROM
>> is accessed via the NVMEM interface via the "eeprom0" directory in the
>> sysfs entry for the device.
> 
> Thanks for an update, my comments below.
> 
>> +struct isl12026 {
>> +       struct rtc_device *rtc;
>> +       struct i2c_client *nvm_client;
>> +       struct nvmem_config nvm_cfg;
>> +       /*
>> +        * RTC write operations require that multiple messages be
>> +        * transmitted, we hold the lock for all accesses to the
>> +        * device so that these sequences cannot be disrupted.  Also,
> 
>> +        * the write cycle to the nvmem takes many mS during which the
> 
> What mS means? milliseconds? The standard abbreviation for it 'ms'.

Yes, milliseconds.   OK.

> 
>> +        * device does not respond to commands, so holding the lock
>> +        * also prevents access during these times.
>> +        */
>> +       struct mutex lock;
>> +};
> 
>> +static int isl12026_read_reg(struct i2c_client *client, int reg)
>> +{
> 
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read reg error, ret=%d\n", ret);
>> +               ret = ret < 0 ? ret : -EIO;
>> +       } else {
>> +               ret = val;
>> +       }
> 
>> +       return val;
> 
> Something wrong. ret is not used after all.
> 
>> +}
> 
> Check entire code for such.

OK.

> 
>> +       /* 2 bytes of address, most significant first */
>> +       addr[0] = (offset >> 8) & 0xff;
>> +       addr[1] = offset & 0xff;
> 
> Consider to drop '& 0xff', they are pointless (you have u8 type).

Generated code is the same, but the intent of the code is less clear 
when the explicit masking is removed.  Never the less, since this seems 
to be impeding progress, I will remove it.


> 
>> +               payload[0] = (offset >> 8) & 0xff;
>> +               payload[1] = offset & 0xff;
> 
> Ditto.
> 
>> +static void isl12026_force_power_modes(struct i2c_client *client)
>> +{
>> +       int ret;
>> +       int pwr, requested_pwr;
>> +       u32 bsw_val, sbib_val;
> 
>> +       bool set_bsw, set_sbib;
>> +
> 
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-bsw", &bsw_val);
>> +       set_bsw = (ret == 0);
> 
> Which is not fully correct. Better to do

I think it is correct.  The properties are optional, so it it perfectly 
fine for of_property_read_u32() to fail.  If it fails, we simply keep 
the current value.  I will add comments to document the intended logic.

> 
> set_bsw = of_property_present();

There are no occurrences of "of_property_present" in my source tree.


> 
> ret = of_property_read...();
> if (ret)
>    return ret;
> 
>> +
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-sbib", &sbib_val);
>> +       set_sbib = (ret == 0);
> 
> Ditto.
> 
>> +
>> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
>> +
> 
>> +       if (set_bsw || set_sbib) {
> 
> if (!x && !y)
>   return;

OK.

> 
>> +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
>> +               if (pwr < 0) {
>> +                       dev_err(&client->dev,
>> +                               "Error: Failed to read PWR %d\n", pwr);
>> +                       return;
>> +               }
>> +
>> +               requested_pwr = pwr;
>> +
>> +               if (set_bsw) {
>> +                       if (bsw_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
>> +               }
> 
> Undefined state if no value?

It is defined.  See above.


> 
>> +               if (set_sbib) {
>> +                       if (sbib_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
>> +               }
> 
> Ditto.
> 
>> +
>> +               if (pwr >= 0 && pwr != requested_pwr) {
> 
>> +                       dev_info(&client->dev, "PWR: %02x\n", (u8)pwr);
>> +                       dev_info(&client->dev,
>> +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
>> +                       isl12026_write_reg(client,
>> +                                          ISL12026_REG_PWR, requested_pwr);
> 
> If you do explicit casting in printf() parameters you are doing
> something wrong in 99.9% cases.

OK.
> 
>> +               }
>> +       }
>> +}
> 
>> +static int isl12026_probe_new(struct i2c_client *client)
>> +{
>> +       struct isl12026 *priv;
>> +       int ret;
> 
> 
>> +       /* The NVMem array responds at i2c address 0x57 */
>> +       priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
> 
> Magic. Make it #define and put comment there.
> 
>> +       if (!priv->nvm_client)
>> +               return -ENOMEM;
> 
>> +}
> 
>> +#ifdef CONFIG_OF
> 
> Remove this ugly #ifdef. Your driver OF only one.

The driver doesn't require OF.  By removing the #if (which I will do), 
the size of the module may be bloated in the non-OF case.  If anybody 
cares about this, they can add back the #if.


> 
>> +static const struct of_device_id isl12026_dt_match[] = {
>> +       { .compatible = "isil,isl12026" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
> 
>> +#endif
> 
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> 
> Drop of_match_ptr().

Best to keep it so that the non-OF case is correctly handled.

> 
