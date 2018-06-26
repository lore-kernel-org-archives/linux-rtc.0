Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:41014 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbeFZQPh (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 26 Jun 2018 12:15:37 -0400
Date: Tue, 26 Jun 2018 18:15:36 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.18
Message-ID: <20180626161536.GH4207@piout.net>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 26/06/2018 16:51:40+0100, Jon Hunter wrote:
> >       rtc: tps6586x: let the core handle rtc range
> 
> Sorry I am missing the original mail with the above change, but I
> have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
> longer working on one of our Tegra boards. The bisect points to the
> above change and reverting it fixes the problem. I have not had
> chance to dig further, but if you have any thoughts, please let me
> know.


Thanks for the report, does the following patch fix the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=1b287f23b0a1fcb2b502dae981a8024be379391e


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
