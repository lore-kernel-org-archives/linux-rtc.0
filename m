Return-Path: <rtc-linux+bncBAABB2NRTW3AKGQELUAJTXQ@googlegroups.com>
Received: from email.microchip.com (exsmtp03.microchip.com. [198.175.253.49])
        by gmr-mx.google.com with ESMTPS id ff2si1888906pad.2.2016.02.19.10.03.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:03:21 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: rtc-pic32: Add PIC32 real time clock driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1454366606-10779-1-git-send-email-joshua.henderson@microchip.com>
 <1454366606-10779-2-git-send-email-joshua.henderson@microchip.com>
 <20160216230241.GC2189@piout.net>
CC: <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>, Alessandro
 Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
From: Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56C7590D.4050700@microchip.com>
Date: Fri, 19 Feb 2016 11:03:57 -0700
MIME-Version: 1.0
In-Reply-To: <20160216230241.GC2189@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Alexandre,

On 02/16/2016 04:02 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 01/02/2016 at 15:43:22 -0700, Joshua Henderson wrote :
>> This drivers adds support for the PIC32 real time clock and calendar
>> peripheral:
>>      - reading and setting time
>>      - alarms when connected to an IRQ
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> ---
>>  drivers/rtc/Kconfig     |   10 ++
>>  drivers/rtc/Makefile    |    1 +
>>  drivers/rtc/rtc-pic32.c |  450 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Nitpick: there are multiple alignment and blank lines issues that you
> can spot using checkpatch --strict.

Thanks. Will address.

> 
>> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
>> index 62d61b2..20c9be5 100644
>> --- a/drivers/rtc/Makefile
>> +++ b/drivers/rtc/Makefile
>> @@ -162,3 +162,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
>>  obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
>>  obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
>>  obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
>> +obj-$(CONFIG_RTC_DRV_PIC32)	+= rtc-pic32.o
> 
> This list has to be ordered alphabetically.

Ack.

> 
>> diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
>> new file mode 100644
>> index 0000000..7c46ccb
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-pic32.c
>> @@ -0,0 +1,450 @@
>> +/*
>> + * PIC32 RTC driver
>> + *
>> + * Joshua Henderson <joshua.henderson@microchip.com>
>> + * Copyright (C) 2016 Microchip Technology Inc.  All rights reserved.
>> + *
>> + * This program is free software; you can distribute it and/or modify it
>> + * under the terms of the GNU General Public License (Version 2) as
>> + * published by the Free Software Foundation.
>> + *
> 
> This specify GPL v2 but you use MODULE_LICENSE("GPL")

Ack.

> 
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> + * for more details.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +#include <linux/rtc.h>
>> +#include <linux/bcd.h>
>> +
>> +#include <asm/mach-pic32/pic32.h>
>> +
>> +#define DRIVER_NAME "pic32-rtc"
>> +
>> +#define PIC32_RTCCON		(0x00)
> 
> You probably don't need those parenthesis.

Ack.

> 
>> +#define PIC32_RTCCON_ON		BIT(15)
>> +#define PIC32_RTCCON_SIDL	BIT(13)
>> +#define PIC32_RTCCON_RTCCLKSEL	(3 << 9)
>> +#define PIC32_RTCCON_RTCCLKON	BIT(6)
>> +#define PIC32_RTCCON_RTCWREN	BIT(3)
>> +#define PIC32_RTCCON_RTCSYNC	BIT(2)
>> +#define PIC32_RTCCON_HALFSEC	BIT(1)
>> +#define PIC32_RTCCON_RTCOE	BIT(0)
>> +
>> +#define PIC32_RTCALRM		(0x10)
> 
> ditto

Ack.

> 
>> +#define PIC32_RTCALRM_ALRMEN	BIT(15)
>> +#define PIC32_RTCALRM_CHIME	BIT(14)
>> +#define PIC32_RTCALRM_PIV	BIT(13)
>> +#define PIC32_RTCALRM_ALARMSYNC	BIT(12)
>> +#define PIC32_RTCALRM_AMASK	(0x0F << 8)
>> +#define PIC32_RTCALRM_ARPT	(0xFF << 0)
> 
> Nit: For those masks, you can use genmask() or directly 0x0F00 and 0xFF

Ack.

> 
>> +struct pic32_rtc_dev {
>> +	struct rtc_device	*rtc;
>> +	void __iomem		*reg_base;
>> +	struct clk		*clk;
>> +	spinlock_t		flags_lock;
> 
> flags_lock is unnecessary, it is used only in one function that is
> called only at probe time

Ack.

> 
>> +	spinlock_t		alarm_lock;
>> +	int			alarm_irq;
>> +	bool			alarm_clk_enabled;
>> +};
>> +
> 
> [...]
> 
>> +static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
>> +{
>> +	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
>> +	void __iomem *base = pdata->reg_base;
>> +	unsigned int have_retried = 0;
>> +
>> +	clk_enable(pdata->clk);
>> +retry_get_time:
>> +	rtc_tm->tm_hour = readb(base + PIC32_RTCHOUR);
>> +	rtc_tm->tm_min = readb(base + PIC32_RTCMIN);
>> +	rtc_tm->tm_mon  = readb(base + PIC32_RTCMON);
>> +	rtc_tm->tm_mday = readb(base + PIC32_RTCDAY);
>> +	rtc_tm->tm_year = readb(base + PIC32_RTCYEAR);
>> +	rtc_tm->tm_sec  = readb(base + PIC32_RTCSEC);
>> +
>> +	/*
>> +	 * The only way to work out whether the system was mid-update
>> +	 * when we read it is to check the second counter, and if it
>> +	 * is zero, then we re-try the entire read.
>> +	 */
>> +
>> +	if (rtc_tm->tm_sec == 0 && !have_retried) {
>> +		have_retried = 1;
>> +		goto retry_get_time;
>> +	}
> 
> Please change that goto in a do while loop.

