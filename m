Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdJEOLP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 10:11:15 -0400
Date: Thu, 5 Oct 2017 16:11:09 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.20.1710051301250.2083@nanos>
Message-ID: <alpine.DEB.2.20.1710051610170.2083@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <CALAqxLUO-62B0umVSUK979A+dApOLN3xt5nnZA5HKHsWnRz3KQ@mail.gmail.com> <alpine.DEB.2.20.1710051301250.2083@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 5 Oct 2017, Thomas Gleixner wrote:
> On Wed, 4 Oct 2017, John Stultz wrote:
> > So, on resume when we call __timekeeping_inject_sleeptime(), that uses
> > the TK_CLEAR_NTP which clears the NTP state (sets STA_UNSYNC, etc) .
> > I'm not sure how else we can notify userspace.  It may be that ntpd
> > doesn't expect the kernel to set things as unsynced and doesn't
> > recover well, but the proper fix for that probably is in userspace.
> 
> Errm. No, __timekeeping_inject_sleeptime() only updates the timekeeper.

That should read:

     updates the timekeeper data fields, but does not call
     timekeeping_update().

> 
> We have two call sites:
> 
> timekeeping_resume()
> {
> 	.....
> 	if (sleeptime_injected)
> 		__timekeeping_inject_sleeptime(tk, &ts_delta);
> 	...
> 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
> 	...
> }
> 
> and
> 
> timekeeping_inject_sleeptime64()
> {
> 	__timekeeping_inject_sleeptime(tk, &delta);
> 	...
> 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
> 	...
> }
> 
> But Gabriel talks about the effects from injecting sleep time in
> timekeeping_resume() because that's where we use
> read_persistent_clock64(). And there we don't clear NTP, unless there is
> some magic I'm missing completely.
> 
> Thanks,
> 
> 	tglx
> 
> 
> 
