Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C5C4320E
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BC460FC3
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhHDKmm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:42:42 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:32915 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbhHDKme (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Aug 2021 06:42:34 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 462AAFF803;
        Wed,  4 Aug 2021 10:41:59 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] rtc: s5m: signal the core when alarm are not available
Date:   Wed,  4 Aug 2021 12:41:30 +0200
Message-Id: <20210804104133.5158-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
References: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Clear the RTC_FEATURE_ALARM bit to signal to the core when alarms are not
available to ensure the alarm callbacks are never called and userspace is
aware alarms are not supported.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-s5m.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 4c1596c55de8..ee195697e6c6 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -794,25 +794,20 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	info->rtc_dev->ops = &s5m_rtc_ops;
 
-	err = devm_rtc_register_device(info->rtc_dev);
-	if (err)
-		return err;
-
 	if (!info->irq) {
-		dev_info(&pdev->dev, "Alarm IRQ not available\n");
-		return 0;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
-					s5m_rtc_alarm_irq, 0, "rtc-alarm0",
-					info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
-			info->irq, ret);
-		return ret;
+		clear_bit(RTC_FEATURE_ALARM, info->rtc_dev->features);
+	} else {
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
+						s5m_rtc_alarm_irq, 0, "rtc-alarm0",
+						info);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
+				info->irq, ret);
+			return ret;
+		}
 	}
 
-	return 0;
+	return devm_rtc_register_device(info->rtc_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.31.1

