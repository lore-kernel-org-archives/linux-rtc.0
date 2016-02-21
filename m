Return-Path: <rtc-linux+bncBCH47WHJQUIRBWXAU23AKGQEFP7BQEI@googlegroups.com>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk. [81.2.110.251])
        by gmr-mx.google.com with ESMTPS id w128si739180wmd.0.2016.02.21.04.40.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 04:40:57 -0800 (PST)
Date: Sun, 21 Feb 2016 12:40:20 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rtc-linux@googlegroups.com,
        Alessandro
 Zummo <a.zummo@towertech.it>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160221124020.49f39207@lxorguk.ukuu.org.uk>
In-Reply-To: <20160220231702.GK2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
	<20160220194310.02964d5f@lxorguk.ukuu.org.uk>
	<20160220204715.GJ2222@piout.net>
	<9634631.sIvUQESgNh@wuerfel>
	<20160220231702.GK2222@piout.net>
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

> It doesn't change anything for 64-bit systems, I've excluded them by
> using "depends on !64BIT". Right now, it doesn't change anything for
> 32-bit systems because either way, they will fail in 2038.

Which realistically won't actually matter because in 22 years time nobody
will be able to find a 32bit system in common use. If you look at x86
platforms today a Pentium Pro is already a collectors item. All of todays
locked down half-maintained embedded and phone devices will be at best
the digital equivalent of toxic waste if connected to anything.

> Won't we have to recompile every application to support 64-bit time on
> 32-bit system anyway? That will be a good time to remove that option.

How will you know when everyone has ? There's no "autodetect which
distribution I am running" feature.

> If the distribution don't recompile to support a 64-bit time, then the
> 32-bit systems will break in 2038 anyway and they will absolutely
> require my patch or something along those lines to still boot using
> systemd.

I disagree. Systemd has a serious robustness bug. Patch systemd to handle
timerd going off early and to take appropriate recovery action.

If you fix the systemd bug you'll also deal with a load of other weird
cornercases like 32bit guests on a 64bit host that accidentally ended up
post 2038, and every other freaky rtc failure.

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