Ack.

> 
>> +
>> +	rtc_tm->tm_sec = bcd2bin(rtc_tm->tm_sec);
>> +	rtc_tm->tm_min = bcd2bin(rtc_tm->tm_min);
>> +	rtc_tm->tm_hour = bcd2bin(rtc_tm->tm_hour);
>> +	rtc_tm->tm_mday = bcd2bin(rtc_tm->tm_mday);
>> +	rtc_tm->tm_mon = bcd2bin(rtc_tm->tm_mon);
>> +	rtc_tm->tm_year = bcd2bin(rtc_tm->tm_year);
>> +
>> +	rtc_tm->tm_year += 100;
>> +
>> +	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
>> +		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
>> +		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
>> +
>> +	rtc_tm->tm_mon -= 1;
> 
> Maybe you should do that substraction with the assignment the only
> drawback is that it changes the debug output.

I think that's acceptable.  Will move.

> 
>> +
>> +	clk_disable(pdata->clk);
>> +	return rtc_valid_tm(rtc_tm);
>> +}
>> +
> 
> [...]
> 
>> +static int pic32_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
>> +	struct rtc_time *alm_tm = &alrm->time;
>> +	void __iomem *base = pdata->reg_base;
>> +	unsigned int alm_en;
>> +
>> +	clk_enable(pdata->clk);
>> +	alm_tm->tm_sec  = readb(base + PIC32_ALRMSEC);
>> +	alm_tm->tm_min  = readb(base + PIC32_ALRMMIN);
>> +	alm_tm->tm_hour = readb(base + PIC32_ALRMHOUR);
>> +	alm_tm->tm_mon  = readb(base + PIC32_ALRMMON);
>> +	alm_tm->tm_mday = readb(base + PIC32_ALRMDAY);
>> +	alm_tm->tm_year = readb(base + PIC32_ALRMYEAR);
>> +
>> +	alm_en = readb(base + PIC32_RTCALRM);
>> +
>> +	alrm->enabled = (alm_en & PIC32_RTCALRM_ALRMEN) ? 1 : 0;
>> +
>> +	dev_dbg(dev, "getalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
>> +		alm_en,
>> +		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
>> +		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
>> +
>> +	alm_tm->tm_sec = bcd2bin(alm_tm->tm_sec);
>> +	alm_tm->tm_min = bcd2bin(alm_tm->tm_min);
>> +	alm_tm->tm_hour = bcd2bin(alm_tm->tm_hour);
>> +	alm_tm->tm_mday = bcd2bin(alm_tm->tm_mday);
>> +	alm_tm->tm_mon = bcd2bin(alm_tm->tm_mon);
>> +	alm_tm->tm_mon -= 1;
> You could merge both lines.

Ack.

> 
>> +	alm_tm->tm_year = bcd2bin(alm_tm->tm_year);
>> +
>> +	clk_disable(pdata->clk);
>> +	return 0;
>> +}
>> +
>> +static int pic32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
>> +	struct rtc_time *tm = &alrm->time;
>> +	void __iomem *base = pdata->reg_base;
>> +
>> +	clk_enable(pdata->clk);
>> +	dev_dbg(dev, "setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
>> +		alrm->enabled,
>> +		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
>> +		tm->tm_hour, tm->tm_min, tm->tm_sec);
>> +
>> +	writel(0x00, base + PIC32_ALRMTIME);
>> +	writel(0x00, base + PIC32_ALRMDATE);
>> +
>> +	if (tm->tm_sec < 60 && tm->tm_sec >= 0)
>> +		writeb(bin2bcd(tm->tm_sec), base + PIC32_ALRMSEC);
>> +
>> +	if (tm->tm_min < 60 && tm->tm_min >= 0)
>> +		writeb(bin2bcd(tm->tm_min), base + PIC32_ALRMMIN);
>> +
>> +	if (tm->tm_hour < 24 && tm->tm_hour >= 0)
>> +		writeb(bin2bcd(tm->tm_hour), base + PIC32_ALRMHOUR);
>> +
> 
> Those three tests are unnecessary because rtc_valid_tm() is called
> before ops->set_alarm.

