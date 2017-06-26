Return-Path: <rtc-linux+bncBC2IT2GSZUDRBMVSYPFAKGQEWYSMJRI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id b206si2891566wme.3.2017.06.26.02.51.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 02:51:45 -0700 (PDT)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: stm32: add STM32H7 RTC support
Date: Mon, 26 Jun 2017 11:51:29 +0200
Message-ID: <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch adds support for STM32H7 RTC. On STM32H7, the RTC bus interface
clock (APB clock) needs to be enabled.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 85 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index bd57eb1..22f988b 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -94,11 +94,17 @@
 /* STM32_PWR_CR bit field */
 #define PWR_CR_DBP			BIT(8)
 
+struct stm32_rtc_data {
+	bool has_pclk;
+};
+
 struct stm32_rtc {
 	struct rtc_device *rtc_dev;
 	void __iomem *base;
 	struct regmap *dbp;
-	struct clk *ck_rtc;
+	struct stm32_rtc_data *data;
+	struct clk *pclk;
+	struct clk *rtc_ck;
 	int irq_alarm;
 };
 
@@ -122,9 +128,9 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 		writel_relaxed(isr, rtc->base + STM32_RTC_ISR);
 
 		/*
-		 * It takes around 2 ck_rtc clock cycles to enter in
+		 * It takes around 2 rtc_ck clock cycles to enter in
 		 * initialization phase mode (and have INITF flag set). As
-		 * slowest ck_rtc frequency may be 32kHz and highest should be
+		 * slowest rtc_ck frequency may be 32kHz and highest should be
 		 * 1MHz, we poll every 10 us with a timeout of 100ms.
 		 */
 		return readl_relaxed_poll_timeout_atomic(
@@ -153,7 +159,7 @@ static int stm32_rtc_wait_sync(struct stm32_rtc *rtc)
 
 	/*
 	 * Wait for RSF to be set to ensure the calendar registers are
-	 * synchronised, it takes around 2 ck_rtc clock cycles
+	 * synchronised, it takes around 2 rtc_ck clock cycles
 	 */
 	return readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
 						 isr,
@@ -456,7 +462,7 @@ static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	/*
 	 * Poll Alarm write flag to be sure that Alarm update is allowed: it
-	 * takes around 2 ck_rtc clock cycles
+	 * takes around 2 rtc_ck clock cycles
 	 */
 	ret = readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
 						isr,
@@ -490,8 +496,17 @@ static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	.alarm_irq_enable = stm32_rtc_alarm_irq_enable,
 };
 
+static const struct stm32_rtc_data stm32_rtc_data = {
+	.has_pclk = false,
+};
+
+static const struct stm32_rtc_data stm32h7_rtc_data = {
+	.has_pclk = true,
+};
+
 static const struct of_device_id stm32_rtc_of_match[] = {
-	{ .compatible = "st,stm32-rtc" },
+	{ .compatible = "st,stm32-rtc", .data = &stm32_rtc_data },
+	{ .compatible = "st,stm32h7-rtc", .data = &stm32h7_rtc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
@@ -503,7 +518,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	unsigned int rate;
 	int ret = 0;
 
-	rate = clk_get_rate(rtc->ck_rtc);
+	rate = clk_get_rate(rtc->rtc_ck);
 
 	/* Find prediv_a and prediv_s to obtain the 1Hz calendar clock */
 	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
@@ -524,7 +539,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 		pred_a = pred_a_max;
 		pred_s = (rate / (pred_a + 1)) - 1;
 
-		dev_warn(&pdev->dev, "ck_rtc is %s\n",
+		dev_warn(&pdev->dev, "rtc_ck is %s\n",
 			 (rate < ((pred_a + 1) * (pred_s + 1))) ?
 			 "fast" : "slow");
 	}
@@ -561,6 +576,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc;
 	struct resource *res;
+	const struct of_device_id *match;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -579,15 +595,37 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc->dbp);
 	}
 
-	rtc->ck_rtc = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(rtc->ck_rtc)) {
-		dev_err(&pdev->dev, "no ck_rtc clock");
-		return PTR_ERR(rtc->ck_rtc);
+	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
+	if (match && match->data)
+		rtc->data = (struct stm32_rtc_data *)match->data;
+	else
+		return -EINVAL;
+
+	if (!rtc->data->has_pclk) {
+		rtc->pclk = NULL;
+		rtc->rtc_ck = devm_clk_get(&pdev->dev, NULL);
+	} else {
+		rtc->pclk = devm_clk_get(&pdev->dev, "pclk");
+		if (rtc->data->has_pclk && IS_ERR(rtc->pclk)) {
+			dev_err(&pdev->dev, "no pclk clock");
+			return PTR_ERR(rtc->rtc_ck);
+		}
+		rtc->rtc_ck = devm_clk_get(&pdev->dev, "rtc_ck");
+	}
+	if (IS_ERR(rtc->rtc_ck)) {
+		dev_err(&pdev->dev, "no rtc_ck clock");
+		return PTR_ERR(rtc->rtc_ck);
 	}
 
-	ret = clk_prepare_enable(rtc->ck_rtc);
+	if (rtc->data->has_pclk) {
+		ret = clk_prepare_enable(rtc->pclk);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_prepare_enable(rtc->rtc_ck);
 	if (ret)
-		return ret;
+		goto err;
 
 	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, PWR_CR_DBP);
 
@@ -595,7 +633,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	 * After a system reset, RTC_ISR.INITS flag can be read to check if
 	 * the calendar has been initalized or not. INITS flag is reset by a
 	 * power-on reset (no vbat, no power-supply). It is not reset if
-	 * ck_rtc parent clock has changed (so RTC prescalers need to be
+	 * rtc_ck parent clock has changed (so RTC prescalers need to be
 	 * changed). That's why we cannot rely on this flag to know if RTC
 	 * init has to be done.
 	 */
@@ -646,7 +684,9 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	clk_disable_unprepare(rtc->ck_rtc);
+	if (rtc->data->has_pclk)
+		clk_disable_unprepare(rtc->pclk);
+	clk_disable_unprepare(rtc->rtc_ck);
 
 	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
 
@@ -667,7 +707,9 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	writel_relaxed(cr, rtc->base + STM32_RTC_CR);
 	stm32_rtc_wpr_lock(rtc);
 
-	clk_disable_unprepare(rtc->ck_rtc);
+	clk_disable_unprepare(rtc->rtc_ck);
+	if (rtc->data->has_pclk)
+		clk_disable_unprepare(rtc->pclk);
 
 	/* Enable backup domain write protection */
 	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
@@ -682,6 +724,9 @@ static int stm32_rtc_suspend(struct device *dev)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
 
+	if (rtc->data->has_pclk)
+		clk_disable_unprepare(rtc->pclk);
+
 	if (device_may_wakeup(dev))
 		return enable_irq_wake(rtc->irq_alarm);
 
@@ -693,6 +738,12 @@ static int stm32_rtc_resume(struct device *dev)
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (rtc->data->has_pclk) {
+		ret = clk_prepare_enable(rtc->pclk);
+		if (ret)
+			return ret;
+	}
+
 	ret = stm32_rtc_wait_sync(rtc);
 	if (ret < 0)
 		return ret;
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
