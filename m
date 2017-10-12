Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52702 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbdJLWEu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:04:50 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] rtc: abx80x: solve race condition
Date: Fri, 13 Oct 2017 00:04:47 +0200
Message-Id: <20171012220447.7940-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220447.7940-1-alexandre.belloni@free-electrons.com>
References: <20171012220447.7940-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There is a race condition that can happen if abx80x_probe() fails after the
rtc registration succeeded. Solve that by moving the registration at the
end of the probe function.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 442e62a3c9a9..b033bc556f5d 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -620,10 +620,6 @@ static int abx80x_probe(struct i2c_client *client,
 
 	rtc->ops = &abx80x_rtc_ops;
 
-	err = rtc_register_device(rtc);
-	if (err)
-		return err;
-
 	i2c_set_clientdata(client, rtc);
 
 	if (client->irq > 0) {
@@ -650,10 +646,14 @@ static int abx80x_probe(struct i2c_client *client,
 	err = devm_add_action_or_reset(&client->dev,
 				       rtc_calib_remove_sysfs_group,
 				       &client->dev);
-	if (err)
+	if (err) {
 		dev_err(&client->dev,
 			"Failed to add sysfs cleanup action: %d\n",
 			err);
+		return err;
+	}
+
+	err = rtc_register_device(rtc);
 
 	return err;
 }
-- 
2.14.2
