Return-Path: <rtc-linux+bncBDKZNNNLXAHBB7VF6WUAKGQEEXJEI2Y@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id br7si616284pdb.2.2015.04.02.07.32.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-MD5 bits=128/128);
        Thu, 02 Apr 2015 07:32:30 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NM60093UOKVUS00@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 02 Apr 2015 15:36:31 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-s3c: Remove one superfluous
 rtc_valid_tm() check
Date: Thu, 02 Apr 2015 16:31:56 +0200
Message-id: <1427985116-20314-1-git-send-email-k.kozlowski@samsung.com>
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

The s3c_rtc_gettime() returns already result of rtc_valid_tm() on
obtained time so get rid of another call to rtc_valid_tm().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 1d3a4c58fec4..a0f832362199 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -497,9 +497,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	/* Check RTC Time */
-	s3c_rtc_gettime(&pdev->dev, &rtc_tm);
-
-	if (rtc_valid_tm(&rtc_tm)) {
+	if (s3c_rtc_gettime(&pdev->dev, &rtc_tm)) {
 		rtc_tm.tm_year	= 100;
 		rtc_tm.tm_mon	= 0;
 		rtc_tm.tm_mday	= 1;
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
