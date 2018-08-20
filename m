Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:47762 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTVYG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 20 Aug 2018 17:24:06 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: od@zcrc.me, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Date: Mon, 20 Aug 2018 20:07:16 +0200
Message-Id: <20180820180716.1853-1-paul@crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a2ba5db36145..98c7f19256b1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1608,7 +1608,7 @@ config RTC_DRV_MPC5121
 
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
-	depends on MACH_INGENIC || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
-- 
2.11.0
