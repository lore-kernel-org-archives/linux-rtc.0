Return-Path: <rtc-linux+bncBAABB2X4QS2QKGQEUW5BZ6Q@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si354048pab.0.2016.01.21.12.24.10
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 12:24:10 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [rtc-linux] [PATCH v2 06/10] rtc: max77686: Add max77802 support
Date: Thu, 21 Jan 2016 17:23:29 -0300
Message-Id: <1453407813-14646-7-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The MAX77686 and MAX77802 RTC IP blocks are very similar with only
these differences:

0) The RTC registers layout and addresses are different.

1) The MAX77686 use 1 bit of the sec/min/hour/etc registers as the
   alarm enable while MAX77802 has a separate register for that.

2) The MAX77686 RTCYEAR register valid values range is 0..99 while
   for MAX77802 is 0..199.

3) The MAX77686 has a separate I2C address for the RTC registers
   while the MAX77802 uses the same I2C address as the PMIC regs.

5) The minimum delay before a RTC update (16 msecs vs 200 usecs).

There are separate drivers for MAX77686 and MAX77802 RTC IP blocks
but the differences are not that big so the driver can be extended
to support both instead of duplicating a lot of code in 2 drivers.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Add a MAX77802 prefix to ALARM_ENABLE_VALUE. Suggested by Krzysztof Kozlowski.
- Rename .rtcae to .alarm_enable_reg and .rtcrm to .separate_i2c_addr.
  Suggested by Krzysztof Kozlowski.
