Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:32999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdJELBX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 07:01:23 -0400
Date: Thu, 5 Oct 2017 13:01:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gabriel Beddingfield <gabe@nestlabs.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Extreme time jitter with suspend/resume cycles
In-Reply-To: <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710051216050.2083@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 4 Oct 2017, Gabriel Beddingfield wrote:
> On Wed, Oct 4, 2017 at 11:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Long story short: you can't always have your low-power clock be your
> monotonic/sched clock.

sched_clock and the clocksource for timekeeping, which feeds monotonic are
not required to be the same thing.
 
> The SoC we use backs the monotonic clock (sched_clock_register()) with a

Again. monotonic clock != sched clock. The clocksource which feeds the
monotonic timekeeper clock is registered via clocksource_register() & al.

> counter that is high frequency (>10 MHz) in their reference
> implementation. But it does not count when the system is in low-power
> mode. However, it can be configured to use a 32kHz clock that *does*
> count when the system is in low-power mode. So, we started by using this
> clock and setting the CLOCK_SOURCE_SUSPEND_NONSTOP flag. It worked
> great... at first.
> 
> Then we found that devices would randomly experience a 36-hour time jump.
> While we don't have a definitive root cause, the current theory is that
> we are getting non-atomic reads because the clock source isn't
> synchronized with the the high frequency clock (which is used for most of
> the digital logic on the SoC).

Groan. Engineering based on theories is doomed to begin with.

Your 36 hour time jump is probably exactly 36.4089 hours as that's

     ((1 << 32) / 32768) / 3600

i.e. the 32bit rollover of the clocksource. So, if the clocksource->read()
function returns a full 64bit counter value, then it must have protection
against observing the rollover independent of the clock which feeds that
counter. Of course the frequency changes the probablity of observing it,
but still the read function must be protected against observing the
rollover unconditionally.

Which SoC/clocksource driver are you talking about?

> Therefore, we moved the monotonic/sched clock back to the high-frequency source.

Please stop confusing timekeeping clock source and sched clock. They might
be the same physical device but conceptually they are different.

> Meanwhile, we can directly read the RTC clock on this system, and it will
> give us 32kHz resolution and also runs non-stop. Since reads are
> non-atomic, we have to read the registers in a loop. We used this
> register to implement read_persistent_clock64().  Because we have to read
> the registers in a loop, it seemed unfit for use as the monotonic/sched
> clock.

I can understand that. Though, using that value for injecting accurate
sleep time should just work with the existing code no matter how long the
actual sleep time was. The timekeeping core takes the nsec part of the
timespec value retrieved via read_persistent_clock64() into account.

I still have a hard time to figure out what you are trying to achieve.

Thanks,

	tglx
