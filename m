Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38479 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754006AbdIDWxt (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 4 Sep 2017 18:53:49 -0400
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: rtc: Add Realtek RTD1295
Date: Tue,  5 Sep 2017 00:53:22 +0200
Message-Id: <20170904225324.29138-2-afaerber@suse.de>
In-Reply-To: <20170904225324.29138-1-afaerber@suse.de>
References: <20170904225324.29138-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add a binding for the RTC on the Realtek RTD119x/RTD129x SoC families.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2 -> v3 -> v4: Unchanged
 
 .../devicetree/bindings/rtc/realtek,rtd119x.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt

diff --git a/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
new file mode 100644
index 000000000000..bbf1ccb5df31
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
@@ -0,0 +1,16 @@
+Realtek RTD129x Real-Time Clock
+===============================
+
+Required properties:
+- compatible :  Should be "realtek,rtd1295-rtc"
+- reg        :  Specifies the physical base address and size
+- clocks     :  Specifies the clock gate
+
+
+Example:
+
+	rtc@9801b600 {
+		compatible = "realtek,rtd1295-clk";
+		reg = <0x9801b600 0x100>;
+		clocks = <&clkc RTD1295_CLK_EN_MISC_RTC>;
+	};
-- 
2.13.5
