Return-Path: <rtc-linux+bncBDCMXBNSKAINHZVIXMCRUBABWICEC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id f10si180878wmg.2.2016.06.21.23.42.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 23:42:27 -0700 (PDT)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id E59FD158016B
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 9B395A405B5
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel
	<fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [rtc-linux] [PATCH v2 3/4] rtc: rv8803: add device tree compatible names
Date: Wed, 22 Jun 2016 08:42:21 +0200
Message-ID: <1466577742-18824-4-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
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

From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

Add device tree compatible names for usage in a compatible
list of alternative RTC devices.

Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: devicetree@vger.kernel.org
---
 drivers/rtc/rtc-rv8803.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index f623038..e122b51 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
+#include <linux/of.h>
 
 #define RV8803_SEC			0x00
 #define RV8803_MIN			0x01
@@ -520,9 +521,19 @@ static const struct i2c_device_id rv8803_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rv8803_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id rv8803_of_match[] = {
+	{ .compatible = "microcrystal,rv8803", },
+	{ .compatible = "epson,rx8900", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rv8803_of_match);
+#endif
+
 static struct i2c_driver rv8803_driver = {
 	.driver = {
 		.name = "rtc-rv8803",
+		.of_match_table = of_match_ptr(rv8803_of_match),
 	},
 	.probe		= rv8803_probe,
 	.remove		= rv8803_remove,
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
