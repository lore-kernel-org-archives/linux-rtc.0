Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58638 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdJDSWT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Oct 2017 14:22:19 -0400
Date: Wed, 4 Oct 2017 20:22:10 +0200 (CEST)
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
In-Reply-To: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710041931560.2406@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Gabriel,

On Wed, 4 Oct 2017, Gabriel Beddingfield wrote:

thanks for bringing this up. Let's see where this goes.

Disclaimer: I did not bother to look at the patch yet because:

  1) It's an attachment and I'm too lazy to open and convert it to inline
     for reply. Sending patches inline is the preferred way, but maybe I
     should be thankful that you did not, as you consider it as ugly
     yourself.

  2) I want to discuss the conceptual issues first w/o being biased by
     looking at the patch.

> We have been developing a device that has very a very aggressive power
> policy, doing suspend/resume cycles a few times a minute ("echo mem >
> /sys/power/state"). In doing so, we found that the system time
> experiences a lot of jitter (compared to, say, an NTP server). It was
> not uncommon for us to see time corrections of 1s to 4s on a regular
> basis. This didn't happen when the device stayed awake, only when it
> was allowed to do suspend/resume.
> 
> We found that the problem is an interaction between the NTP code and
> what I call the "delta_delta hack." (see [1] and [2])

What you consider a hack might other people not. In fact it is the least
resort the kernel has on a lot of systems to maintain some halfways
accurate notion of walltime across suspend/resume.

I personally consider using high frequency suspend to mem a hack as well,
because contrary to suspend to idle and proper runtime power management it
must go through a lot of work which drains power and it prevents the kernel
from using all of its knowledge of power saving / wakeup predictions etc to
avoid that.  But it might be as well the least resort on a particular
system or use case scenario to squeeze the most lifetime out of the
battery.

Calling things a hack which might have been thought out carefully does not
make people more receptive.

> This code allocates a static variable in a function that contains an
> offset from the system time to the persistent/rtc clock. It uses that
> time to fudge the suspend timestamp so that on resume the sleep time will
> be compensated. It's kind of a statistical hack that assumes things will
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

The latter might be trivial to solve by adding TK_NTP_CLEAR to the
timekeeping_update() flags if the RTC was used for injecting the sleep
time, but I leave that to John for judgement.

> This problem affects any device that does "frequent" suspend/resume
> cycles. I.e. any battery-powered "linux" device (like Android phones).

Depends as there are other options depending on your SoC/CPU.

> Many ARM systems provide a "persistent clock." Most of them are backed
> by a 32kHz clock that gives good precision and makes the delta_delta
> hack unnecessary. However, devices that only have single-second
> precision for the persistent clock and/or are forced to use the RTC
> (whose API only allows for single-second precision) -- they still need
> this hack.

I have no idea what you are trying to tell me. We know that there are
systems which have a clocksource which continues to tick across
suspend/resume.

Such clocksources can be flagged with CLOCK_SOURCE_SUSPEND_NONSTOP and the
timekeeping resume code uses them when available instead of using the
RTC. There are a few of them flagged as such in the kernel, but it might
not be the complete set of capable devices which is neither a problem of
the timekeeping core code nor of the maintainers, as we are not able to
verify every single hardware detail of a submitted driver for obvious
reasons.

It's neither a problem of the timekeeping core code to select the
appropriate clocksource for a system. That's up to the developer who
implemented the SoC/CPU support and made a decision about rating the
clocksource(s), which might end up selecting one which stops in suspend.

If your particular use case is not working with the rating decision of the
developers you can override that decision on the kernel command line or
after boot through sysfs. With some restrictions you can even switch back
and forth during runtime, though that might not be the best idea if you
want to maintain a high precision wall time clock. Again, that depends on
your use case and system.

If the clocksource on your system is missing a flag despite being nonstop
across suspend, feel free to send a patch.

> I've attached a patch that we developed in-house. I have a feeling you
> won't like it... since it pushes the responsibility on whoever
> configures the kernel. It also ignores the RTC problem (which will
> still affect a lot of battery-powered devices).

Without looking at what it does, I can tell you that making it a config
option is not going to fly. It has to be runtime discoverable as we have to
support multi platform kernels.

Though I still want to know exactly why you think that you need some extra
magic in the timekeeping core code. If your system has a clocksource which
is not stopping on suspend and it lacks the flag, then this is a one liner
patch. If there is something else, then please elaborate.

Thanks,

	tglx
