Return-Path: <rtc-linux+bncBCLLTU5HV4PRBTO77W6AKGQECPWH6BY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mta2.parkeon.com (ip83.parkeon.com. [213.152.31.83])
        by gmr-mx.google.com with ESMTPS id i193si867935wmg.1.2016.08.01.08.50.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 08:50:37 -0700 (PDT)
Subject: [rtc-linux] [PATCH 1/3] dt-binding: rtc Add DT binding for NXP 85263 RTC
To: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com
Date: Mon, 01 Aug 2016 17:50:32 +0200
Message-ID: <20160801155032.32232.68432.stgit@localhost>
In-Reply-To: <20160801155029.32232.56063.stgit@localhost>
References: <20160801155029.32232.56063.stgit@localhost>
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

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../devicetree/bindings/rtc/nxp,pcf85263.txt       |   41 ++++++++++++++++++++
 include/dt-bindings/rtc/nxp,pcf85263.h             |   14 +++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
 create mode 100644 include/dt-bindings/rtc/nxp,pcf85263.h

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
new file mode 100644
index 0000000..03b9505
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
@@ -0,0 +1,41 @@
+NXP PCF85263 I2C Real Time Clock
+
+Required properties:
+- compatible: must be: "nxp,rtc-pcf85263"
+- reg: must be the I2C address
+
+Optional properties:
+- interrupt-names: Which interrupt signal is used must be "INTA" or "INTB"
+    Defaults to "INTA"
+
+- quartz-load-capacitance: The internal capacitor to select for the quartz:
+	PCF85263_QUARTZCAP_7pF		[0]
+	PCF85263_QUARTZCAP_6pF		[1]
+	PCF85263_QUARTZCAP_12p5pF	[2] DEFAULT
+
+- quartz-drive-strength: Drive strength for the quartz:
+	PCF85263_QUARTZDRIVE_NORMAL	[0] DEFAULT
+	PCF85263_QUARTZDRIVE_LOW	[1]
+	PCF85263_QUARTZDRIVE_HIGH	[2]
+
+- quartz-low-jitter: Boolean property, if present enables low jitter mode which
+    reduces jitter at the cost of increased power consumption.
+
+- wakeup-source: mark the chip as a wakeup source, independently of
+    the availability of an IRQ line connected to the SoC.
+    This is useful if the IRQ line is connected to a PMIC or other circuit
+    that can power up the device rather than to a normal SOC interrupt.
+
+Example:
+
+rtc@51 {
+	compatible = "nxp,pcf85263";
+	reg = <0x51>;
+
+	interrupt-parent = <&gpio4>;
+	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "INTB";
+
+	quartz-load-capacitance = <PCF85263_QUARTZCAP_12p5pF>;
+	quartz-drive-strength = <PCF85263_QUARTZDRIVE_LOW>;
+};
diff --git a/include/dt-bindings/rtc/nxp,pcf85263.h b/include/dt-bindings/rtc/nxp,pcf85263.h
new file mode 100644
index 0000000..ea87ae4
--- /dev/null
+++ b/include/dt-bindings/rtc/nxp,pcf85263.h
@@ -0,0 +1,14 @@
+#ifndef _DT_BINDINGS_RTC_NXP_PCF85263_H
+#define _DT_BINDINGS_RTC_NXP_PCF85263_H
+
+/* Quartz capacitance */
+#define PCF85263_QUARTZCAP_7pF		0
+#define PCF85263_QUARTZCAP_6pF		1
+#define PCF85263_QUARTZCAP_12p5pF	2
+
+/* Quartz drive strength */
+#define PCF85263_QUARTZDRIVE_NORMAL	0
+#define PCF85263_QUARTZDRIVE_LOW	1
+#define PCF85263_QUARTZDRIVE_HIGH	2
+
+#endif /* _DT_BINDINGS_RTC_NXP_PCF85263_H */

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
