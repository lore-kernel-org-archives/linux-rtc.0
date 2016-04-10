Return-Path: <rtc-linux+bncBCPM5SUWUYIRBXWUVG4AKGQE6KHJCSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id y20si1149388pfa.2.2016.04.10.07.59.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Apr 2016 07:59:42 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id hb4so12537267pac.1
        for <rtc-linux@googlegroups.com>; Sun, 10 Apr 2016 07:59:42 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 0/4] support control with using GPIO lines
Date: Sun, 10 Apr 2016 23:59:22 +0900
Message-Id: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This series adds support access to DS1302 with GPIO lines.

Recently rtc-ds1302 is rewritten using SPI 3wire mode.  This adds
another platform driver using GPIO while supporting both modes.

Thie series first fixes two problems I found while tesing, secondly
introduces the abstraction layer for the register access which enables
to share the most code between spi and platform driver, and adds
the platform driver using GPIO.

Akinobu Mita (4):
  rtc: ds1302: fix error check in set_time
  rtc: ds1302: fix write value for day of week register
  rtc: ds1302: add register access abstraction layer
  rtc: ds1302: support control with using GPIO lines

 .../devicetree/bindings/rtc/maxim-ds1302.txt       |  13 +
 drivers/rtc/Kconfig                                |  17 +-
 drivers/rtc/rtc-ds1302.c                           | 558 ++++++++++++++++++---
 3 files changed, 503 insertions(+), 85 deletions(-)

Cc: Sergey Yanovich <ynvich@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
-- 
2.5.0

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
