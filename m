Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37631 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdHSTIM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Aug 2017 15:08:12 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 1/4] rtc: ds1672: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:37:55 +0530
Message-Id: <1503169678-18078-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-ds1672.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 7bf46bf..9caaccc 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -190,7 +190,7 @@ static int ds1672_probe(struct i2c_client *client,
 	return 0;
 }
 
-static struct i2c_device_id ds1672_id[] = {
+static const struct i2c_device_id ds1672_id[] = {
 	{ "ds1672", 0 },
 	{ }
 };
-- 
2.7.4
