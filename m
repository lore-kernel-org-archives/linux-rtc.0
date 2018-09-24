Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:43351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733102AbeIXVIA (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Sep 2018 17:08:00 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: rs5c348: remove forward declaration
Date: Mon, 24 Sep 2018 17:05:08 +0200
Message-Id: <20180924150509.2082-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
References: <20180924150509.2082-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The name passed to devm_rtc_device_register is now unused. anyway, switch
to devm_rtc_allocate_device to avoid forward declaring rs5c348_driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c348.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index aeb14fc0175d..7b9c7dc5b309 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -143,8 +143,6 @@ static const struct rtc_class_ops rs5c348_rtc_ops = {
 	.set_time	= rs5c348_rtc_set_time,
 };
 
-static struct spi_driver rs5c348_driver;
-
 static int rs5c348_probe(struct spi_device *spi)
 {
 	int ret;
@@ -195,15 +193,15 @@ static int rs5c348_probe(struct spi_device *spi)
 	if (ret & RS5C348_BIT_24H)
 		pdata->rtc_24h = 1;
 
-	rtc = devm_rtc_device_register(&spi->dev, rs5c348_driver.driver.name,
-				  &rs5c348_rtc_ops, THIS_MODULE);
-
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
 	pdata->rtc = rtc;
 
-	return 0;
+	rtc->ops = &rs5c348_rtc_ops;
+
+	return rtc_register_device(rtc);
 }
 
 static struct spi_driver rs5c348_driver = {
-- 
2.19.0
