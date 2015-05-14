Return-Path: <rtc-linux+bncBDS7HNEFSALRBNNQ2SVAKGQE57X7MUA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p12si10993wiv.1.2015.05.14.14.48.37
        for <rtc-linux@googlegroups.com>;
        Thu, 14 May 2015 14:48:37 -0700 (PDT)
Date: Thu, 14 May 2015 23:48:36 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: Remove the unused variables
Message-ID: <20150514214836.GD3338@piout.net>
References: <1430922210-9606-1-git-send-email-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430922210-9606-1-git-send-email-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Andrew,

On 06/05/2015 at 16:23:30 +0200, Gregory CLEMENT wrote :
> When applying the fix "rtc: armada38x: Fix concurrency access in
> armada38x_rtc_set_time", some spinlock using the flags variable have
> been removed, but not the flags variable themselves. This commit fixes
> it.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org> #v4.0

Can you send this fix to Linus after adding those tags:

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: 489405fe5ed38 ("rtc: armada38x: fix concurrency access in armada38x_rtc_set_time")

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
