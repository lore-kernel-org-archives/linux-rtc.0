Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40155 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdIUI56 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 04:57:58 -0400
Date: Thu, 21 Sep 2017 10:57:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: YiPing Xu <xuyiping@hisilicon.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, roy.chenjun@hisilicon.com,
        colin.king@canonical.com, wanghao24@huawei.com
Subject: Re: [PATCH] rtc: interface: set the next alarm event appropriately
Message-ID: <20170921085752.q7kepvl7zmrdvm3t@piout.net>
References: <1505877751-26566-1-git-send-email-xuyiping@hisilicon.com>
 <20170920091617.j7sie3mrncjkcj3m@piout.net>
 <b13fabbb-fe2e-b3a3-6e8e-c42b8bab063c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b13fabbb-fe2e-b3a3-6e8e-c42b8bab063c@hisilicon.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 21/09/2017 at 14:45:17 +0800, YiPing Xu wrote:
> 
> 
> On 2017/9/20 17:16, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 20/09/2017 at 11:22:31 +0800, Xu Yiping wrote:
> > > From: Xu YiPing  <xuyiping@hisilicon.com>
> > > 
> > > After commit 2b2f5ff00f63 ("rtc: interface: ignore expired timers when
> > > enqueuing new timers"), the rtc_timer_enqueue will not reprogram the RTC
> > > when there is any non-expired timers in the timerqueue. If we set a
> > > RTC_TIMER between now and the next non-expired timers, it won't go into
> > > effect in time.
> > > 
> > > So, besides ignoring the expired timers, we should take the next effect
> > > timer into account, and reprogram the RTC timer appropriately.
> > > 
> > 
> > Can you try this patch instead? I think it solves this issue:
> > http://patchwork.ozlabs.org/patch/792482/
> 
>    We've tested this patch, it works too.
> 
>    Will it be merged into the main tree?
> 

Yes, I will send it as a fix for 4.14.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
