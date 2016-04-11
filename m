Return-Path: <rtc-linux+bncBC2JFQ6TUUPRBBVEV64AKGQEI247NSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com. [2607:f8b0:400e:c03::22e])
        by gmr-mx.google.com with ESMTPS id ph3si1499197pac.1.2016.04.11.09.34.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 09:34:13 -0700 (PDT)
Received: by mail-pa0-x22e.google.com with SMTP id zm5so124449131pac.0
        for <rtc-linux@googlegroups.com>; Mon, 11 Apr 2016 09:34:13 -0700 (PDT)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: stmp3xxx: check for failure
Date: Mon, 11 Apr 2016 22:03:55 +0530
Message-Id: <1460392435-23803-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

stmp3xxx_wdt_register() can fail as platform_device_alloc() or
platform_device_add() can fail. Lets check for the return value from
both platform_device_alloc() and platform_device_add() and return the
error value accordingly which is now propagated from probe.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/rtc/rtc-stmp3xxx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index ca54d03..e02e827 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -105,20 +105,22 @@ static struct stmp3xxx_wdt_pdata wdt_pdata = {
 	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
 };
 
-static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
+static int stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 {
 	struct platform_device *wdt_pdev =
 		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
 
-	if (wdt_pdev) {
-		wdt_pdev->dev.parent = &rtc_pdev->dev;
-		wdt_pdev->dev.platform_data = &wdt_pdata;
-		platform_device_add(wdt_pdev);
-	}
+	if (!wdt_pdev)
+		return -ENOMEM;
+
+	wdt_pdev->dev.parent = &rtc_pdev->dev;
+	wdt_pdev->dev.platform_data = &wdt_pdata;
+	return platform_device_add(wdt_pdev);
 }
 #else
-static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
+static int stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 {
+	return 0;
 }
 #endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
 
@@ -357,8 +359,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	stmp3xxx_wdt_register(pdev);
-	return 0;
+	return stmp3xxx_wdt_register(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
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
