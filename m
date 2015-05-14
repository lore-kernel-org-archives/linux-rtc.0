Return-Path: <rtc-linux+bncBCF2PQPV4MDRBYNZ2OVAKGQEBSKPKLI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com. [2a00:1450:4010:c03::22f])
        by gmr-mx.google.com with ESMTPS id bm9si1729531lbb.0.2015.05.14.10.35.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 10:35:28 -0700 (PDT)
Received: by mail-la0-x22f.google.com with SMTP id y10so77891584lay.0
        for <rtc-linux@googlegroups.com>; Thu, 14 May 2015 10:35:28 -0700 (PDT)
From: Joachim Eastwood <manabian@gmail.com>
To: akpm@linux-foundation.org,
	a.zummo@towertech.it
Cc: Joachim Eastwood <manabian@gmail.com>,
	wellsk40@gmail.com,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 0/2] RTC support for NXP LPC18xx family
Date: Thu, 14 May 2015 19:34:33 +0200
Message-Id: <1431624875-20990-1-git-send-email-manabian@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This patch set adds support for the RTC found on many NXP devices
including LPC24xx/178x/18xx/43xx. The RTC provides calendar and
clock functionality together with periodic tick and alarm interrupt
support.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up.

Patch set is based on Linux v4.1-rc1.

Base support for the NXP LPC18xx family can be found here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2

Joachim Eastwood (2):
  rtc: add rtc-lpc24xx driver
  doc: dt: add documentation for nxp,lpc1788-rtc

 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    |  21 ++
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-lpc24xx.c                          | 379 +++++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
 create mode 100644 drivers/rtc/rtc-lpc24xx.c

-- 
1.8.0

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
