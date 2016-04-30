Return-Path: <rtc-linux+bncBC2JFQ6TUUPRB2MGSS4QKGQE46VFLKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id a124si477830wme.0.2016.04.30.12.11.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2016 12:11:37 -0700 (PDT)
Received: by mail-wm0-x22c.google.com with SMTP id g17so84102216wme.1
        for <rtc-linux@googlegroups.com>; Sat, 30 Apr 2016 12:11:37 -0700 (PDT)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: stmp3xxx: print message on error
Date: Sat, 30 Apr 2016 20:11:30 +0100
Message-Id: <1462043490-21448-1-git-send-email-sudipm.mukherjee@gmail.com>
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
platform_device_add() can fail. But when it fails it failed silently.
Lets print out an error message on failure so that user will atlest
know that there was some error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

v1 -  returned error while failing in the probe.

 drivers/rtc/rtc-stmp3xxx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index ca54d03..e6aaaa5 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -107,14 +107,19 @@ static struct stmp3xxx_wdt_pdata wdt_pdata = {
 
 static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 {
+	int rc = -1;
 	struct platform_device *wdt_pdev =
 		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
 
 	if (wdt_pdev) {
 		wdt_pdev->dev.parent = &rtc_pdev->dev;
 		wdt_pdev->dev.platform_data = &wdt_pdata;
-		platform_device_add(wdt_pdev);
+		rc = platform_device_add(wdt_pdev);
 	}
+
+	if (rc)
+		dev_err(&rtc_pdev->dev,
+			"failed to register stmp3xxx_rtc_wdt\n");
 }
 #else
 static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
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
