Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55809 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbdFHNs0 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:26 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 09/25] rtc: m41t80: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:55 +0300
Message-Id: <20170608134811.60786-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-m41t80.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 8940e9e43ea0..155d23a874ff 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -978,11 +978,7 @@ static int m41t80_probe(struct i2c_client *client,
 		if (m41t80_data->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
-			dev_info(&client->dev,
-				 "Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
-				 tm.tm_year + 1900,
-				 tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
-				 tm.tm_min, tm.tm_sec);
+			dev_info(&client->dev, "Power Down at %pt\n", &tm);
 		}
 		rc = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_HOUR,
 					       rc & ~M41T80_ALHOUR_HT);
-- 
2.11.0
