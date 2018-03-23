Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:46348 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751668AbeCWJP3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 23 Mar 2018 05:15:29 -0400
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 06/16] rtc: mediatek: remove unnecessary parentheses
Date: Fri, 23 Mar 2018 17:15:03 +0800
Message-ID: <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Remove unnecessary parentheses due to explicit C operator precedence.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 0df7ccd..4411c08 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -106,7 +106,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
 	int ret;
 
 	ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_IRQ_STA, &irqsta);
-	if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
+	if (ret >= 0 && irqsta & RTC_IRQ_STA_AL) {
 		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
 		irqen = irqsta & ~RTC_IRQ_EN_AL;
 		mutex_lock(&rtc->lock);
-- 
2.7.4
