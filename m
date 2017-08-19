Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33444 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdHSTIO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Aug 2017 15:08:14 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 2/4] rtc: em3027: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:37:56 +0530
Message-Id: <1503169678-18078-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-em3027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-em3027.c b/drivers/rtc/rtc-em3027.c
index 4f4930a..b0ef8cf 100644
--- a/drivers/rtc/rtc-em3027.c
+++ b/drivers/rtc/rtc-em3027.c
@@ -132,7 +132,7 @@ static int em3027_probe(struct i2c_client *client,
 	return 0;
 }
 
-static struct i2c_device_id em3027_id[] = {
+static const struct i2c_device_id em3027_id[] = {
 	{ "em3027", 0 },
 	{ }
 };
-- 
2.7.4