- Don't use func and LINE in error messages. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_AE2 since is not used by neither max77686 nor max77802.
- Check if REG_RTC_AE1 has a valid address before accessing it.

 drivers/rtc/rtc-max77686.c | 204 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 158 insertions(+), 46 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 74bf54be36a4..3e6d6bff5154 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -1,5 +1,5 @@
 /*
- * RTC driver for Maxim MAX77686
+ * RTC driver for Maxim MAX77686 and MAX77802
  *
  * Copyright (C) 2012 Samsung Electronics Co.Ltd
  *
@@ -41,6 +41,15 @@
 #define ALARM_ENABLE_SHIFT		7
 #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
 
+#define REG_RTC_NONE			0xdeadbeef
+
+/*
+ * MAX77802 has separate register (RTCAE1) for alarm enable instead
+ * using 1 bit from registers RTC{SEC,MIN,HOUR,DAY,MONTH,YEAR,DATE}
+ * as in done in MAX77686.
+ */
+#define MAX77802_ALARM_ENABLE_VALUE	0x77
+
 enum {
 	RTC_SEC = 0,
 	RTC_MIN,
@@ -59,6 +68,10 @@ struct max77686_rtc_driver_data {
 	u8			mask;
 	/* Registers offset to I2C addresses map */
 	const unsigned int	*map;
+	/* Has a separate alarm enable register? */
+	bool			alarm_enable_reg;
+	/* Has a separate I2C regmap for the RTC? */
+	bool			separate_i2c_addr;
 };
 
 struct max77686_rtc_info {
@@ -108,6 +121,7 @@ enum max77686_rtc_reg_offset {
 	REG_ALARM2_MONTH,
 	REG_ALARM2_YEAR,
 	REG_ALARM2_DATE,
+	REG_RTC_AE1,
 	REG_RTC_END,
 };
 
@@ -138,12 +152,52 @@ static const unsigned int max77686_map[REG_RTC_END] = {
 	[REG_ALARM2_MONTH]   = MAX77686_ALARM2_MONTH,
 	[REG_ALARM2_YEAR]    = MAX77686_ALARM2_YEAR,
 	[REG_ALARM2_DATE]    = MAX77686_ALARM2_DATE,
+	[REG_RTC_AE1]	     = REG_RTC_NONE,
 };
 
 static const struct max77686_rtc_driver_data max77686_drv_data = {
 	.delay = 1600,
 	.mask  = 0x7f,
 	.map   = max77686_map,
+	.alarm_enable_reg  = false,
+	.separate_i2c_addr = true,
+};
+
+static const unsigned int max77802_map[REG_RTC_END] = {
+	[REG_RTC_CONTROLM]   = MAX77802_RTC_CONTROLM,
+	[REG_RTC_CONTROL]    = MAX77802_RTC_CONTROL,
+	[REG_RTC_UPDATE0]    = MAX77802_RTC_UPDATE0,
+	[REG_WTSR_SMPL_CNTL] = MAX77802_WTSR_SMPL_CNTL,
+	[REG_RTC_SEC]        = MAX77802_RTC_SEC,
+	[REG_RTC_MIN]        = MAX77802_RTC_MIN,
+	[REG_RTC_HOUR]       = MAX77802_RTC_HOUR,
+	[REG_RTC_WEEKDAY]    = MAX77802_RTC_WEEKDAY,
+	[REG_RTC_MONTH]      = MAX77802_RTC_MONTH,
+	[REG_RTC_YEAR]       = MAX77802_RTC_YEAR,
+	[REG_RTC_DATE]       = MAX77802_RTC_DATE,
+	[REG_ALARM1_SEC]     = MAX77802_ALARM1_SEC,
+	[REG_ALARM1_MIN]     = MAX77802_ALARM1_MIN,
+	[REG_ALARM1_HOUR]    = MAX77802_ALARM1_HOUR,
+	[REG_ALARM1_WEEKDAY] = MAX77802_ALARM1_WEEKDAY,
+	[REG_ALARM1_MONTH]   = MAX77802_ALARM1_MONTH,
+	[REG_ALARM1_YEAR]    = MAX77802_ALARM1_YEAR,
+	[REG_ALARM1_DATE]    = MAX77802_ALARM1_DATE,
+	[REG_ALARM2_SEC]     = MAX77802_ALARM2_SEC,
+	[REG_ALARM2_MIN]     = MAX77802_ALARM2_MIN,
+	[REG_ALARM2_HOUR]    = MAX77802_ALARM2_HOUR,
+	[REG_ALARM2_WEEKDAY] = MAX77802_ALARM2_WEEKDAY,
+	[REG_ALARM2_MONTH]   = MAX77802_ALARM2_MONTH,
+	[REG_ALARM2_YEAR]    = MAX77802_ALARM2_YEAR,
+	[REG_ALARM2_DATE]    = MAX77802_ALARM2_DATE,
+	[REG_RTC_AE1]	     = MAX77802_RTC_AE1,
+};
+
+static const struct max77686_rtc_driver_data max77802_drv_data = {
+	.delay = 200,
+	.mask  = 0xff,
+	.map   = max77802_map,
+	.alarm_enable_reg  = true,
+	.separate_i2c_addr = false,
 };
 
 static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
@@ -165,12 +219,20 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
 	tm->tm_mday = data[RTC_DATE] & 0x1f;
 	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
-	tm->tm_year = (data[RTC_YEAR] & mask) + 100;
+	tm->tm_year = data[RTC_YEAR] & mask;
 	tm->tm_yday = 0;
 	tm->tm_isdst = 0;
+
+	/*
+	 * MAX77686 uses 1 bit from sec/min/hour/etc RTC registers and the
+	 * year values are just 0..99 so add 100 to support up to 2099.
+	 */
+	if (!info->drv_data->alarm_enable_reg)
+		tm->tm_year += 100;
 }
 
-static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
+static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
+				   struct max77686_rtc_info *info)
 {
 	data[RTC_SEC] = tm->tm_sec;
 	data[RTC_MIN] = tm->tm_min;
@@ -178,13 +240,19 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
 	data[RTC_WEEKDAY] = 1 << tm->tm_wday;
 	data[RTC_DATE] = tm->tm_mday;
 	data[RTC_MONTH] = tm->tm_mon + 1;
-	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
 
-	if (tm->tm_year < 100) {
-		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
-			1900 + tm->tm_year);
-		return -EINVAL;
+	if (!info->drv_data->alarm_enable_reg) {
+		data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
+
+		if (tm->tm_year < 100) {
+			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
+				1900 + tm->tm_year);
+			return -EINVAL;
+		}
+	} else {
+		data[RTC_YEAR] = tm->tm_year;
 	}
+
 	return 0;
 }
 
@@ -249,7 +317,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 data[RTC_NR_TIME];
 	int ret;
 
-	ret = max77686_rtc_tm_to_data(tm, data);
+	ret = max77686_rtc_tm_to_data(tm, data, info);
 	if (ret < 0)
 		return ret;
 
@@ -296,11 +364,32 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	max77686_rtc_data_to_tm(data, &alrm->time, info);
 
 	alrm->enabled = 0;
