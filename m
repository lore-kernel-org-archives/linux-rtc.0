Return-Path: <rtc-linux+bncBCN6JTVP2IEBBEXEWWVQKGQECUTJMIY@googlegroups.com>
MIME-Version: 1.0
Received: from m50-110.126.com (m50-110.126.com. [123.125.50.110])
        by gmr-mx.google.com with ESMTP id ax9si1092556igc.1.2015.06.02.02.06.25
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 02:06:26 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Herbert Valerio Riedel <hvr@gnu.org>
Subject: [rtc-linux] [PATCH v2 3/4] drivers/rtc/isl1208: Replace deprecated rtc_tm_to_time()
Date: Tue,  2 Jun 2015 17:04:21 +0800
Message-Id: <1433235862-1638-3-git-send-email-xlpang@126.com>
In-Reply-To: <1433235862-1638-1-git-send-email-xlpang@126.com>
References: <1433235862-1638-1-git-send-email-xlpang@126.com>
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
 - Replacing rtc_tm_to_time() with rtc_tm_subtract()

Cc: Herbert Valerio Riedel <hvr@gnu.org>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-isl1208.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index c3c549d..6eb5d36 100644
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
+	if (!alarm->enabled || rtc_tm_subtract(alarm_tm, &rtc_tm) <= 0)
 		enable = 0x00;
 	else
 		enable = 0x80;
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
