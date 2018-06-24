Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKiG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 24 Jun 2018 06:38:06 -0400
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: test: make array pdev static
Date: Sun, 24 Jun 2018 11:38:03 +0100
Message-Id: <20180624103803.4606-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The array pdev is local to the source and does not need to be in
global scope, so make it static.

Cleans up sparse warning:
symbol 'pdev' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 8469256edc2a..ade6a82709be 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -22,7 +22,7 @@ struct rtc_test_data {
 	bool alarm_en;
 };
 
-struct platform_device *pdev[MAX_RTC_TEST];
+static struct platform_device *pdev[MAX_RTC_TEST];
 
 static int test_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-- 
2.17.0