Good catch. Ack.

> 
>> +	pic32_rtc_setaie(dev, alrm->enabled);
>> +
>> +	clk_disable(pdata->clk);
>> +	return 0;
>> +}
>> +
> 
> [...]
> 
> 
>> +	pic32_rtc_gettime(&pdev->dev, &rtc_tm);
>> +
>> +	if (rtc_valid_tm(&rtc_tm)) {
>> +		rtc_tm.tm_year	= 100;
>> +		rtc_tm.tm_mon	= 0;
>> +		rtc_tm.tm_mday	= 1;
>> +		rtc_tm.tm_hour	= 0;
>> +		rtc_tm.tm_min	= 0;
>> +		rtc_tm.tm_sec	= 0;
>> +
>> +		pic32_rtc_settime(NULL, &rtc_tm);
>> +
>> +		dev_warn(&pdev->dev,
>> +			"warning: invalid RTC value so initializing it\n");
> 
> This is a bad idea. If you do that, userspace has no way of knowing
> whether the date is valid or not.

Ack.

> 
> [...]
> 
>> +static const struct of_device_id pic32_rtc_dt_ids[] = {
>> +	{ .compatible = "microchip,pic32mzda-rtc" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pic32_rtc_dt_ids);
> 
> This compatible string needs to be documented. Was that patch 1/2?

It was indeed patch 1/2.  I'll make sure you are copied on it next time.

> 
>> +
>> +static struct platform_driver pic32_rtc_driver = {
>> +	.probe		= pic32_rtc_probe,
>> +	.remove		= pic32_rtc_remove,
>> +	.driver		= {
>> +		.name	= DRIVER_NAME,
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table	= of_match_ptr(pic32_rtc_dt_ids),
>> +	},
>> +};
>> +module_platform_driver(pic32_rtc_driver);
>> +
>> +MODULE_DESCRIPTION("Microchip PIC32 RTC Driver");
>> +MODULE_AUTHOR("Joshua Henderson <joshua.henderson@microchip.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
> 
> I think this driver is DT only, you can get rid of MODULE_ALIAS and
> DRIVER_NAME

Ack.

Thanks,
Josh

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
