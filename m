Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdJELFj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 07:05:39 -0400
Date: Thu, 5 Oct 2017 13:05:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: John Stultz <john.stultz@linaro.org>
cc: Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com, Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
In-Reply-To: <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710051301250.2083@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 4 Oct 2017, John Stultz wrote:
> On Wed, Oct 4, 2017 at 9:11 AM, Gabriel Beddingfield <gabe@nestlabs.com> wrote:
> > TL;DR: the "delta_delta" hack[1 and 2] in kernel/time/timekeeping.c
> > and drivers/rtc/class.c undermines the NTP system. It's not
> > appropriate to use if sub-second precision is available. I've attached
> > a patch to resolve this... please let me know the ways you hate it.
> > :-)
> >
> > Hello Kernel Timekeeping Maintainers,
> >
> > We have been developing a device that has very a very aggressive power
> > policy, doing suspend/resume cycles a few times a minute ("echo mem >
> > /sys/power/state"). In doing so, we found that the system time
> > experiences a lot of jitter (compared to, say, an NTP server). It was
> > not uncommon for us to see time corrections of 1s to 4s on a regular
> > basis. This didn't happen when the device stayed awake, only when it
> > was allowed to do suspend/resume.
> >
> > We found that the problem is an interaction between the NTP code and
> > what I call the "delta_delta hack." (see [1] and [2]) This code
> > allocates a static variable in a function that contains an offset from
> > the system time to the persistent/rtc clock. It uses that time to
> > fudge the suspend timestamp so that on resume the sleep time will be
> > compensated. It's kind of a statistical hack that assumes things will
> > average out. It seems to have two main assumptions:
> >
> >   1. The persistent/rtc clock has only single-second precision
> >   2. The system does not frequently suspend/resume.
> >   3. If delta_delta is less than 2 seconds, these assumptions are "true"
> >
> > Because the delta_delta hack is trying to maintain an offset from the
> > system time to the persistent/rtc clock, any minor NTP corrections
> > that have occurred since the last suspend will be discarded. However,
> > the NTP subsystem isn't notified that this is happening -- and so it
> > causes some level of instability in its PLL logic.
> 
> So, on resume when we call __timekeeping_inject_sleeptime(), that uses
> the TK_CLEAR_NTP which clears the NTP state (sets STA_UNSYNC, etc) .
> I'm not sure how else we can notify userspace.  It may be that ntpd
> doesn't expect the kernel to set things as unsynced and doesn't
> recover well, but the proper fix for that probably is in userspace.

Errm. No, __timekeeping_inject_sleeptime() only updates the timekeeper.

We have two call sites:

timekeeping_resume()
{
	.....
	if (sleeptime_injected)
		__timekeeping_inject_sleeptime(tk, &ts_delta);
	...
	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
	...
}

and

timekeeping_inject_sleeptime64()
{
	__timekeeping_inject_sleeptime(tk, &delta);
	...
	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
	...
}

But Gabriel talks about the effects from injecting sleep time in
timekeeping_resume() because that's where we use
read_persistent_clock64(). And there we don't clear NTP, unless there is
some magic I'm missing completely.

Thanks,

	tglx
