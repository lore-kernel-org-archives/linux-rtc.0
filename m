Return-Path: <rtc-linux+bncBDKNBMNKRMJRB6OZUPFAKGQEXSNOBTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id j201si2837522wmg.5.2017.06.20.02.38.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:01 -0700 (PDT)
Received: by mail-wm0-x232.google.com with SMTP id m125so15803546wmm.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:01 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 27/51] rtc: imxdi: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:35 +0200
Message-Id: <1497951359-13334-28-git-send-email-benjamin.gaignard@linaro.org>
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

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-imxdi.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 6b54f6c..9af601d 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -549,10 +549,10 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
 static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
-	unsigned long now;
+	unsigned long long now;
 
 	now = readl(imxdi->ioaddr + DTCMR);
-	rtc_time_to_tm(now, tm);
+	rtc_time64_to_tm(now, tm);
 
 	return 0;
 }
@@ -561,7 +561,7 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
  * set the seconds portion of dryice time counter and clear the
  * fractional part.
  */
-static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int dryice_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	u32 dcr, dsr;
@@ -618,7 +618,7 @@ static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	u32 dcamr;
 
 	dcamr = readl(imxdi->ioaddr + DCAMR);
-	rtc_time_to_tm(dcamr, &alarm->time);
+	rtc_time64_to_tm((u64)dcamr, &alarm->time);
 
 	/* alarm is enabled if the interrupt is enabled */
 	alarm->enabled = (readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
@@ -641,12 +641,10 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	unsigned long now;
-	unsigned long alarm_time;
+	unsigned long long alarm_time;
 	int rc;
 
-	rc = rtc_tm_to_time(&alarm->time, &alarm_time);
-	if (rc)
-		return rc;
+	alarm_time = rtc_tm_to_time64(&alarm->time);
 
 	/* don't allow setting alarm in the past */
 	now = readl(imxdi->ioaddr + DTCMR);
@@ -668,7 +666,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static const struct rtc_class_ops dryice_rtc_ops = {
 	.read_time		= dryice_rtc_read_time,
-	.set_mmss		= dryice_rtc_set_mmss,
+	.set_mmss64		= dryice_rtc_set_mmss64,
 	.alarm_irq_enable	= dryice_rtc_alarm_irq_enable,
 	.read_alarm		= dryice_rtc_read_alarm,
 	.set_alarm		= dryice_rtc_set_alarm,
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
