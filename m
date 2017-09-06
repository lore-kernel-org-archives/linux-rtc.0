Return-Path: <rtc-linux+bncBAABBKM6X3GQKGQEXX4CQMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (mail-by2nam01on0056.outbound.protection.outlook.com. [104.47.34.56])
        by gmr-mx.google.com with ESMTPS id a67si97836pfe.17.2017.09.05.23.01.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Sep 2017 23:01:13 -0700 (PDT)
From: <ying.zhang22455@nxp.com>
To: <rtc-linux@googlegroups.com>
CC: <jiafei.pan@nxp.com>, Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pcf85263.c: add support for devicetree
Date: Wed, 6 Sep 2017 13:44:03 +0800
Message-ID: <20170906054403.18567-1-ying.zhang22455@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add compatible string "nxp,rtc-pcf85263"
Document the binding

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt
new file mode 100644
index 000000000000..d2ffd3626f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt
@@ -0,0 +1,15 @@
+NXP PCF85263 SPI Real Time Clock
+
+Required properties:
+- compatible: should be: "nxp,rtc-pcf85263"
+- reg: should be the SPI slave chipselect address
+
+Optional properties:
+- spi-cs-high: PCF85263 needs chipselect high
+
+Example:
+
+rtc: nxp,rtc-pcf85263@51 {
+	compatible = "nxp,rtc-pcf85263"
+	reg = <51>
+};
-- 
2.14.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
