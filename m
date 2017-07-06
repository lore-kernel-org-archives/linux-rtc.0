Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49164 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdGFJmQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:16 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 06/11] rtc: rv8803: switch to rtc_register_device
Date: Thu,  6 Jul 2017 11:42:03 +0200
Message-Id: <20170706094208.16240-7-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This removes a possible race condition and allows for further improvement
of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rv8803.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 9ad97ab29866..209edbb03971 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -577,6 +577,11 @@ static int rv8803_probe(struct i2c_client *client,
 	if (flags & RV8803_FLAG_AF)
 		dev_warn(&client->dev, "An alarm maybe have been missed.\n");
 
+	rv8803->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rv8803->rtc)) {
+		return PTR_ERR(rv8803->rtc);
+	}
+
 	if (client->irq > 0) {
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, rv8803_handle_irq,
@@ -592,12 +597,10 @@ static int rv8803_probe(struct i2c_client *client,
 		}
 	}
 
-	rv8803->rtc = devm_rtc_device_register(&client->dev, client->name,
-					       &rv8803_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rv8803->rtc)) {
-		dev_err(&client->dev, "unable to register the class device\n");
-		return PTR_ERR(rv8803->rtc);
-	}
+	rv8803->rtc->ops = &rv8803_rtc_ops;
+	err = rtc_register_device(rv8803->rtc);
+	if (err)
+		return err;
 
 	err = rv8803_write_reg(rv8803->client, RV8803_EXT, RV8803_EXT_WADA);
 	if (err)
-- 
2.11.0
