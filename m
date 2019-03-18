Return-Path: <SRS0=4iP+=RV=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DDC43381
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Mar 2019 12:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CB520811
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Mar 2019 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCRMop (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:44:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47543 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRMop (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Mar 2019 08:44:45 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A859EFF808;
        Mon, 18 Mar 2019 12:44:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: omap: let the core handle range
Date:   Mon, 18 Mar 2019 13:44:37 +0100
Message-Id: <20190318124438.26327-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Let the core handle the RTC range instead of open coding it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-omap.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index bbff0e2deb84..ea0eb48f3bb9 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -271,7 +271,7 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 }
 
 /* this hardware doesn't support "don't care" alarm fields */
-static int tm2bcd(struct rtc_time *tm)
+static void tm2bcd(struct rtc_time *tm)
 {
 	tm->tm_sec = bin2bcd(tm->tm_sec);
 	tm->tm_min = bin2bcd(tm->tm_min);
@@ -279,13 +279,7 @@ static int tm2bcd(struct rtc_time *tm)
 	tm->tm_mday = bin2bcd(tm->tm_mday);
 
 	tm->tm_mon = bin2bcd(tm->tm_mon + 1);
-
-	/* epoch == 1900 */
-	if (tm->tm_year < 100 || tm->tm_year > 199)
-		return -EINVAL;
 	tm->tm_year = bin2bcd(tm->tm_year - 100);
-
-	return 0;
 }
 
 static void bcd2tm(struct rtc_time *tm)
@@ -328,8 +322,7 @@ static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
-	if (tm2bcd(tm) < 0)
-		return -EINVAL;
+	tm2bcd(tm);
 
 	local_irq_disable();
 	rtc_wait_not_busy(rtc);
@@ -378,8 +371,7 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 	u8 reg, irqwake_reg = 0;
 
-	if (tm2bcd(&alm->time) < 0)
-		return -EINVAL;
+	tm2bcd(&alm->time);
 
 	local_irq_disable();
 	rtc_wait_not_busy(rtc);
@@ -444,11 +436,7 @@ static void omap_rtc_power_off(void)
 	rtc_tm_to_time(&tm, &now);
 	rtc_time_to_tm(now + 1, &tm);
 
-	if (tm2bcd(&tm) < 0) {
-		dev_err(&rtc->rtc->dev, "power off failed\n");
-		rtc->type->lock(rtc);
-		return;
-	}
+	tm2bcd(&tm);
 
 	rtc_wait_not_busy(rtc);
 
@@ -845,6 +833,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->rtc->ops = &omap_rtc_ops;
+	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	omap_rtc_nvmem_config.priv = rtc;
 
 	/* handle periodic and alarm irqs */
-- 
2.20.1

