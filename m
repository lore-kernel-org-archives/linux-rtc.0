Return-Path: <xlpang@126.com>
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [PATCH v3 2/4] rtc/lib: Introduce rtc_tm_sub() helper function
Date: Fri, 12 Jun 2015 10:04:10 +0800
Message-Id: <1434074652-16054-2-git-send-email-xlpang@126.com>
In-Reply-To: <1434074652-16054-1-git-send-email-xlpang@126.com>
References: <1434074652-16054-1-git-send-email-xlpang@126.com>
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

There're many sites need comparing the two rtc_time variants for many
rtc drivers, especially in the instances of rtc_class_ops::set_alarm().

So add this common helper function to make things easy.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
v2->v3:
Respin rtc_tm_subtract() to rtc_tm_sub() using "static inline".

 include/linux/rtc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..f46f765 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -24,6 +24,14 @@ extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
 ktime_t rtc_tm_to_ktime(struct rtc_time tm);
 struct rtc_time rtc_ktime_to_tm(ktime_t kt);
 
+/*
+ * rtc_tm_sub - Return the difference in seconds.
+ */
+static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
+{
+	return rtc_tm_to_time64(lhs) - rtc_tm_to_time64(rhs);
+}
+
 /**
  * Deprecated. Use rtc_time64_to_tm().
  */
-- 
1.9.1
