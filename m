Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:48754 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933939AbeDXNag (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 24 Apr 2018 09:30:36 -0400
Date: Tue, 24 Apr 2018 15:30:25 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        rjw@rjwysocki.net, gabriele.mzt@gmail.com
Subject: Re: [PATCH 1/3] rtc: cmos: allow using ACPI for RTC alarm instead of
 HPET
Message-ID: <20180424133025.GC19011@piout.net>
References: <1522072683-3968-1-git-send-email-rui.zhang@intel.com>
 <20180419140538.GG7369@piout.net>
 <1524203968.2553.32.camel@intel.com>
 <20180420064652.GI7369@piout.net>
 <1524575720.2597.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524575720.2597.28.camel@intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 24/04/2018 21:15:20+0800, Zhang Rui wrote:
> > > Yes, I noticed this conflict as well.
> > > I have rebased it on top of -rc1 and it is under testing right now.
> > > I will rebase on your tree and resend.
> > > 
> > Rebasing on top of -rc1 is sufficient, I'm already carrying your
> > patches
> > now so they are part of linux-next early in the cycle.
> > 
> Great, thanks.
> so I don't need to send the refreshed ones, right?
> 

If what I did works, then all is fine and I'll send them to Linus for
4.18.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
