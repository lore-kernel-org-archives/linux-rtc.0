Return-Path: <rtc-linux+bncBAABB55P3OZAKGQELXLR3MI@googlegroups.com>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com. [67.231.152.168])
        by gmr-mx.google.com with ESMTP id b62si40429wmc.0.2015.11.26.01.59.19
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Nov 2015 01:59:19 -0800 (PST)
From: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <patches@opensource.wolfsonmicro.com>,
        Piotr
 Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Subject: [rtc-linux] [PATCH] rtc: rx8581: adding Device Tree support
Date: Thu, 26 Nov 2015 09:58:37 +0000
Message-ID: <1448531917-14994-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
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

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
---
 drivers/rtc/rtc-rx8581.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 161e25d0..a4c86c5 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -312,9 +312,18 @@ static const struct i2c_device_id rx8581_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rx8581_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id rx8581_of_match[] = {
+	{ .compatible = "epson,rx8581"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, rx8581_of_match);
+#endif
+
 static struct i2c_driver rx8581_driver = {
 	.driver		= {
 		.name	= "rtc-rx8581",
+		.of_match_table = of_match_ptr(rx8581_of_match),
 	},
 	.probe		= rx8581_probe,
 	.id_table	= rx8581_id,
-- 
1.7.10.4

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
