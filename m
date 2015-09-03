Return-Path: <rtc-linux+bncBDULZYNR2QMRBB5GUKXQKGQE55GJPIQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com. [2607:f8b0:4002:c07::22e])
        by gmr-mx.google.com with ESMTPS id j22si1109467ywg.2.2015.09.03.11.35.51
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 11:35:51 -0700 (PDT)
Received: by mail-yk0-x22e.google.com with SMTP id g206so52458619ykd.1
        for <rtc-linux@googlegroups.com>; Thu, 03 Sep 2015 11:35:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linus.walleij@linaro.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH] rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]
Date: Thu,  3 Sep 2015 15:35:18 -0300
Message-Id: <1441305318-24773-1-git-send-email-festevam@gmail.com>
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

From: Fabio Estevam <fabio.estevam@freescale.com>

Add a sentinel to ab85xx_rtc_ids[] in order to fix the following error:

drivers/rtc/rtc-ab8500: struct platform_device_id is 24 bytes.  The last of 2 is:
0x61 0x62 0x38 0x35 0x34 0x30 0x2d 0x72 0x74 0x63 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x8c 
FATAL: drivers/rtc/rtc-ab8500: struct platform_device_id is not terminated with a NULL entry!

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-ab8500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 8537d1e..51407c4 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -445,6 +445,7 @@ static const struct rtc_class_ops ab8540_rtc_ops = {
 static const struct platform_device_id ab85xx_rtc_ids[] = {
 	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
 	{ "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, ab85xx_rtc_ids);
 
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
