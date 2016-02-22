Return-Path: <rtc-linux+bncBCH47WHJQUIRBF5BVS3AKGQEDB5HJ7A@googlegroups.com>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk. [81.2.110.251])
        by gmr-mx.google.com with ESMTPS id s141si1201216wmd.1.2016.02.22.05.43.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 05:43:51 -0800 (PST)
Date: Mon, 22 Feb 2016 13:43:19 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rtc-linux@googlegroups.com,
        Alessandro
 Zummo <a.zummo@towertech.it>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160222134319.31e77b71@lxorguk.ukuu.org.uk>
In-Reply-To: <20160222130014.GN2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
	<20160220194310.02964d5f@lxorguk.ukuu.org.uk>
	<20160220204715.GJ2222@piout.net>
	<9634631.sIvUQESgNh@wuerfel>
	<20160220231702.GK2222@piout.net>
	<20160221124020.49f39207@lxorguk.ukuu.org.uk>
	<20160222130014.GN2222@piout.net>
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

On Mon, 22 Feb 2016 14:00:14 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
.
> But there are long lived products like cars, parking ticket machines,
> insulin pumps, automated external defibrillators, home automation
> controllers, point of sales, etc... Some of those may still be in use in
> 22 years.

And if so their vendors will have provided updates. Your "fix" doesn't
help anything, it just means the user sees it fail in a different way.

> I can also agree that systemd could be a bit more robust there but
> you'll have to convince Lennart...

That's a systemd problem. If their code isn't robust then the
distributiosn will just have to keep patching it.

The only problem that can actually be "fixed" is the case where it isn't
2038 yet and the user has a scrambled RTC. In that case your init tools
need to be robust enough to handle the problem or use APIs that don't
break. The kernel can't actually "fix" this because it never knows
whether your userspace is sane or not.

I'd argue btw that any code using timerfd_create with TFD_TIMER_ABSTIME
and passing it a value that wraps the range permitted by that time
representation *is* buggy. It's the applications responsibility to use
values that are within the defined behavioural range of the function.

Far more constructive would I think be to add a TFD_TIME64 flag to
timerfd_create that allows the use of 64bit time in timerfd_*. Systemd
can then adopt that safely even on 32bit legacy systems, while on 64bit
TFD_TIME64 would presumably be 0 and the 64/32bit time structs would
match.

Alan

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
