Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53554 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdIOCAf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Sep 2017 22:00:35 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/3] powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible
Date: Fri, 15 Sep 2017 04:00:04 +0200
Message-Id: <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The proper compatible for rv3029 is microcrystal,rv3029.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/powerpc/boot/dts/digsy_mtc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index c280e75c86bf..c3922fc03e0b 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -78,7 +78,7 @@
 			};
 
 			rtc@56 {
-				compatible = "mc,rv3029c2";
+				compatible = "microcrystal,rv3029";
 				reg = <0x56>;
 			};
 
-- 
2.14.1
