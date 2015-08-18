Return-Path: <rtc-linux+bncBDS7HNEFSALRBWXTZOXAKGQEOTC4BGQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x20si493029wia.0.2015.08.18.02.24.42
        for <rtc-linux@googlegroups.com>;
        Tue, 18 Aug 2015 02:24:42 -0700 (PDT)
Date: Tue, 18 Aug 2015 11:21:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: Align RTC set time procedure
 with the official errata
Message-ID: <20150818092152.GV22269@piout.net>
References: <1438874328-31844-1-git-send-email-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1438874328-31844-1-git-send-email-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/08/2015 at 17:18:48 +0200, Gregory CLEMENT wrote :
> From: Nadav Haklai <nadavh@marvell.com>
> 
> According to the Armada38x functional errata FE-3124064, writing to
> the RTC TIME register may fail. As a workaround, after writing to RTC
> TIME register, issue a dummy write of 0x0 twice to the RTC Status
> register.  This is the updated implementation of the Errata that
> eliminates the need of the long 100ms delay during the RTC set time
> procedure.
> 
> [gregory.clement@free-electrons.com]: removed the mutex and use the
> spinlock again
> 
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Applied, thanks.

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
