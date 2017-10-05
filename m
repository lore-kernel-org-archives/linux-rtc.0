Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdJELIM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 5 Oct 2017 07:08:12 -0400
Date: Thu, 5 Oct 2017 13:08:08 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: John Stultz <john.stultz@linaro.org>
Cc: Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Extreme time jitter with suspend/resume cycles
Message-ID: <20171005110808.GA19251@localhost>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Oct 04, 2017 at 05:16:31PM -0700, John Stultz wrote:
> On Wed, Oct 4, 2017 at 9:11 AM, Gabriel Beddingfield <gabe@nestlabs.com> wrote:
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

This is interesting. What polling interval was ntpd using? If I
understand it correctly, with a high-resolution persistent clock the
delta-delta compensation should be very small and shouldn't disrupt
ntpd. Does this instability disappear when ntpd is not controlling the
clock (i.e. "disable ntp" in ntp.conf)?

> We should also figure out how to best handle ntpd in userspace dealing
> with frequent suspend/resume cycles. This is problematic, as the
> closest analogy is trying driving on the road while frequently falling
> asleep.  This is not something I think ntpd handles well.  I suspect
> our options are that any ntp adjustments being made might be made for
> far too long (causing potentially massive over-correction) or not at
> all, and not at all seems slightly better in my mind.

Yeah, controlling the clock in such conditions will be difficult. The
kernel/ntp PLL requires periodic updates. There is some code in
ntp_update_offset() that reduces the frequency adjustment when PLL
updates are missing, but I'm not actually sure if it works correctly
with suspend.

-- 
Miroslav Lichvar
