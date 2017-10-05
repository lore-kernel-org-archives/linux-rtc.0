Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:53886 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdJEUOv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 16:14:51 -0400
Received: by mail-qk0-f172.google.com with SMTP id w63so15970801qkd.10
        for <linux-rtc@vger.kernel.org>; Thu, 05 Oct 2017 13:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Thu, 5 Oct 2017 13:14:49 -0700
Message-ID: <CAOdF7nv5re6Hvv5e3Mj=tiQKBw2CvEEdE1Nt96gqZmhr5+xZ+g@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: John Stultz <john.stultz@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>,
        Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi John,

On Wed, Oct 4, 2017 at 5:16 PM, John Stultz <john.stultz@linaro.org> wrote:
>> Please let me know what you think -- and what the right approach for
>> solving this would be.
>
> So I suspect the best solution for you here is: provide some
> infrastructure so clocksources that set CLOCK_SOURCE_SUSPEND_NONSTOP
> which are not the current clocksource can be used for suspend timing.

Let me see if I understand how this might work in my situation...

1. I register a clocksource and set the NONSTOP flag.
2. Give it a "low" rating so that it's not selected as the timekeeping
clocksource.
3. Create functions clocksource_select_persistent() and
timekeeping_notify_persistent()
4. Add `struct tk_read_base tk_persistent' to `struct timekeeper'
5. Possibly add a change_persistent_clocksource() function to timekeeping.c

> We should also figure out how to best handle ntpd in userspace dealing
> with frequent suspend/resume cycles. This is problematic, as the
> closest analogy is trying driving on the road while frequently falling
> asleep.  This is not something I think ntpd handles well.  I suspect
> our options are that any ntp adjustments being made might be made for
> far too long (causing potentially massive over-correction) or not at
> all, and not at all seems slightly better in my mind.

Indeed. Because of this, we've actually disabled NTP time slewing for now. We
always "jump" the time whenever we sync with the server.

However, I set up a test with the chrony NTP daemon (and the "delta_delta"
compensation disabled). I modified chrony to do the following:

    1. hold a "wake lock" with the power management daemon whenever
doing anything (e.g. sync with time server)
    2. use an alarmtimer (timerfd backed by CLOCK_BOOTTIME_ALARM) to
back up the select(2) timeout.

In this configuration, the NTP corrections were very stable, the drift
converged, the
jitter was negligible (less than 0.010 sec), and the time synchronized
very slowly
and methodically (as it should).

In a similar test with connman's NTP implementation (which is much less
sophisticated and does not estimate drift), we got "good" results.

Thanks,
Gabe
