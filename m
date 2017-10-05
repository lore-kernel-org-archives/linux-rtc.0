Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbdJESB2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 14:01:28 -0400
Date: Thu, 5 Oct 2017 20:01:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gabriel Beddingfield <gabe@nestlabs.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
In-Reply-To: <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710051943570.2398@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com> <alpine.DEB.2.20.1710051216050.2083@nanos>
 <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Gabriel,

On Thu, 5 Oct 2017, Gabriel Beddingfield wrote:
> On Thu, Oct 5, 2017 at 4:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > i.e. the 32bit rollover of the clocksource. So, if the clocksource->read()
> > function returns a full 64bit counter value, then it must have protection
> > against observing the rollover independent of the clock which feeds that
> > counter. Of course the frequency changes the probablity of observing it,
> > but still the read function must be protected against observing the
> > rollover unconditionally.
> 
> Right, but isn't this what clocksource->mask is supposed to do? When we change
> the back-end frequency, we're still using the same front-end 32-bit register and
> we don't see the same jumps.

Right. That's what the mask should protect. I was assuming that this is one
of the fancy clocksources which expose two 32bit registers of a 64bit
counter and the rollover protection was missing. So that's not the
case. Good, or not so good :)

> > Which SoC/clocksource driver are you talking about?
> 
> NXP i.MX 6SoloX
> drivers/clocksource/timer-imx-gpt.c

So that clocksource driver looks correct. Do you have an idea in which
context this time jump happens? Does it happen when you exercise your high
frequency suspend/resume dance or is that happening just when you let the
machine run forever as well?

The timekeeping_resume() path definitely has an issue:

        cycle_now = tk_clock_read(&tk->tkr_mono);
        if ((clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
                cycle_now > tk->tkr_mono.cycle_last) {

This works nice for clocksources which wont wrap across suspend/resume but
not for those which can. That cycle_now -> cycle_last check should take
cs-mask into account ...

Of course for clocksources which can wrap within realistic suspend times,
which 36 hours might be accounted for, this would need an extra sanity
check against a RTC whether wrap time has been exceeded.

I haven't thought it through whether that buggered check fully explains
what you are observing, but it's wrong nevertheless. John?

Thanks,

	tglx
