Return-Path: <rtc-linux+bncBAABBZWG6SUAKGQEFSBFQVA@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id e4si1772627igt.3.2015.04.02.04.09.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 04:09:26 -0700 (PDT)
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
CC: <t-kristo@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 3/3] rtc: omap: use module_platform_driver
Date: Thu, 2 Apr 2015 16:39:11 +0530
Message-ID: <1427972951-18959-4-git-send-email-lokeshvutla@ti.com>
In-Reply-To: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
References: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
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

module_platform_driver_probe() prevents driver from requesting probe deferral.
So using module_platform_drive() to support probe deferral.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 935212c..48f2257 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -521,7 +521,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
 
-static int __init omap_rtc_probe(struct platform_device *pdev)
+static int omap_rtc_probe(struct platform_device *pdev)
 {
 	struct omap_rtc	*rtc;
 	struct resource	*res;
@@ -756,6 +756,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_rtc_driver = {
+	.probe		= omap_rtc_probe,
 	.remove		= __exit_p(omap_rtc_remove),
 	.shutdown	= omap_rtc_shutdown,
 	.driver		= {
@@ -766,7 +767,7 @@ static struct platform_driver omap_rtc_driver = {
 	.id_table	= omap_rtc_id_table,
 };
 
-module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
+module_platform_driver(omap_rtc_driver);
 
 MODULE_ALIAS("platform:omap_rtc");
 MODULE_AUTHOR("George G. Davis (and others)");
-- 
1.9.1

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
