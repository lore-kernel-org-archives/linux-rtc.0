Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:51244 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTXHD (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 20 Aug 2018 19:07:03 -0400
Date: Mon, 20 Aug 2018 21:50:02 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20180820195002.GW21707@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
 <20180820191247.GU21707@piout.net>
 <1534792697.1744.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1534792697.1744.0@crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/08/2018 21:18:17+0200, Paul Cercueil wrote:
> Hi,
> 
> Le lun. 20 août 2018 à 21:12, Alexandre Belloni
> <alexandre.belloni@bootlin.com> a écrit :
> > On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
> > >  Depending on MACH_INGENIC prevent us from creating a generic kernel
> > > that
> > >  works on more than one MIPS board. Instead, we just depend on MIPS
> > > being
> > >  set.
> > 
> > Maybe you could consider dropping the whole dependency as we already
> > know it will build on every architecture.
> 
> Well, I didn't really want the Kconfig option to show on the menu when
> compiling for non-MIPS, since it's only ever useful there.
> 
> Should I drop the dependency then?
> 

No, I don't mind.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
