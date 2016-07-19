Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB5MLXC6AKGQE33B7X2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o10si1003647wme.0.2016.07.19.03.50.29
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 03:50:29 -0700 (PDT)
Date: Tue, 19 Jul 2016 12:49:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Lawrence <joe.lawrence@stratus.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: __rtc_read_alarm missing month/year field bug?
Message-ID: <20160719104958.GF7132@piout.net>
References: <5768148E.8090304@stratus.com>
 <57716404.9080204@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57716404.9080204@stratus.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27/06/2016 at 13:36:04 -0400, Joe Lawrence wrote :
> Ping?  This isn't a major problem, but can setup endless RTC interrupts
> under certain conditions on said hardware.
> 

Well like said in my previous mail, I don't think the rollover is the
issue here but I'm interested in knowing what conditions are leading to
endless interrupts.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
