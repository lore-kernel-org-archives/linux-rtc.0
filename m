Return-Path: <rtc-linux+bncBDS7HNEFSALRBR7J3OUQKGQE6T7IVXA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si218778wia.1.2015.04.21.18.09.27
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Apr 2015 18:09:27 -0700 (PDT)
Date: Wed, 22 Apr 2015 03:09:25 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the
 mcp794xx alarm after programming time
Message-ID: <20150422010925.GH8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
 <20150421234139.GF8539@piout.net>
 <5536E433.90103@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5536E433.90103@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2015 at 18:58:43 -0500, Nishanth Menon wrote :
> > 
> > Consider the following use case: a platform is setting the RTC alarm
> > before going to suspend to ram. Before your patch, it may be woken up
> ^^ precisely what I am trying to solve.
> 
> > quite quickly, before expected. After your patch, it may never wake at
> > all.
> 
> Why is that so? when set alarm is requested for time X, you want
> interrupt at time X, not an interrupt for previous configured RTC
> alarm time!
> 

You expect at least an interrupt.

> If the time X is > the point when ALM0 is programmed, then you will
> get an interrupt.
> 

You are eluding my point. What happens if the alarm expires before ALM0
is programmed? Your system is probably dead because it will never wake
up.

> If you get an interrupt (like my screenshot shows) because the new
> value has not yet been programmed (just because we enabled interrupt
> before programming time), it is unexpected event and wrong!
> 
> Another scenario: Take the following time points A < B < C < D
> we program at time (A), an interrupt for time (C).
> but at time B, we intiate a new time request for time (D).
> if we happen to send the first ALM0EN at time C (before programming
> D), you will generate an interrupt, but before the irq handler can
> handle (since we are doing burst i2c), we program D which clears the
> irq status (as can be seen in waveform).
> 
> This does not make sense for a predictable behavior! Yeah, it will
> wakeup quickly, but when we go and read irqstatus (ALM0IF), it will be
> 0 and nothing will get reported to rtc subsystem. So:
> a) we woke up at a time not requested - this is wrong
> b) our irq handler has nothing to handle! - this is wrong as well.
> 
> in short, the behavior you are asking for is quiet the wrong behavior!
> 

I agree that an unexpected event is wrong but it is still better than a
dead system. I'm not asking to keep the current behaviour. I'm just
wanting to try to not introduce another race condition.

What about setting ALM0MTH to 0x1F before reading the control registers?
You could also read only the first 3 registers as all the others are
overwritten. And finally, you only need to write 9 bytes instead of 10
(register 0x10 is reserved). While not eliminating it completely, this
will definitively reduce the race condition window.


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
