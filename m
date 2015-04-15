Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time() and
 rtc_time_to_tm()
From: Xunlei Pang <xlpang@126.com>
Message-Id: <1429089611-29776-5-git-send-email-xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Xunlei Pang <pang.xunlei@linaro.org>, CIH <cih@coventive.com>,
 Nicolas Pitre <nico@fluxnic.net>,
 Andrew Christian <andrew.christian@hp.com>,
 Richard Purdie <rpurdie@rpsys.net>
Date: Wed, 15 Apr 2015 17:20:11 +0800
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
 - Replacing rtc_time_to_tm() with rtc_time64_to_tm()

Cc: CIH <cih@coventive.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Christian <andrew.christian@hp.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-sa1100.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index b6e1ca0..625a320 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(RCNR, tm);
+	rtc_time64_to_tm(RCNR, tm);
 	return 0;
 }
 
 static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long time;
-	int ret;
-
-	ret = rtc_tm_to_time(tm, &time);
-	if (ret == 0)
-		RCNR = time;
-	return ret;
+	RCNR = rtc_tm_to_time64(tm);
+	return 0;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -185,23 +180,17 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
-	unsigned long time;
-	int ret;
 
 	spin_lock_irq(&info->lock);
-	ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret != 0)
-		goto out;
 	RTSR = RTSR & (RTSR_HZE|RTSR_ALE|RTSR_AL);
-	RTAR = time;
+	RTAR = rtc_tm_to_time64(&alrm->time);
 	if (alrm->enabled)
 		RTSR |= RTSR_ALE;
 	else
 		RTSR &= ~RTSR_ALE;
-out:
 	spin_unlock_irq(&info->lock);
 
-	return ret;
+	return 0;
 }
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
