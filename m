Return-Path: <rtc-linux+bncBDCMXBNSKAINHZVIXMCRUBABWICEC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id f10si180879wmg.2.2016.06.21.23.42.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 23:42:27 -0700 (PDT)
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 315F4158016B
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:27 +0200 (CEST)
Received: from SI-HUB1001.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id CC4AF2E40315
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:26 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [rtc-linux] [PATCH v2 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
Date: Wed, 22 Jun 2016 08:42:20 +0200
Message-ID: <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
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

From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>

... and Epson RX8900 real time clock

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt

diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.txt b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
new file mode 100644
index 0000000..3f61e51
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.txt
@@ -0,0 +1,22 @@
+Real Time Clock driver for:
+  - Epson RX8900
+  - Micro Crystal rv8803
+
+Required properties:
+- compatible: should be: "microcrystal,rv8803" or "epson,rx8900"
+- reg : the I2C address of the device for I2C
+
+Optional properties:
+- epson,vdet-disable : boolean, if present will disable voltage detector.
+  Should be set if no backup battery is used.
+- trickle-diode-disable : boolean, if present will disable internal trickle
+  charger diode
+
+Example:
+
+	rtc: rtc@32 {
+		compatible = "epson,rx8900"
+		reg = <0x32>;
+		epson,vdet-disable;
+		trickle-diode-disable;
+	};
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
