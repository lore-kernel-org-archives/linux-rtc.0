Return-Path: <rtc-linux+bncBDS7HNEFSALRBOFR2SVAKGQEABK7WJY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si176862wiz.0.2015.05.14.14.50.48
        for <rtc-linux@googlegroups.com>;
        Thu, 14 May 2015 14:50:48 -0700 (PDT)
Date: Thu, 14 May 2015 23:50:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: pfc8563: fix uninitialized variable warning
Message-ID: <20150514215047.GE3338@piout.net>
References: <2293546.ekQV1ek12O@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2293546.ekQV1ek12O@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Andrew,

On 12/05/2015 at 23:27:02 +0200, Arnd Bergmann wrote :
> Gcc is unable to prove that alm_pending is always initialized
> when it is used, so it prints a harmless warning:
> 
> drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_probe':
> drivers/rtc/rtc-pcf8563.c:449:5: warning: 'alm_pending' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This uses the same conditional expression that is used inside of
> the pcf8563_get_alarm_mode() function, to help gcc figure it out
> and shut up that warning, and make the ARM defconfigs build again
> with no warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a45d528aab8b ("rtc: pcf8563: clear expired alarm at boot time")
> 

Can you send that fix to Linus for the next 4.1 rc?

You can add my
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I hope that will be the last one :)

Thanks!

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
