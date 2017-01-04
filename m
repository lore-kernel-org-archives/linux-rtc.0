Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWW7WXBQKGQER6P7EKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id a19si2484024wme.0.2017.01.04.13.57.45
        for <rtc-linux@googlegroups.com>;
        Wed, 04 Jan 2017 13:57:45 -0800 (PST)
Date: Wed, 4 Jan 2017 22:57:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ryan Jones <ryan@rjones.io>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: Add support for RX4035
Message-ID: <20170104215745.soz5cxur35yqvhyk@piout.net>
References: <1470419676-5616-1-git-send-email-ryan@rjones.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470419676-5616-1-git-send-email-ryan@rjones.io>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Sorry for the late review!

On 05/08/2016 at 11:54:36 -0600, Ryan Jones wrote :
> + * Based on:
> + * drivers/rtc/rtc-rx4581.c

I'd argue that it doesn't really matter ;)

> +#define RX4035_REG_SC		0x00 /* Second in BCD */
> +#define RX4035_REG_MN		0x01 /* Minute in BCD */
> +#define RX4035_REG_HR		0x02 /* Hour in BCD */
> +#define RX4035_REG_DW		0x03 /* Day of Week */
> +#define RX4035_REG_DM		0x04 /* Day of Month in BCD */
> +#define RX4035_REG_MO		0x05 /* Month in BCD */
> +#define RX4035_REG_YR		0x06 /* Year in BCD */
> +#define RX4035_REG_RAM		0x0D /* RAM */
> +#define RX4035_REG_CTL1		0x0E /* Control Register 1*/
> +#define RX4035_REG_CTL2		0x0F /* Control Register 2*/
> +
> +/* Flag Register bit definitions */
> +#define RX4035_FLAG_VDET	0x40 /* Low Voltage Detection */
> +#define RX4035_FLAG_PON		0x10 /* Indicates a Power On condition */

Please use BIT().

> +
> +static int rx4035_set_reg(struct spi_device *spi, unsigned char address,
> +	unsigned char data)
> +{
> +	unsigned char buf[2];
> +
> +	/*Set MSB to indicate a write transfer*/
> +	buf[0] = (address<<4) | 0x08;

checkpatch --strict is complaining about spaces here and also a few
alignements later. Can you fix those?

> +	buf[1] = data;
> +
> +	return spi_write_then_read(spi, buf, 2, NULL, 0);
> +}
> +
> +static int rx4035_get_reg(struct spi_device *spi, unsigned char address,
> +	unsigned char *data)
> +{
> +	/*Set MSB to indicate a write transfer*/

This comment is probably wrong...

> +	*data = (address<<4) | 0x0c;
> +
> +	return spi_write_then_read(spi, data, 1, data, 1);
> +}
> +
> +/*
> + * In the routines that deal directly with the rx4035 hardware, we use
> + * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> + */

This comment is not useful

> +static int rx4035_get_datetime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	unsigned char date[7];
> +	unsigned char data;
> +	int err;
> +
> +	/*Check that data is reliable*/
> +	err = rx4035_get_reg(spi, RX4035_REG_CTL1, &data);
> +	if (err != 0) {
> +		dev_err(dev, "Unable to read control register\n");
> +		return -EIO;
> +	}
> +	if (data & (RX4035_FLAG_VDET | RX4035_FLAG_PON))
> +		dev_err(dev, "RTC DATA UNRELIABLE - battery voltage fell below minimum value\n");

It prints an error but the function continues as if nothing happend so
userspace doesn't actually know something is wrong. You probably need to
return -EINVAL here.

> +
> +	/* Read time and date */
> +	date[0] = 0x04;

This is a magic value. I understand what it does but maybe you could have
a define for each read and write mode and then remove the (inaccurate)
comments.

> +	err = spi_write_then_read(spi, date, 1, date, 7);
> +	if (err < 0) {
> +		dev_err(dev, "Unable to read date\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev,
> +		"%s: raw data is sec=%02x, min=%02x, hr=%02x, wday=%02x, mday=%02x, mon=%02x, year=%02x\n",
> +		__func__,
> +		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
> +
> +	tm->tm_sec = bcd2bin(date[RX4035_REG_SC] & 0x7F);
> +	tm->tm_min = bcd2bin(date[RX4035_REG_MN] & 0x7F);
> +	tm->tm_hour = bcd2bin(date[RX4035_REG_HR] & 0x3F); /* rtc hr 0-23 */
> +	tm->tm_wday = date[RX4035_REG_DW] & 0x7F;
> +	tm->tm_mday = bcd2bin(date[RX4035_REG_DM] & 0x3F);
> +	tm->tm_mon = bcd2bin(date[RX4035_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> +	tm->tm_year = bcd2bin(date[RX4035_REG_YR]);
> +	if (tm->tm_year < 70)
> +		tm->tm_year += 100; /* assume we are in 1970...2069 */

This is bad and usually doesn't work properly.
The datasheet explicitly state:
"The auto calendar function updates all dates, months, and years from
January 1, 2001 to December 31, 2099."

It will not work outside this range. The leap year handling will
certainly fail at the edges.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
