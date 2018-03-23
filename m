Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:8094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752069AbeCWJPh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 23 Mar 2018 05:15:37 -0400
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 10/16] rtc: mediatek: add devm_of_platform_populate
Date: Fri, 23 Mar 2018 17:15:07 +0800
Message-ID: <2bf23f9f05b747674419be6008822bef43085626.1521794177.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add devm_of_platform_populate to populate all child nodes according to
the dt-binding.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index bfc5d6f..d133d1f 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/jiffies.h>
@@ -349,7 +350,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.7.4
