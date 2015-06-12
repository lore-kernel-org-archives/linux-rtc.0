Return-Path: <xlpang@126.com>
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [PATCH v3 1/4] drivers/rtc/pcf8563: Replace deprecated rtc_time_to_tm() and rtc_tm_to_time()
Date: Fri, 12 Jun 2015 10:04:09 +0800
Message-Id: <1434074652-16054-1-git-send-email-xlpang@126.com>
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

pcf8563_rtc_set_alarm() uses deprecated rtc_tm_to_time()
and rtc_time_to_tm(), which will overflow in year 2106
on 32-bit machines.

This patch solves this by:
 - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
v2->v3:
no changes.

 drivers/rtc/rtc-pcf8563.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0ba7e59..5f87f84 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -363,13 +363,13 @@ static int pcf8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[4];
 	int err;
-	unsigned long alarm_time;
 
 	/* The alarm has no seconds, round up to nearest minute */
 	if (tm->time.tm_sec) {
-		rtc_tm_to_time(&tm->time, &alarm_time);
-		alarm_time += 60-tm->time.tm_sec;
-		rtc_time_to_tm(alarm_time, &tm->time);
+		time64_t alarm_time = rtc_tm_to_time64(&tm->time);
+
+		alarm_time += 60 - tm->time.tm_sec;
+		rtc_time64_to_tm(alarm_time, &tm->time);
 	}
 
 	dev_dbg(dev, "%s, min=%d hour=%d wday=%d mday=%d "
-- 
1.9.1
