Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752088AbeCWJPi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 23 Mar 2018 05:15:38 -0400
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 12/16] rtc: mediatek: cleanup header files to include
Date: Fri, 23 Mar 2018 17:15:09 +0800
Message-ID: <6e4f709162d57c6e81dfca0996f88358080bf411.1521794177.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Clean up those included header files by removing unreferenced ones,
add missing ones the driver explicitly depends on and finally list
all #includes in alphabetical order.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 015609d..f5dc70d 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -12,18 +12,15 @@
 * GNU General Public License for more details.
 */
 
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
 #include <linux/rtc/mt6397.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
-- 
2.7.4
