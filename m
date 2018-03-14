Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:45669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCNPjZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Mar 2018 11:39:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 08/47] rtc: remove tile driver
Date: Wed, 14 Mar 2018 16:35:21 +0100
Message-Id: <20180314153603.3127932-9-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The tile architecture is getting removed, so this driver is
no longer needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig    |   7 ---
 drivers/rtc/Makefile   |   1 -
 drivers/rtc/rtc-tile.c | 143 -------------------------------------------------
 3 files changed, 151 deletions(-)
 delete mode 100644 drivers/rtc/rtc-tile.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5457d15bbcc0..0e1413a5ba3a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1667,13 +1667,6 @@ config RTC_DRV_TEGRA
 	  This drive can also be built as a module. If so, the module
 	  will be called rtc-tegra.
 
-config RTC_DRV_TILE
-	tristate "Tilera hypervisor RTC support"
-	depends on TILE
-	help
-	  Enable support for the Linux driver side of the Tilera
-	  hypervisor's real-time clock interface.
-
 config RTC_DRV_PUV3
 	tristate "PKUnity v3 RTC support"
 	depends on ARCH_PUV3
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index f481661a6eae..f7a4b09557a0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -163,7 +163,6 @@ obj-$(CONFIG_RTC_DRV_SUN6I)	+= rtc-sun6i.o
 obj-$(CONFIG_RTC_DRV_SUNXI)	+= rtc-sunxi.o
 obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
-obj-$(CONFIG_RTC_DRV_TILE)	+= rtc-tile.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TPS80031)	+= rtc-tps80031.o
diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
deleted file mode 100644
index ef1cdabf05b4..000000000000
-- 
2.9.0
