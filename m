Return-Path: <rtc-linux+bncBCN6JTVP2IEBBSMAUKVQKGQE74GIOGI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-111.126.com ([123.125.50.111])
        by gmr-mx.google.com with ESMTP id wh3si165235pbc.0.2015.05.29.08.05.43
        for <rtc-linux@googlegroups.com>;
        Fri, 29 May 2015 08:05:44 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Herbert Valerio Riedel <hvr@gnu.org>
Subject: [rtc-linux] [PATCH RESEND 2/3] drivers/rtc/isl1208: Replace
 deprecated rtc_tm_to_time()
Date: Fri, 29 May 2015 23:04:36 +0800
Message-Id: <1432911877-607-2-git-send-email-xlpang@126.com>
In-Reply-To: <1432911877-607-1-git-send-email-xlpang@126.com>
References: <1432911877-607-1-git-send-email-xlpang@126.com>
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
-- 
1.9.1


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
