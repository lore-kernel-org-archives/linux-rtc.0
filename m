Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbdFPT2W (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:22 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/6] rtc: s3c: Do not remove const from rodata memory
Date: Fri, 16 Jun 2017 21:28:05 +0200
Message-Id: <20170616192807.10347-4-krzk@kernel.org>
In-Reply-To: <20170616192807.10347-1-krzk@kernel.org>
References: <20170616192807.10347-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

All instances of struct s3c_rtc_data are in fact static const thus
put in rodata so we should not drop the const while getting the pointer
to them.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s3c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index bfc8660ff1e7..c666b95fb8d7 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -41,7 +41,7 @@ struct s3c_rtc {
 	struct clk *rtc_src_clk;
 	bool clk_disabled;
 
-	struct s3c_rtc_data *data;
+	const struct s3c_rtc_data *data;
 
 	int irq_alarm;
 	int irq_tick;
@@ -437,12 +437,12 @@ static int s3c_rtc_remove(struct platform_device *pdev)
 
 static const struct of_device_id s3c_rtc_dt_match[];
 
-static struct s3c_rtc_data *s3c_rtc_get_data(struct platform_device *pdev)
+static const struct s3c_rtc_data *s3c_rtc_get_data(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 
 	match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
-	return (struct s3c_rtc_data *)match->data;
+	return match->data;
 }
 
 static int s3c_rtc_probe(struct platform_device *pdev)
-- 
2.9.3
