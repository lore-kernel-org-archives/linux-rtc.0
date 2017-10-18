Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34474 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdJRV05 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 17:26:57 -0400
Date: Wed, 18 Oct 2017 23:26:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Introduce clock precision to help time travelers was Re: Extreme
 time jitter with suspend/resume cycles
Message-ID: <20171018212645.7htby4qmnfbep3vx@piout.net>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <20171015063738.GA24716@xo-6d-61-c0.localdomain>
 <20171018213449.523cd958@alans-desktop>
 <20171018210828.GA3581@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018210828.GA3581@amd>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/10/2017 at 23:08:28 +0200, Pavel Machek wrote:
> On Wed 2017-10-18 21:34:49, Alan Cox wrote:
> > > And even the boring ones have pretty imprecise RTCs... For example Nokia N9.
> > > I only power it up from time to time, I believe it drifts something like
> > > minute per month... For normal use with SIM card, it can probably correct
> > > from GSM network if you happen to have a cell phone signal, but...
> > > 
> > > More interesting machines... Old thinkpad is running without CMOS battery.
> > > ARM OLPC has _three_ RTCs, but not a single working one. N900 has working
> > > RTC but no or dead backup battery. On these, RTC driver probably knows
> > > time is not valid, but feeds the garbage into the system time, anyway. Ouch.
> > > Neither Sharp Zaurus SL-5500 nor C-3000 had battery backup on RTC...
> > 
> > Not a new problem, RTC's used to cost lots of money 8)
> > 
> > Most early Unixen set the clock at boot from the superblock timestamp of
> > the root fs, some with RTC's also used to scream at you if the superblock
> > stamp was too far head of current time.That doesn't quite work with
> > initrd but you can do the same in userspace on Linux so you'll at least
> > get 'when I last booted it' and because it's always moving forward lots
> > of other messes don't happen.
> 
> Yeah, that's what "swclock" module of init system does. Someone solved
> that one for me. But... that's not good enough. In particular, I'd
> like time not to be displayed when "swclock" was used. Nokia 6230
> could do it, so linux should be able to do it, too.
> 
> It seems kernel should pass accurancy info, or at least "this time is
> probably off by hours at least" from gettimeofday() and similar
> syscalls...

The question being how do you expect the kernel to get that information?

Some RTCs will tell you when they lost time/time accuracy and this
should be properly reported by the driver. If not, this has to be
implemented.

For anything else, it is probably the job of userspace to try to be
clever.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
