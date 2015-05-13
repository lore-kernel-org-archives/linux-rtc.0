Return-Path: <rtc-linux+bncBD62P6P6EQIJXT6NVICRUBHGJVZU6@googlegroups.com>
MIME-Version: 1.0
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com. [2607:f8b0:4003:c06::229])
        by gmr-mx.google.com with ESMTPS id x12si483162igx.1.2015.05.13.08.02.51
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 08:02:51 -0700 (PDT)
Received: by mail-oi0-x229.google.com with SMTP id o83so33264798oik.1
        for <rtc-linux@googlegroups.com>; Wed, 13 May 2015 08:02:51 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>
Subject: [rtc-linux] [PATCH v4 5/6] ARM: sa1100: remove unused RTC register definitions
Date: Wed, 13 May 2015 10:02:29 -0500
Message-Id: <1431529350-4597-6-git-send-email-robh@kernel.org>
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Now that register definitions have been moved to the driver, we can remove
them from machine specific code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 -----------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
index 0ac6cc0..7972617 100644
--- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
+++ b/arch/arm/mach-sa1100/include/mach/SA-1100.h
@@ -858,40 +858,6 @@
 
 
 /*
- * Real-Time Clock (RTC) control registers
- *
- * Registers
- *    RTAR      	Real-Time Clock (RTC) Alarm Register (read/write).
- *    RCNR      	Real-Time Clock (RTC) CouNt Register (read/write).
- *    RTTR      	Real-Time Clock (RTC) Trim Register (read/write).
- *    RTSR      	Real-Time Clock (RTC) Status Register (read/write).
- *
- * Clocks
- *    frtx, Trtx	Frequency, period of the real-time clock crystal
- *              	(32.768 kHz nominal).
- *    frtc, Trtc	Frequency, period of the real-time clock counter
- *              	(1 Hz nominal).
- */
-
-#define RTAR		__REG(0x90010000)  /* RTC Alarm Reg. */
-#define RCNR		__REG(0x90010004)  /* RTC CouNt Reg. */
-#define RTTR		__REG(0x90010008)  /* RTC Trim Reg. */
-#define RTSR		__REG(0x90010010)  /* RTC Status Reg. */
-
-#define RTTR_C  	Fld (16, 0)	/* clock divider Count - 1         */
-#define RTTR_D  	Fld (10, 16)	/* trim Delete count               */
-                	        	/* frtc = (1023*(C + 1) - D)*frtx/ */
-                	        	/*        (1023*(C + 1)^2)         */
-                	        	/* Trtc = (1023*(C + 1)^2)*Trtx/   */
-                	        	/*        (1023*(C + 1) - D)       */
-
-#define RTSR_AL 	0x00000001	/* ALarm detected                  */
-#define RTSR_HZ 	0x00000002	/* 1 Hz clock detected             */
-#define RTSR_ALE	0x00000004	/* ALarm interrupt Enable          */
-#define RTSR_HZE	0x00000008	/* 1 Hz clock interrupt Enable     */
-
-
-/*
  * Power Manager (PM) control registers
  *
  * Registers
-- 
2.1.0

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
