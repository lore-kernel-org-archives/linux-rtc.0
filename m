Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbdH1LKy (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:54 -0400
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: realtek: Add RTD1295 RTC node
Date: Mon, 28 Aug 2017 13:10:41 +0200
Message-Id: <20170828111041.17946-4-afaerber@suse.de>
In-Reply-To: <20170828111041.17946-1-afaerber@suse.de>
References: <20170828111041.17946-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add RTC node to the Realtek RTD1295 Device Tree.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2 -> v3:
 * Rebased to no longer depend on reset controller series
 
 v1 -> v2: Unchanged
 
 Depends on the pending clock bindings.
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index ab72255f843f..fbbd6456079e 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -164,6 +164,12 @@
 			status = "disabled";
 		};
 
+		rtc@9801b600 {
+			compatible = "realtek,rtd1295-rtc";
+			reg = <0x9801b600 0x100>;
+			clocks = <&clkc RTD1295_CLK_EN_MISC_RTC>;
+		};
+
 		gic: interrupt-controller@ff011000 {
 			compatible = "arm,gic-400";
 			reg = <0xff011000 0x1000>,
-- 
2.12.3
