Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:37182 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeHIAe5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 8 Aug 2018 20:34:57 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Denis Osterland <Denis.Osterland@diehl.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] rtc: isl1208: fix error handling in isl1208_probe()
Date: Thu,  9 Aug 2018 01:13:07 +0300
Message-Id: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

After moving rtc_register_device() sysfs group is left unremoved
on the error path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 236b7187034e ("rtc: isl1208: switch to rtc_register_device")
---
 drivers/rtc/rtc-isl1208.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 1a2c38cc0178..4b5df9bfb8d4 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -674,7 +674,12 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	return rtc_register_device(rtc);
+	rc = rtc_register_device(rtc);
+	if (rc) {
+		sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
+		return rc;
+	}
+	return 0;
 }
 
 static int
-- 
2.7.4
