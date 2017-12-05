Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from netsrv01.beckhoff.com ([62.159.14.10]:62106 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdLEOHY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Dec 2017 09:07:24 -0500
From: <linux-kernel-dev@beckhoff.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Patrick Bruenn <p.bruenn@beckhoff.com>,
        Patrick Bruenn <p.bruenn@beckhoff.comPaste>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
Date: Tue, 5 Dec 2017 15:06:42 +0100
Message-ID: <20171205140646.30367-2-linux-kernel-dev@beckhoff.com>
In-Reply-To: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Document the binding for i.MX53 SRTC implemented by rtc-mxc_v2

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com><Paste>

---

To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel@vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Waßmann <LW@KARO-electronics.de>
---
 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
new file mode 100644
index 000000000000..796e7f4995db
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
@@ -0,0 +1,17 @@
+* i.MX53 Real Time Clock controller
+
+Required properties:
+- compatible: should be: "fsl,imx53-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks: should contain the phandle for the rtc clock
+- interrupts: rtc alarm interrupt
+
+Example:
+
+srtc@53fa4000 {
+	compatible = "fsl,imx53-rtc";
+	reg = <0x53fa4000 0x4000>;
+	interrupts = <24>;
+	clocks = <&clks IMX5_CLK_SRTC_GATE>;
+};
-- 
2.11.0
