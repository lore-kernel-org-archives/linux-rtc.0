Return-Path: <rtc-linux+bncBCO3XAUMTIFRBIEMU2WAKGQEH655NFQ@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTP id b7si4915igv.3.2015.06.23.09.15.27
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Jun 2015 09:15:27 -0700 (PDT)
From: Nishanth Menon <nm@ti.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <balbi@ti.com>, <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] [PATCH V2 3/5] drivers/rtc/rtc-ds1307.c: Sort the headers
Date: Tue, 23 Jun 2015 11:15:12 -0500
Message-ID: <1435076114-12416-4-git-send-email-nm@ti.com>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

It is always a good practice to keep the #includes sorted

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/rtc/rtc-ds1307.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 0a98d8a52791..b03880fc32b5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,14 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rtc/ds1307.h>
+#include <linux/rtc.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
 #include <linux/string.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/rtc/ds1307.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
-- 
1.7.9.5

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
