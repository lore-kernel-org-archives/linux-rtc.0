Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWVRX65QKGQE4JKNWPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f10si226368wmg.2.2016.06.26.06.30.01
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 06:30:01 -0700 (PDT)
Date: Sun, 26 Jun 2016 15:30:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, cphealy@gmail.com
Subject: [rtc-linux] Re: [PATCH v2 00/17] DS1341 support and code cleanup
Message-ID: <20160626133001.GA29249@piout.net>
References: <1466493519-11277-1-git-send-email-andrew.smirnov@gmail.com>
 <20160621213219.GC5809@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160621213219.GC5809@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/06/2016 at 23:32:19 +0200, Alexandre Belloni wrote :
> >   RTC: rtctest: Change alarm IRQ support detection
> >   RTC: rtctest: Change no IRQ detection for RTC_IRQP_READ
> >   RTC: rtctest: Change no IRQ detection for RTC_IRQP_SET
> 
> I already had patches for that issue in a development tree, I'll see if
> they match what I did.
> 

I've applied those now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
