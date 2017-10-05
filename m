Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:56860 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdJEQro (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 12:47:44 -0400
Received: by mail-qk0-f170.google.com with SMTP id l194so5336191qke.13
        for <linux-rtc@vger.kernel.org>; Thu, 05 Oct 2017 09:47:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710051216050.2083@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
 <alpine.DEB.2.20.1710051216050.2083@nanos>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Thu, 5 Oct 2017 09:47:42 -0700
Message-ID: <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Thomas,

On Thu, Oct 5, 2017 at 4:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > The SoC we use backs the monotonic clock (sched_clock_register()) with a
>
> Again. monotonic clock != sched clock. The clocksource which feeds the
> monotonic timekeeper clock is registered via clocksource_register() & al.

Sorry. I was hedging since I wasn't sure *which* term to use.

> Groan. Engineering based on theories is doomed to begin with.

I knew you'd say that. :-p

> Your 36 hour time jump is probably exactly 36.4089 hours as that's
>
>      ((1 << 32) / 32768) / 3600
>
> i.e. the 32bit rollover of the clocksource. So, if the clocksource->read()
> function returns a full 64bit counter value, then it must have protection
> against observing the rollover independent of the clock which feeds that
> counter. Of course the frequency changes the probablity of observing it,
> but still the read function must be protected against observing the
> rollover unconditionally.

Right, but isn't this what clocksource->mask is supposed to do? When we change
the back-end frequency, we're still using the same front-end 32-bit register and
we don't see the same jumps.

> Which SoC/clocksource driver are you talking about?

NXP i.MX 6SoloX
drivers/clocksource/timer-imx-gpt.c
drivers/rtc/rtc-snvs.c
arch/arm/boot/dts/imx6sx.dtsi (included from imx6sx-sdb.dts)
   (node: soc/aips1/gpt)

We patched the RTC driver to call register_persistent_clock()
(arch/arm/kernel/time.c)

The upstream driver doesn't support using the 32kHz clock, but the silicone
does... so we modified the driver to accept it and set the "NONSTOP" flag.

> I can understand that. Though, using that value for injecting accurate
> sleep time should just work with the existing code no matter how long the
> actual sleep time was. The timekeeping core takes the nsec part of the
> timespec value retrieved via read_persistent_clock64() into account.
>
> I still have a hard time to figure out what you are trying to achieve.

I'm trying to disable this block:

int timekeeping_suspend(void)
{
        struct timekeeper *tk = &tk_core.timekeeper;
        unsigned long flags;
#ifdef CONFIG_PERSISTENT_CLOCK_IS_LOW_PRECISION
        struct timespec64               delta, delta_delta;
        static struct timespec64        old_delta;
#endif

        read_persistent_clock64(&timekeeping_suspend_time);

//...

#ifdef CONFIG_PERSISTENT_CLOCK_IS_LOW_PRECISION
        if (persistent_clock_exists) {
                /*
                 * To avoid drift caused by repeated suspend/resumes,
                 * which each can add ~1 second drift error,
                 * try to compensate so the difference in system time
                 * and persistent_clock time stays close to constant.
                 */
                delta = timespec64_sub(tk_xtime(tk), timekeeping_suspend_time);
                delta_delta = timespec64_sub(delta, old_delta);
                if (abs(delta_delta.tv_sec) >= 2) {
                        /*
                         * if delta_delta is too large, assume time correction
                         * has occurred and set old_delta to the current delta.
                         */
                        old_delta = delta;
                } else {
                        /* Otherwise try to adjust old_system to compensate */
                        timekeeping_suspend_time =

timespec64_add(timekeeping_suspend_time, delta_delta);
                }
        }
#endif

In the typical case, it is trying to maintain the assumption that
(ideally) 'delta'
is a constant. It tries to maintain this assumption by fiddling with
the "suspend
time" -- adding or subtracting a little to it.

However, if NTP has adjusted the system time but *not* adjusted the persistent
clock's time... then the assumption is violated, 'delta' is *not*
constant, and this
block cancels out the NTP corrections.

-gabe
