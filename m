Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37910 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdGEV4T (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 17:56:19 -0400
Date: Wed, 5 Jul 2017 23:56:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v2 02/10] MIPS: ranchu: Add Goldfish RTC driver
Message-ID: <20170705215602.vihwoio2dagxy2fc@piout.net>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498664922-28493-3-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

The subject doesn't fit the subsystem style, this needs to be changed.

On 28/06/2017 at 17:46:55 +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> Add device driver for a virtual Goldfish RTC clock.
> 
> The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
> set. The compatible string used by OS for binding the driver is
> defined as "google,goldfish-rtc".
> 

Is it really MIPS specific? I would expect the same driver to work on
the ARM based emulator too.

> +config RTC_DRV_GOLDFISH
> +	tristate "Goldfish Real Time Clock"
> +	depends on MIPS
> +	depends on GOLDFISH

This should be made buildable with COMPILE_TEST to extend coverage.

> +	help
> +	  Say yes here to build support for the Goldfish RTC.

Please, don't expect anybody to actually know what is goldfish can you
add a sentence or two?

> +static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct goldfish_rtc	*qrtc = dev_id;
> +	unsigned long		events = 0;
> +	void __iomem *base = qrtc->base;
> +
> +	writel(1, base + TIMER_CLEAR_INTERRUPT);
> +	events = RTC_IRQF | RTC_AF;
> +
> +	rtc_update_irq(qrtc->rtc, 1, events);

I'd say that events is not needed you can pass the flags directly to
rtc_update_irq

> +static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	u64 time;
> +	u64 time_low;
> +	u64 time_high;
> +	u64 time_high_prev;
> +
> +	struct goldfish_rtc *qrtc =
> +			platform_get_drvdata(to_platform_device(dev));
> +	void __iomem *base = qrtc->base;
> +
> +	time_high = readl(base + TIMER_TIME_HIGH);
> +	do {
> +		time_high_prev = time_high;
> +		time_low = readl(base + TIMER_TIME_LOW);
> +		time_high = readl(base + TIMER_TIME_HIGH);
> +	} while (time_high != time_high_prev);

I'm not sure why you need that loop as the comments for TIMER_TIME_LOW
and TIMER_TIME_HIGH indicate that TIMER_TIME_HIGH is latched when
TIMER_TIME_LOW is read. Note that the original driver from google
doesn't do that.

> +	time = (time_high << 32) | time_low;
> +
> +	do_div(time, NSEC_PER_SEC);
> +
> +	rtc_time_to_tm(time, tm);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops goldfish_rtc_ops = {
> +	.read_time	= goldfish_rtc_read_time,
> +};
> +
> +static int goldfish_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *r;
> +	struct goldfish_rtc *qrtc;
> +	unsigned long rtc_dev_len;
> +	unsigned long rtc_dev_addr;
> +	int err;
> +
> +	qrtc = devm_kzalloc(&pdev->dev, sizeof(*qrtc), GFP_KERNEL);
> +	if (qrtc == NULL)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, qrtc);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (r == NULL)
> +		return -ENODEV;
> +
> +	rtc_dev_addr = r->start;
> +	rtc_dev_len = resource_size(r);
> +	qrtc->base = devm_ioremap(&pdev->dev, rtc_dev_addr, rtc_dev_len);

devm_ioremap_resource ?

> +	if (IS_ERR(qrtc->base))
> +		return -ENODEV;
> +
> +	qrtc->irq = platform_get_irq(pdev, 0);
> +	if (qrtc->irq < 0)
> +		return -ENODEV;
> +

Is the irq so important that you have to fail here even if the driver
doesn't support any alarm?

> +	qrtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					&goldfish_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(qrtc->rtc))
> +		return PTR_ERR(qrtc->rtc);
> +
> +	err = devm_request_irq(&pdev->dev, qrtc->irq, goldfish_rtc_interrupt,
> +		0, pdev->name, qrtc);
> +	if (err)
> +		return err;

Ditto.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
