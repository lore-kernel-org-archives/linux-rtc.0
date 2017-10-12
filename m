Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52673 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdJLWDb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:03:31 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: ds1305: switch to rtc_register_device
Date: Fri, 13 Oct 2017 00:03:22 +0200
Message-Id: <20171012220323.7515-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1305.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 72b22935eb62..c3232c818e65 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -708,10 +708,15 @@ static int ds1305_probe(struct spi_device *spi)
 		dev_dbg(&spi->dev, "AM/PM\n");
 
 	/* register RTC ... from here on, ds1305->ctrl needs locking */
-	ds1305->rtc = devm_rtc_device_register(&spi->dev, "ds1305",
-			&ds1305_ops, THIS_MODULE);
+	ds1305->rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(ds1305->rtc)) {
-		status = PTR_ERR(ds1305->rtc);
+		return PTR_ERR(ds1305->rtc);
+	}
+
+	ds1305->rtc->ops = &ds1305_ops;
+
+	status = rtc_register_device(ds1305->rtc);
+	if (status) {
 		dev_dbg(&spi->dev, "register rtc --> %d\n", status);
 		return status;
 	}
-- 
2.14.2
