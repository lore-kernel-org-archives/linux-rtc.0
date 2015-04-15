Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [2/5] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
From: Xunlei Pang <xlpang@126.com>
Message-Id: <1429089611-29776-2-git-send-email-xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Xunlei Pang <pang.xunlei@linaro.org>, Herbert Valerio Riedel <hvr@gnu.org>
Date: Wed, 15 Apr 2015 17:20:08 +0800
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

isl1208_i2c_set_alarm() uses deprecated rtc_tm_to_time(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()

Cc: Herbert Valerio Riedel <hvr@gnu.org>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-isl1208.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index c3c549d..06113e8 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -370,19 +370,16 @@ isl1208_i2c_set_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
 	struct rtc_time *alarm_tm = &alarm->time;
 	u8 regs[ISL1208_ALARM_SECTION_LEN] = { 0, };
 	const int offs = ISL1208_REG_SCA;
-	unsigned long rtc_secs, alarm_secs;
+	time64_t rtc_secs, alarm_secs;
 	struct rtc_time rtc_tm;
 	int err, enable;
 
 	err = isl1208_i2c_read_time(client, &rtc_tm);
 	if (err)
 		return err;
-	err = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (err)
-		return err;
-	err = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (err)
-		return err;
+
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	/* If the alarm time is before the current time disable the alarm */
 	if (!alarm->enabled || alarm_secs <= rtc_secs)
