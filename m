Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40405 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHASZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Sep 2018 20:18:25 -0400
From: Sam Ravnborg <sam@ravnborg.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 2/5] dt-binding: rtc-pcf85063: add quartz load property
Date: Fri,  7 Sep 2018 21:35:05 +0200
Message-Id: <20180907193508.24974-3-sam@ravnborg.org>
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Søren Andersen <san@skov.dk>

The NXP pcf85063 support two different quartz loads.
- 7 pF (default)
- 12.5 pF (minimum power consumption)

The pcf85063 needs to know the size of the external capacitor,
otherwise the RTC will have a bad precision (hours/week).

The power-on default is 7 pF
Add a property that tells if the external capacitor is 12.5 pF

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 .../devicetree/bindings/rtc/nxp,pcf85063.txt          | 19 +++++++++++++++++++
 Documentation/devicetree/bindings/trivial-devices.txt |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
new file mode 100644
index 000000000000..22ebb2ce52c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -0,0 +1,19 @@
+* NXP PCF85063 Real Time Clock
+
+NXP PCF85063 Real Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf85063".
+- reg: I2C address for chip.
+
+Optional property:
+- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
+  which differ from the default value of 7 pF
+
+Example:
+
+pcf85063: pcf85063@51 {
+	compatible = "nxp,pcf85063";
+	reg = <0x51>;
+	nxp,quartz_load_12.5pF;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 297dc82b67ad..440632682e31 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -170,7 +170,6 @@ nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
-- 
2.12.0
