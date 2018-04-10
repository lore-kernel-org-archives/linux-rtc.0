Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43486 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeDJNBx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 10 Apr 2018 09:01:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id j2so8239708pff.10
        for <linux-rtc@vger.kernel.org>; Tue, 10 Apr 2018 06:01:53 -0700 (PDT)
Date: Tue, 10 Apr 2018 23:01:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY
 loops
Message-ID: <20180410230136.7d0b357e@roar.ozlabs.ibm.com>
In-Reply-To: <20180410120728.GC2745@piout.net>
References: <20180410114933.24581-1-npiggin@gmail.com>
        <20180410114933.24581-3-npiggin@gmail.com>
        <20180410120728.GC2745@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 10 Apr 2018 14:07:28 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi Nicholas,
> 
> I would greatly appreciate a changelog and at least the cover letter
> because it is difficult to grasp how this relates to the previous
> patches you sent to the RTC mailing list. 

Yes good point. Basically this change is "standalone" except using
OPAL_BUSY_DELAY_MS define from patch 1. That patch has a lot of
comments about firmware delays I did not think would be too
interesting.

Basically we're adding msleep(10) here, because the firmware can
repeatedly return OPAL_BUSY for long periods, so we want to context
switch and respond to interrupts.

> 
> On 10/04/2018 21:49:32+1000, Nicholas Piggin wrote:
> > The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
> > OPAL_BUSY_EVENT from firmware, which causes large scheduling
> > latencies, up to 50 seconds have been observed here when RTC stops
> > responding (BMC reboot can do it).
> > 
> > Fix this by converting it to the standard form OPAL_BUSY loop that
> > sleeps.
> > 
> > Fixes 	 ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: linux-rtc@vger.kernel.org
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/platforms/powernv/opal-rtc.c |  8 +++--
> >  drivers/rtc/rtc-opal.c                    | 37 ++++++++++++++---------  
> 
> From what I understand, the changes in those files are fairly
> independent, they should probably be separated to ease merging.

I'm happy to do that. It's using the same firmware call, so I thought
a single patch would be fine. But I guess the boot call can be
dropped from this patch because it does not  not solve the problem
described in the changelog.

Would you be happy for the driver change to be merged via the powerpc
tree? The code being fixed here came from the same original patch as
a similar issue being fixed in the OPAL NVRAM driver so it might be
easier that way.

Thanks,
Nick
