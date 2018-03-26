Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:33455 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbeCZKF4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 26 Mar 2018 06:05:56 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <linux-rtc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] rtc: mt7622: fix module autoloading for OF platform drivers
Date: Mon, 26 Mar 2018 18:05:52 +0800
Message-ID: <4231c0b6038764f68324297a40b18b15ecda5a92.1522055289.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
for the OF platform driver. Otherwise, module autoloading cannot work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt7622.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index d79b9ae..147252f 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -307,6 +307,7 @@ static const struct of_device_id mtk_rtc_match[] = {
 	{ .compatible = "mediatek,soc-rtc" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mtk_rtc_match);
 
 static int mtk_rtc_probe(struct platform_device *pdev)
 {
-- 
2.7.4
