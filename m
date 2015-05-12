Return-Path: <rtc-linux+bncBDS7HNEFSALRBHXRZGVAKGQEVWO5GKA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si172730wia.1.2015.05.12.15.03.09
        for <rtc-linux@googlegroups.com>;
        Tue, 12 May 2015 15:03:09 -0700 (PDT)
Date: Wed, 13 May 2015 00:03:08 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: remove unused variables
Message-ID: <20150512220308.GT3338@piout.net>
References: <2116673.Ym6IPoTTaZ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2116673.Ym6IPoTTaZ@wuerfel>
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

On 13/05/2015 at 00:00:33 +0200, Arnd Bergmann wrote :
> A recent bugfix introduced a new compiler warning in the rtc-armada38x
> driver:
> 
> drivers/rtc/rtc-armada38x.c: In function 'armada38x_rtc_read_time':
> drivers/rtc/rtc-armada38x.c:67:34: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long time, time_check, flags;
> 
> This removes the now obsolete variables to get rid of the warning.
> As the orginal fix was marked for stable backports [4.0], this one
> should be backported as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 489405fe5ed38 ("rtc: armada38x: fix concurrency access in armada38x_rtc_set_time")
> Cc: stable@vger.kernel.org
> 

That one has already been sent by Gregory ;)


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
