Return-Path: <rtc-linux+bncBD62P6P6EQIIFJMKVICRUBFHAVERA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com. [2607:f8b0:4003:c01::22a])
        by gmr-mx.google.com with ESMTPS id x12si230844igx.1.2015.04.30.13.37.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 13:37:22 -0700 (PDT)
Received: by mail-ob0-x22a.google.com with SMTP id lk2so14304054obb.0
        for <rtc-linux@googlegroups.com>; Thu, 30 Apr 2015 13:37:22 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 3/4] ARM: sa1100: remove unused RTC register definitions
Date: Thu, 30 Apr 2015 15:37:12 -0500
Message-Id: <1430426233-7461-4-git-send-email-robh@kernel.org>
In-Reply-To: <1430426233-7461-1-git-send-email-robh@kernel.org>
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
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
v2:
- Rebase to v4.1-rc1

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
