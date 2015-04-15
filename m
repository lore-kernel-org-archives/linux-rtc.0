Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [1/5] drivers/rtc/pcf8563: Replace deprecated rtc_time_to_tm() and
 rtc_tm_to_time()
From: Xunlei Pang <xlpang@126.com>
Message-Id: <1429089611-29776-1-git-send-email-xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Xunlei Pang <pang.xunlei@linaro.org>
Date: Wed, 15 Apr 2015 17:20:07 +0800
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

pcf8563_rtc_set_alarm() uses deprecated rtc_tm_to_time()
and rtc_time_to_tm(), which will overflow in year 2106
on 32-bit machines.

This patch solves this by:
 - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-pcf8563.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 96fb32e..4ce66ad 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -368,13 +368,13 @@ static int pcf8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
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
