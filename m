Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C585EC64E8A
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Dec 2020 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F584221F8
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Dec 2020 03:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLBDL2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 1 Dec 2020 22:11:28 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49416 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbgLBDL1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 1 Dec 2020 22:11:27 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 01F93200C90;
        Wed,  2 Dec 2020 04:10:41 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D350200C83;
        Wed,  2 Dec 2020 04:10:37 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1CD2F402CB;
        Wed,  2 Dec 2020 04:10:33 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     leoyang.li@nxp.com, alexandre.belloni@bootlin.com,
        anson.huang@nxp.com, aisheng.dong@nxp.com
Cc:     linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        linux-rtc@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v2 2/2] rtc: pcf2127: clear these flags TSF1, TSF2 before enabling interrupt generation
Date:   Wed,  2 Dec 2020 11:18:40 +0800
Message-Id: <20201202031840.15582-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202031840.15582-1-biwen.li@oss.nxp.com>
References: <20201202031840.15582-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Clear these flags TSF1, TSF2 before enabling interrupt generation

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- clear flag TSF2

 drivers/rtc/rtc-pcf2127.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index a5418b657c50..7e3fc70ac5f9 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -659,7 +659,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 	/*
 	 * Enable timestamp function and store timestamp of first trigger
-	 * event until TSF1 and TFS2 interrupt flags are cleared.
+	 * event until TSF1 and TSF2 interrupt flags are cleared.
 	 */
 	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_TS_CTRL,
 				 PCF2127_BIT_TS_CTRL_TSOFF |
@@ -671,6 +671,31 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	/*
+	 * Clear TSF1 field of ctrl1 register and TSF2
+	 * field of ctrl2 register to clear interrupt
+	 * before enabling interrupt generation when
+	 * timestamp flag set. Unless the flag TSF1 won't
+	 * be cleared and get the interrupt storm.
+	 */
+	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+				 PCF2127_BIT_CTRL1_TSF1,
+				 0);
+	if (ret) {
+		dev_err(dev, "%s:  control and status register 1 (ctrl1) failed, ret = 0x%x\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
+				 PCF2127_BIT_CTRL2_TSF2,
+				 0);
+	if (ret) {
+		dev_err(dev, "%s:  control and status register 2 (ctrl2) failed, ret = 0x%x\n",
+			__func__, ret);
+		return ret;
+	}
+
 	/*
 	 * Enable interrupt generation when TSF1 or TSF2 timestamp flags
 	 * are set. Interrupt signal is an open-drain output and can be
-- 
2.17.1

