Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6FES26AKGQEYITJKHI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 65si246596wmr.3.2016.07.12.17.59.36
        for <rtc-linux@googlegroups.com>;
        Tue, 12 Jul 2016 17:59:36 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 0/3] rtc: remove intersil isl12057
Date: Wed, 13 Jul 2016 02:59:28 +0200
Message-Id: <1468371571-22641-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Arnaud,

This is the series I intend to apply once you confirm my previous patch
is working.

Alexandre Belloni (3):
  Documentation: dt: Intersil isl12057 is not a trivial device
  rtc: ds1307: add Intersil ISL12057 support
  rtc: isl12057: remove driver

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 -
 drivers/rtc/Kconfig                                |  18 +-
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/rtc-ds1307.c                           |   6 +
 drivers/rtc/rtc-isl12057.c                         | 643 ---------------------
 5 files changed, 10 insertions(+), 659 deletions(-)
 delete mode 100644 drivers/rtc/rtc-isl12057.c

-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
