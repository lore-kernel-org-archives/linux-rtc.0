Return-Path: <rtc-linux+bncBDS7HNEFSALRBUW54WWQKGQEQREYW5Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si776926wiz.2.2015.07.29.17.24.50
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Jul 2015 17:24:50 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 3/5] rtc: at91sam9: sort headers alphabetically
Date: Thu, 30 Jul 2015 02:24:30 +0200
Message-Id: <1438215872-27794-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Sort included headers alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 0a8485ac3864..23f721d049b2 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -11,20 +11,20 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/time.h>
-#include <linux/rtc.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
-#include <linux/slab.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_data/atmel.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/clk.h>
+#include <linux/time.h>
 
 /*
  * This driver uses two configurable hardware resources that live in the
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
