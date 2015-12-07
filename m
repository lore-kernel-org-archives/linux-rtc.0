Return-Path: <rtc-linux+bncBAABBP7LSWZQKGQEB346NPA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id b62si668784wmc.0.2015.12.07.04.04.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 04:04:15 -0800 (PST)
Date: Mon, 7 Dec 2015 13:03:56 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20151207120356.GC32453@pengutronix.de>
References: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
 <1448977700-10924-2-git-send-email-s.trumtrar@pengutronix.de>
 <20151201144218.GS22136@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151201144218.GS22136@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi!

On Tue, Dec 01, 2015 at 03:42:18PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> Thanks for that patch, I'm sorry I didn't find the time to reply to your
> previous version.
> 

No problem.

> On 01/12/2015 at 14:48:20 +0100, Steffen Trumtrar wrote :
> > diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
> > new file mode 100644
> > index 000000000000..7a828adf9794
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-rx6110.c
> > @@ -0,0 +1,480 @@
> > +/*
> > + * Driver for the Epson RTC module RX-6110 SA
> > + *
> > + * Copyright(C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
> > + * Copyright(C) SEIKO EPSON CORPORATION 2013. All rights reserved.
> > + *
> > + * Derived from RX-8025 driver:
> > + * Copyright (C) 2009 Wolfgang Grandegger <wg@grandegger.com>
> > + *
> > + * Copyright (C) 2005 by Digi International Inc.
> > + * All rights reserved.
> > + *
> > + * Modified by fengjh at rising.com.cn
> > + * <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>
> > + * 2006.11
> > + *
> > + * Code cleanup by Sergei Poselenov, <sposelenov@emcraft.com>
> > + * Converted to new style by Wolfgang Grandegger <wg@grandegger.com>
> > + * Alarm and periodic interrupt added by Dmitry Rakhchev <rda@emcraft.com>
> > + *
> > + *
> 
> Please remove all those unnecessary copyrights and credits. The original
> rx-8025 has been heavily rewritten anyway. Also, all the epson drivers
> suffer from a lot of issues (some of those you already fixed) because
> they are based on an old version of the driver.
> 

Okay. I wasn't sure how okay it is to just get rid of it.
I removed everything after the SEIKO EPSON copyright.

> > +/* Extension Register (1Dh) bit positions */
> > +#define RX6110_BIT_EXT_TSEL		(7 << 0)
> > +#define RX6110_BIT_EXT_WADA		(1 << 3)
> > +#define RX6110_BIT_EXT_TE		(1 << 4)
> > +#define RX6110_BIT_EXT_USEL		(1 << 5)
> > +#define RX6110_BIT_EXT_FSEL		(3 << 6)
> > +
> > +/* Flag Register (1Eh) bit positions */
> > +#define RX6110_BIT_FLAG_VLF		(1 << 1)
> > +#define RX6110_BIT_FLAG_AF		(1 << 3)
> > +#define RX6110_BIT_FLAG_TF		(1 << 4)
> > +#define RX6110_BIT_FLAG_UF		(1 << 5)
> > +
> > +/* Control Register (1Fh) bit positions */
> > +#define RX6110_BIT_CTRL_TSTP		(1 << 2)
> > +#define RX6110_BIT_CTRL_AIE		(1 << 3)
> > +#define RX6110_BIT_CTRL_TIE		(1 << 4)
> > +#define RX6110_BIT_CTRL_UIE		(1 << 5)
> > +#define RX6110_BIT_CTRL_STOP		(1 << 6)
> > +#define RX6110_BIT_CTRL_TEST		(1 << 7)
> > +
> 
> Can you use the BIT() macro?
> 
> > +static struct spi_driver rx6110_driver;
> > +
> > +struct rx6110_data {
> > +	struct rtc_device *rtc;
> > +	struct regmap *regmap;
> > +	int ctrlreg;
> 
> ctrlreg is cached but never used.
> 
> > +};
> > +
> > +/**
> > + * rx6110_get_week_day - translate reg_week_day to tm_wday
> > + * @reg_week_day: weekday register value
> > + *
> > + * Return: an integer representing the tm_wday
> > + */
> > +static int rx6110_get_week_day(u8 reg_week_day)
> > +{
> > +	int tm_wday = -1;
> > +	int i;
> > +
> > +	for (i = 0; i < 7; i++) {
> > +		if (reg_week_day & 1) {
> > +			tm_wday = i;
> > +			break;
> > +		}
> > +		reg_week_day >>= 1;
> > +	}
> > +
> > +	return tm_wday;
> > +}
> 
> ffs() is probably better.
> 
> > +
> > +/**
> > + * rx6110_set_time - set the current time in the rx6110 registers
> > + *
> > + * @dev: the rtc device in use
> > + * @tm: holds date and time
> > + *
> > + * BUG: The HW assumes every year that is a multiple of 4 to be a leap
> > + * year. Next time this is wrong is 2100, which will not be a leap year
> > + *
> > + * Note: If STOP is not set/cleared, the clock will start when the seconds
> > + *       register is written
> > + *
> > + */
> > +static int rx6110_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct rx6110_data *rx6110 = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (tm->tm_year > 137)
> > +		return -EINVAL;
> > +
> 
> Seeing the comment comment above, this should probably be if
> (tm->tm_year < 100 || tm->tm_year >= 200)
> I don't think this particular part has any issue
> handling 2038. However, on 32bit platform, your userspace is probably
> not ready to handle those date. hwclock should return the correct date.
> 
> > + /* set STOP bit before changing clock/calendar */
> > + ret = regmap_update_bits(rx6110->regmap, RX6110_REG_CTRL,
> > +              RX6110_BIT_CTRL_STOP, RX6110_BIT_CTRL_STOP);
> > + if (ret)
> > +     return ret;
> > +
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_SEC,
> > +            bin2bcd(tm->tm_sec));
> > + if (ret)
> > +     return ret;
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_MIN,
> > +            bin2bcd(tm->tm_min));
> > + if (ret)
> > +     return ret;
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_HOUR,
> > +            bin2bcd(tm->tm_hour));
> > + if (ret)
> > +     return ret;
> > +
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_MDAY,
> > +            bin2bcd(tm->tm_mday));
> > + if (ret)
> > +     return ret;
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_MONTH,
> > +            bin2bcd(tm->tm_mon + 1));
> > + if (ret)
> > +     return ret;
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_YEAR,
> > +            bin2bcd(tm->tm_year % 100));
> > + if (ret)
> > +     return ret;
> > + ret = regmap_write(rx6110->regmap, RX6110_REG_WDAY,
> > +            1 << bin2bcd(tm->tm_wday));
> > + if (ret)
> > +     return ret;
> > +
> 
> I feel that using a bulk write between setting and clearing the STOP bit
> would be more efficient, in particular if one day we want to support
> i2c.
> 
> > + /* clear STOP bit after changing clock/calendar */
> > + ret = regmap_update_bits(rx6110->regmap, RX6110_REG_CTRL,
> > +              RX6110_BIT_CTRL_STOP, 0);
> > +
> > + return ret;
> > +}
> > +/**
> > + * rx6110_reset_time - reset the time to 1970/1/1 00:00
> > + * @dev: the rtc device in use
> > + * @tm: holds date and time
> > + */
> > +static int rx6110_reset_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	int ret;
> > +
> > +	tm->tm_sec = 0;
> > +	tm->tm_min = 0;
> > +	tm->tm_hour = 0;
> > +	tm->tm_wday = 0;
> > +	tm->tm_mday = 1;
> > +	tm->tm_mon = 0;
> > +	tm->tm_year = 70;
> > +	ret = rx6110_set_time(dev, tm);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set time.\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> This reset function is unnecessary.
> 
> 
> > +
> > +/**
> > + * rx6110_get_time - get the current time from the rx6110 registers
> > + * @dev: the rtc device in use
> > + * @tm: holds date and time
> > + */
> > +static int rx6110_get_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct rx6110_data *rx6110 = dev_get_drvdata(dev);
> > +	unsigned char date[7];
> > +	int flags;
> > +	int ret;
> > +
> > +	ret = regmap_read(rx6110->regmap, RX6110_REG_FLAG, &flags);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	/* check for VLF Flag (set at power-on) */
> > +	if ((flags & RX6110_BIT_FLAG_VLF))
> > +		return -EINVAL;
> > +
> > +	/* read registers to date */
> > +	ret = regmap_bulk_read(rx6110->regmap, RX6110_REG_SEC, date, 7);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tm->tm_sec = bcd2bin(date[0] & 0x7f);
> > +	tm->tm_min = bcd2bin(date[1] & 0x7f);
> > +	/* only 24-hour clock */
> > +	tm->tm_hour = bcd2bin(date[2] & 0x3f);
> > +	tm->tm_wday = rx6110_get_week_day(date[3] & 0x7f);
> > +	tm->tm_mday = bcd2bin(date[4] & 0x3f);
> > +	tm->tm_mon = bcd2bin(date[5] & 0x1f) - 1;
> > +	tm->tm_year = bcd2bin(date[6]);
> > +
> > +	if (tm->tm_year < 70)
> > +		tm->tm_year += 100;
> > +
> 
> I think you are better off not playing with the date and only support
> dates between 2000 and 2100. I don't really think anybody really care
> about dates more than 15 years in the past.
> 
> > +	if (tm->tm_year > 137) {
> > +		ret = rx6110_reset_time(dev, tm);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> Please, never reset the date/time. This will confuse userspace. When
> silently resetting the time, userspace as no way of knowing whether an error
> really happened or you used a time machine ;). Return an error instead.
> 
> I think the check should be if (tm->tm_year > 200).
> 
> > +
> > +	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
> > +		tm->tm_sec, tm->tm_min, tm->tm_hour,
> > +		tm->tm_mday, tm->tm_mon, tm->tm_year);
> > +
> > +	return rtc_valid_tm(tm);
> > +}
> > +
> > +/**
> > + * rx6110_init - initialize the rx6110 registers
> > + *
> > + * @rx6110: pointer to the rx6110 struct in use
> > + *
> > + */
> > +static int rx6110_init(struct rx6110_data *rx6110)
> > +{
> > +	struct rtc_device *rtc = rx6110->rtc;
> > +	int need_clear = 0;
> > +	int need_reset = 0;
> > +	int ext;
> > +	int flags;
> > +	int ctrl;
> > +	int ret;
> > +
> > +	/* set reserved register 0x17 with specified value of 0xB8 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0xB8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* set reserved register 0x30 with specified value of 0x00 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* set reserved register 0x31 with specified value of 0x10 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0x10);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_IRQ, 0x0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(rx6110->regmap, RX6110_REG_EXT,
> > +				 RX6110_BIT_EXT_TE, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* get current extension, flag, control register values */
> > +	ret = regmap_read(rx6110->regmap, RX6110_REG_EXT, &ext);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(rx6110->regmap, RX6110_REG_FLAG, &flags);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* clear ctrl register */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_CTRL, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ctrl = 0;
> > +
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_ALMIN, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_ALHOUR, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_ALWDAY, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(&rtc->dev, "ext: %x, flag: %x, ctrl: %x\n", ext, flags, ctrl);
> > +
> > +	/* check for VLF Flag (set at power-on) */
> > +	if ((flags & RX6110_BIT_FLAG_VLF)) {
> > +		dev_warn(&rtc->dev, "Frequency stop was detected, probably due to a supply voltage drop\n");
> > +		need_reset = 1;
> > +		need_clear = 1;
> > +	}
> 
> Again, never reset the time. The correct handling of that flag is to
> return an error on read until the time is set again.you can check the
> current rx8025 or rv8803 drivers, they handle the same logic. Maybe you
> could also align the warnings message for missed alarms on those drivers.
> 

(...)

To make it short: I have done everything of the above :-)

Thanks,
Steffen Trumtrar

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

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
