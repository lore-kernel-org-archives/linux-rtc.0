Return-Path: <rtc-linux+bncBDS7HNEFSALRBN4EX22QKGQEVXYN5AA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si380189wmh.0.2016.02.01.08.05.11
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Feb 2016 08:05:11 -0800 (PST)
Date: Mon, 1 Feb 2016 17:05:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, a.zummo@towertech.it,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: add rtc-asm9260 driver
Message-ID: <20160201160510.GS20165@piout.net>
References: <1454056802-23386-1-git-send-email-linux@rempel-privat.de>
 <1454056802-23386-2-git-send-email-linux@rempel-privat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454056802-23386-2-git-send-email-linux@rempel-privat.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/01/2016 at 09:40:01 +0100, Oleksij Rempel wrote :
> +static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
> +{
> +	struct asm9260_rtc_priv *priv = dev_id;
> +	u32 isr;
> +	unsigned long events = 0;
> +
> +	isr = ioread32(priv->iobase + HW_CIIR);
> +	if (!isr)
> +		return IRQ_NONE;
> +
> +	iowrite32(0, priv->iobase + HW_CIIR);
> +
> +	events |= RTC_AF | RTC_IRQF;
> +
> +	rtc_update_irq(priv->rtc, 1, events);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> +	u32 ctime0, ctime1, ctime2;
> +	unsigned long irq_flags;
> +

It would be nice to actually use BM_RTC_OSCF and return -EINVAL if it is
set.

> +	spin_lock_irqsave(&priv->lock, irq_flags);
> +	ctime0 = ioread32(priv->iobase + HW_CTIME0);
> +	ctime1 = ioread32(priv->iobase + HW_CTIME1);
> +	ctime2 = ioread32(priv->iobase + HW_CTIME2);
> +
> +	if (ctime1 != ioread32(priv->iobase + HW_CTIME1)) {
> +		/*
> +		 * woops, counter flipped right now. Now we are safe
> +		 * to reread.
> +		 */
> +		ctime0 = ioread32(priv->iobase + HW_CTIME0);
> +		ctime1 = ioread32(priv->iobase + HW_CTIME1);
> +		ctime2 = ioread32(priv->iobase + HW_CTIME2);
> +	}
> +	spin_unlock_irqrestore(&priv->lock, irq_flags);
> +
> +	tm->tm_sec  = (ctime0 >> BM_CTIME0_SEC_S)  & BM_CTIME0_SEC_M;
> +	tm->tm_min  = (ctime0 >> BM_CTIME0_MIN_S)  & BM_CTIME0_MIN_M;
> +	tm->tm_hour = (ctime0 >> BM_CTIME0_HOUR_S) & BM_CTIME0_HOUR_M;
> +	tm->tm_wday = (ctime0 >> BM_CTIME0_DOW_S)  & BM_CTIME0_DOW_M;
> +
> +	tm->tm_mday = (ctime1 >> BM_CTIME1_DOM_S)  & BM_CTIME1_DOM_M;
> +	tm->tm_mon  = (ctime1 >> BM_CTIME1_MON_S)  & BM_CTIME1_MON_M;
> +	tm->tm_year = (ctime1 >> BM_CTIME1_YEAR_S) & BM_CTIME1_YEAR_M;
> +
> +	tm->tm_yday = (ctime2 >> BM_CTIME2_DOY_S)  & BM_CTIME2_DOY_M;
> +
> +	return 0;
> +}
> +
> +static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> +	unsigned long irq_flags;
> +
> +	spin_lock_irqsave(&priv->lock, irq_flags);
> +	/*
> +	 * make sure SEC counter will not flip other counter on write time,
> +	 * real value will be written at the enf of sequence.
> +	 */
> +	iowrite32(0, priv->iobase + HW_SEC);
> +
> +	iowrite32(tm->tm_year, priv->iobase + HW_YEAR);
> +	iowrite32(tm->tm_mon,  priv->iobase + HW_MONTH);
> +	iowrite32(tm->tm_mday, priv->iobase + HW_DOM);
> +	iowrite32(tm->tm_wday, priv->iobase + HW_DOW);
> +	iowrite32(tm->tm_yday, priv->iobase + HW_DOY);
> +	iowrite32(tm->tm_hour, priv->iobase + HW_HOUR);
> +	iowrite32(tm->tm_min,  priv->iobase + HW_MIN);
> +	iowrite32(tm->tm_sec,  priv->iobase + HW_SEC);

That would be a good time to reset BM_RTC_OSCF. Maybe it can also be
useful to enable the interrupt but there isn't much more to do than
print an error message.

> +	spin_unlock_irqrestore(&priv->lock, irq_flags);
> +
> +	return 0;
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
