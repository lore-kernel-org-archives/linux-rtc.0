Return-Path: <rtc-linux+bncBDKZNNNLXAHBB6GC6SUAKGQEFX3LYXQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id oc12si565888pdb.1.2015.04.02.04.01.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-MD5 bits=128/128);
        Thu, 02 Apr 2015 04:01:11 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NM6004GLESOET70@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 02 Apr 2015 12:05:12 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-s3c: Fix failed first read of RTC time
Date: Thu, 02 Apr 2015 13:00:59 +0200
Message-id: <1427972459-6480-1-git-send-email-k.kozlowski@samsung.com>
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

Initialize the device time (if it is wrong) before registering RTC
device to fix following error message during rtc-s3c probe:

[    2.215414] rtc (null): read_time: fail to read
[    2.216322] s3c-rtc 10070000.rtc: rtc core: registered s3c as rtc1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 5e162eaad277..1d3a4c58fec4 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -496,6 +496,22 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
+	/* Check RTC Time */
+	s3c_rtc_gettime(&pdev->dev, &rtc_tm);
+
+	if (rtc_valid_tm(&rtc_tm)) {
+		rtc_tm.tm_year	= 100;
+		rtc_tm.tm_mon	= 0;
+		rtc_tm.tm_mday	= 1;
+		rtc_tm.tm_hour	= 0;
+		rtc_tm.tm_min	= 0;
+		rtc_tm.tm_sec	= 0;
+
+		s3c_rtc_settime(&pdev->dev, &rtc_tm);
+
+		dev_warn(&pdev->dev, "warning: invalid RTC value so initializing it\n");
+	}
+
 	/* register RTC and exit */
 	info->rtc = devm_rtc_device_register(&pdev->dev, "s3c", &s3c_rtcops,
 				  THIS_MODULE);
@@ -519,22 +535,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		goto err_nortc;
 	}
 
-	/* Check RTC Time */
-	s3c_rtc_gettime(&pdev->dev, &rtc_tm);
-
-	if (rtc_valid_tm(&rtc_tm)) {
-		rtc_tm.tm_year	= 100;
-		rtc_tm.tm_mon	= 0;
-		rtc_tm.tm_mday	= 1;
-		rtc_tm.tm_hour	= 0;
-		rtc_tm.tm_min	= 0;
-		rtc_tm.tm_sec	= 0;
-
-		s3c_rtc_settime(&pdev->dev, &rtc_tm);
-
-		dev_warn(&pdev->dev, "warning: invalid RTC value so initializing it\n");
-	}
-
 	if (info->data->select_tick_clk)
 		info->data->select_tick_clk(info);
 
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
