Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52699 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755462AbdJLWEu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:04:50 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: abx80x: switch to rtc_register_device
Date: Fri, 13 Oct 2017 00:04:46 +0200
Message-Id: <20171012220447.7940-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fea9a60b06cf..442e62a3c9a9 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -614,12 +614,16 @@ static int abx80x_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rtc = devm_rtc_device_register(&client->dev, "abx8xx",
-				       &abx80x_rtc_ops, THIS_MODULE);
-
+	rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &abx80x_rtc_ops;
+
+	err = rtc_register_device(rtc);
+	if (err)
+		return err;
+
 	i2c_set_clientdata(client, rtc);
 
 	if (client->irq > 0) {
-- 
2.14.2
