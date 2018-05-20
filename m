Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50729 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeETSkF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 May 2018 14:40:05 -0400
Date: Sun, 20 May 2018 20:40:01 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] rtc: pcf2127: add support for accessing internal static
 RAM
Message-ID: <20180520184001.xcgn4b6aijvfzu37@pengutronix.de>
References: <20180520133723.30547-1-u.kleine-koenig@pengutronix.de>
 <20180520180520.GC23730@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180520180520.GC23730@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello Alexandre,

On Sun, May 20, 2018 at 08:05:20PM +0200, Alexandre Belloni wrote:
> On 20/05/2018 15:37:23+0200, Uwe Kleine-König wrote:
> > @@ -200,8 +242,21 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >  
> >  	pcf2127->rtc = devm_rtc_device_register(dev, name, &pcf2127_rtc_ops,
> >  						THIS_MODULE);
> > +	if (IS_ERR(pcf2127->rtc))
> > +		return PTR_ERR(pcf2127->rtc);
> > +
> > +	if (has_nvmem) {
> > +		struct nvmem_config nvmem_cfg = {
> > +			.priv = pcf2127,
> > +			.reg_read = pcf2127_nvmem_read,
> > +			.reg_write = pcf2127_nvmem_write,
> > +			.size = 512,
> > +		};
> > +
> > +		ret = rtc_nvmem_register(pcf2127->rtc, &nvmem_cfg);
> > +	}
> >  
> > -	return PTR_ERR_OR_ZERO(pcf2127->rtc);
> > +	return ret;
> 
> You must not return an error here once devm_rtc_device_register has
> succeeded.

Why? Sounds like something that should be fixed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
