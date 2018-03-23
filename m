Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752053AbeCWJPf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 23 Mar 2018 05:15:35 -0400
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 03/16] dt-bindings: mfd: mediatek: add a description for MT6323 RTC
Date: Fri, 23 Mar 2018 17:15:00 +0800
Message-ID: <ba4708a34e43fbc12e78804840be1698f84243cc.1521794177.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add a description for MT6323 RTC and link it to the detailed binding
documentation.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index d1df77f..11a748d 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -22,8 +22,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
 Optional subnodes:
 
 - rtc
-	Required properties:
+	Required properties: Should be one of follows
+		- compatible: "mediatek,mt6323-rtc"
 		- compatible: "mediatek,mt6397-rtc"
+	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
-- 
2.7.4
