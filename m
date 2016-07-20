Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBHWUX66AKGQENY6OFIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o85si1658558wme.0.2016.07.20.14.16.14
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jul 2016 14:16:14 -0700 (PDT)
Date: Wed, 20 Jul 2016 23:16:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: fix century bit support
Message-ID: <20160720211602.GD4446@piout.net>
References: <1468370064-19255-1-git-send-email-alexandre.belloni@free-electrons.com>
 <87inw8hu62.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87inw8hu62.fsf@natisbad.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/07/2016 at 21:54:45 +0200, Arnaud Ebalard wrote :
> One small thing though: for user which have always used RTC_DRV_ISL12057
> config knob, the change will not be transparent. Would it be possible to
> somehow make that old kernel config knob some kind of alias for
> RTC_DRV_DS1307 and RTC_DRV_DS1307_CENTURY in Kconfig?
> 

Well, I tried multiple things but making RTC_DRV_ISL12057 hidden makes it
unable to select both RTC_DRV_DS1307 and RTC_DRV_DS1307_CENTURY. I'll
try to find a solution but I pretty much prefer not having
RTC_DRV_ISL12057 selectable anymore

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