-	for (i = 0; i < RTC_NR_TIME; i++) {
-		if (data[i] & ALARM_ENABLE_MASK) {
-			alrm->enabled = 1;
-			break;
+
+	if (!info->drv_data->alarm_enable_reg) {
+		for (i = 0; i < RTC_NR_TIME; i++) {
+			if (data[i] & ALARM_ENABLE_MASK) {
+				alrm->enabled = 1;
+				break;
+			}
+		}
+	} else {
+		if (map[REG_RTC_AE1] == REG_RTC_NONE) {
+			ret = -EINVAL;
+			dev_err(info->dev,
+				"alarm enable register not set(%d)\n", ret);
+			goto out;
 		}
+
+		ret = regmap_read(info->max77686->regmap,
+				  map[REG_RTC_AE1], &val);
+		if (ret < 0) {
+			dev_err(info->dev,
+				"fail to read alarm enable(%d)\n", ret);
+			goto out;
+		}
+
+		if (val)
+			alrm->enabled = 1;
 	}
 
 	alrm->pending = 0;
@@ -333,21 +422,34 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
-	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
+	if (!info->drv_data->alarm_enable_reg) {
+		ret = regmap_bulk_read(info->max77686->rtc_regmap,
+				       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
+		if (ret < 0) {
+			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
-		goto out;
-	}
+			goto out;
+		}
 
-	max77686_rtc_data_to_tm(data, &tm, info);
+		max77686_rtc_data_to_tm(data, &tm, info);
 
-	for (i = 0; i < RTC_NR_TIME; i++)
-		data[i] &= ~ALARM_ENABLE_MASK;
+		for (i = 0; i < RTC_NR_TIME; i++)
+			data[i] &= ~ALARM_ENABLE_MASK;
+
+		ret = regmap_bulk_write(info->max77686->rtc_regmap,
+					map[REG_ALARM1_SEC], data, RTC_NR_TIME);
+	} else {
+		if (map[REG_RTC_AE1] == REG_RTC_NONE) {
+			ret = -EINVAL;
+			dev_err(info->dev,
+				"alarm enable register not set(%d)\n", ret);
+			goto out;
+		}
+
+		ret = regmap_write(info->max77686->regmap,
+				   map[REG_RTC_AE1], 0);
+	}
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -373,29 +475,35 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
-	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
+	if (!info->drv_data->alarm_enable_reg) {
+		ret = regmap_bulk_read(info->max77686->rtc_regmap,
+				       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
+		if (ret < 0) {
+			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
-		goto out;
-	}
-
-	max77686_rtc_data_to_tm(data, &tm, info);
+			goto out;
+		}
 
-	data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
-	data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
-	data[RTC_HOUR] |= (1 << ALARM_ENABLE_SHIFT);
-	data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
-	if (data[RTC_MONTH] & 0xf)
-		data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
-	if (data[RTC_YEAR] & info->drv_data->mask)
-		data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
-	if (data[RTC_DATE] & 0x1f)
-		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
+		max77686_rtc_data_to_tm(data, &tm, info);
+
+		data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
+		data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
+		data[RTC_HOUR] |= (1 << ALARM_ENABLE_SHIFT);
+		data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
+		if (data[RTC_MONTH] & 0xf)
+			data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
+		if (data[RTC_YEAR] & info->drv_data->mask)
+			data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
+		if (data[RTC_DATE] & 0x1f)
+			data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
+
+		ret = regmap_bulk_write(info->max77686->rtc_regmap,
+					map[REG_ALARM1_SEC], data, RTC_NR_TIME);
+	} else {
+		ret = regmap_write(info->max77686->regmap, map[REG_RTC_AE1],
+				   MAX77802_ALARM_ENABLE_VALUE);
+	}
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -413,7 +521,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u8 data[RTC_NR_TIME];
 	int ret;
 
-	ret = max77686_rtc_tm_to_data(&alrm->time, data);
+	ret = max77686_rtc_tm_to_data(&alrm->time, data, info);
 	if (ret < 0)
 		return ret;
 
@@ -524,6 +632,9 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	info->drv_data = (const struct max77686_rtc_driver_data *)
 		id->driver_data;
 
+	if (!info->drv_data->separate_i2c_addr)
+		info->max77686->rtc_regmap = info->max77686->regmap;
+
 	platform_set_drvdata(pdev, info);
 
 	ret = max77686_rtc_init_reg(info);
@@ -535,7 +646,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "max77686-rtc",
+	info->rtc_dev = devm_rtc_device_register(&pdev->dev, id->name,
 					&max77686_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(info->rtc_dev)) {
@@ -598,6 +709,7 @@ static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
 
 static const struct platform_device_id rtc_id[] = {
 	{ "max77686-rtc", .driver_data = (kernel_ulong_t)&max77686_drv_data, },
+	{ "max77802-rtc", .driver_data = (kernel_ulong_t)&max77802_drv_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, rtc_id);
-- 
2.5.0

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
