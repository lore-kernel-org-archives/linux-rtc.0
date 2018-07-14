Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:54446 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeGNQnz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 14 Jul 2018 12:43:55 -0400
Date: Sat, 14 Jul 2018 18:24:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
Message-ID: <20180714162419.GX16084@piout.net>
References: <20180713151424.13000-1-paul@crapouillou.net>
 <20180714131920.GU16084@piout.net>
 <1531574734.2831.0@smtp.crapouillou.net>
 <20180714133250.GW16084@piout.net>
 <1531576208.2831.1@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531576208.2831.1@smtp.crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 14/07/2018 15:50:08+0200, Paul Cercueil wrote:
> > >  > This would avoid that change (and the test would preferably be
> > >  > (rtc->type == ID_JZ4780))
> > > 
> > >  That branch should be taken if the SoC is JZ4760, JZ4770 or JZ4780.
> > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
> > 
> > Sure but you can achieve that with only 2 ids...
> > 
> > > 
> > >  > >   		ret = jz4780_rtc_enable_write(rtc);
> > >  > >   	if (ret == 0)
> > >  > >   		ret = jz4740_rtc_wait_write_ready(rtc);
> > >  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
> > >  > >
> > >  > >   static const struct of_device_id jz4740_rtc_of_match[] = {
> > >  > >   	{ .compatible = "ingenic,jz4740-rtc", .data = (void
> > > *)ID_JZ4740 },
> > >  > >  +	{ .compatible = "ingenic,jz4725b-rtc", .data = (void
> > > *)ID_JZ4725B
> > >  > > },
> > >  > >  +	{ .compatible = "ingenic,jz4760-rtc", .data = (void
> > > *)ID_JZ4760 },
> > >  > >  +	{ .compatible = "ingenic,jz4770-rtc", .data = (void
> > > *)ID_JZ4770 },
> > 
> > By doing the correct mapping here e.g:
> > 
> > { .compatible = "ingenic,jz4725b-rtc", .data = (void *)ID_JZ4740 },
> 
> Not very pretty and future-proof if you ask me...
> But you're the boss...
> 

I think it makes the code simpler to follow . Regarding future
proofness, you will have to add code and probably use a switch case at
the time you need to handle an RTC differently. At that time, the >=
test trick will not work anymore anyway.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
