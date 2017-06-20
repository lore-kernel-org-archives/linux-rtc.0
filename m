Return-Path: <rtc-linux+bncBDKNBMNKRMJRBSWZUPFAKGQE2ND4YXQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id o27si2852219wmi.4.2017.06.20.02.37.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:14 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id u185so5599321wmd.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:14 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 09/51] rtc: at32ap700x: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:17 +0200
Message-Id: <1497951359-13334-10-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-at32ap700x.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
index de8bf56..db58cf5 100644
--- a/drivers/rtc/rtc-at32ap700x.c
+++ b/drivers/rtc/rtc-at32ap700x.c
@@ -61,7 +61,7 @@
 struct rtc_at32ap700x {
 	struct rtc_device	*rtc;
 	void __iomem		*regs;
-	unsigned long		alarm_time;
+	unsigned long long	alarm_time;
 	unsigned long		irq;
 	/* Protect against concurrent register access. */
 	spinlock_t		lock;
@@ -70,10 +70,10 @@ struct rtc_at32ap700x {
 static int at32_rtc_readtime(struct device *dev, struct rtc_time *tm)
 {
 	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long now;
+	unsigned long long now;
 
 	now = rtc_readl(rtc, VAL);
-	rtc_time_to_tm(now, tm);
+	rtc_time64_to_tm(now, tm);
 
 	return 0;
 }
@@ -81,14 +81,12 @@ static int at32_rtc_readtime(struct device *dev, struct rtc_time *tm)
 static int at32_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long now;
-	int ret;
+	unsigned long long now;
 
-	ret = rtc_tm_to_time(tm, &now);
-	if (ret == 0)
-		rtc_writel(rtc, VAL, now);
+	now = rtc_tm_to_time64(tm);
+	rtc_writel(rtc, VAL, now);
 
-	return ret;
+	return 0;
 }
 
 static int at32_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -96,7 +94,7 @@ static int at32_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
 
 	spin_lock_irq(&rtc->lock);
-	rtc_time_to_tm(rtc->alarm_time, &alrm->time);
+	rtc_time64_to_tm(rtc->alarm_time, &alrm->time);
 	alrm->enabled = rtc_readl(rtc, IMR) & RTC_BIT(IMR_TOPI) ? 1 : 0;
 	alrm->pending = rtc_readl(rtc, ISR) & RTC_BIT(ISR_TOPI) ? 1 : 0;
 	spin_unlock_irq(&rtc->lock);
@@ -107,15 +105,12 @@ static int at32_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int at32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long rtc_unix_time;
-	unsigned long alarm_unix_time;
-	int ret;
+	unsigned long long rtc_unix_time;
+	unsigned long long alarm_unix_time;
 
 	rtc_unix_time = rtc_readl(rtc, VAL);
 
-	ret = rtc_tm_to_time(&alrm->time, &alarm_unix_time);
-	if (ret)
-		return ret;
+	alarm_unix_time = rtc_tm_to_time64(&alrm->time);
 
 	if (alarm_unix_time < rtc_unix_time)
 		return -EINVAL;
@@ -131,7 +126,7 @@ static int at32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 				& ~RTC_BIT(CTRL_TOPEN));
 	spin_unlock_irq(&rtc->lock);
 
-	return ret;
+	return 0;
 }
 
 static int at32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
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
