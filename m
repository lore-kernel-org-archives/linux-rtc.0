Return-Path: <rtc-linux+bncBDS7HNEFSALRBDED72ZAKGQE6QWJKWA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q80si531wmg.0.2015.12.02.15.40.59
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Dec 2015 15:40:59 -0800 (PST)
Date: Thu, 3 Dec 2015 00:40:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, justin.waters@timesys.com
Subject: [rtc-linux] Re: [PATCH] rtc: Add Epson RX8010SJ RTC driver
Message-ID: <20151202234058.GG22136@piout.net>
References: <1447281118-25275-1-git-send-email-akshay.bhat@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1447281118-25275-1-git-send-email-akshay.bhat@timesys.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 11/11/2015 at 17:31:58 -0500, Akshay Bhat wrote :
> diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
> new file mode 100644
> index 0000000..9b8bd76
> --- /dev/null
> +++ b/drivers/rtc/rtc-rx8010.c
> @@ -0,0 +1,570 @@
> +/*
> + * Driver for the Epson RTC module RX-8010 SJ
> + *
> + * Copyright(C) Timesys Corporation 2015
> + * Copyright(C) General Electric Company 2015
> + * Copyright(C) SEIKO EPSON CORPORATION 2013. All rights reserved.
> + *
> + * Derived from RX-8025 driver:
> + * Copyright (C) 2009 Wolfgang Grandegger <wg@grandegger.com>
> + *
> + * Copyright (C) 2005 by Digi International Inc.
> + * All rights reserved.
> + *
> + * Modified by fengjh at rising.com.cn
> + * <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>
> + * 2006.11
> + *
> + * Code cleanup by Sergei Poselenov, <sposelenov@emcraft.com>
> + * Converted to new style by Wolfgang Grandegger <wg@grandegger.com>
> + * Alarm and periodic interrupt added by Dmitry Rakhchev <rda@emcraft.com>
> + *

Please remove all those unnecessary copyrights, the original
rx-8025 has been heavily rewritten anyway.

> +static int rx8010_read_reg(struct i2c_client *client, int number, u8 *value)
> +{
> +	int ret = i2c_smbus_read_byte_data(client, number);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*value = ret;
> +	return 0;
> +}

I don't see the benefit of that function, calling
i2c_smbus_read_byte_data directly is more efficient.

> +
> +static int rx8010_read_regs(struct i2c_client *client, int number, u8 length,
> +			u8 *values)
> +{
> +	int ret = i2c_smbus_read_i2c_block_data(client, number, length, values);
> +
> +	if (ret != length)
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}

Apart from the error handling, I'd say the same for that function.

> +
> +static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
> +{
> +	struct i2c_client *client = dev_id;
> +	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
> +	u8 flagreg;
> +
> +	spin_lock(&rx8010->flags_lock);
> +
> +	if (rx8010_read_reg(client, RX8010_FLAG, &flagreg)) {
> +		spin_unlock(&rx8010->flags_lock);
> +		return IRQ_NONE;
> +	}
> +
> +	if (flagreg & RX8010_FLAG_VLF)
> +		dev_warn(&client->dev, "Frequency stop detected\n");
> +
> +	if (flagreg & RX8010_FLAG_TF) {
> +		flagreg &= ~RX8010_FLAG_TF;
> +		rtc_update_irq(rx8010->rtc, 1, RTC_PF | RTC_IRQF);
> +	}
> +
> +	if (flagreg & RX8010_FLAG_AF) {
> +		flagreg &= ~RX8010_FLAG_AF;
> +		rtc_update_irq(rx8010->rtc, 1, RTC_AF | RTC_IRQF);
> +	}
> +
> +	if (flagreg & RX8010_FLAG_UF) {
> +		flagreg &= ~RX8010_FLAG_UF;
> +		rtc_update_irq(rx8010->rtc, 1, RTC_UF | RTC_IRQF);
> +	}
> +
> +	i2c_smbus_write_byte_data(client, RX8010_FLAG, flagreg);
> +
> +	spin_unlock(&rx8010->flags_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
> +	u8 date[7];
> +	u8 flagreg;
> +	int err;
> +
> +	err = rx8010_read_reg(rx8010->client, RX8010_FLAG, &flagreg);
> +	if (err)
> +		return err;
> +
> +	if (flagreg & RX8010_FLAG_VLF) {
> +		dev_warn(dev, "Frequency stop detected\n");
> +		return -EINVAL;
> +	}
> +
> +	err = rx8010_read_regs(rx8010->client, RX8010_SEC, 7, date);
> +	if (err)
> +		return err;
> +
> +	dt->tm_sec = bcd2bin(date[RX8010_SEC-RX8010_SEC] & 0x7f);
> +	dt->tm_min = bcd2bin(date[RX8010_MIN-RX8010_SEC] & 0x7f);
> +	dt->tm_hour = bcd2bin(date[RX8010_HOUR-RX8010_SEC] & 0x3f);
> +	dt->tm_mday = bcd2bin(date[RX8010_MDAY-RX8010_SEC] & 0x3f);
> +	dt->tm_mon = bcd2bin(date[RX8010_MONTH-RX8010_SEC] & 0x1f) - 1;
> +	dt->tm_year = bcd2bin(date[RX8010_YEAR-RX8010_SEC]);
> +	dt->tm_wday = bcd2bin(date[RX8010_WDAY-RX8010_SEC] & 0x7f);
> +

This is not the correct value for tm_wday, you should use ffs(), not
that anybody actually cares.

Also, checkpatch --strict complains about missing spaces around those '-'
and a few alignments are not correct, can fix those?


> +	if (dt->tm_year < 70)
> +		dt->tm_year += 100;
> +

I'd say that we don't care about handling dates before 2000 and that the
range should be 2000-2100 as this is actually the range where the leap
year calculation is correct. Also your are not respecting that in
rx8010_set_time() so setting a date in 2072 will end up reading 1972.

> +	return rtc_valid_tm(dt);
> +}
> +
> +static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
> +	u8 date[7];
> +	u8 ctrl, flagreg;
> +	int ret;
> +	unsigned long irqflags;
> +
> +	/* BUG: The HW assumes every year that is a multiple of 4 to be a leap
> +	 * year.  Next time this is wrong is 2100, which will not be a leap
> +	 * year.
> +	 */
> +

