Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51523 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754696AbdLFLFF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 06:05:05 -0500
Date: Wed, 6 Dec 2017 12:05:03 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-kernel-dev@beckhoff.com
Cc: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
Message-ID: <20171206110503.GO21780@piout.net>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/12/2017 at 15:06:46 +0100, linux-kernel-dev@beckhoff.com wrote:
> +/* This function is the RTC interrupt service routine. */
> +static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	unsigned long flags;
> +	u32 events = 0;
> +	u32 lp_status;
> +	u32 lp_cr;
> +
> +	spin_lock_irqsave(&pdata->lock, flags);
> +	if (clk_prepare_enable(pdata->clk)) {
> +		spin_unlock_irqrestore(&pdata->lock, flags);
> +		return IRQ_NONE;
> +	}
> +
> +	lp_status = readl(ioaddr + SRTC_LPSR);
> +	lp_cr = readl(ioaddr + SRTC_LPCR);
> +
> +	/* update irq data & counter */
> +	if (lp_status & SRTC_LPSR_ALP) {
> +		if (lp_cr & SRTC_LPCR_ALP)
> +			events = (RTC_AF | RTC_IRQF);

I would just call rtc_update_irq here...

> +
> +		/* disable further lp alarm interrupts */
> +		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +	}
> +
> +	/* Update interrupt enables */
> +	writel(lp_cr, ioaddr + SRTC_LPCR);
> +
> +	/* clear interrupt status */
> +	writel(lp_status, ioaddr + SRTC_LPSR);
> +
> +	mxc_rtc_sync_lp_locked(ioaddr);
> +	rtc_update_irq(pdata->rtc, 1, events);

... because calling it here with events == 0 will result in a lot of
work for nothing (the core will walk through the timers and set the
alarm again).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
