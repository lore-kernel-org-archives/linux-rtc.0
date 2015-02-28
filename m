Return-Path: <joe@perches.com>
Message-ID: <1425151935.25697.5.camel@perches.com>
Subject: Re: [PATCH] rtc: add Abracon ABx80x driver
From: Joe Perches <joe@perches.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Date: Sat, 28 Feb 2015 11:32:15 -0800
In-Reply-To: <1425150876-8141-1-git-send-email-alexandre.belloni@free-electrons.com>
References: 
	<1425150876-8141-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <rtc-linux.googlegroups.com>

On Sat, 2015-02-28 at 20:14 +0100, Alexandre Belloni wrote:
> Add support for the i2c RTC from Abracon.

Perhaps you can run this through
$ ./scripts/checkpatch.pl --strict --fix-inplace

Is there going to be a MAINTAINERS entry for this driver?

> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
[]
> @@ -22,6 +22,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
>  
>  obj-$(CONFIG_RTC_DRV_88PM860X)  += rtc-88pm860x.o
>  obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
> +obj-$(CONFIG_RTC_DRV_ABX80X)	+= rtc-abx80x.o

alphabetic order?

>  obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
>  obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
>  obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o

[]

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
[]
> +static int ab08xx_get_datetime(struct i2c_client *client, struct rtc_time *tm)
> +{
> +	unsigned char date[8];
> +	int err;
> +
> +	/* Now read time and date */
> +	err = i2c_smbus_read_i2c_block_data(client, AB08XX_REG_HTH,
> +		8, date);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Unable to read date\n");
> +		return -EIO;
> +	}
> +
> +	tm->tm_sec = bcd2bin(date[AB08XX_REG_SC] & 0x7F);
> +	tm->tm_min = bcd2bin(date[AB08XX_REG_MN] & 0x7F);
> +	tm->tm_hour = bcd2bin(date[AB08XX_REG_HR] & 0x3F);
> +	tm->tm_wday = date[AB08XX_REG_WD] & 0x7;
> +	tm->tm_mday = bcd2bin(date[AB08XX_REG_DA] & 0x3F);
> +	tm->tm_mon = bcd2bin(date[AB08XX_REG_MO] & 0x1F) - 1;
> +	tm->tm_year = bcd2bin(date[AB08XX_REG_YR]);
> +	if (tm->tm_year < 70)
> +		tm->tm_year += 100;
> +
> +	err = rtc_valid_tm(tm);
> +	if (err < 0)
> +		dev_err(&client->dev, "retrieved date/time is not valid.\n");

Is setting the date to a known bad value really the desired thing?

> +static int ab08xx_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct rtc_device *rtc;
> +	int data, err, part0, part1;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +
> +	part0 = i2c_smbus_read_byte_data(client, AB08XX_REG_PART0);
> +	part1 = i2c_smbus_read_byte_data(client, AB08XX_REG_PART1);
> +	if ((part0 < 0) || (part1 < 0)) {
> +		dev_err(&client->dev, "Unable to read part number\n");
> +		return -EIO;
> +	}
> +	dev_info(&client->dev, "chip found %2x%2x\n", part0, part1);

	"%02x%02x" ?
