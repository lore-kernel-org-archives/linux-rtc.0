Return-Path: <rtc-linux+bncBDS7HNEFSALRBFXUVS3AKGQETGL6LLQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si1229168wmd.1.2016.02.22.08.40.54
        for <rtc-linux@googlegroups.com>;
        Mon, 22 Feb 2016 08:40:54 -0800 (PST)
Date: Mon, 22 Feb 2016 17:40:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160222164053.GQ2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <6269543.oe8MmZQUmX@wuerfel>
 <20160222155653.GP2222@piout.net>
 <2768647.1bFEcFDZRI@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2768647.1bFEcFDZRI@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2016 at 17:18:03 +0100, Arnd Bergmann wrote :
> > > IIRC, the problem is that user space passes in TIME_T_MAX and the kernel
> > > is considering that to be in the past because the clock is set beyond 2038.
> > > 
> > > I find it hard to blame user space for that, but I don't have a good
> > > idea for solving this either.
> > > 
> > > In case of systemd, it is literally the first thing that runs on the kernel
> > > after booting, so we could fall back to setting the time to some known
> > > working state (1970 or 2016 or something), but that would be a rather
> > > bad default policy once the system has been running for a while.
> > > 
> > 
> > Also, how would you know that it is an invalid time, some RTC doesn't
> > provide that information. 
> 
> What I meant was encountering a time past the 2038 date, which is invalid
> as seen from current 32-bit user space, but not necessarily from the
> kernel.
> 

I'm not completely sure how this would be different from my current patch...

> > One other workaround is to asked distributions
> > using systemd to stop using HCTOSYS so userspace would be responsible to
> > set the system time and in that case we won't have the 32/64 discrepancy.
> 
> I'm missing a bit of background here. This seems like a fairly useful
> piece of infrastructure for the majority of the use cases (working RTC)
> 
> How would the time get set when this is disabled? Is systemd able
> to read the rtc and write it back to the kernel? That could in fact
> be a nicer workaround for the problem, if it just does this before
> setting up the timerfd.
> 

I didn't check other distribution but debian and poky have
/etc/init.d/hwclock.sh that reads the rtc and sets the system time at
startup. It also saves the time to the RTC on shutdown.


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
