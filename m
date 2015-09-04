Return-Path: <rtc-linux+bncBDULZYNR2QMRBY4OU2XQKGQE3WJWY5Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com. [2607:f8b0:4002:c07::233])
        by gmr-mx.google.com with ESMTPS id g144si224814ywb.6.2015.09.04.04.58.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 04:58:27 -0700 (PDT)
Received: by mail-yk0-x233.google.com with SMTP id k143so17913762yke.2
        for <rtc-linux@googlegroups.com>; Fri, 04 Sep 2015 04:58:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: k.kozlowski@samsung.com,
	ryabinin.a.a@gmail.com,
	rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH v2] rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]
Date: Fri,  4 Sep 2015 08:58:05 -0300
Message-Id: <1441367885-10077-1-git-send-email-festevam@gmail.com>
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

Reported-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changes since v1:
- Add also a Reported-by tag from Andrey Ryabinin and also Reviewed-by from
Krzysztof Kozlowski.

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
