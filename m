Return-Path: <rtc-linux+bncBDEKVJM7XAHRBVOLUO3AKGQE3YZ2XBQ@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id s141si826982wmd.1.2016.02.20.14.16.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 14:16:53 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Date: Sat, 20 Feb 2016 23:16:48 +0100
Message-ID: <9634631.sIvUQESgNh@wuerfel>
In-Reply-To: <20160220204715.GJ2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com> <20160220194310.02964d5f@lxorguk.ukuu.org.uk> <20160220204715.GJ2222@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Saturday 20 February 2016 21:47:15 Alexandre Belloni wrote:
> 
> Actually, I'm not trying to solve the 2038 issue.
> 
> But in the current state on 32 bit platforms, while the kernel is able
> to handle a 64bit date, userspace is not. The main issue is that
> distributions use HCTOSYS so if the RTC is set to a date after 2038
> (which we know is currently bogus), the kernel will set a system time to
> that date.
> 
> This result in a system that fails when using timerfd, The timerfd will
> always fire immediately (until, as some people pointed out, we have
> relative timers).
> 
> This is know to break systemd [1] but I have had reports for other
> failing applications.
> 
> I understand this is a workaround and I plan to switch the default to n
> once libc and critical userspace is able to handle 64 bit time.
> 
> The other way of solving that is to get back to a 32 bit time_t
> internally until we switch the whole userspace to a 64 bit time_t but I
> don't think this is practical.
> 
> [1] https://github.com/systemd/systemd/issues/1143
> 

I think in both cases you introduce a new 2038 problem though:
as long as you have a kernel that tries to support an old
32-bit systemd build, the kernel becomes incompatible with RTC
times beyond 2038, even on 64-bit systems and 32-bit systems
that have fixed system call table and fixed user space.

This is bad because it means we still have to break systemd
eventually in order to fix the 2038 overflow.

The plan to revert this after glibc has been converted is
problematic because a lot of 32-bit distros will likely never
recompile with 64-bit time_t in order to avoid breaking
backwards compatibility. While we could require that user
space and kernel must match here (either support 64-bit time_t
everywhere or nowhere), that makes it much harder to deal
with the migration, and it has always been a strict requirement
that none of the changes for y2038 compatibility break existing
user space (which of course is what happened for RTC and what
we need to fix here).

Has the problem of random RTC times been observed on more than
one RTC driver yet? Maybe we can just apply your workaround
to that one driver that saw it instead.

Have you figured out whether there is a pattern in the reported
times? Is it just completely random or could we perhaps
detect an RTC that reports an invalid time other than by 
looking at the year?

	Arnd

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
