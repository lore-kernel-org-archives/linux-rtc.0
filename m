Return-Path: <rtc-linux+bncBDKNBMNKRMJRBCG2UPFAKGQEITYDHJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id y3si713742wmc.1.2017.06.20.02.38.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:16 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id d73so14630641wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:16 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 35/51] rtc: pm8xxx: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:43 +0200
Message-Id: <1497951359-13334-36-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-pm8xxx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fac8355..e6b52bd 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -81,7 +81,8 @@ struct pm8xxx_rtc {
 static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc, i;
-	unsigned long secs, irq_flags;
+	unsigned long long secs;
+	unsigned long irq_flags;
 	u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0;
 	unsigned int ctrl_reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
@@ -90,14 +91,14 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (!rtc_dd->allow_set_time)
 		return -EACCES;
 
-	rtc_tm_to_time(tm, &secs);
+	secs = rtc_tm_to_time64(tm);
 
 	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
 		value[i] = secs & 0xFF;
 		secs >>= 8;
 	}
 
-	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
+	dev_dbg(dev, "Seconds value to be written to RTC = %llu\n", secs);
 
 	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
 
@@ -156,7 +157,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc;
 	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned long secs;
+	unsigned long long secs;
 	unsigned int reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
@@ -188,7 +189,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) | (value[3] << 24);
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 
 	rc = rtc_valid_tm(tm);
 	if (rc < 0) {
@@ -196,7 +197,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return rc;
 	}
 
-	dev_dbg(dev, "secs = %lu, h:m:s == %d:%d:%d, d/m/y = %d/%d/%d\n",
+	dev_dbg(dev, "secs = %llu, h:m:s == %d:%d:%d, d/m/y = %d/%d/%d\n",
 		secs, tm->tm_hour, tm->tm_min, tm->tm_sec,
 		tm->tm_mday, tm->tm_mon, tm->tm_year);
 
@@ -208,11 +209,12 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int rc, i;
 	u8 value[NUM_8_BIT_RTC_REGS];
 	unsigned int ctrl_reg;
-	unsigned long secs, irq_flags;
+	unsigned long long secs;
+	unsigned long irq_flags;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
 		value[i] = secs & 0xFF;
@@ -256,7 +258,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int rc;
 	u8 value[NUM_8_BIT_RTC_REGS];
-	unsigned long secs;
+	unsigned long long secs;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
@@ -269,7 +271,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) | (value[3] << 24);
 
-	rtc_time_to_tm(secs, &alarm->time);
+	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = rtc_valid_tm(&alarm->time);
 	if (rc < 0) {
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
