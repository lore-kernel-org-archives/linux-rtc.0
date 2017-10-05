Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdJEVeA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 17:34:00 -0400
Date: Thu, 5 Oct 2017 23:33:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gabriel Beddingfield <gabe@nestlabs.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
In-Reply-To: <alpine.DEB.2.20.1710052302440.2398@nanos>
Message-ID: <alpine.DEB.2.20.1710052331310.2398@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com> <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com> <alpine.DEB.2.20.1710051216050.2083@nanos>
 <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com> <alpine.DEB.2.20.1710051943570.2398@nanos> <CAOdF7nssJZZG_VKO+G_K6+aukOApmXp823yA9k3sUsSYpSB71g@mail.gmail.com> <alpine.DEB.2.20.1710052302440.2398@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 5 Oct 2017, Thomas Gleixner wrote:
> On Thu, 5 Oct 2017, Gabriel Beddingfield wrote:
> 
> > Hi Thomas,
> > 
> > On Thu, Oct 5, 2017 at 11:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> > Which SoC/clocksource driver are you talking about?
> > >>
> > >> NXP i.MX 6SoloX
> > >> drivers/clocksource/timer-imx-gpt.c
> > >
> > > So that clocksource driver looks correct. Do you have an idea in which
> > > context this time jump happens? Does it happen when you exercise your high
> > > frequency suspend/resume dance or is that happening just when you let the
> > > machine run forever as well?
> > 
> > We couldn't devise any reproduction steps. We observed it happening at
> > unexpected times in a fleet of devices -- and we couldn't find any
> > patterns to clue us in.
> 
> Ok. Did you talk to NXP about that? Or did you try to exercise reads in a
> loop to detect the wreckage and maybe a pattern in there?

The reason I'm asking is to exclude any weird issue in the timekeeping
code, which is still a possibility, despite the fact that I went through it
with a fine comb after stumbling over that check in the resume path.

Thanks,

	tglx
