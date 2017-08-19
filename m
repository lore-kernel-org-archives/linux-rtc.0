Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35147 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbdHSTIQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Aug 2017 15:08:16 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 3/4] rtc: max6900: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:37:57 +0530
Message-Id: <1503169678-18078-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-max6900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index 48b6b41..cbdc86a 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -226,7 +226,7 @@ max6900_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 }
 
-static struct i2c_device_id max6900_id[] = {
+static const struct i2c_device_id max6900_id[] = {
 	{ "max6900", 0 },
 	{ }
 };
-- 
2.7.4
