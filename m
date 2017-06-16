Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdFPT2f (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:35 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] rtc: s3c: Drop unneeded cast to void pointer
Date: Fri, 16 Jun 2017 21:28:04 +0200
Message-Id: <20170616192807.10347-3-krzk@kernel.org>
In-Reply-To: <20170616192807.10347-1-krzk@kernel.org>
References: <20170616192807.10347-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There is no need for casting to void pointer for of_device_id data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s3c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 2b503dab7957..bfc8660ff1e7 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -801,19 +801,19 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
 static const struct of_device_id s3c_rtc_dt_match[] = {
 	{
 		.compatible = "samsung,s3c2410-rtc",
-		.data = (void *)&s3c2410_rtc_data,
+		.data = &s3c2410_rtc_data,
 	}, {
 		.compatible = "samsung,s3c2416-rtc",
-		.data = (void *)&s3c2416_rtc_data,
+		.data = &s3c2416_rtc_data,
 	}, {
 		.compatible = "samsung,s3c2443-rtc",
-		.data = (void *)&s3c2443_rtc_data,
+		.data = &s3c2443_rtc_data,
 	}, {
 		.compatible = "samsung,s3c6410-rtc",
-		.data = (void *)&s3c6410_rtc_data,
+		.data = &s3c6410_rtc_data,
 	}, {
 		.compatible = "samsung,exynos3250-rtc",
-		.data = (void *)&s3c6410_rtc_data,
+		.data = &s3c6410_rtc_data,
 	},
 	{ /* sentinel */ },
 };
-- 
2.9.3
