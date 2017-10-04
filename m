Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:56389 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdJDXKD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Oct 2017 19:10:03 -0400
Received: by mail-qt0-f179.google.com with SMTP id 34so5190437qtb.13
        for <linux-rtc@vger.kernel.org>; Wed, 04 Oct 2017 16:10:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710041931560.2406@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <alpine.DEB.2.20.1710041931560.2406@nanos>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Wed, 4 Oct 2017 16:10:01 -0700
Message-ID: <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Thomas,

Thanks for your reply!

On Wed, Oct 4, 2017 at 11:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Calling things a hack which might have been thought out carefully does not
> make people more receptive.

My bad... sorry! You're right. The code in question is better than a "hack."

>> Many ARM systems provide a "persistent clock." Most of them are backed
>> by a 32kHz clock that gives good precision and makes the delta_delta
>> hack unnecessary. However, devices that only have single-second
>> precision for the persistent clock and/or are forced to use the RTC
>> (whose API only allows for single-second precision) -- they still need
>> this hack.
>
> I have no idea what you are trying to tell me. We know that there are
> systems which have a clocksource which continues to tick across
> suspend/resume.

I'm referring to read_persistent_clock64() API... which is distinct from the
CLOCK_SOURCE_SUSPEND_NONSTOP flag.

> Such clocksources can be flagged with CLOCK_SOURCE_SUSPEND_NONSTOP and the
> timekeeping resume code uses them when available instead of using the
> RTC. There are a few of them flagged as such in the kernel, but it might
...
> It's neither a problem of the timekeeping core code to select the
> appropriate clocksource for a system. That's up to the developer who
> implemented the SoC/CPU support and made a decision about rating the
> clocksource(s), which might end up selecting one which stops in suspend.

This was our first approach. However, because of some hardware
limitations we couldn't
move the system's monotonic clock to the persistent clock. They had to
be two different
clocks. (Details below.)

> Without looking at what it does, I can tell you that making it a config
> option is not going to fly. It has to be runtime discoverable as we have to
> support multi platform kernels.

OK. Here's a couple ideas...

APPROACH ONE: Use a heuristic

If read_persistent_clock64() ever returns fractional seconds (as
apposed to whole seconds), then
permanently disable the compensation.

APPROACH TWO: Use a property

Provide another weak symbol like this:

    extern u64 persistent_clock_precision;

or..

    void get_persistent_clock_precision(struct timespec *ts);
    void get_persistent_clock_percision64(struct timespec64 *ts);

And the value returned should be, approximately, the minimum time
between clock ticks.
For clocks that only supply whole-second precision... the value should
be NSECS_PER_SEC.
For clocks that are backed by, say, a 32kHz clock... the value should be
(NSECS_PER_SEC/32768).

> Though I still want to know exactly why you think that you need some extra
> magic in the timekeeping core code. If your system has a clocksource which
> is not stopping on suspend and it lacks the flag, then this is a one liner
> patch. If there is something else, then please elaborate.

Long story short: you can't always have your low-power clock be your
monotonic/sched
clock.

The SoC we use backs the monotonic clock (sched_clock_register()) with
a counter that is
high frequency (>10 MHz) in their reference implementation. But it
does not count when the
system is in low-power mode. However, it can be configured to use a
32kHz clock that *does*
count when the system is in low-power mode. So, we started by using
this clock and setting the
CLOCK_SOURCE_SUSPEND_NONSTOP flag. It worked great... at first.

Then we found that devices would randomly experience a 36-hour time jump.
While we don't have a definitive root cause, the current theory is
that we are getting
non-atomic reads because the clock source isn't synchronized with the
the high frequency
clock (which is used for most of the digital logic on the SoC).

Therefore, we moved the monotonic/sched clock back to the high-frequency source.

Meanwhile, we can directly read the RTC clock on this system, and it
will give us 32kHz
resolution and also runs non-stop. Since reads are non-atomic, we have
to read the
registers in a loop. We used this register to implement
read_persistent_clock64().
Because we have to read the registers in a loop, it seemed unfit for use as the
monotonic/sched clock.

Thanks,
Gabe
