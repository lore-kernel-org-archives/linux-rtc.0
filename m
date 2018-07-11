Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:42971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKJZy (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 11 Jul 2018 05:25:54 -0400
Date: Wed, 11 Jul 2018 11:22:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.18
Message-ID: <20180711092213.GN16084@piout.net>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
 <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
 <20180626213138.GI4207@piout.net>
 <7fab97df-9cd9-fa57-47a8-883a717dd96c@nvidia.com>
 <20180709121747.GG16084@piout.net>
 <20180710221410.GL16084@piout.net>
 <dccdc3e9-4fac-ee05-dab0-3533c274f59c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dccdc3e9-4fac-ee05-dab0-3533c274f59c@nvidia.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 11/07/2018 10:17:11+0100, Jon Hunter wrote:
> Hi Alexandre.
> 
> On 10/07/18 23:14, Alexandre Belloni wrote:
> > Hi Jon,
> > 
> > Can you test that one?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=4393575d9aa250c74335f8b37e0466b872b5080
> > 
> > This fixes setting alarms on the TPS658623 of my T20 board but I don't
> > get the interrupt I'm expecting. However, I don't get interrupts with
> > the offending patch reverted so hopefully, this fix is sufficient.
> 
> Yes this fixes the problem. Feel free to add my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 

Great ! Thank you for your patience, I'll send it as a fix before Sunday.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
