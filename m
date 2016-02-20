Return-Path: <rtc-linux+bncBCH47WHJQUIRB4EDUO3AKGQE3BDNXVI@googlegroups.com>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk. [81.2.110.251])
        by gmr-mx.google.com with ESMTPS id w197si623984wmw.3.2016.02.20.11.43.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 11:43:44 -0800 (PST)
Date: Sat, 20 Feb 2016 19:43:10 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
In-Reply-To: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
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

On Sat, 20 Feb 2016 20:10:44 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> hctosys is setting the system time from the kernel. This means that 32bit
> system can get their time set to a date after the 31bit time_t overflow.
> 
> This is currently an issue as userspace is not yet ready to handle those
> dates and may break. For example systemd's usage of timerfd shows that the
> timerfd will always fire immediately because it can't be set at a date
> after the current date.
> 
> The new RTC_INVALID_2038 option will make sure that date after 03:09:07 on
> Jan 19 2038 are invalid. This is 5 minutes before the 31bit overflow. This
> leaves enough time for userspace to react and is short enough to make the
> issue visible.

This is kind of pointless. You replace loading the RTC and discovering
the time isn't supported by your system with not loading he RTC and
discovering your system clock is magically and almost un-debuggably
wrong, and when something like NTP syncs it, breaks anyway.

The only way to deal with 2038 is to fix your user space. People need to
deal with reality, even if it's not all pink unicorns and rainbows.

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
