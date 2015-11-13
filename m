Return-Path: <rtc-linux+bncBCZ6H25I54IBBZ4MTGZAKGQENPKWTYI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id sm2si2124575pab.0.2015.11.13.12.21.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2015 12:21:59 -0800 (PST)
Received: by mail-pa0-x244.google.com with SMTP id fl14so13783247pac.1
        for <rtc-linux@googlegroups.com>; Fri, 13 Nov 2015 12:21:59 -0800 (PST)
From: Nizam Haider <nizamhaider786@gmail.com>
To: ulli.kroll@googlemail.com
Cc: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [rtc-linux] [PATCH] Rtc: rtc-gemini.c: Remove unnecessary platform_set_drvdata()
Date: Sat, 14 Nov 2015 01:51:29 +0530
Message-Id: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
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

The driver core clears the driver data to NULL after device_release
or on probe failure

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/rtc/rtc-gemini.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index e841846..f46b6d4 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -156,7 +156,6 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
 
 	rtc_device_unregister(rtc->rtc_dev);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.8.1.4

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
