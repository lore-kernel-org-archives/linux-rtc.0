Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:45878 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754478AbeFMJZe (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 13 Jun 2018 05:25:34 -0400
Date: Wed, 13 Jun 2018 11:25:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] rtc: ftrtc010: let the core handle range
Message-ID: <20180613092522.GS10521@piout.net>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
 <20180604141528.15635-3-alexandre.belloni@bootlin.com>
 <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/06/2018 11:10:35+0200, Linus Walleij wrote:
> On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > The current range handling is highly suspicious. Anyway, let the core
> > handle it.
> 
> Hmmm. I have datasheets, do you need some input about the hardware?
> Something I should patch?
> 

Nothing to do as you seemed to confirm what I did was OK. I could find
why it was set to 2148 in the first place. Maybe it correspond to the
default days, hours minutes, second values on the SoC.

> > The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
