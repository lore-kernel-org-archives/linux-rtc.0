Return-Path: <rtc-linux+bncBDEKVJM7XAHRBZ6ZVS3AKGQE7JPD74Q@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.74])
        by gmr-mx.google.com with ESMTPS id iq8si1940717igb.0.2016.02.22.07.44.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 07:44:38 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Date: Mon, 22 Feb 2016 16:44:32 +0100
Message-ID: <6269543.oe8MmZQUmX@wuerfel>
In-Reply-To: <20160222134319.31e77b71@lxorguk.ukuu.org.uk>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com> <20160222130014.GN2222@piout.net> <20160222134319.31e77b71@lxorguk.ukuu.org.uk>
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

On Monday 22 February 2016 13:43:19 One Thousand Gnomes wrote:
> On Mon, 22 Feb 2016 14:00:14 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > I can also agree that systemd could be a bit more robust there but
> > you'll have to convince Lennart...
> 
> That's a systemd problem. If their code isn't robust then the
> distributiosn will just have to keep patching it.
> 
> The only problem that can actually be "fixed" is the case where it isn't
> 2038 yet and the user has a scrambled RTC. In that case your init tools
> need to be robust enough to handle the problem or use APIs that don't
> break. The kernel can't actually "fix" this because it never knows
> whether your userspace is sane or not.
> 
> I'd argue btw that any code using timerfd_create with TFD_TIMER_ABSTIME
> and passing it a value that wraps the range permitted by that time
> representation *is* buggy. It's the applications responsibility to use
> values that are within the defined behavioural range of the function.

IIRC, the problem is that user space passes in TIME_T_MAX and the kernel
is considering that to be in the past because the clock is set beyond 2038.

I find it hard to blame user space for that, but I don't have a good
idea for solving this either.

In case of systemd, it is literally the first thing that runs on the kernel
after booting, so we could fall back to setting the time to some known
working state (1970 or 2016 or something), but that would be a rather
bad default policy once the system has been running for a while.

The best we can do for a workaround localized to timerfd might be
to make absolute timers behave differently when they come from a 32-bit
process and the current time has already overflown.

> Far more constructive would I think be to add a TFD_TIME64 flag to
> timerfd_create that allows the use of 64bit time in timerfd_*. Systemd
> can then adopt that safely even on 32bit legacy systems, while on 64bit
> TFD_TIME64 would presumably be 0 and the 64/32bit time structs would
> match.

I should really dust off my syscall series, I'd rather not have any
partial solutions to merged here.

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
