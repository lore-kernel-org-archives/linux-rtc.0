Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:55462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeINCC5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 13 Sep 2018 22:02:57 -0400
Date: Thu, 13 Sep 2018 22:51:36 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180913205136.GL14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
 <20180913204412.GA30987@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180913204412.GA30987@ravnborg.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/09/2018 22:44:12+0200, Sam Ravnborg wrote:
> > The boolean properties usually don't work well for RTCs because people
> > usually want to keep any previous configuration that may have been done
> > at the factory or in the bootloader so I would use:
> > 
> > nxp,quartz_load_fF and this would be either 7000 or 12500.
> We had is implmented like this (using pF) in the beginning but
> then went for the simpler property.
> Will add a fF property as you suggest and avoid breaking the existing drivers.
> We will check a few of the boards to see if the current configuration
> of the pcf8523 driver looks wrong, and if so we will print
> the warnings as suggested.
> 
> I think the above covers feedback on all patches.
> And thanks for the feedback!
> 

Hint: look at the cubox-i and the hummingboard schematics. I'm
definitely not an analog expert but the two capacitors on the cubox-i
are making me think that the setting should be different from the
hummingboard.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
