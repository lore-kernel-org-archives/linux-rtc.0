Return-Path: <boris.brezillon@free-electrons.com>
Date: Tue, 23 Sep 2014 13:05:06 +0200
From: Boris BREZILLON <boris.brezillon@free-electrons.com>
To: Johan Hovold <johan@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Samuel
 Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Johan
 Hovold <jhovold@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] rtc: at91sam9: use clk API instead of relying
 on AT91_SLOW_CLOCK
Message-ID: <20140923130506.3433c5a3@bbrezillon>
In-Reply-To: <20140923103326.GA404@localhost>
References: <1411465130-29011-1-git-send-email-boris.brezillon@free-electrons.com>
	<1411465130-29011-9-git-send-email-boris.brezillon@free-electrons.com>
	<20140923103326.GA404@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

On Tue, 23 Sep 2014 12:33:26 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Sep 23, 2014 at 11:38:48AM +0200, Boris BREZILLON wrote:
> 
> > @@ -328,6 +328,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
> >  	struct sam9_rtc	*rtc;
> >  	int		ret, irq;
> >  	u32		mr;
> > +	unsigned int	sclk_rate;
> >  
> >  	irq = platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> > @@ -385,11 +386,27 @@ static int at91_rtc_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	rtc->sclk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(rtc->sclk))
> > +		return PTR_ERR(rtc->sclk);
> > +
> > +	sclk_rate = clk_get_rate(rtc->sclk);
> > +	if (!sclk_rate || sclk_rate > AT91_RTT_RTTRST) {
> 
> You probably meant AT91_RTT_RTPRES here.

Yes, that's what I meant.
Nice catch!

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
