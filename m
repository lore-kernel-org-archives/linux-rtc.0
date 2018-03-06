Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from condef-09.nifty.com ([202.248.20.74]:36978 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeCFLV7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 6 Mar 2018 06:21:59 -0500
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-09.nifty.com with ESMTP id w26B8n4e001923
        for <linux-rtc@vger.kernel.org>; Tue, 6 Mar 2018 20:08:51 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: at91sam: add 'depends on HAS_IOMEM' to fix unmet dependency
Date: Tue,  6 Mar 2018 20:08:11 +0900
Message-Id: <1520334491-7078-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This config select's MFD_SYSCON, but does not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet
direct dependencies" in Kconfig phase.

Detected by "make ARCH=score allyesconfig".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
https://lkml.org/lkml/2018/2/27/284

We agreed to add 'depends on HAS_IOMEM' to drivers causing
unmet dependency.


 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5..d826e5d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1413,6 +1413,7 @@ config RTC_DRV_AT91RM9200
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9 RTT as RTC"
 	depends on ARCH_AT91 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
-- 
2.7.4
