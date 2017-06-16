Return-Path: <rtc-linux+bncBDKNBMNKRMJRBB6LR7FAKGQEE2OR5YA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id 197si701762wmo.0.2017.06.16.07.04.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 07:04:55 -0700 (PDT)
Received: by mail-wm0-x232.google.com with SMTP id m125so26940429wmm.1
        for <rtc-linux@googlegroups.com>; Fri, 16 Jun 2017 07:04:55 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: john.stultz@linaro.org,
	tglx@linutronix.de,
	sboyd@codeaurora.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	patrice.chotard@st.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com
Cc: linaro-kernel@lists.linaro.org,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [rtc-linux] [PATCH 3/3] rtc: st-lpc: make it robust against
 y2038/2106 bug
Date: Fri, 16 Jun 2017 16:03:53 +0200
Message-Id: <1497621833-9942-4-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Make driver use u64 variables and functions to be sure that
it will support dates after year 2038.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/rtc/rtc-st-lpc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 74c0a33..82b0af1 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -99,7 +99,7 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	lpt = ((unsigned long long)lpt_msb << 32) | lpt_lsb;
 	do_div(lpt, rtc->clkrate);
-	rtc_time_to_tm(lpt, tm);
+	rtc_time64_to_tm(lpt, tm);
 
 	return 0;
 }
@@ -107,13 +107,10 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int st_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct st_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long long lpt;
-	unsigned long secs, flags;
-	int ret;
+	unsigned long long lpt, secs;
+	unsigned long flags;
 
-	ret = rtc_tm_to_time(tm, &secs);
-	if (ret)
-		return ret;
+	secs = rtc_tm_to_time64(tm);
 
 	lpt = (unsigned long long)secs * rtc->clkrate;
 
@@ -161,13 +158,13 @@ static int st_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct st_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time now;
-	unsigned long now_secs;
-	unsigned long alarm_secs;
+	unsigned long long now_secs;
+	unsigned long long alarm_secs;
 	unsigned long long lpa;
 
 	st_rtc_read_time(dev, &now);
-	rtc_tm_to_time(&now, &now_secs);
-	rtc_tm_to_time(&t->time, &alarm_secs);
+	now_secs = rtc_tm_to_time64(&now);
+	alarm_secs = rtc_tm_to_time64(&t->time);
 
 	/* Invalid alarm time */
 	if (now_secs > alarm_secs)
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
