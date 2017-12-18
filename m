Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from netsrv01.beckhoff.com ([62.159.14.10]:57307 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbdLRLw1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Dec 2017 06:52:27 -0500
From: <linux-kernel-dev@beckhoff.com>
CC: Patrick Bruenn <p.bruenn@beckhoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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
Subject: [PATCH v4 2/4] ARM: dts: imx53: add srtc node
Date: Mon, 18 Dec 2017 12:51:31 +0100
Message-ID: <20171218115133.16371-3-linux-kernel-dev@beckhoff.com>
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Patrick Bruenn <p.bruenn@beckhoff.com>

rtc-mxc_v2 driver will add support for the i.MX53 SRTC

Note: we keep the 'srtc' label to avoid duplicate with imx53-m53.dtsi

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

v4:
- replace "srtc" node name with generic "rtc"

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel@vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Waßmann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 84f17f7abb71..beca1c830623 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -433,6 +433,13 @@
 				clock-names = "ipg", "per";
 			};
 
+			srtc: rtc@53fa4000 {
+				compatible = "fsl,imx53-rtc";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <24>;
+				clocks = <&clks IMX5_CLK_SRTC_GATE>;
+			};
+
 			iomuxc: iomuxc@53fa8000 {
 				compatible = "fsl,imx53-iomuxc";
 				reg = <0x53fa8000 0x4000>;
-- 
2.11.0
