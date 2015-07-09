Return-Path: <rtc-linux+bncBCH4V2OOTYHBBTOD7GWAKGQEA55O4LA@googlegroups.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com. [2a00:1450:400c:c00::22c])
        by gmr-mx.google.com with ESMTPS id ec7si284898wib.3.2015.07.09.04.58.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 04:58:05 -0700 (PDT)
Received: by mail-wg0-x22c.google.com with SMTP id m20so37816190wgx.3
        for <rtc-linux@googlegroups.com>; Thu, 09 Jul 2015 04:58:05 -0700 (PDT)
Date: Thu, 9 Jul 2015 13:58:02 +0200 (CEST)
From: "'Hans Ulli Kroll' via rtc-linux" <rtc-linux@googlegroups.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-arm-kernel@lists.infradead.org, Roman Yeryomin <roman@advem.lv>,
    Felix Fietkau <nbd@openwrt.org>, rtc-linux@googlegroups.com,
    Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Russell King <rmk+kernel@arm.linux.org.uk>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <1781580.JRD7b0UrJA@wuerfel>
Message-ID: <alpine.LNX.2.00.1507091343150.24357@localhost>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com> <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv> <1781580.JRD7b0UrJA@wuerfel>
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

On Thu, 9 Jul 2015, Arnd Bergmann wrote:

> On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> > 
> > OK, here are the minimal changes required (see attachment). Tested on 
> > 4.1.1
> > Let me know if you want me to submit it in some other way.
> > 
> 
> The changes look ok to me. Please submit them as two separate
> patches (1. set up and use timer3, 2. register sched_clock) according
> to the Documentation/SubmittingPatches description.
> 
> Thanks,
> 
> 	Arnd
> 

have you seen this thread ...
[PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/423992

arch/arm/mach-gemini/time.c              | 69 ++++++++++++------------ 

Two or more weeks ago I send a patchset fixing this problem.
At this time Arnd was in holiday and until today I was very busy at work.

I can rework my patches on top of Viresh's patchset

and Roman please fix the subject.

Ulli
