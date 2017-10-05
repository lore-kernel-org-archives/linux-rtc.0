Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44861 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdJEAQe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Oct 2017 20:16:34 -0400
Received: by mail-wr0-f180.google.com with SMTP id l24so6834643wre.1
        for <linux-rtc@vger.kernel.org>; Wed, 04 Oct 2017 17:16:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 4 Oct 2017 17:16:31 -0700
Message-ID: <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: Gabriel Beddingfield <gabe@nestlabs.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com, Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Oct 4, 2017 at 9:11 AM, Gabriel Beddingfield <gabe@nestlabs.com> wrote:
> TL;DR: the "delta_delta" hack[1 and 2] in kernel/time/timekeeping.c
> and drivers/rtc/class.c undermines the NTP system. It's not
> appropriate to use if sub-second precision is available. I've attached
> a patch to resolve this... please let me know the ways you hate it.
> :-)
>
> Hello Kernel Timekeeping Maintainers,
>
> We have been developing a device that has very a very aggressive power
> policy, doing suspend/resume cycles a few times a minute ("echo mem >
> /sys/power/state"). In doing so, we found that the system time
> experiences a lot of jitter (compared to, say, an NTP server). It was
> not uncommon for us to see time corrections of 1s to 4s on a regular
> basis. This didn't happen when the device stayed awake, only when it
> was allowed to do suspend/resume.
>
> We found that the problem is an interaction between the NTP code and
> what I call the "delta_delta hack." (see [1] and [2]) This code
> allocates a static variable in a function that contains an offset from
> the system time to the persistent/rtc clock. It uses that time to
> fudge the suspend timestamp so that on resume the sleep time will be
> compensated. It's kind of a statistical hack that assumes things will
> average out. It seems to have two main assumptions:
>
>   1. The persistent/rtc clock has only single-second precision
>   2. The system does not frequently suspend/resume.
>   3. If delta_delta is less than 2 seconds, these assumptions are "true"
>
> Because the delta_delta hack is trying to maintain an offset from the
> system time to the persistent/rtc clock, any minor NTP corrections
> that have occurred since the last suspend will be discarded. However,
> the NTP subsystem isn't notified that this is happening -- and so it
> causes some level of instability in its PLL logic.

So, on resume when we call __timekeeping_inject_sleeptime(), that uses
the TK_CLEAR_NTP which clears the NTP state (sets STA_UNSYNC, etc) .
I'm not sure how else we can notify userspace.  It may be that ntpd
doesn't expect the kernel to set things as unsynced and doesn't
recover well, but the proper fix for that probably is in userspace.

>
> This problem affects any device that does "frequent" suspend/resume
> cycles. I.e. any battery-powered "linux" device (like Android phones).

Ironically, if I recall correctly, the delta_delta "hack" originally
came from Android developers who were trying to find a solution to the
~1sec per suspend  time error that we had before.


> Many ARM systems provide a "persistent clock." Most of them are backed
> by a 32kHz clock that gives good precision and makes the delta_delta
> hack unnecessary. However, devices that only have single-second
> precision for the persistent clock and/or are forced to use the RTC
> (whose API only allows for single-second precision) -- they still need
> this hack.
>
> I've attached a patch that we developed in-house. I have a feeling you
> won't like it... since it pushes the responsibility on whoever
> configures the kernel. It also ignores the RTC problem (which will
> still affect a lot of battery-powered devices).
>
> Please let me know what you think -- and what the right approach for
> solving this would be.

So I suspect the best solution for you here is: provide some
infrastructure so clocksources that set CLOCK_SOURCE_SUSPEND_NONSTOP
which are not the current clocksource can be used for suspend timing.

We should also figure out how to best handle ntpd in userspace dealing
with frequent suspend/resume cycles. This is problematic, as the
closest analogy is trying driving on the road while frequently falling
asleep.  This is not something I think ntpd handles well.  I suspect
our options are that any ntp adjustments being made might be made for
far too long (causing potentially massive over-correction) or not at
all, and not at all seems slightly better in my mind.

Miroslav may have other thoughts?

thanks
-john
