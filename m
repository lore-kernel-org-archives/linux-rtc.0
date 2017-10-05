Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36382 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdJEVba (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 17:31:30 -0400
Date: Thu, 5 Oct 2017 23:31:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gabriel Beddingfield <gabe@nestlabs.com>
cc: John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
In-Reply-To: <CAOdF7nv5re6Hvv5e3Mj=tiQKBw2CvEEdE1Nt96gqZmhr5+xZ+g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710052305200.2398@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com> <CAOdF7nv5re6Hvv5e3Mj=tiQKBw2CvEEdE1Nt96gqZmhr5+xZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Gabriel,

On Thu, 5 Oct 2017, Gabriel Beddingfield wrote:

> Hi John,
> 
> On Wed, Oct 4, 2017 at 5:16 PM, John Stultz <john.stultz@linaro.org> wrote:
> >> Please let me know what you think -- and what the right approach for
> >> solving this would be.
> >
> > So I suspect the best solution for you here is: provide some
> > infrastructure so clocksources that set CLOCK_SOURCE_SUSPEND_NONSTOP
> > which are not the current clocksource can be used for suspend timing.
> 
> Let me see if I understand how this might work in my situation...
> 
> 1. I register a clocksource and set the NONSTOP flag.
> 2. Give it a "low" rating so that it's not selected as the timekeeping
> clocksource.
> 3. Create functions clocksource_select_persistent() and
> timekeeping_notify_persistent()
> 4. Add `struct tk_read_base tk_persistent' to `struct timekeeper'
> 5. Possibly add a change_persistent_clocksource() function to timekeeping.c

That might work, but that looks a tad too complex. Let me give it a try:

1) Create a new flag CLOCK_SOURCE_SUSPEND_BACKUP

   This makes sense because such a clocksource is likely to be something
   which you don't want ever to use for timekeeping even if its the only
   thing aside of jiffies.

2) Set this flag when registering a clocksource, which excludes it from the
   normal selection process.

3) Make the registration code select such a clocksource as the backup for
   suspend resume to brige the gap when the timekeeper clocksource does not
   have the NONSTOP flag set.

   You don't need the extra timekeeping_notify_persistent() because in that
   case the maybe current backup clocksource is definitely not in use and
   can be replaced without the stompmachine muck which we need for
   replacing the current timekeeper clocksource. The system cannot be in
   suspend at this point obviously. so all it needs is to switch a pointer.

   You neither need this extra stuff in struct timekeeper, it's big enough
   anyway. A simple static struct tk_read_base should be sufficient.

On suspend you do

   if (tk_backup->clock)
   	sync_data(timekeeper, tk_backup);

   You still want to record the RTC based time if possible, in case that
   the backup timekeeper can wrap so you have a sanity check for that
   similar to the one we need for NONSTOP clocksources. If there is no RTC
   then we need a sensible cutoff for that wraparound time which makes sure
   that we don't trip over our own feet.

On resume you check tk_backup->clock again, do the RTC sanity check, if
available and valid (either wraps above cutoff or is checked via RTC). If
that's ok, then you update the timekeeper and proceed. If not, use the
fallback or do nothing in the worst case.

Thoughts?

Thanks,

	tglx

   
