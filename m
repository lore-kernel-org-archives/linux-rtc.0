Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59467 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdJOVjj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 15 Oct 2017 17:39:39 -0400
Date: Sun, 15 Oct 2017 08:39:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gabriel Beddingfield <gabe@nestlabs.com>, pavel@ucw.cz
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Introduce clock precision to help time travelers was Re: Extreme
 time jitter with suspend/resume cycles
Message-ID: <20171015063738.GA24716@xo-6d-61-c0.localdomain>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

H!

> We have been developing a device that has very a very aggressive power
> policy, doing suspend/resume cycles a few times a minute ("echo mem >
> /sys/power/state"). In doing so, we found that the system time
> experiences a lot of jitter (compared to, say, an NTP server). It was
> not uncommon for us to see time corrections of 1s to 4s on a regular
> basis. This didn't happen when the device stayed awake, only when it
> was allowed to do suspend/resume.

Ok, so I have various machines here. It seems only about half of them has
working RTC. That are the boring ones.

And even the boring ones have pretty imprecise RTCs... For example Nokia N9.
I only power it up from time to time, I believe it drifts something like
minute per month... For normal use with SIM card, it can probably correct
from GSM network if you happen to have a cell phone signal, but...

More interesting machines... Old thinkpad is running without CMOS battery.
ARM OLPC has _three_ RTCs, but not a single working one. N900 has working
RTC but no or dead backup battery. On these, RTC driver probably knows
time is not valid, but feeds the garbage into the system time, anyway. Ouch.
Neither Sharp Zaurus SL-5500 nor C-3000 had battery backup on RTC...

Even in new end-user machines, time quality varies a lot. "First boot, please
enter time" is only accurate to seconds, if the user is careful. RTC is usually
not very accurate, either... and noone uses adjtime these days. GSM time and
ntpdate are probably accurate to miliseconds, GPS can provide time down to
picoseconds... And broken systems are so common "swclock" is available in
init system to store time in file, so it at least does not go backwards.

https (and other crypto) depends on time... so it is important to know approximate
month we are in.

Is it time we handle it better?

Could we return both time and log2(expected error) from system calls?

That way we could hide the clock in GUI if time is not available or not precise
to minutes, ignore certificate dates when time is not precise to months, and
you would not have to send me a "Pavel, are you time traveling, again?" message
next time my mailer sends email dated to 1970.

									Pavel

PS: And yes, I'm time-travaling again, this time by ~15 hours.
