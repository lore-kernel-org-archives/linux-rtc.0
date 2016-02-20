Return-Path: <rtc-linux+bncBDS7HNEFSALRBWNBUO3AKGQEFHAPTTY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si631091wmw.3.2016.02.20.12.47.21
        for <rtc-linux@googlegroups.com>;
        Sat, 20 Feb 2016 12:47:21 -0800 (PST)
Date: Sat, 20 Feb 2016 21:47:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Arnd Bergmann <arnd@arndb.de>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160220204715.GJ2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2016 at 19:43:10 +0000, One Thousand Gnomes wrote :
> On Sat, 20 Feb 2016 20:10:44 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > hctosys is setting the system time from the kernel. This means that 32bit
> > system can get their time set to a date after the 31bit time_t overflow.
> > 
> > This is currently an issue as userspace is not yet ready to handle those
> > dates and may break. For example systemd's usage of timerfd shows that the
> > timerfd will always fire immediately because it can't be set at a date
> > after the current date.
> > 
> > The new RTC_INVALID_2038 option will make sure that date after 03:09:07 on
> > Jan 19 2038 are invalid. This is 5 minutes before the 31bit overflow. This
> > leaves enough time for userspace to react and is short enough to make the
> > issue visible.
> 
> This is kind of pointless. You replace loading the RTC and discovering
> the time isn't supported by your system with not loading he RTC and
> discovering your system clock is magically and almost un-debuggably
> wrong, and when something like NTP syncs it, breaks anyway.
> 
> The only way to deal with 2038 is to fix your user space. People need to
> deal with reality, even if it's not all pink unicorns and rainbows.
> 

Actually, I'm not trying to solve the 2038 issue.

But in the current state on 32 bit platforms, while the kernel is able
to handle a 64bit date, userspace is not. The main issue is that
distributions use HCTOSYS so if the RTC is set to a date after 2038
(which we know is currently bogus), the kernel will set a system time to
that date.

This result in a system that fails when using timerfd, The timerfd will
always fire immediately (until, as some people pointed out, we have
relative timers).

This is know to break systemd [1] but I have had reports for other
failing applications.

I understand this is a workaround and I plan to switch the default to n
once libc and critical userspace is able to handle 64 bit time.

The other way of solving that is to get back to a 32 bit time_t
internally until we switch the whole userspace to a 64 bit time_t but I
don't think this is practical.

[1] https://github.com/systemd/systemd/issues/1143

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
