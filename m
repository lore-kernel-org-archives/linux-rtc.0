Return-Path: <rtc-linux+bncBDS7HNEFSALRBSUTQKXAKGQEX7H7DEY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hm7si54172wib.0.2015.08.04.02.45.45
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:45 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 05/15] rtc: rx8025: use BIT()
Date: Tue,  4 Aug 2015 11:45:24 +0200
Message-Id: <1438681534-12027-6-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Use BIT() instead of hand coding.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 612b6876cbd5..52683eda1da2 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -19,6 +19,7 @@
  * version 2 as published by the Free Software Foundation.
  */
 #include <linux/bcd.h>
+#include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -45,17 +46,17 @@
 #define RX8025_BIT_CTRL1_CT	(7 << 0)
 /* 1 Hz periodic level irq */
 #define RX8025_BIT_CTRL1_CT_1HZ	4
-#define RX8025_BIT_CTRL1_TEST	(1 << 3)
-#define RX8025_BIT_CTRL1_1224	(1 << 5)
-#define RX8025_BIT_CTRL1_DALE	(1 << 6)
-#define RX8025_BIT_CTRL1_WALE	(1 << 7)
-
-#define RX8025_BIT_CTRL2_DAFG	(1 << 0)
-#define RX8025_BIT_CTRL2_WAFG	(1 << 1)
-#define RX8025_BIT_CTRL2_CTFG	(1 << 2)
-#define RX8025_BIT_CTRL2_PON	(1 << 4)
-#define RX8025_BIT_CTRL2_XST	(1 << 5)
-#define RX8025_BIT_CTRL2_VDET	(1 << 6)
+#define RX8025_BIT_CTRL1_TEST	BIT(3)
+#define RX8025_BIT_CTRL1_1224	BIT(5)
+#define RX8025_BIT_CTRL1_DALE	BIT(6)
+#define RX8025_BIT_CTRL1_WALE	BIT(7)
+
+#define RX8025_BIT_CTRL2_DAFG	BIT(0)
+#define RX8025_BIT_CTRL2_WAFG	BIT(1)
+#define RX8025_BIT_CTRL2_CTFG	BIT(2)
+#define RX8025_BIT_CTRL2_PON	BIT(4)
+#define RX8025_BIT_CTRL2_XST	BIT(5)
+#define RX8025_BIT_CTRL2_VDET	BIT(6)
 
 /* Clock precision adjustment */
 #define RX8025_ADJ_RESOLUTION	3050 /* in ppb */
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
