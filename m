Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55122 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeAWKRa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Jan 2018 05:17:30 -0500
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ds1302: remove redundant initializations of pointer bp
Date: Tue, 23 Jan 2018 10:17:27 +0000
Message-Id: <20180123101727.31028-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Pointe bp is being initialized and this value is never read, it
is being updated to the same value later just before it is going to
be used. Remove the initialization as it is never read and keep
the setting of bp closer to the use of bp.

Cleans up clang warnings:
drivers/rtc/rtc-ds1302.c:115:7: warning: Value stored to 'bp' during
its initialization is never read
drivers/rtc/rtc-ds1302.c:46:7: warning: Value stored to 'bp' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-ds1302.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 0ec4be62322b..43bcb17c922e 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -43,7 +43,7 @@ static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
 	struct spi_device	*spi = dev_get_drvdata(dev);
 	u8		buf[1 + RTC_CLCK_LEN];
-	u8		*bp = buf;
+	u8		*bp;
 	int		status;
 
 	/* Enable writing */
@@ -112,7 +112,7 @@ static int ds1302_probe(struct spi_device *spi)
 	struct rtc_device	*rtc;
 	u8		addr;
 	u8		buf[4];
-	u8		*bp = buf;
+	u8		*bp;
 	int		status;
 
 	/* Sanity check board setup data.  This may be hooked up
-- 
2.15.1
