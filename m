Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:11424 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750756AbdJWHRE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 Oct 2017 03:17:04 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v3 3/4] rtc: mediatek: enhance the description for MediaTek PMIC based RTC
Date: Mon, 23 Oct 2017 15:16:46 +0800
Message-ID: <6f7a30fe5637066fd9fe67287f2d8c9a2b7afca2.1508741263.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1508741262.git.sean.wang@mediatek.com>
References: <cover.1508741262.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Give a better description for original MediaTek RTC driver as PMIC based
RTC in order to distinguish SoC based RTC. Also turning all words with
Mediatek to MediaTek here.

Cc: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/rtc/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index fd9b590..6a315cb 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1716,14 +1716,14 @@ config RTC_DRV_MT7622
 	  will be called rtc-mt7622.
 
 config RTC_DRV_MT6397
-	tristate "Mediatek Real Time Clock driver"
+	tristate "MediaTek PMIC based RTC"
 	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
 	help
-	  This selects the Mediatek(R) RTC driver. RTC is part of Mediatek
+	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
-	  Mediatek(R) RTC driver.
+	  MediaTek(R) RTC driver.
 
-	  If you want to use Mediatek(R) RTC interface, select Y or M here.
+	  If you want to use MediaTek(R) RTC interface, select Y or M here.
 
 config RTC_DRV_XGENE
 	tristate "APM X-Gene RTC"
-- 
2.7.4
