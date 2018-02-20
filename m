Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57443 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbeBTVoL (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:11 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/21] rtc: m41t80: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:44 +0200
Message-Id: <20180220214400.66749-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-m41t80.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c90fba3ed861..0ffc03826efb 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -950,11 +950,7 @@ static int m41t80_probe(struct i2c_client *client,
 		if (m41t80_data->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
-			dev_info(&client->dev,
-				 "Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
-				 tm.tm_year + 1900,
-				 tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
-				 tm.tm_min, tm.tm_sec);
+			dev_info(&client->dev, "Power Down at %ptR\n", &tm);
 		}
 		rc = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_HOUR,
 					       rc & ~M41T80_ALHOUR_HT);
-- 
2.15.1
