Return-Path: <rtc-linux+bncBDS7HNEFSALRB6PHUO3AKGQEC6NETEA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si639595wmd.0.2016.02.20.15.17.12
        for <rtc-linux@googlegroups.com>;
        Sat, 20 Feb 2016 15:17:12 -0800 (PST)
Date: Sun, 21 Feb 2016 00:17:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160220231702.GK2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
 <20160220204715.GJ2222@piout.net>
 <9634631.sIvUQESgNh@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <9634631.sIvUQESgNh@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2016 at 23:16:48 +0100, Arnd Bergmann wrote :
> On Saturday 20 February 2016 21:47:15 Alexandre Belloni wrote:
> > 
> > Actually, I'm not trying to solve the 2038 issue.
> > 
> > But in the current state on 32 bit platforms, while the kernel is able
> > to handle a 64bit date, userspace is not. The main issue is that
> > distributions use HCTOSYS so if the RTC is set to a date after 2038
> > (which we know is currently bogus), the kernel will set a system time to
> > that date.
> > 
> > This result in a system that fails when using timerfd, The timerfd will
> > always fire immediately (until, as some people pointed out, we have
> > relative timers).
> > 
> > This is know to break systemd [1] but I have had reports for other
> > failing applications.
> > 
> > I understand this is a workaround and I plan to switch the default to n
> > once libc and critical userspace is able to handle 64 bit time.
> > 
> > The other way of solving that is to get back to a 32 bit time_t
> > internally until we switch the whole userspace to a 64 bit time_t but I
> > don't think this is practical.
> > 
> > [1] https://github.com/systemd/systemd/issues/1143
> > 
> 
> I think in both cases you introduce a new 2038 problem though:
> as long as you have a kernel that tries to support an old
> 32-bit systemd build, the kernel becomes incompatible with RTC
> times beyond 2038, even on 64-bit systems and 32-bit systems
> that have fixed system call table and fixed user space.
> 

It doesn't change anything for 64-bit systems, I've excluded them by
using "depends on !64BIT". Right now, it doesn't change anything for
32-bit systems because either way, they will fail in 2038.

> This is bad because it means we still have to break systemd
> eventually in order to fix the 2038 overflow.
> 

Won't we have to recompile every application to support 64-bit time on
32-bit system anyway? That will be a good time to remove that option.

> The plan to revert this after glibc has been converted is
> problematic because a lot of 32-bit distros will likely never
> recompile with 64-bit time_t in order to avoid breaking
> backwards compatibility. While we could require that user
> space and kernel must match here (either support 64-bit time_t
> everywhere or nowhere), that makes it much harder to deal
> with the migration, and it has always been a strict requirement
> that none of the changes for y2038 compatibility break existing
> user space (which of course is what happened for RTC and what
> we need to fix here).

If the distribution don't recompile to support a 64-bit time, then the
32-bit systems will break in 2038 anyway and they will absolutely
require my patch or something along those lines to still boot using
systemd.

> 
> Has the problem of random RTC times been observed on more than
> one RTC driver yet? Maybe we can just apply your workaround
> to that one driver that saw it instead.
> 
> Have you figured out whether there is a pattern in the reported
> times? Is it just completely random or could we perhaps
> detect an RTC that reports an invalid time other than by 
> looking at the year?
> 

All the failures seem quite random to me but the reports I get are not
that precise.

I know it happens with PCF8523 and that can be true because the
datasheet says the date is undefined at reset. The handling of the OS
bit (that bit indicates the date is probably wrong) has to be fixed and
I will take care of that.

If that is the only RTC with that particular issue, we clearly don't
need my workaround. But As I say, I can ask but I don't have a clear
list of the affected system and their RTC.


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
