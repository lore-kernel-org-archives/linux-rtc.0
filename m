Return-Path: <rtc-linux+bncBDS7HNEFSALRBDVKX6ZQKGQE54XSPGI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w79si69956wme.2.2015.12.15.00.53.33
        for <rtc-linux@googlegroups.com>;
        Tue, 15 Dec 2015 00:53:33 -0800 (PST)
Date: Tue, 15 Dec 2015 09:53:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, akpm@linux-foundation.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] powerpc: Remove broken GregorianDay()
Message-ID: <20151215085332.GH11209@piout.net>
References: <1450163354-16894-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1450163354-16894-1-git-send-email-dja@axtens.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/12/2015 at 18:09:14 +1100, Daniel Axtens wrote :
> GregorianDay() is supposed to calculate the day of the week
> (tm->tm_wday) for a given day/month/year. In that calcuation it
> indexed into an array called MonthOffset using tm->tm_mon-1. However
> tm_mon is zero-based, not one-based, so this is off-by-one. It also
> means that every January, GregoiranDay() will access element -1 of
> the MonthOffset array.
> 
> It also doesn't appear to be a correct algorithm either: see in
> contrast kernel/time/timeconv.c's time_to_tm function.
> 
> It's been broken forever, which suggests no-one in userland uses
> this. It looks like no-one in the kernel uses tm->tm_wday either
> (see e.g. drivers/rtc/rtc-ds1305.c:319).
> 
> tm->tm_wday is conventionally set to -1 when not available in
> hardware so we can simply set it to -1 and drop the function.
> (There are over a dozen other drivers in drivers/rtc that do
> this.)
> 
> Found using UBSAN.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org> # as an example of what UBSan finds.
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> This is almost entirely a powerpc patch, but it also touches
> the OPAL rtc driver. Alessandro, Alexandre, RTC folk, would
> you be OK with mpe taking this through the powerpc tree?
> 

Sure.

I have a plan to actually correct tm_wday before sending it to user
space when it is -1.
I may as well calculate it every time but I'm not sure the extra
calculation is actually worth it because as you mention it, it is not
used by anybody.

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
