Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZHEU25QKGQEF4R3O7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f4si209881wmg.0.2016.06.21.14.32.20
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jun 2016 14:32:20 -0700 (PDT)
Date: Tue, 21 Jun 2016 23:32:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, cphealy@gmail.com
Subject: [rtc-linux] Re: [PATCH v2 00/17] DS1341 support and code cleanup
Message-ID: <20160621213219.GC5809@piout.net>
References: <1466493519-11277-1-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466493519-11277-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 21/06/2016 at 00:18:22 -0700, Andrey Smirnov wrote :
> Hi everyone,
> 
> This set is a v2 of the DS1307 driver patches. Changes since v1:
> 
>  - Devicetree bindings are separated into a separate commit
> 
>  - Device tree properties now have vendor specific prefixes and
>    documenatation explicitly stating their type
> 
>  - Three more patches, with improvements to rtctest.c, are added to
>    the patchset
> 



> Any feedback is appreciated.
> 
> Thank you,
> Andrey Smirnov
> 
> Andrey Smirnov (17):
>   RTC: ds1307: Add DS1341 variant
>   RTC: ds1307: Disable square wave and timers as default
>   RTC: ds1307: Add devicetree bindings for DS1341
>   RTC: ds1307: Add DS1341 specific power-saving options
>   RTC: ds1307: Convert ds1307_can_wakeup_device into a predicate
>   RTC: ds1307: Convert want_irq into a predicate

I'll have to triple check that one, it breaks in thousand different
ways, every time someone touches that code :)

>   RTC: ds1307: Move chip configuration into a separate routine
>   RTC: ds1307: Move chip sanity checking into a separate routine

I'm not sure about the cleanup in those two patches yet, It moves a lot
of code and the readability improvement is not obvious

>   RTC: ds1307: Remove register "cache"
>   RTC: ds1307: Constify struct ds1307 where possible
>   RTC: ds1307: Convert goto to a loop
>   RTC: ds1307: Redefine RX8025_REG_* to minimize extra code
>   RTC: ds1307: Report oscillator problems more intelligently
>   RTC: ds1307: Move last bits of sanity checking out of chip_configure

>   RTC: rtctest: Change alarm IRQ support detection
>   RTC: rtctest: Change no IRQ detection for RTC_IRQP_READ
>   RTC: rtctest: Change no IRQ detection for RTC_IRQP_SET

I already had patches for that issue in a development tree, I'll see if
they match what I did.

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
