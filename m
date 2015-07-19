Return-Path: <rtc-linux+bncBCH4V2OOTYHBBKNAV6WQKGQEMIQKEHY@googlegroups.com>
Received: from mail-wg0-x244.google.com (mail-wg0-x244.google.com. [2a00:1450:400c:c00::244])
        by gmr-mx.google.com with ESMTPS id t6si253131wiz.0.2015.07.19.09.28.25
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2015 09:28:25 -0700 (PDT)
Received: by wgal16 with SMTP id l16so3794596wga.3
        for <rtc-linux@googlegroups.com>; Sun, 19 Jul 2015 09:28:25 -0700 (PDT)
Date: Sun, 19 Jul 2015 18:28:17 +0200 (CEST)
From: "'Hans Ulli Kroll' via rtc-linux" <rtc-linux@googlegroups.com>
To: Roman Yeryomin <roman@advem.lv>
cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
    linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@openwrt.org>,
    rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>,
    linux-kernel@vger.kernel.org,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Russell King <rmk+kernel@arm.linux.org.uk>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <89dc8e097d12d9400217a237b7a6ca6e@advem.lv>
Message-ID: <alpine.LNX.2.00.1507191821310.12665@localhost>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv> <1781580.JRD7b0UrJA@wuerfel> <89dc8e097d12d9400217a237b7a6ca6e@advem.lv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi

On Thu, 9 Jul 2015, Roman Yeryomin wrote:

> On 2015-07-09 11:04, Arnd Bergmann wrote:
> > On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> > > 
> > > OK, here are the minimal changes required (see attachment). Tested on
> > > 4.1.1
> > > Let me know if you want me to submit it in some other way.
> > > 
> > 
> > The changes look ok to me. Please submit them as two separate
> > patches (1. set up and use timer3, 2. register sched_clock) according
> > to the Documentation/SubmittingPatches description.
> > 
> 
> So what do we do?
> Do you still want me to split this as you said and submit or you want Hans's
> patches rebased/resubmitted?
> 
> Regards,
> Roman
> 

can you rebase your patches againt my branch at

git://github.com/ulli-kroll/linux.git gemini/clockevents/4.3

I've added here the clockevents changes for 4.3 and patch fory
arch/arm/mach-gemini 
This changes will then go arm@kernel.org.

Hans Ulli
