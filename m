Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:60127 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeI0BFw (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 26 Sep 2018 21:05:52 -0400
Date: Wed, 26 Sep 2018 20:51:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180926185121.GF16644@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
 <20180926154708.GA3264@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926154708.GA3264@bogus>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 26/09/2018 10:47:08-0500, Rob Herring wrote:
> > > +Optional property:
> > > +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> > > +  which differ from the default value of 7 pF
> > > +
> > 
> > The boolean properties usually don't work well for RTCs because people
> > usually want to keep any previous configuration that may have been done
> > at the factory or in the bootloader so I would use:
> > 
> > nxp,quartz_load_fF and this would be either 7000 or 12500.
> 
> Use '-' rather than '_'.
> 
> There's already a defined unit suffix of '-picofarads'. If you need 
> '-femtofarads', then please add to property-units.txt. Though I'd prefer 
> not as wouldn't a value of 12 (or 13) be close enough for the needs 
> here?
> 

For that particular RTC, yes but the isl1208 has 0.5pF steps and the
x1205 has 0.25pf steps. I'd prefer having a single generic property for
all the RTCs: quartz-load-femtofarads.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
