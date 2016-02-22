Return-Path: <rtc-linux+bncBDS7HNEFSALRBX4MVS3AKGQE4GIIHAY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 141si1102793wmy.2.2016.02.22.05.00.14
        for <rtc-linux@googlegroups.com>;
        Mon, 22 Feb 2016 05:00:14 -0800 (PST)
Date: Mon, 22 Feb 2016 14:00:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160222130014.GN2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160220194310.02964d5f@lxorguk.ukuu.org.uk>
 <20160220204715.GJ2222@piout.net>
 <9634631.sIvUQESgNh@wuerfel>
 <20160220231702.GK2222@piout.net>
 <20160221124020.49f39207@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160221124020.49f39207@lxorguk.ukuu.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/02/2016 at 12:40:20 +0000, One Thousand Gnomes wrote :
> > It doesn't change anything for 64-bit systems, I've excluded them by
> > using "depends on !64BIT". Right now, it doesn't change anything for
> > 32-bit systems because either way, they will fail in 2038.
> 
> Which realistically won't actually matter because in 22 years time nobody
> will be able to find a 32bit system in common use. If you look at x86
> platforms today a Pentium Pro is already a collectors item. All of todays
> locked down half-maintained embedded and phone devices will be at best
> the digital equivalent of toxic waste if connected to anything.
> 

The current 32 bit systems are not only phones. I'm not concerned by
those, they have an average 18 month live and the manufacturers are
already switching to 64 bit.
But there are long lived products like cars, parking ticket machines,
insulin pumps, automated external defibrillators, home automation
controllers, point of sales, etc... Some of those may still be in use in
22 years.

Or maybe we want to ensure that there is a Y2038 bug, that can be a good
retirement plan for the whole IT industry ;)

> > Won't we have to recompile every application to support 64-bit time on
> > 32-bit system anyway? That will be a good time to remove that option.
> 
> How will you know when everyone has ? There's no "autodetect which
> distribution I am running" feature.
> 

I have the hope that the distribution maintainers know how to configure
a kernel and will ship a kernel with that option unset once they
switched to a 64 bit time userspace.

> > If the distribution don't recompile to support a 64-bit time, then the
> > 32-bit systems will break in 2038 anyway and they will absolutely
> > require my patch or something along those lines to still boot using
> > systemd.
> 
> I disagree. Systemd has a serious robustness bug. Patch systemd to handle
> timerd going off early and to take appropriate recovery action.
> 
> If you fix the systemd bug you'll also deal with a load of other weird
> cornercases like 32bit guests on a 64bit host that accidentally ended up
> post 2038, and every other freaky rtc failure.
> 

Actually, I agree with Lennart that this is definitively a kernel bug
that has to be fixed. systemd is not the only affected application, any
user of timerfd is failing (actually, the first report I got was not
related to systemd at all).

I can also agree that systemd could be a bit more robust there but
you'll have to convince Lennart...


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
