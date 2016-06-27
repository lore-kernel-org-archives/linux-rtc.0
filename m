Return-Path: <rtc-linux+bncBCPM5SUWUYIRBT4XYS5QKGQEIWELKUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id c11si2169679pfc.2.2016.06.27.04.19.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 04:19:43 -0700 (PDT)
Received: by mail-pf0-x244.google.com with SMTP id c74so15620836pfb.0
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 04:19:43 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 0/2] support control with using GPIO lines
Date: Mon, 27 Jun 2016 20:19:20 +0900
Message-Id: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
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

This series first introduces the abstraction layer for the register
access which enables to share the most code between existing spi driver
and new platform driver, and then adds the platform driver using GPIO.

Changes from v1
* Remove two fixes which have already been merged
* Remove readbyte and writebyte ops from ds1302_ops because they were
  just special cases for readburst and writeburst ops
* Place Kconfig entry under Platform RTC drivers

Akinobu Mita (2):
  rtc: ds1302: add register access abstraction layer
  rtc: ds1302: support control with using GPIO lines

 .../devicetree/bindings/rtc/maxim-ds1302.txt       |  13 +
 drivers/rtc/Kconfig                                |  17 +-
 drivers/rtc/rtc-ds1302.c                           | 509 ++++++++++++++++++---
 3 files changed, 456 insertions(+), 83 deletions(-)

Cc: Sergey Yanovich <ynvich@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
