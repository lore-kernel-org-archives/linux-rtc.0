Return-Path: <rtc-linux+bncBDP6N55ZUYDRBR5U3XCQKGQEO2CBJYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id 2si371958pfz.1.2017.03.01.15.33.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 15:33:27 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id b5so2438144pfa.0
        for <rtc-linux@googlegroups.com>; Wed, 01 Mar 2017 15:33:27 -0800 (PST)
Date: Wed, 1 Mar 2017 15:33:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: omap: remove incorrect __exit markups
Message-ID: <20170301233323.GA8881@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Even if bus is not hot-pluggable, devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe(), which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 51e52446eacb..fa856d9c5e23 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -844,7 +844,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit omap_rtc_remove(struct platform_device *pdev)
+static int omap_rtc_remove(struct platform_device *pdev)
 {
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
 	u8 reg;
@@ -964,7 +964,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 
 static struct platform_driver omap_rtc_driver = {
 	.probe		= omap_rtc_probe,
-	.remove		= __exit_p(omap_rtc_remove),
+	.remove		= omap_rtc_remove,
 	.shutdown	= omap_rtc_shutdown,
 	.driver		= {
 		.name	= "omap_rtc",
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
