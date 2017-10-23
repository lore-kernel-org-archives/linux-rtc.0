Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:26623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750756AbdJWHQ7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 Oct 2017 03:16:59 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 1/4] dt-bindings: rtc: mediatek: add bindings for MediaTek SoC based RTC
Date: Mon, 23 Oct 2017 15:16:44 +0800
Message-ID: <80005d9cfb50c4decd91e03a57358a76e52f21aa.1508741263.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1508741262.git.sean.wang@mediatek.com>
References: <cover.1508741262.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add device-tree binding for MediaTek SoC based RTC

Cc: devicetree@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/rtc/rtc-mt7622.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt b/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
new file mode 100644
index 0000000..09fe8f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
@@ -0,0 +1,21 @@
+Device-Tree bindings for MediaTek SoC based RTC
+
+Required properties:
+- compatible	    : Should be
+			"mediatek,mt7622-rtc", "mediatek,soc-rtc" : for MT7622 SoC
+- reg 		    : Specifies base physical address and size of the registers;
+- interrupts	    : Should contain the interrupt for RTC alarm;
+- clocks	    : Specifies list of clock specifiers, corresponding to
+		      entries in clock-names property;
+- clock-names	    : Should contain "rtc" entries
+
+Example:
+
+rtc: rtc@10212800 {
+	compatible = "mediatek,mt7622-rtc",
+		     "mediatek,soc-rtc";
+	reg = <0 0x10212800 0 0x200>;
+	interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&topckgen CLK_TOP_RTC>;
+	clock-names = "rtc";
+};
-- 
2.7.4
