Return-Path: <rtc-linux+bncBDS7HNEFSALRBBWLWO3AKGQEYG3UHSA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si1236566wme.2.2016.02.23.15.04.38
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 15:04:38 -0800 (PST)
Date: Wed, 24 Feb 2016 00:04:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	jbe@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v2] RTC/PCF85063: fix reading/setting time/date
Message-ID: <20160223230437.GC10681@piout.net>
References: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/02/2016 at 11:57:24 +0100, Juergen Borleis wrote :
> The PCF85063 RTC needs special treatment while setting or reading the
> time/date:
> 
>  - when reading the 7 time/date registers they are blocked from updating by
>    the 'one second' pulse internally. So reading all time/date registers
>    should happen in one turn to ensure reading is an atomic operation
> 
>  - to let setting the time/date be an atomic operation as well, the clock
>    dividers must be kept in reset state to avoid a 'one second' pulse during
>    writing the 7 time/date registers
> 
> Changes from v1:
> 
>  - using high level I2C access functions instead of the low level i2c_transfer()
>    to simplify the code
> 

All applied, thanks!

However, I found two interesting things in that driver. I'll send a
patch shortly, removing the useless century handling.
Also, I'm quite unsure about the year range handling. I have a patch but
I'm not sure about the RTC behaviour when the year goes from 99 to 00.
Can you check that works properly?

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
