Return-Path: <rtc-linux+bncBDS7HNEFSALRBZ62VG4AKGQEMVG6K4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si435499wmg.1.2016.04.10.08.12.38
        for <rtc-linux@googlegroups.com>;
        Sun, 10 Apr 2016 08:12:38 -0700 (PDT)
Date: Sun, 10 Apr 2016 17:12:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
Message-ID: <20160410151237.GD5377@piout.net>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 10/04/2016 at 23:59:22 +0900, Akinobu Mita wrote :
> This series adds support access to DS1302 with GPIO lines.
> 
> Recently rtc-ds1302 is rewritten using SPI 3wire mode.  This adds
> another platform driver using GPIO while supporting both modes.
> 
> Thie series first fixes two problems I found while tesing, secondly
> introduces the abstraction layer for the register access which enables
> to share the most code between spi and platform driver, and adds
> the platform driver using GPIO.
> 

Well, isn't spi-gpio fitting for that use case? I'd like to avoid open
coding gpio bitbanging in the driver.

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
