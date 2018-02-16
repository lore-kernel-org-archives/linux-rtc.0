Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35732 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBPXn1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Feb 2018 18:43:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH RESEND] powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible
Date: Sat, 17 Feb 2018 00:43:23 +0100
Message-Id: <20180216234323.27601-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The proper compatible for rv3029 is microcrystal,rv3029.

Acked-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Hi,

I'm resending that one because I prefer not taking DT patches through the RTC
tree.

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
2.16.1
