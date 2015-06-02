Return-Path: <rtc-linux+bncBCN6JTVP2IEBB5HDWWVQKGQEPVT6CXI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-110.126.com (m50-110.126.com. [123.125.50.110])
        by gmr-mx.google.com with ESMTP id ns5si896215igb.0.2015.06.02.02.05.55
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 02:05:55 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH v2 1/4] drivers/rtc/pcf8563: Replace deprecated
 rtc_time_to_tm() and rtc_tm_to_time()
Date: Tue,  2 Jun 2015 17:04:19 +0800
Message-Id: <1433235862-1638-1-git-send-email-xlpang@126.com>
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

pcf8563_rtc_set_alarm() uses deprecated rtc_tm_to_time()
and rtc_time_to_tm(), which will overflow in year 2106
on 32-bit machines.

This patch solves this by:
 - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
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
