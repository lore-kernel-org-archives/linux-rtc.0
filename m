Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112BC433E6
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 23:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4264B225AB
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 23:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbhAJXTW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 10 Jan 2021 18:19:22 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33387 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbhAJXTJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Jan 2021 18:19:09 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 04E7CFF809;
        Sun, 10 Jan 2021 23:18:26 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/17] rtc: rv3029: constify rv3029_rtc_ops
Date:   Mon, 11 Jan 2021 00:17:49 +0100
Message-Id: <20210110231752.1418816-15-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
References: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use RTC_FEATURE_ALARM to signal to the core whether alarms are available
instead of changing the global struct rtc_class_ops, allowing to make it
const.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index dc1bda62095e..c1f4c0bba1e5 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -694,10 +694,13 @@ static void rv3029_hwmon_register(struct device *dev, const char *name)
 
 #endif /* CONFIG_RTC_DRV_RV3029_HWMON */
 
-static struct rtc_class_ops rv3029_rtc_ops = {
+static const struct rtc_class_ops rv3029_rtc_ops = {
 	.read_time	= rv3029_read_time,
 	.set_time	= rv3029_set_time,
 	.ioctl		= rv3029_ioctl,
+	.read_alarm	= rv3029_read_alarm,
+	.set_alarm	= rv3029_set_alarm,
+	.alarm_irq_enable = rv3029_alarm_irq_enable,
 };
 
 static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
@@ -739,12 +742,10 @@ static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
 		if (rc) {
 			dev_warn(dev, "unable to request IRQ, alarms disabled\n");
 			rv3029->irq = 0;
-		} else {
-			rv3029_rtc_ops.read_alarm = rv3029_read_alarm;
-			rv3029_rtc_ops.set_alarm = rv3029_set_alarm;
-			rv3029_rtc_ops.alarm_irq_enable = rv3029_alarm_irq_enable;
 		}
 	}
+	if (!rv3029->irq)
+		clear_bit(RTC_FEATURE_ALARM, rv3029->rtc->features);
 
 	rv3029->rtc->ops = &rv3029_rtc_ops;
 	rv3029->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-- 
2.29.2

