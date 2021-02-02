Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF2C433E0
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D731364E4C
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhBBLZM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:25:12 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40417 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBBLXX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Feb 2021 06:23:23 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EFBDE40009;
        Tue,  2 Feb 2021 11:22:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] rtc: pcf85063: quiet maybe-unused variable warnings
Date:   Tue,  2 Feb 2021 12:22:08 +0100
Message-Id: <20210202112219.3610853-12-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
References: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

pcf85063a_config and rv8263_config are only referenced by
pcf85063_of_match, move them in the #ifdef CONFIG_OF section.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index f7e7c9eb0781..aef6c1ee8bb0 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -501,15 +501,6 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 }
 #endif
 
-static const struct pcf85063_config pcf85063a_config = {
-	.regmap = {
-		.reg_bits = 8,
-		.val_bits = 8,
-		.max_register = 0x11,
-	},
-	.has_alarms = 1,
-};
-
 static const struct pcf85063_config pcf85063tp_config = {
 	.regmap = {
 		.reg_bits = 8,
@@ -518,16 +509,6 @@ static const struct pcf85063_config pcf85063tp_config = {
 	},
 };
 
-static const struct pcf85063_config rv8263_config = {
-	.regmap = {
-		.reg_bits = 8,
-		.val_bits = 8,
-		.max_register = 0x11,
-	},
-	.has_alarms = 1,
-	.force_cap_7000 = 1,
-};
-
 static int pcf85063_probe(struct i2c_client *client)
 {
 	struct pcf85063 *pcf85063;
@@ -611,6 +592,25 @@ static int pcf85063_probe(struct i2c_client *client)
 }
 
 #ifdef CONFIG_OF
+static const struct pcf85063_config pcf85063a_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x11,
+	},
+	.has_alarms = 1,
+};
+
+static const struct pcf85063_config rv8263_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x11,
+	},
+	.has_alarms = 1,
+	.force_cap_7000 = 1,
+};
+
 static const struct of_device_id pcf85063_of_match[] = {
 	{ .compatible = "nxp,pcf85063", .data = &pcf85063tp_config },
 	{ .compatible = "nxp,pcf85063tp", .data = &pcf85063tp_config },
-- 
2.29.2

