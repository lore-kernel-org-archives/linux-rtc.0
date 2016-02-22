Return-Path: <rtc-linux+bncBDS7HNEFSALRBRW7VS3AKGQEEMTSH5Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si1222270wmd.1.2016.02.22.07.56.54
        for <rtc-linux@googlegroups.com>;
        Mon, 22 Feb 2016 07:56:54 -0800 (PST)
Date: Mon, 22 Feb 2016 16:56:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160222155653.GP2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160222130014.GN2222@piout.net>
 <20160222134319.31e77b71@lxorguk.ukuu.org.uk>
 <6269543.oe8MmZQUmX@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6269543.oe8MmZQUmX@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2016 at 16:44:32 +0100, Arnd Bergmann wrote :
> On Monday 22 February 2016 13:43:19 One Thousand Gnomes wrote:
> > On Mon, 22 Feb 2016 14:00:14 +0100
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > > I can also agree that systemd could be a bit more robust there but
> > > you'll have to convince Lennart...
> > 
> > That's a systemd problem. If their code isn't robust then the
> > distributiosn will just have to keep patching it.
> > 
> > The only problem that can actually be "fixed" is the case where it isn't
> > 2038 yet and the user has a scrambled RTC. In that case your init tools
> > need to be robust enough to handle the problem or use APIs that don't
> > break. The kernel can't actually "fix" this because it never knows
> > whether your userspace is sane or not.
> > 
> > I'd argue btw that any code using timerfd_create with TFD_TIMER_ABSTIME
> > and passing it a value that wraps the range permitted by that time
> > representation *is* buggy. It's the applications responsibility to use
> > values that are within the defined behavioural range of the function.
> 
> IIRC, the problem is that user space passes in TIME_T_MAX and the kernel
> is considering that to be in the past because the clock is set beyond 2038.
> 
> I find it hard to blame user space for that, but I don't have a good
> idea for solving this either.
> 
> In case of systemd, it is literally the first thing that runs on the kernel
> after booting, so we could fall back to setting the time to some known
> working state (1970 or 2016 or something), but that would be a rather
> bad default policy once the system has been running for a while.
> 

Also, how would you know that it is an invalid time, some RTC doesn't
provide that information. One other workaround is to asked distributions
using systemd to stop using HCTOSYS so userspace would be responsible to
set the system time and in that case we won't have the 32/64 discrepancy.

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
