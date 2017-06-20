Return-Path: <rtc-linux+bncBDKNBMNKRMJRBFO2UPFAKGQEKBBIJMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com. [2a00:1450:400c:c0c::230])
        by gmr-mx.google.com with ESMTPS id 140si3846457wmr.2.2017.06.20.02.38.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:29 -0700 (PDT)
Received: by mail-wr0-x230.google.com with SMTP id 77so88340372wrb.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:29 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 43/51] rtc: sun6i: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:51 +0200
Message-Id: <1497951359-13334-44-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/rtc/rtc-sun6i.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 39cbc12..9928f74 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -120,7 +120,7 @@ struct sun6i_rtc_dev {
 	struct device *dev;
 	void __iomem *base;
 	int irq;
-	unsigned long alarm;
+	unsigned long long alarm;
 
 	struct clk_hw hw;
 	struct clk_hw *int_osc;
@@ -342,7 +342,7 @@ static int sun6i_rtc_getalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	wkalrm->enabled = !!(alrm_en & SUN6I_ALRM_EN_CNT_EN);
 	wkalrm->pending = !!(alrm_st & SUN6I_ALRM_EN_CNT_EN);
-	rtc_time_to_tm(chip->alarm, &wkalrm->time);
+	rtc_time64_to_tm(chip->alarm, &wkalrm->time);
 
 	return 0;
 }
@@ -352,9 +352,9 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	unsigned long time_now = 0;
-	unsigned long time_set = 0;
-	unsigned long time_gap = 0;
+	unsigned long long time_now = 0;
+	unsigned long long time_set = 0;
+	unsigned long long time_gap = 0;
 	int ret = 0;
 
 	ret = sun6i_rtc_gettime(dev, &tm_now);
@@ -363,8 +363,8 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		return -EINVAL;
 	}
 
-	rtc_tm_to_time(alrm_tm, &time_set);
-	rtc_tm_to_time(&tm_now, &time_now);
+	time_set = rtc_tm_to_time64(alrm_tm);
+	time_now = rtc_tm_to_time64(&tm_now);
 	if (time_set <= time_now) {
 		dev_err(dev, "Date to set in the past\n");
 		return -EINVAL;
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
