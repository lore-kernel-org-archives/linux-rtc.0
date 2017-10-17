Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:16641 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934839AbdJQJkt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Oct 2017 05:40:49 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: rtc: mediatek: add bindings for MediaTek SoC based RTC
Date: Tue, 17 Oct 2017 17:40:32 +0800
Message-ID: <235e4bdaa605021facf4ab5c4e8a2ecc5293516d.1508231935.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1508231935.git.sean.wang@mediatek.com>
References: <cover.1508231935.git.sean.wang@mediatek.com>
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
 .../devicetree/bindings/rtc/rtc-mediatek.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mediatek.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
new file mode 100644
index 0000000..09fe8f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
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
