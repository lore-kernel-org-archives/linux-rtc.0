Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:47196 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751787AbdJRUfH (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 18 Oct 2017 16:35:07 -0400
Date: Wed, 18 Oct 2017 21:34:49 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Introduce clock precision to help time travelers was Re:
 Extreme time jitter with suspend/resume cycles
Message-ID: <20171018213449.523cd958@alans-desktop>
In-Reply-To: <20171015063738.GA24716@xo-6d-61-c0.localdomain>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
        <20171015063738.GA24716@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

> And even the boring ones have pretty imprecise RTCs... For example Nokia N9.
> I only power it up from time to time, I believe it drifts something like
> minute per month... For normal use with SIM card, it can probably correct
> from GSM network if you happen to have a cell phone signal, but...
> 
> More interesting machines... Old thinkpad is running without CMOS battery.
> ARM OLPC has _three_ RTCs, but not a single working one. N900 has working
> RTC but no or dead backup battery. On these, RTC driver probably knows
> time is not valid, but feeds the garbage into the system time, anyway. Ouch.
> Neither Sharp Zaurus SL-5500 nor C-3000 had battery backup on RTC...

Not a new problem, RTC's used to cost lots of money 8)

Most early Unixen set the clock at boot from the superblock timestamp of
the root fs, some with RTC's also used to scream at you if the superblock
stamp was too far head of current time.That doesn't quite work with
initrd but you can do the same in userspace on Linux so you'll at least
get 'when I last booted it' and because it's always moving forward lots
of other messes don't happen.

Alan
