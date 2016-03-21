Return-Path: <rtc-linux+bncBCW4XG6ATMLBB47VXS3QKGQE7NCCFCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x22f.google.com (mail-lf0-x22f.google.com. [2a00:1450:4010:c07::22f])
        by gmr-mx.google.com with ESMTPS id to3si884263lbb.1.2016.03.20.17.06.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Mar 2016 17:06:11 -0700 (PDT)
Received: by mail-lf0-x22f.google.com with SMTP id d82so51870377lfe.3
        for <rtc-linux@googlegroups.com>; Sun, 20 Mar 2016 17:06:11 -0700 (PDT)
Date: Mon, 21 Mar 2016 01:06:10 +0100
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, robh+dt@kernel.org
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-mcp795.c: add devicetree support
Message-ID: <20160321000610.GA21979@emba-laptop>
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

Add device tree support to the rtc-mcp795 driver.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt | 11 +++++++++++
 drivers/rtc/rtc-mcp795.c                               | 10 ++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt

diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
new file mode 100644
index 0000000..a59fdd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
@@ -0,0 +1,11 @@
+* Maxim MCP795		SPI Serial Real-Time Clock
+
+Required properties:
+- compatible: Should contain "maxim,mcp795".
+- reg: SPI address for chip
+
+Example:
+	mcp795: rtc@0 {
+		compatible = "maxim,mcp795";
+		reg = <0>;
+	};
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 1c91ce8..025bb33 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -20,6 +20,7 @@
 #include <linux/printk.h>
 #include <linux/spi/spi.h>
 #include <linux/rtc.h>
+#include <linux/of.h>
 
 /* MCP795 Instructions, see datasheet table 3-1 */
 #define MCP795_EEREAD	0x03
@@ -183,9 +184,18 @@ static int mcp795_probe(struct spi_device *spi)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id mcp795_of_match[] = {
+	{ .compatible = "maxim,mcp795" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp795_of_match);
+#endif
+
 static struct spi_driver mcp795_driver = {
 		.driver = {
 				.name = "rtc-mcp795",
+				.of_match_table = of_match_ptr(mcp795_of_match),
 		},
 		.probe = mcp795_probe,
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
