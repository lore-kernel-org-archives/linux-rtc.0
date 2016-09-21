Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB5UMRS7QKGQECFL6GDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si2940156wmr.2.2016.09.21.15.15.18
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Sep 2016 15:15:18 -0700 (PDT)
Date: Thu, 22 Sep 2016 00:15:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: ds1347: changed raw spi calls to
 register map calls
Message-ID: <20160921221517.jkvv7ngmw2yc3qtp@piout.net>
References: <57C71506.6000202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57C71506.6000202@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/08/2016 at 23:03:58 +0530, Raghavendra Chandra Ganiga wrote :
> From 633c012ba6c8f9bc6cf475d2434ca450cd06b18e Mon Sep 17 00:00:00 2001
> From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
> Date: Wed, 31 Aug 2016 22:56:41 +0530
> Subject: [PATCH] rtc: ds1347: changed raw spi calls to register map calls
> 
> This patch changes calls of spi read write calls to register map
> read and write calls in rtc ds1347
> 
> Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
> ---
>  drivers/rtc/Kconfig      |  1 +
>  drivers/rtc/rtc-ds1347.c | 96 ++++++++++++++++++++++++++----------------------
>  2 files changed, 54 insertions(+), 43 deletions(-)
> 
Applied, thanks.

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
