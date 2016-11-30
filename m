Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBQP47TAQKGQEZPGO2JI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 85si951047wmb.3.2016.11.30.13.01.53
        for <rtc-linux@googlegroups.com>;
        Wed, 30 Nov 2016 13:01:53 -0800 (PST)
Date: Wed, 30 Nov 2016 22:01:52 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH] rtc: add support for EPSON TOYOCOM RTC-7301SF/DG
Message-ID: <20161130210152.hiyfa3srismgvtj5@piout.net>
References: <1472396118-13424-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1472396118-13424-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Sorry for the very late review!

It seems mostly fine for me, two small comments:

On 28/08/2016 at 23:55:18 +0900, Akinobu Mita wrote :
> diff --git a/drivers/rtc/rtc-r7301.c b/drivers/rtc/rtc-r7301.c
> new file mode 100644
> index 0000000..b1be281
> --- /dev/null
> +++ b/drivers/rtc/rtc-r7301.c
> @@ -0,0 +1,458 @@
> +/*
> + * EPSON TOYOCOM RTC-7301SF/DG Driver
> + *
> + * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
> + *
> + * Based on rtc-rp5c01.c
> + *
> + * Datasheet: http://www5.epsondevice.com/en/products/parallel/rtc7301sf.html
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define DRV_NAME "rtc-r7301"
> +
> +enum {
> +	RTC7301_1_SEC		= 0x0,	/* Bank 0 and Band 1 */
> +	RTC7301_10_SEC		= 0x1,	/* Bank 0 and Band 1 */
> +	RTC7301_AE		= BIT(3),
> +	RTC7301_1_MIN		= 0x2,	/* Bank 0 and Band 1 */
> +	RTC7301_10_MIN		= 0x3,	/* Bank 0 and Band 1 */
> +	RTC7301_1_HOUR		= 0x4,	/* Bank 0 and Band 1 */
> +	RTC7301_10_HOUR		= 0x5,	/* Bank 0 and Band 1 */
> +	RTC7301_DAY_OF_WEEK	= 0x6,	/* Bank 0 and Band 1 */
> +	RTC7301_1_DAY		= 0x7,	/* Bank 0 and Band 1 */
> +	RTC7301_10_DAY		= 0x8,	/* Bank 0 and Band 1 */
> +	RTC7301_1_MONTH		= 0x9,	/* Bank 0 */
> +	RTC7301_10_MONTH	= 0xa,	/* Bank 0 */
> +	RTC7301_1_YEAR		= 0xb,	/* Bank 0 */
> +	RTC7301_10_YEAR		= 0xc,	/* Bank 0 */
> +	RTC7301_100_YEAR	= 0xd,	/* Bank 0 */
> +	RTC7301_1000_YEAR	= 0xe,	/* Bank 0 */
> +	RTC7301_ALARM_CONTROL	= 0xe,	/* Bank 1 */
> +	RTC7301_ALARM_CONTROL_AIE	= BIT(0),
> +	RTC7301_ALARM_CONTROL_AF	= BIT(1),
> +	RTC7301_TIMER_CONTROL	= 0xe,	/* Bank 2 */
> +	RTC7301_ALARM_CONTROL_TIE	= BIT(0),
> +	RTC7301_ALARM_CONTROL_TF	= BIT(1),
> +	RTC7301_CONTROL		= 0xf,	/* All banks */
> +	RTC7301_CONTROL_BUSY		= BIT(0),
> +	RTC7301_CONTROL_STOP		= BIT(1),
> +	RTC7301_CONTROL_BANK_SEL_0	= BIT(2),
> +	RTC7301_CONTROL_BANK_SEL_1	= BIT(3),
> +};
> +

Any particular reason why you use an enum instead of the usual #define?

[...]

> +static void rtc7301_init(struct rtc7301_priv *priv)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	rtc7301_select_bank(priv, 1);
> +	rtc7301_alarm_irq(priv, false);
> +

If the RTC is battery backed, it may still run with the core power off
and maybe someone will actually expect the alarm to trigger at a later
time.

I don't mind much as you are probably the only user anyway.


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
