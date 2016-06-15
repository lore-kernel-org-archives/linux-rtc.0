Return-Path: <rtc-linux+bncBDKOBWPM5ABRB3G5QO5QKGQEDFJYDCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id 62si3601890pfx.1.2016.06.14.23.00.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:11 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id hf6so794121pac.2
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:11 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 09/13] RTC: ds1307: Constify struct ds1307 where possible
Date: Tue, 14 Jun 2016 22:59:35 -0700
Message-Id: <1465970379-14703-10-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 3c137ab..dbf8361 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -333,7 +333,7 @@ static s32 ds1307_native_smbus_read_block_data(const struct i2c_client *client,
 static irqreturn_t ds1307_irq(int irq, void *dev_id)
 {
 	struct i2c_client	*client = dev_id;
-	struct ds1307		*ds1307 = i2c_get_clientdata(client);
+	const struct ds1307	*ds1307 = i2c_get_clientdata(client);
 	struct mutex		*lock = &ds1307->rtc->ops_lock;
 	int			stat, control;
 
@@ -367,8 +367,8 @@ out:
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
 	u8              regs[DS1307_REG_COUNT];
-	struct ds1307	*ds1307 = dev_get_drvdata(dev);
 	int		tmp;
+	const struct ds1307 *ds1307 = dev_get_drvdata(dev);
 
 	/* read the RTC date and time registers all at once */
 	tmp = ds1307->read_block_data(ds1307->client,
@@ -404,7 +404,7 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 
 static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 {
-	struct ds1307	*ds1307 = dev_get_drvdata(dev);
+	const struct ds1307 *ds1307 = dev_get_drvdata(dev);
 	int		result;
 	int		tmp;
 	u8		regs[DS1307_REG_COUNT];
@@ -464,7 +464,7 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client       *client = to_i2c_client(dev);
-	struct ds1307		*ds1307 = i2c_get_clientdata(client);
+	const struct ds1307	*ds1307 = i2c_get_clientdata(client);
 	int			ret;
 	u8			regs[DS1307_REG_COUNT];
 
@@ -512,7 +512,7 @@ static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
-	struct ds1307		*ds1307 = i2c_get_clientdata(client);
+	const struct ds1307	*ds1307 = i2c_get_clientdata(client);
 	u8			regs[DS1307_REG_COUNT];
 	u8			control, status;
 	int			ret;
@@ -574,7 +574,7 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
-	struct ds1307		*ds1307 = i2c_get_clientdata(client);
+	const struct ds1307	*ds1307 = i2c_get_clientdata(client);
 	int			ret;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
@@ -629,7 +629,7 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
 static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
 {
 	struct i2c_client       *client = dev_id;
-	struct ds1307           *ds1307 = i2c_get_clientdata(client);
+	const struct ds1307     *ds1307 = i2c_get_clientdata(client);
 	struct mutex            *lock = &ds1307->rtc->ops_lock;
 	int reg, ret;
 
@@ -666,7 +666,7 @@ out:
 static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct ds1307 *ds1307 = i2c_get_clientdata(client);
+	const struct ds1307 *ds1307 = i2c_get_clientdata(client);
 	u8  regs[DS1307_REG_COUNT];
 	int ret;
 
@@ -705,7 +705,7 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct ds1307 *ds1307 = i2c_get_clientdata(client);
+	const struct ds1307 *ds1307 = i2c_get_clientdata(client);
 	u8  regs[DS1307_REG_COUNT];
 	int ret;
 
@@ -751,7 +751,7 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct ds1307 *ds1307 = i2c_get_clientdata(client);
+	const struct ds1307 *ds1307 = i2c_get_clientdata(client);
 	int reg;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
@@ -785,7 +785,7 @@ ds1307_nvram_read(struct file *filp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count)
 {
 	struct i2c_client	*client;
-	struct ds1307		*ds1307;
+	const struct ds1307	*ds1307;
 	int			result;
 
 	client = kobj_to_i2c_client(kobj);
@@ -804,7 +804,7 @@ ds1307_nvram_write(struct file *filp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count)
 {
 	struct i2c_client	*client;
-	struct ds1307		*ds1307;
+	const struct ds1307	*ds1307;
 	int			result;
 
 	client = kobj_to_i2c_client(kobj);
@@ -880,7 +880,7 @@ out:
  */
 static int ds3231_hwmon_read_temp(struct device *dev, s32 *mC)
 {
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	const struct ds1307 *ds1307 = dev_get_drvdata(dev);
 	u8 temp_buf[2];
 	s16 temp;
 	int ret;
@@ -973,7 +973,7 @@ static int ds3231_clk_sqw_rates[] = {
 	8192,
 };
 
-static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
+static int ds1337_write_control(const struct ds1307 *ds1307, u8 mask, u8 value)
 {
 	struct i2c_client *client = ds1307->client;
 	struct mutex *lock = &ds1307->rtc->ops_lock;
@@ -1001,7 +1001,7 @@ out:
 static unsigned long ds3231_clk_sqw_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
 	int control;
 	int rate_sel = 0;
 
@@ -1032,7 +1032,7 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate)
 {
-	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
 	int control = 0;
 	int rate_sel;
 
@@ -1056,21 +1056,21 @@ static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static int ds3231_clk_sqw_prepare(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
 
 	return ds1337_write_control(ds1307, DS1337_BIT_INTCN, 0);
 }
 
 static void ds3231_clk_sqw_unprepare(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
 
 	ds1337_write_control(ds1307, DS1337_BIT_INTCN, DS1337_BIT_INTCN);
 }
 
 static int ds3231_clk_sqw_is_prepared(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
 	int control;
 
 	control = i2c_smbus_read_byte_data(ds1307->client, DS1337_REG_CONTROL);
@@ -1095,7 +1095,7 @@ static unsigned long ds3231_clk_32khz_recalc_rate(struct clk_hw *hw,
 	return 32768;
 }
 
-static int ds3231_clk_32khz_control(struct ds1307 *ds1307, bool enable)
+static int ds3231_clk_32khz_control(const struct ds1307 *ds1307, bool enable)
 {
 	struct i2c_client *client = ds1307->client;
 	struct mutex *lock = &ds1307->rtc->ops_lock;
@@ -1124,21 +1124,21 @@ out:
 
 static int ds3231_clk_32khz_prepare(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
 
 	return ds3231_clk_32khz_control(ds1307, true);
 }
 
 static void ds3231_clk_32khz_unprepare(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
 
 	ds3231_clk_32khz_control(ds1307, false);
 }
 
 static int ds3231_clk_32khz_is_prepared(struct clk_hw *hw)
 {
-	struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
+	const struct ds1307 *ds1307 = clk_32khz_to_ds1307(hw);
 	int status;
 
 	status = i2c_smbus_read_byte_data(ds1307->client, DS1337_REG_STATUS);
@@ -1273,7 +1273,7 @@ static bool ds1307_want_irq(const struct ds1307 *ds1307,
 	return false;
 }
 
-static int ds1307_chip_configure(struct ds1307 *ds1307)
+static int ds1307_chip_configure(const struct ds1307 *ds1307)
 {
 	int tmp;
 	u8  regs[DS1307_REG_COUNT];
@@ -1422,7 +1422,7 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 	return 0;
 }
 
-static int ds1307_chip_sanity_check(struct ds1307 *ds1307)
+static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 {
 	int tmp;
 	u8  regs[DS1307_REG_COUNT];
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
