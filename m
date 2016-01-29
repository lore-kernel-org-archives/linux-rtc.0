Return-Path: <rtc-linux+bncBDQJZJXU2UMBB5WKVS2QKGQECXMGCLY@googlegroups.com>
MIME-Version: 1.0
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id tn7si2078517pac.1.2016.01.29.00.40.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 00:40:22 -0800 (PST)
From: Oleksij Rempel <linux@rempel-privat.de>
To: devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] [PATCH 0/2] add Alphascale asm9260 RTC driver
Date: Fri, 29 Jan 2016 09:40:00 +0100
Message-Id: <1454056802-23386-1-git-send-email-linux@rempel-privat.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch set provide support for RTC controller found on Alphascale
ASM9260 SoC.

Oleksij Rempel (2):
  rtc: add rtc-asm9260 driver
  doc: dt: add documentation for alphascale,asm9260-rtc

 .../bindings/rtc/alphascale,asm9260-rtc.txt        |  25 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-asm9260.c                          | 391 +++++++++++++++++++++
 4 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
 create mode 100644 drivers/rtc/rtc-asm9260.c

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
