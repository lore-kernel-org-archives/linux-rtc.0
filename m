Return-Path: <rtc-linux+bncBD62P6P6EQIIHJMKVICRUBDGLSHKQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com. [2607:f8b0:4003:c01::232])
        by gmr-mx.google.com with ESMTPS id f17si217674igt.0.2015.04.30.13.37.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 13:37:22 -0700 (PDT)
Received: by mail-ob0-x232.google.com with SMTP id e9so53378775obf.1
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
Subject: [rtc-linux] [PATCH v2 4/4] ARM: mmp: remove unused RTC register definitions
Date: Thu, 30 Apr 2015 15:37:13 -0500
Message-Id: <1430426233-7461-5-git-send-email-robh@kernel.org>
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

Now that register definitions have been moved to the driver, regs-rtc.h is
no longer used and can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
v2:
- Rebase to v4.1-rc1

 arch/arm/mach-mmp/include/mach/regs-rtc.h | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

diff --git a/arch/arm/mach-mmp/include/mach/regs-rtc.h b/arch/arm/mach-mmp/include/mach/regs-rtc.h
deleted file mode 100644
index 5bff886..0000000
--- a/arch/arm/mach-mmp/include/mach/regs-rtc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __ASM_MACH_REGS_RTC_H
-#define __ASM_MACH_REGS_RTC_H
-
-#include <mach/addr-map.h>
-
-#define RTC_VIRT_BASE	(APB_VIRT_BASE + 0x10000)
-#define RTC_REG(x)	(*((volatile u32 __iomem *)(RTC_VIRT_BASE + (x))))
-
-/*
- * Real Time Clock
- */
-
-#define RCNR		RTC_REG(0x00)	/* RTC Count Register */
-#define RTAR		RTC_REG(0x04)	/* RTC Alarm Register */
-#define RTSR		RTC_REG(0x08)	/* RTC Status Register */
-#define RTTR		RTC_REG(0x0C)	/* RTC Timer Trim Register */
-
-#define RTSR_HZE	(1 << 3)	/* HZ interrupt enable */
-#define RTSR_ALE	(1 << 2)	/* RTC alarm interrupt enable */
-#define RTSR_HZ		(1 << 1)	/* HZ rising-edge detected */
-#define RTSR_AL		(1 << 0)	/* RTC alarm detected */
-
-#endif /* __ASM_MACH_REGS_RTC_H */
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
