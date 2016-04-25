Return-Path: <rtc-linux+bncBAABBZ5V7C4AKGQEA3M3BBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.microcatalog.org.uk. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id c7si452510wmf.2.2016.04.25.06.25.58
        for <rtc-linux@googlegroups.com>;
        Mon, 25 Apr 2016 06:25:58 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v3 1/8] drivers: mfd: rk808: rename rk808 struct
 to rk8xx
Date: Mon, 25 Apr 2016 15:20:41 +0200
Message-Id: <1461590448-47685-2-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1461590448-47685-1-git-send-email-w.egorov@phytec.de>
References: <1461590448-47685-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch renames the rk808 struct. So it is more clear that this
struct can be shared between all RK8XX related PMIC drivers.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/clk/clk-rk808.c             | 20 +++++++--------
 drivers/mfd/rk808.c                 | 36 +++++++++++++-------------
 drivers/regulator/rk808-regulator.c |  8 +++---
 drivers/rtc/rtc-rk808.c             | 50 ++++++++++++++++++-------------------
 include/linux/mfd/rk808.h           |  2 +-
 5 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 0fee2f4..6df2e72 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -25,7 +25,7 @@
 #define RK808_NR_OUTPUT 2
 
 struct rk808_clkout {
-	struct rk808 *rk808;
+	struct rk8xx *rk8xx;
 	struct clk_onecell_data clk_data;
 	struct clk_hw		clkout1_hw;
 	struct clk_hw		clkout2_hw;
@@ -42,9 +42,9 @@ static int rk808_clkout2_enable(struct clk_hw *hw, bool enable)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
+	struct rk8xx *rk8xx = rk808_clkout->rk8xx;
 
-	return regmap_update_bits(rk808->regmap, RK808_CLK32OUT_REG,
+	return regmap_update_bits(rk8xx->regmap, RK808_CLK32OUT_REG,
 				  CLK32KOUT2_EN, enable ? CLK32KOUT2_EN : 0);
 }
 
@@ -63,10 +63,10 @@ static int rk808_clkout2_is_prepared(struct clk_hw *hw)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
+	struct rk8xx *rk8xx = rk808_clkout->rk8xx;
 	uint32_t val;
 
-	int ret = regmap_read(rk808->regmap, RK808_CLK32OUT_REG, &val);
+	int ret = regmap_read(rk8xx->regmap, RK808_CLK32OUT_REG, &val);
 
 	if (ret < 0)
 		return ret;
@@ -87,8 +87,8 @@ static const struct clk_ops rk808_clkout2_ops = {
 
 static int rk808_clkout_probe(struct platform_device *pdev)
 {
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
+	struct rk8xx *rk8xx = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *client = rk8xx->i2c;
 	struct device_node *node = client->dev.of_node;
 	struct clk_init_data init = {};
 	struct clk **clk_table;
@@ -99,7 +99,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	if (!rk808_clkout)
 		return -ENOMEM;
 
-	rk808_clkout->rk808 = rk808;
+	rk808_clkout->rk8xx = rk8xx;
 
 	clk_table = devm_kcalloc(&client->dev, RK808_NR_OUTPUT,
 				 sizeof(struct clk *), GFP_KERNEL);
@@ -144,8 +144,8 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 
 static int rk808_clkout_remove(struct platform_device *pdev)
 {
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
+	struct rk8xx *rk8xx = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *client = rk8xx->i2c;
 	struct device_node *node = client->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4b1e439..0386251 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -152,15 +152,15 @@ static struct i2c_client *rk808_i2c_client;
 static void rk808_device_shutdown(void)
 {
 	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk8xx *rk8xx = i2c_get_clientdata(rk808_i2c_client);
 
-	if (!rk808) {
+	if (!rk8xx) {
 		dev_warn(&rk808_i2c_client->dev,
 			 "have no rk808, so do nothing here\n");
 		return;
 	}
 
-	ret = regmap_update_bits(rk808->regmap,
+	ret = regmap_update_bits(rk8xx->regmap,
 				 RK808_DEVCTRL_REG,
 				 DEV_OFF_RST, DEV_OFF_RST);
 	if (ret)
@@ -171,7 +171,7 @@ static int rk808_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
-	struct rk808 *rk808;
+	struct rk8xx *rk8xx;
 	int pm_off = 0;
 	int ret;
 	int i;
@@ -181,18 +181,18 @@ static int rk808_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
-	if (!rk808)
+	rk8xx = devm_kzalloc(&client->dev, sizeof(*rk8xx), GFP_KERNEL);
+	if (!rk8xx)
 		return -ENOMEM;
 
-	rk808->regmap = devm_regmap_init_i2c(client, &rk808_regmap_config);
-	if (IS_ERR(rk808->regmap)) {
+	rk8xx->regmap = devm_regmap_init_i2c(client, &rk808_regmap_config);
+	if (IS_ERR(rk8xx->regmap)) {
 		dev_err(&client->dev, "regmap initialization failed\n");
-		return PTR_ERR(rk808->regmap);
+		return PTR_ERR(rk8xx->regmap);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pre_init_reg); i++) {
-		ret = regmap_update_bits(rk808->regmap, pre_init_reg[i].addr,
+		ret = regmap_update_bits(rk8xx->regmap, pre_init_reg[i].addr,
 					 pre_init_reg[i].mask,
 					 pre_init_reg[i].value);
 		if (ret) {
@@ -202,20 +202,20 @@ static int rk808_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
+	ret = regmap_add_irq_chip(rk8xx->regmap, client->irq,
 				  IRQF_ONESHOT, -1,
-				  &rk808_irq_chip, &rk808->irq_data);
+				  &rk808_irq_chip, &rk8xx->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
 		return ret;
 	}
 
-	rk808->i2c = client;
-	i2c_set_clientdata(client, rk808);
+	rk8xx->i2c = client;
+	i2c_set_clientdata(client, rk8xx);
 
 	ret = mfd_add_devices(&client->dev, -1,
 			      rk808s, ARRAY_SIZE(rk808s),
-			      NULL, 0, regmap_irq_get_domain(rk808->irq_data));
+			      NULL, 0, regmap_irq_get_domain(rk8xx->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
 		goto err_irq;
@@ -231,15 +231,15 @@ static int rk808_probe(struct i2c_client *client,
 	return 0;
 
 err_irq:
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
+	regmap_del_irq_chip(client->irq, rk8xx->irq_data);
 	return ret;
 }
 
 static int rk808_remove(struct i2c_client *client)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(client);
+	struct rk8xx *rk8xx = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
+	regmap_del_irq_chip(client->irq, rk8xx->irq_data);
 	mfd_remove_devices(&client->dev);
 	pm_power_off = NULL;
 
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index d86a3dc..37aaba9 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -568,8 +568,8 @@ dt_parse_end:
 
 static int rk808_regulator_probe(struct platform_device *pdev)
 {
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
+	struct rk8xx *rk8xx = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *client = rk8xx->i2c;
 	struct regulator_config config = {};
 	struct regulator_dev *rk808_rdev;
 	struct rk808_regulator_data *pdata;
@@ -580,7 +580,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = rk808_regulator_dt_parse_pdata(&pdev->dev, &client->dev,
-					     rk808->regmap, pdata);
+					     rk8xx->regmap, pdata);
 	if (ret < 0)
 		return ret;
 
@@ -594,7 +594,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 
 		config.dev = &client->dev;
 		config.driver_data = pdata;
-		config.regmap = rk808->regmap;
+		config.regmap = rk8xx->regmap;
 		config.of_node = rk808_reg_matches[i].of_node;
 		config.init_data = rk808_reg_matches[i].init_data;
 
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 35c9aad..b3fe5a8 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -51,7 +51,7 @@
 #define NUM_ALARM_REGS	(RK808_ALARM_YEARS_REG - RK808_ALARM_SECONDS_REG + 1)
 
 struct rk808_rtc {
-	struct rk808 *rk808;
+	struct rk8xx *rk8xx;
 	struct rtc_device *rtc;
 	int irq;
 };
@@ -96,12 +96,12 @@ static void gregorian_to_rockchip(struct rtc_time *tm)
 static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
 	/* Force an update of the shadowed registers right now */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_CTRL_REG,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
 	if (ret) {
@@ -115,7 +115,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
 	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
 	 */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_CTRL_REG,
 				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
 				 0);
 	if (ret) {
@@ -123,7 +123,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 		return ret;
 	}
 
-	ret = regmap_bulk_read(rk808->regmap, RK808_SECONDS_REG,
+	ret = regmap_bulk_read(rk8xx->regmap, RK808_SECONDS_REG,
 			       rtc_data, NUM_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
@@ -149,7 +149,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
@@ -166,7 +166,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_data[6] = bin2bcd(tm->tm_wday);
 
 	/* Stop RTC while updating the RTC registers */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_CTRL_REG,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M);
 	if (ret) {
@@ -174,14 +174,14 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 	}
 
-	ret = regmap_bulk_write(rk808->regmap, RK808_SECONDS_REG,
+	ret = regmap_bulk_write(rk8xx->regmap, RK808_SECONDS_REG,
 				rtc_data, NUM_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
 		return ret;
 	}
 	/* Start RTC again */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_CTRL_REG,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
 	if (ret) {
 		dev_err(dev, "Failed to update RTC control: %d\n", ret);
@@ -194,12 +194,12 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	u8 alrm_data[NUM_ALARM_REGS];
 	uint32_t int_reg;
 	int ret;
 
-	ret = regmap_bulk_read(rk808->regmap, RK808_ALARM_SECONDS_REG,
+	ret = regmap_bulk_read(rk8xx->regmap, RK808_ALARM_SECONDS_REG,
 			       alrm_data, NUM_ALARM_REGS);
 
 	alrm->time.tm_sec = bcd2bin(alrm_data[0] & SECONDS_REG_MSK);
@@ -210,7 +210,7 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->time.tm_year = (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
 	rockchip_to_gregorian(&alrm->time);
 
-	ret = regmap_read(rk808->regmap, RK808_RTC_INT_REG, &int_reg);
+	ret = regmap_read(rk8xx->regmap, RK808_RTC_INT_REG, &int_reg);
 	if (ret) {
 		dev_err(dev, "Failed to read RTC INT REG: %d\n", ret);
 		return ret;
@@ -228,10 +228,10 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
 {
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	int ret;
 
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_INT_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_INT_REG,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M, 0);
 
 	return ret;
@@ -239,10 +239,10 @@ static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
 
 static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
 {
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	int ret;
 
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_INT_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_INT_REG,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M,
 				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 
@@ -252,7 +252,7 @@ static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
 static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
 	u8 alrm_data[NUM_ALARM_REGS];
 	int ret;
 
@@ -274,7 +274,7 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm_data[4] = bin2bcd(alrm->time.tm_mon + 1);
 	alrm_data[5] = bin2bcd(alrm->time.tm_year - 100);
 
-	ret = regmap_bulk_write(rk808->regmap, RK808_ALARM_SECONDS_REG,
+	ret = regmap_bulk_write(rk8xx->regmap, RK808_ALARM_SECONDS_REG,
 				alrm_data, NUM_ALARM_REGS);
 	if (ret) {
 		dev_err(dev, "Failed to bulk write: %d\n", ret);
@@ -314,11 +314,11 @@ static int rk808_rtc_alarm_irq_enable(struct device *dev,
 static irqreturn_t rk808_alarm_irq(int irq, void *data)
 {
 	struct rk808_rtc *rk808_rtc = data;
-	struct rk808 *rk808 = rk808_rtc->rk808;
-	struct i2c_client *client = rk808->i2c;
+	struct rk8xx *rk8xx = rk808_rtc->rk8xx;
+	struct i2c_client *client = rk8xx->i2c;
 	int ret;
 
-	ret = regmap_write(rk808->regmap, RK808_RTC_STATUS_REG,
+	ret = regmap_write(rk8xx->regmap, RK808_RTC_STATUS_REG,
 			   RTC_STATUS_MASK);
 	if (ret) {
 		dev_err(&client->dev,
@@ -373,7 +373,7 @@ static SIMPLE_DEV_PM_OPS(rk808_rtc_pm_ops,
 
 static int rk808_rtc_probe(struct platform_device *pdev)
 {
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
+	struct rk8xx *rk8xx = dev_get_drvdata(pdev->dev.parent);
 	struct rk808_rtc *rk808_rtc;
 	struct rtc_time tm;
 	int ret;
@@ -383,10 +383,10 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, rk808_rtc);
-	rk808_rtc->rk808 = rk808;
+	rk808_rtc->rk8xx = rk8xx;
 
 	/* start rtc running by default, and use shadowed timer. */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+	ret = regmap_update_bits(rk8xx->regmap, RK808_RTC_CTRL_REG,
 				 BIT_RTC_CTRL_REG_STOP_RTC_M |
 				 BIT_RTC_CTRL_REG_RTC_READSEL_M,
 				 BIT_RTC_CTRL_REG_RTC_READSEL_M);
@@ -396,7 +396,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_write(rk808->regmap, RK808_RTC_STATUS_REG,
+	ret = regmap_write(rk8xx->regmap, RK808_RTC_STATUS_REG,
 			   RTC_STATUS_MASK);
 	if (ret) {
 		dev_err(&pdev->dev,
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 441b6ee..117d79f 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -191,7 +191,7 @@ enum {
 	BOOST_ILMIN_250MA,
 };
 
-struct rk808 {
+struct rk8xx {
 	struct i2c_client *i2c;
 	struct regmap_irq_chip_data *irq_data;
 	struct regmap *regmap;
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
