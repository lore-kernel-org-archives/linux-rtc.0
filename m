Return-Path: <rtc-linux+bncBAABB3G376VQKGQEGBTQJ2Q@googlegroups.com>
MIME-Version: 1.0
Received: from mx.dave-tech.it (mx.dave-tech.it. [2.229.21.40])
        by gmr-mx.google.com with ESMTP id p9si642607wiz.3.2015.06.16.02.35.39
        for <rtc-linux@googlegroups.com>;
        Tue, 16 Jun 2015 02:35:39 -0700 (PDT)
From: rnd4@dave-tech.it
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>
Subject: [rtc-linux] [PATCH] driver: rtc: use rtc_valid_tm() error code when
 reading date/time
Date: Tue, 16 Jun 2015 11:35:19 +0200
Message-Id: <1434447319-23007-1-git-send-email-rnd4@dave-tech.it>
In-Reply-To: <557EF5DD.9070300@dave-tech.it>
References: <557EF5DD.9070300@dave-tech.it>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Andrea Scian <andrea.scian@dave.eu>

There's a wrong commend in some RTC driver that say it's better to ignore
rtc_valid_tm() when reading RTC timestamp. However this is wrong and is
better to return to the userspace the an error if timestamp is not valid.

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 drivers/rtc/rtc-isl12022.c |    7 +------
 drivers/rtc/rtc-pcf2123.c  |    8 +-------
 drivers/rtc/rtc-pcf2127.c  |    8 +-------
 drivers/rtc/rtc-pcf8563.c  |    8 +-------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index a1bbbb8..54e9eca 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -148,12 +148,7 @@ static int isl12022_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* The clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup. */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(&client->dev, "retrieved date and time is invalid.\n");
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int isl12022_set_datetime(struct i2c_client *client, struct rtc_time *tm)
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 796a6c5..e0a2469 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -159,13 +159,7 @@ static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			tm->tm_sec, tm->tm_min, tm->tm_hour,
 			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* the clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
-	 */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(dev, "retrieved date/time is not valid.\n");
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1ee514a..7f803b2 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -88,13 +88,7 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* the clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
-	 */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(&client->dev, "retrieved date/time is not valid.\n");
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 97b354a..3a6d7e0 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -131,13 +131,7 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* the clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
-	 */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(&client->dev, "retrieved date/time is not valid.\n");
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int pcf8563_set_datetime(struct i2c_client *client, struct rtc_time *tm)
-- 
1.7.9.5

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
