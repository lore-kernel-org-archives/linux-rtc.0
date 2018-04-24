Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933379AbeDXNPY (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:24 -0400
Message-ID: <1524575720.2597.28.camel@intel.com>
Subject: Re: [PATCH 1/3] rtc: cmos: allow using ACPI for RTC alarm instead
 of HPET
From: Zhang Rui <rui.zhang@intel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        rjw@rjwysocki.net, gabriele.mzt@gmail.com
Date: Tue, 24 Apr 2018 21:15:20 +0800
In-Reply-To: <20180420064652.GI7369@piout.net>
References: <1522072683-3968-1-git-send-email-rui.zhang@intel.com>
         <20180419140538.GG7369@piout.net> <1524203968.2553.32.camel@intel.com>
         <20180420064652.GI7369@piout.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 五, 2018-04-20 at 08:46 +0200, Alexandre Belloni wrote:
> On 20/04/2018 13:59:28+0800, Zhang Rui wrote:
> > 
> > Hi, Alexandre
> > 
> > On 四, 2018-04-19 at 16:05 +0200, Alexandre Belloni wrote:
> > > 
> > > Hi,
> > > 
> > > 
> > > On 26/03/2018 21:58:01+0800, Zhang Rui wrote:
> > > > 
> > > > 
> > > > It's found that the HPET timer prevents the platform from
> > > > entering
> > > > Low Power S0 on some new Intel platforms.
> > > > 
> > > > This means that
> > > > 1. users can still use RTC wake Alarm for suspend-to-idle, but
> > > > the
> > > > system
> > > >    never enters Low Power S0, which is a waste of power.
> > > > or
> > > > 2. if users want to put the system into Low Power S0, they can
> > > > not
> > > > use
> > > >    RTC as the wakeup source.
> > > > 
> > > > To fix this, we need to stop using the HPET timer for wake
> > > > alarm.
> > > > But disabling CONFIG_HPET_EMULATE_RTC is not an option because
> > > > HPET
> > > > emulates PIT at the same time, and this is needed on some of
> > > > these
> > > > platforms.
> > > > 
> > > > Thus, introduce a new mode (use_acpi_alarm) to the rtc_cmos
> > > > driver,
> > > > so that, even with CONFIG_HPET_EMULATE_RTC enabled, it's still
> > > > possible to
> > > > use ACPI SCI for RTC Alarm, including UIE/AIE/wkalrm, instead
> > > > of
> > > > HPET.
> > > > 
> > > > Only necessary changes are made for the new "use_acpi_alarm"
> > > > mode,
> > > > including
> > > > 1. drop all the calls to HPET emulation code, including the
> > > > HPET
> > > > irq
> > > >    handler for rtc interrupt.
> > > > 2. enabling/disabling ACPI RTC Fixed event upon RTC UIE/AIE
> > > > request.
> > > > 3. acknowledge the RTC Alarm in ACPI RTC Fixed event handler.
> > > > 
> > > > There is no functional change made in this patch if the new
> > > > mode is
> > > > not
> > > > enabled.
> > > > 
> > > > Note: this "use_acpi_alarm" mode is made based on the
> > > > assumption
> > > > that
> > > > ACPI RTC Fixed event is reliable both at runtime and during
> > > > system
> > > > wakeup.
> > > > And this has been verified on a couple of platforms I have,
> > > > including
> > > > a MS Surface Pro 4 (SKL), a Lenovo Yoga 900 (SKL), and a HP
> > > > 9360
> > > > (KBL).
> > > > 
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > >  drivers/rtc/rtc-cmos.c | 111
> > > > +++++++++++++++++++++++++++++++++++
> > > > --------------
> > > >  1 file changed, 80 insertions(+), 31 deletions(-)
> > > > 
> > > I've applied the series but it didn't apply cleanly, please check
> > > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.gi
> > > t/lo
> > > g/?h=rtc-next
> > > 
> > Yes, I noticed this conflict as well.
> > I have rebased it on top of -rc1 and it is under testing right now.
> > I will rebase on your tree and resend.
> > 
> Rebasing on top of -rc1 is sufficient, I'm already carrying your
> patches
> now so they are part of linux-next early in the cycle.
> 
Great, thanks.
so I don't need to send the refreshed ones, right?

thanks,
rui
> 
