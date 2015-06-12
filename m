Return-Path: <xlpang@126.com>
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Herbert Valerio Riedel <hvr@gnu.org>
Subject: [PATCH v3 3/4] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
Date: Fri, 12 Jun 2015 10:04:11 +0800
Message-Id: <1434074652-16054-3-git-send-email-xlpang@126.com>
In-Reply-To: <1434074652-16054-1-git-send-email-xlpang@126.com>
References: <1434074652-16054-1-git-send-email-xlpang@126.com>
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

isl1208_i2c_set_alarm() uses deprecated rtc_tm_to_time(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
 - Replacing rtc_tm_to_time() with rtc_tm_sub()

Cc: Herbert Valerio Riedel <hvr@gnu.org>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
v2->v3:
Rename rtc_tm_subtract() to rtc_tm_sub().

 drivers/rtc/rtc-isl1208.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index c3c549d..aa3b8f1 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -370,22 +370,15 @@ isl1208_i2c_set_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
 	struct rtc_time *alarm_tm = &alarm->time;
 	u8 regs[ISL1208_ALARM_SECTION_LEN] = { 0, };
 	const int offs = ISL1208_REG_SCA;
-	unsigned long rtc_secs, alarm_secs;
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
 
 	/* If the alarm time is before the current time disable the alarm */
-	if (!alarm->enabled || alarm_secs <= rtc_secs)
+	if (!alarm->enabled || rtc_tm_sub(alarm_tm, &rtc_tm) <= 0)
 		enable = 0x00;
 	else
 		enable = 0x80;
-- 
1.9.1
