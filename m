Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53964 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754025AbdIDUqN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Sep 2017 16:46:13 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 4/7] rtc: ds1307: use BIT
Date: Mon,  4 Sep 2017 22:46:05 +0200
Message-Id: <20170904204608.7090-4-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
References: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use the BIT macro were possbiel.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 328183e0e121..5b2fe3579e45 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -634,11 +634,11 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
 #define RX8130_REG_ALARM_HOUR		0x08
 #define RX8130_REG_ALARM_WEEK_OR_DAY	0x09
 #define RX8130_REG_EXTENSION		0x0c
-#define RX8130_REG_EXTENSION_WADA	(1 << 3)
+#define RX8130_REG_EXTENSION_WADA	BIT(3)
 #define RX8130_REG_FLAG			0x0d
-#define RX8130_REG_FLAG_AF		(1 << 3)
+#define RX8130_REG_FLAG_AF		BIT(3)
 #define RX8130_REG_CONTROL0		0x0e
-#define RX8130_REG_CONTROL0_AIE		(1 << 3)
+#define RX8130_REG_CONTROL0_AIE		BIT(3)
 
 static irqreturn_t rx8130_irq(int irq, void *dev_id)
 {
@@ -798,11 +798,11 @@ static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
 #define MCP794XX_REG_ALARM0_CTRL	0x0d
 #define MCP794XX_REG_ALARM1_BASE	0x11
 #define MCP794XX_REG_ALARM1_CTRL	0x14
-#	define MCP794XX_BIT_ALMX_IF	(1 << 3)
-#	define MCP794XX_BIT_ALMX_C0	(1 << 4)
-#	define MCP794XX_BIT_ALMX_C1	(1 << 5)
-#	define MCP794XX_BIT_ALMX_C2	(1 << 6)
-#	define MCP794XX_BIT_ALMX_POL	(1 << 7)
+#	define MCP794XX_BIT_ALMX_IF	BIT(3)
+#	define MCP794XX_BIT_ALMX_C0	BIT(4)
+#	define MCP794XX_BIT_ALMX_C1	BIT(5)
+#	define MCP794XX_BIT_ALMX_C2	BIT(6)
+#	define MCP794XX_BIT_ALMX_POL	BIT(7)
 #	define MCP794XX_MSK_ALMX_MATCH	(MCP794XX_BIT_ALMX_C0 | \
 					 MCP794XX_BIT_ALMX_C1 | \
 					 MCP794XX_BIT_ALMX_C2)
@@ -869,7 +869,7 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->time.tm_isdst = -1;
 
 	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
-		"enabled=%d polarity=%d irq=%d match=%d\n", __func__,
+		"enabled=%d polarity=%d irq=%d match=%lu\n", __func__,
 		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
 		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled,
 		!!(regs[6] & MCP794XX_BIT_ALMX_POL),
-- 
2.14.1
