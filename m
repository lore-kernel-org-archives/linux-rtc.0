Return-Path: <rtc-linux+bncBDS7HNEFSALRBMWH22VQKGQEXWK3NRI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si49740wib.3.2015.06.08.07.16.17
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Jun 2015 07:16:17 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 1/2] rtc: mv: use BIT()
Date: Mon,  8 Jun 2015 16:16:14 +0200
Message-Id: <1433772975-15228-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Use bit instead of hand coding the shift and correct the 24 hour vs 24
hours typo.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes since v1:
 - split the patch, first switching to use BIT then fixing the error
   message

 drivers/rtc/rtc-mv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 423762241042..7e84bb4072ad 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -24,7 +25,7 @@
 #define RTC_MINUTES_OFFS	8
 #define RTC_HOURS_OFFS		16
 #define RTC_WDAY_OFFS		24
-#define RTC_HOURS_12H_MODE		(1 << 22) /* 12 hours mode */
+#define RTC_HOURS_12H_MODE	BIT(22) /* 12 hour mode */
 
 #define RTC_DATE_REG_OFFS	4
 #define RTC_MDAY_OFFS		0
@@ -33,7 +34,7 @@
 
 #define RTC_ALARM_TIME_REG_OFFS	8
 #define RTC_ALARM_DATE_REG_OFFS	0xc
-#define RTC_ALARM_VALID		(1 << 7)
+#define RTC_ALARM_VALID		BIT(7)
 
 #define RTC_ALARM_INTERRUPT_MASK_REG_OFFS	0x10
 #define RTC_ALARM_INTERRUPT_CASUE_REG_OFFS	0x14
-- 
2.1.4

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
