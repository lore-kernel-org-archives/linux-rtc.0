Return-Path: <rtc-linux+bncBDS7HNEFSALRBGNZ3OUQKGQEQ67KCPQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si216697wiz.0.2015.04.21.16.26.16
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Apr 2015 16:26:16 -0700 (PDT)
Date: Wed, 22 Apr 2015 01:26:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	kernel@pengutronix.de, Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH 2nd try] RTC/i.MX/DryICE: add recovery
 routines to the driver
Message-ID: <20150421232615.GD8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 14/04/2015 at 11:11:51 +0200, Juergen Borleis wrote :
> 2nd try, this time with a cover letter... m(
> 
> The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
> monitor unit which can keep some keys. When it does its tamper detection job

Does it have more functions? I would say that it also holds some keys
but I don't have a handy Freescale representative to contact ;)

I'm fine getting that unlocking done in the RTC driver but maybe in the
future, it will be necessary to handle that in an MFD driver when adding
support for the other functions.

> and a tamper violation is detected, this RTC unit locks completely including
> the real-time counter. In this state the unit is completely useless. The only
> way to bring it out of this locked state is a power on reset. At the next boot
> time some flags signals the tamper violation and a specific register access
> sequence must be done to finaly bring this unit into life again. Until this is
> done, there is no way to use it again as an RTC.
> But also without any enabled tamper detection sometimes this unit tends to
> lock. And in this case the same steps must be done to bring it into life
> again.

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
