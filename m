Return-Path: <rtc-linux+bncBCN6JTVP2IEBB4PDWWVQKGQERQVWIAI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-110.126.com (m50-110.126.com. [123.125.50.110])
        by gmr-mx.google.com with ESMTP id g4si1083740igc.3.2015.06.02.02.05.52
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 02:05:53 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH v2 2/4] rtc/lib: Introduce rtc_tm_subtract()
 helper function
Date: Tue,  2 Jun 2015 17:04:20 +0800
Message-Id: <1433235862-1638-2-git-send-email-xlpang@126.com>
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

There're many sites need comparing the two rtc_time variants for many
rtc drivers, especially in the instances of rtc_class_ops::set_alarm().

So add this common helper function to make things easy.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-lib.c | 9 +++++++++
 include/linux/rtc.h   | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index e6bfb9c..fdb94cc 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -124,6 +124,15 @@ time64_t rtc_tm_to_time64(struct rtc_time *tm)
 EXPORT_SYMBOL(rtc_tm_to_time64);
 
 /*
+ * rtc_tm_subtract - Return the difference in seconds.
+ */
+time64_t rtc_tm_subtract(struct rtc_time *minuend, struct rtc_time *subtrahend)
+{
+	return rtc_tm_to_time64(minuend) - rtc_tm_to_time64(subtrahend);
+}
+EXPORT_SYMBOL_GPL(rtc_tm_subtract);
+
+/*
  * Convert rtc_time to ktime
  */
 ktime_t rtc_tm_to_ktime(struct rtc_time tm)
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..13e4138 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -21,6 +21,8 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
 extern int rtc_valid_tm(struct rtc_time *tm);
 extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
 extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
+extern time64_t rtc_tm_subtract(struct rtc_time *minuend,
+		struct rtc_time *subtrahend);
 ktime_t rtc_tm_to_ktime(struct rtc_time tm);
 struct rtc_time rtc_ktime_to_tm(ktime_t kt);
 
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
