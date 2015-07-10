Return-Path: <rtc-linux+bncBDKZNNNLXAHBBQOR7WWAKGQERIIR7WY@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ra16si857171pac.0.2015.07.09.23.40.00
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 23:40:00 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NR90042FEIK8M40@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 10 Jul 2015 07:39:56 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: Drop owner assignment from platform_driver
Date: Fri, 10 Jul 2015 15:39:51 +0900
Message-id: <1436510391-6001-3-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
References: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
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

platform_driver does not need to set an owner because
platform_driver_register() will set it.
---
 drivers/rtc/rtc-opal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7061dcae2b09..417d7b4a5cd8 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -236,7 +236,6 @@ static struct platform_driver opal_rtc_driver = {
 	.id_table	= opal_rtc_driver_ids,
 	.driver		= {
 		.name		= DRVNAME,
-		.owner		= THIS_MODULE,
 		.of_match_table	= opal_rtc_match,
 	},
 };
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
