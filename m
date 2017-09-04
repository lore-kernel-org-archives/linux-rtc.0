Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53958 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754020AbdIDUqN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Sep 2017 16:46:13 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/7] rtc: ds1307: use sizeof
Date: Mon,  4 Sep 2017 22:46:03 +0200
Message-Id: <20170904204608.7090-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
References: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use sizeof where possible to ensure we don't read/write more than the
allocated buffer.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8de1d7116461..93fb08452159 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -650,7 +650,8 @@ static irqreturn_t rx8130_irq(int irq, void *dev_id)
 	mutex_lock(lock);
 
 	/* Read control registers. */
-	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+			       sizeof(ctl));
 	if (ret < 0)
 		goto out;
 	if (!(ctl[1] & RX8130_REG_FLAG_AF))
@@ -658,7 +659,8 @@ static irqreturn_t rx8130_irq(int irq, void *dev_id)
 	ctl[1] &= ~RX8130_REG_FLAG_AF;
 	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
 
-	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+				sizeof(ctl));
 	if (ret < 0)
 		goto out;
 
@@ -680,12 +682,14 @@ static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		return -EINVAL;
 
 	/* Read alarm registers. */
-	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_ALARM_MIN, ald, 3);
+	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_ALARM_MIN, ald,
+			       sizeof(ald));
 	if (ret < 0)
 		return ret;
 
 	/* Read control registers. */
-	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+			       sizeof(ctl));
 	if (ret < 0)
 		return ret;
 
@@ -726,7 +730,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 		t->enabled, t->pending);
 
 	/* Read control registers. */
-	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+			       sizeof(ctl));
 	if (ret < 0)
 		return ret;
 
@@ -734,7 +739,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	ctl[1] |= RX8130_REG_FLAG_AF;
 	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
 
-	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+				sizeof(ctl));
 	if (ret < 0)
 		return ret;
 
@@ -743,7 +749,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	ald[1] = bin2bcd(t->time.tm_hour);
 	ald[2] = bin2bcd(t->time.tm_mday);
 
-	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_ALARM_MIN, ald, 3);
+	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_ALARM_MIN, ald,
+				sizeof(ald));
 	if (ret < 0)
 		return ret;
 
@@ -752,7 +759,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	ctl[2] |= RX8130_REG_CONTROL0_AIE;
 
-	return regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl, 3);
+	return regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
+				 sizeof(ctl));
 }
 
 static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
-- 
2.14.1
