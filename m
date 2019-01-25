Return-Path: <SRS0=r6Xw=QB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F15C282C0
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E3B218E2
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYOgN (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:36:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56831 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAYOgN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Jan 2019 09:36:13 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aR-0001kb-II; Fri, 25 Jan 2019 15:36:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aQ-0007B3-2O; Fri, 25 Jan 2019 15:36:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-rtc@vger.kernel.org
Subject: [PATCH 1/5] rtc: ds1307: Move register definitions to start of file
Date:   Fri, 25 Jan 2019 15:35:54 +0100
Message-Id: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This allows to use the register offsets in all functions
which is needed in one of the next patches.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-ds1307.c | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 74b31dce484f..f7a47ee5cdf6 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -114,6 +114,32 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define RX8130_REG_ALARM_MIN		0x07
+#define RX8130_REG_ALARM_HOUR		0x08
+#define RX8130_REG_ALARM_WEEK_OR_DAY	0x09
+#define RX8130_REG_EXTENSION		0x0c
+#define RX8130_REG_EXTENSION_WADA	BIT(3)
+#define RX8130_REG_FLAG			0x0d
+#define RX8130_REG_FLAG_AF		BIT(3)
+#define RX8130_REG_CONTROL0		0x0e
+#define RX8130_REG_CONTROL0_AIE		BIT(3)
+
+#define MCP794XX_REG_CONTROL		0x07
+#	define MCP794XX_BIT_ALM0_EN	0x10
+#	define MCP794XX_BIT_ALM1_EN	0x20
+#define MCP794XX_REG_ALARM0_BASE	0x0a
+#define MCP794XX_REG_ALARM0_CTRL	0x0d
+#define MCP794XX_REG_ALARM1_BASE	0x11
+#define MCP794XX_REG_ALARM1_CTRL	0x14
+#	define MCP794XX_BIT_ALMX_IF	BIT(3)
+#	define MCP794XX_BIT_ALMX_C0	BIT(4)
+#	define MCP794XX_BIT_ALMX_C1	BIT(5)
+#	define MCP794XX_BIT_ALMX_C2	BIT(6)
+#	define MCP794XX_BIT_ALMX_POL	BIT(7)
+#	define MCP794XX_MSK_ALMX_MATCH	(MCP794XX_BIT_ALMX_C0 | \
+					 MCP794XX_BIT_ALMX_C1 | \
+					 MCP794XX_BIT_ALMX_C2)
+
 #define M41TXX_REG_CONTROL	0x07
 #	define M41TXX_BIT_OUT		BIT(7)
 #	define M41TXX_BIT_FT		BIT(6)
@@ -680,16 +706,6 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
  * Alarm support for rx8130 devices.
  */
 
-#define RX8130_REG_ALARM_MIN		0x07
-#define RX8130_REG_ALARM_HOUR		0x08
-#define RX8130_REG_ALARM_WEEK_OR_DAY	0x09
-#define RX8130_REG_EXTENSION		0x0c
-#define RX8130_REG_EXTENSION_WADA	BIT(3)
-#define RX8130_REG_FLAG			0x0d
-#define RX8130_REG_FLAG_AF		BIT(3)
-#define RX8130_REG_CONTROL0		0x0e
-#define RX8130_REG_CONTROL0_AIE		BIT(3)
-
 static irqreturn_t rx8130_irq(int irq, void *dev_id)
 {
 	struct ds1307           *ds1307 = dev_id;
@@ -839,22 +855,6 @@ static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
  * Alarm support for mcp794xx devices.
  */
 
-#define MCP794XX_REG_CONTROL		0x07
-#	define MCP794XX_BIT_ALM0_EN	0x10
-#	define MCP794XX_BIT_ALM1_EN	0x20
-#define MCP794XX_REG_ALARM0_BASE	0x0a
-#define MCP794XX_REG_ALARM0_CTRL	0x0d
-#define MCP794XX_REG_ALARM1_BASE	0x11
-#define MCP794XX_REG_ALARM1_CTRL	0x14
-#	define MCP794XX_BIT_ALMX_IF	BIT(3)
-#	define MCP794XX_BIT_ALMX_C0	BIT(4)
-#	define MCP794XX_BIT_ALMX_C1	BIT(5)
-#	define MCP794XX_BIT_ALMX_C2	BIT(6)
-#	define MCP794XX_BIT_ALMX_POL	BIT(7)
-#	define MCP794XX_MSK_ALMX_MATCH	(MCP794XX_BIT_ALMX_C0 | \
-					 MCP794XX_BIT_ALMX_C1 | \
-					 MCP794XX_BIT_ALMX_C2)
-
 static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
 {
 	struct ds1307           *ds1307 = dev_id;
-- 
2.20.1

