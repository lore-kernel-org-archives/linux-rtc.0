Return-Path: <rtc-linux+bncBCF2PQPV4MDRB75EQWWQKGQEGB3XTIA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com. [2a00:1450:4010:c04::232])
        by gmr-mx.google.com with ESMTPS id sf5si377844lbb.2.2015.07.11.10.29.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2015 10:29:35 -0700 (PDT)
Received: by lblf12 with SMTP id f12so37249353lbl.2
        for <rtc-linux@googlegroups.com>; Sat, 11 Jul 2015 10:29:35 -0700 (PDT)
From: Joachim Eastwood <manabian@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: Joachim Eastwood <manabian@gmail.com>,
	joshc@ni.com,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v3 0/2] RTC support for NXP LPC18xx family
Date: Sat, 11 Jul 2015 19:28:48 +0200
Message-Id: <1436635730-15617-1-git-send-email-manabian@gmail.com>
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
including LPC178x/18xx/408x/43xx. The RTC provides calendar and
clock functionality together with alarm interrupt support.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up. Driver was originally written to support the
LPC24xx platform but since this platform isn't upstream support has
been removed. The LPC24xx name is still kept to preserve the origin
of this hardware block.

Been a while since the last version, but this version should address
all comments from Josh and Alexandre on v2. There has also been some
rework from my side. Please have a look.

changes since v2:
 - rework hw init
 - update Kconfig text
 - remove unused registers defines
 - misc clean ups
 - rebase on 4.2-rc1

changes since v1:
 - s/lpc2k/lpc24xx for better consistency
 - fix Kconfig entry
 - drop support for old versions for the ip block

Patch set is based on Linux v4.2-rc1.

Joachim Eastwood (2):
  rtc: add rtc-lpc24xx driver
  doc: dt: add documentation for nxp,lpc1788-rtc

 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    |  21 ++
 drivers/rtc/Kconfig                                |  12 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-lpc24xx.c                          | 310 +++++++++++++++++++++
 4 files changed, 344 insertions(+)
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