Then, return -EINVAL if the year is out of the 100-200 range.


> +	/* set STOP bit before changing clock/calendar */
> +	ret = rx8010_read_reg(rx8010->client, RX8010_CTRL, &ctrl);
> +	if (ret)
> +		return ret;
> +	rx8010->ctrlreg = ctrl | RX8010_CTRL_STOP;
> +	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
> +		rx8010->ctrlreg);
> +	if (ret < 0)
> +		return ret;
> +
> +	date[RX8010_SEC-RX8010_SEC] = bin2bcd(dt->tm_sec);
> +	date[RX8010_MIN-RX8010_SEC] = bin2bcd(dt->tm_min);
> +	date[RX8010_HOUR-RX8010_SEC] = bin2bcd(dt->tm_hour);
> +	date[RX8010_MDAY-RX8010_SEC] = bin2bcd(dt->tm_mday);
> +	date[RX8010_MONTH-RX8010_SEC] = bin2bcd(dt->tm_mon + 1);
> +	date[RX8010_YEAR-RX8010_SEC] = bin2bcd(dt->tm_year % 100);
> +	date[RX8010_WDAY-RX8010_SEC] = bin2bcd(dt->tm_wday);

this is not the expected value for RX8010_WDAY, it must be 1 <<
dt->tm_wday, see the datasheet.

> +
> +	ret = i2c_smbus_write_i2c_block_data(rx8010->client,
> +			RX8010_SEC, 7, date);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* clear STOP bit after changing clock/calendar */
> +	ret = rx8010_read_reg(rx8010->client, RX8010_CTRL, &ctrl);
> +	if (ret)
> +		return ret;
> +	rx8010->ctrlreg = ctrl & ~RX8010_CTRL_STOP;
> +	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
> +		rx8010->ctrlreg);
> +	if (ret < 0)
> +		return ret;
> +
> +	spin_lock_irqsave(&rx8010->flags_lock, irqflags);
> +
> +	ret = rx8010_read_reg(rx8010->client, RX8010_FLAG, &flagreg);
> +	if (ret) {
> +		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +		return ret;
> +	}
> +
> +	if (flagreg & RX8010_FLAG_VLF)
> +		ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
> +					flagreg & ~RX8010_FLAG_VLF);
> +
> +	spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +static int rx8010_init_client(struct i2c_client *client)
> +{
> +	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
> +	u8 ctrl[3];
> +	int need_clear = 0, need_reset = 0, err = 0;
> +
> +	/* Initialize reserved registers as specified in datasheet */
> +	err = i2c_smbus_write_byte_data(client, RX8010_RESV17, 0xD8);
> +	if (err < 0)
> +		return err;
> +
> +	err = i2c_smbus_write_byte_data(client, RX8010_RESV30, 0x00);
> +	if (err < 0)
> +		return err;
> +
> +	err = i2c_smbus_write_byte_data(client, RX8010_RESV31, 0x08);
> +	if (err < 0)
> +		return err;
> +
> +	err = i2c_smbus_write_byte_data(client, RX8010_IRQ, 0x00);
> +	if (err < 0)
> +		return err;
> +
> +	err = rx8010_read_regs(rx8010->client, RX8010_EXT, 3, ctrl);
> +	if (err)
> +		return err;
> +
> +	if ((ctrl[1] & RX8010_FLAG_VLF)) {
> +		dev_warn(&client->dev, "Frequency stop was detected\n");
> +		need_reset = 1;
> +	}
> +
> +	if (ctrl[1] & RX8010_FLAG_AF) {
> +		dev_warn(&client->dev, "Alarm was detected\n");
> +		need_clear = 1;
> +	}
> +
> +	if (ctrl[1] & RX8010_FLAG_TF)
> +		need_clear = 1;
> +
> +	if (ctrl[1] & RX8010_FLAG_UF)
> +		need_clear = 1;
> +
> +	if (need_reset) {
> +		ctrl[0] = ctrl[1] = ctrl[2] = 0;
> +		err = i2c_smbus_write_i2c_block_data(client, RX8010_EXT,
> +				3, ctrl);
> +		if (err < 0)
> +			return err;

Please don't do that, reseting RX8010_FLAG_VLF will make userspace
believe that the bogus date is valid.

> +	} else if (need_clear) {
> +		err = i2c_smbus_write_byte_data(client, RX8010_FLAG, 0x00);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	rx8010->ctrlreg = (ctrl[2] & ~RX8010_CTRL_TEST);
> +

BTW, I'm not sure about the necessity to cache ctrl. It actually only saves one
i2c read in the alarm functions.

> +	return err;
> +}
> +


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
