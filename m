Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37481 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSTIS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Aug 2017 15:08:18 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 4/4] rtc: rv3029c2: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:37:58 +0530
Message-Id: <1503169678-18078-5-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 85fa1da..aa09771 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -868,7 +868,7 @@ static int rv3029_i2c_probe(struct i2c_client *client,
 	return rv3029_probe(&client->dev, regmap, client->irq, client->name);
 }
 
-static struct i2c_device_id rv3029_id[] = {
+static const struct i2c_device_id rv3029_id[] = {
 	{ "rv3029", 0 },
 	{ "rv3029c2", 0 },
 	{ }
-- 
2.7.4
