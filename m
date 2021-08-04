Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A34C4338F
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AAF60FC3
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhHDKmz (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:42:55 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35531 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbhHDKmh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Aug 2021 06:42:37 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B1223FF807;
        Wed,  4 Aug 2021 10:42:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/4] rtc: s5m: set range
Date:   Wed,  4 Aug 2021 12:41:32 +0200
Message-Id: <20210804104133.5158-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
References: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The S5M8763X type seems to handles dates from year 0000 to 9999, there is
no info on leap year handling after 2099. The other models handles dates
from 2000 to 2099.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-s5m.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 87df797758fc..fb9c6b709e13 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -204,15 +204,9 @@ static int s5m8767_tm_to_data(struct rtc_time *tm, u8 *data)
 	data[RTC_WEEKDAY] = 1 << tm->tm_wday;
 	data[RTC_DATE] = tm->tm_mday;
 	data[RTC_MONTH] = tm->tm_mon + 1;
-	data[RTC_YEAR1] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
+	data[RTC_YEAR1] = tm->tm_year - 100;
 
-	if (tm->tm_year < 100) {
-		pr_err("RTC cannot handle the year %d\n",
-		       1900 + tm->tm_year);
-		return -EINVAL;
-	} else {
-		return 0;
-	}
+	return 0;
 }
 
 /*
@@ -792,6 +786,14 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	info->rtc_dev->ops = &s5m_rtc_ops;
 
+	if (info->device_type == S5M8763X) {
+		info->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_0000;
+		info->rtc_dev->range_max = RTC_TIMESTAMP_END_9999;
+	} else {
+		info->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+		info->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
+	}
+
 	if (!info->irq) {
 		clear_bit(RTC_FEATURE_ALARM, info->rtc_dev->features);
 	} else {
-- 
2.31.1

