Return-Path: <rtc-linux+bncBAABBZ74QS2QKGQEER4SYII@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si340843pfr.0.2016.01.21.12.24.07
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 12:24:07 -0800 (PST)
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
Subject: [rtc-linux] [PATCH v2 05/10] rtc: max77686: Add an indirection level
 to access RTC registers
Date: Thu, 21 Jan 2016 17:23:28 -0300
Message-Id: <1453407813-14646-6-git-send-email-javier@osg.samsung.com>
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

The max77686 driver is generic enough that can be used for other
Maxim RTC IP blocks but these might not have the same registers
layout so instead of accessing the registers directly, add a map
to translate offsets to the real registers addresses for each IP.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Rename rtc_reg to max77686_rtc_reg_offset. Suggested by Krzysztof Kozlowski.
- Comment what's mapped by max77686_map. Suggested by Krzysztof Kozlowski.
- Use max77686_map array indexes in init. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_UPDATE1 since is not used by neither max77686 nor max77802.

 drivers/rtc/rtc-max77686.c | 90 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 16033a2c2756..74bf54be36a4 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -57,6 +57,8 @@ struct max77686_rtc_driver_data {
 	unsigned long		delay;
 	/* Mask used to read RTC registers value */
 	u8			mask;
+	/* Registers offset to I2C addresses map */
+	const unsigned int	*map;
 };
 
 struct max77686_rtc_info {
@@ -79,9 +81,69 @@ enum MAX77686_RTC_OP {
 	MAX77686_RTC_READ,
 };
 
+/* These are not registers but just offsets that are mapped to addresses */
+enum max77686_rtc_reg_offset {
+	REG_RTC_CONTROLM = 0,
+	REG_RTC_CONTROL,
+	REG_RTC_UPDATE0,
+	REG_WTSR_SMPL_CNTL,
+	REG_RTC_SEC,
+	REG_RTC_MIN,
+	REG_RTC_HOUR,
+	REG_RTC_WEEKDAY,
+	REG_RTC_MONTH,
+	REG_RTC_YEAR,
+	REG_RTC_DATE,
+	REG_ALARM1_SEC,
+	REG_ALARM1_MIN,
+	REG_ALARM1_HOUR,
+	REG_ALARM1_WEEKDAY,
+	REG_ALARM1_MONTH,
+	REG_ALARM1_YEAR,
+	REG_ALARM1_DATE,
+	REG_ALARM2_SEC,
+	REG_ALARM2_MIN,
+	REG_ALARM2_HOUR,
+	REG_ALARM2_WEEKDAY,
+	REG_ALARM2_MONTH,
+	REG_ALARM2_YEAR,
+	REG_ALARM2_DATE,
+	REG_RTC_END,
+};
+
+/* Maps RTC registers offset to the MAX77686 register addresses */
+static const unsigned int max77686_map[REG_RTC_END] = {
+	[REG_RTC_CONTROLM]   = MAX77686_RTC_CONTROLM,
+	[REG_RTC_CONTROL]    = MAX77686_RTC_CONTROL,
+	[REG_RTC_UPDATE0]    = MAX77686_RTC_UPDATE0,
+	[REG_WTSR_SMPL_CNTL] = MAX77686_WTSR_SMPL_CNTL,
+	[REG_RTC_SEC]        = MAX77686_RTC_SEC,
+	[REG_RTC_MIN]        = MAX77686_RTC_MIN,
+	[REG_RTC_HOUR]       = MAX77686_RTC_HOUR,
+	[REG_RTC_WEEKDAY]    = MAX77686_RTC_WEEKDAY,
+	[REG_RTC_MONTH]      = MAX77686_RTC_MONTH,
+	[REG_RTC_YEAR]       = MAX77686_RTC_YEAR,
+	[REG_RTC_DATE]       = MAX77686_RTC_DATE,
+	[REG_ALARM1_SEC]     = MAX77686_ALARM1_SEC,
+	[REG_ALARM1_MIN]     = MAX77686_ALARM1_MIN,
+	[REG_ALARM1_HOUR]    = MAX77686_ALARM1_HOUR,
+	[REG_ALARM1_WEEKDAY] = MAX77686_ALARM1_WEEKDAY,
+	[REG_ALARM1_MONTH]   = MAX77686_ALARM1_MONTH,
+	[REG_ALARM1_YEAR]    = MAX77686_ALARM1_YEAR,
+	[REG_ALARM1_DATE]    = MAX77686_ALARM1_DATE,
+	[REG_ALARM2_SEC]     = MAX77686_ALARM2_SEC,
+	[REG_ALARM2_MIN]     = MAX77686_ALARM2_MIN,
+	[REG_ALARM2_HOUR]    = MAX77686_ALARM2_HOUR,
+	[REG_ALARM2_WEEKDAY] = MAX77686_ALARM2_WEEKDAY,
+	[REG_ALARM2_MONTH]   = MAX77686_ALARM2_MONTH,
+	[REG_ALARM2_YEAR]    = MAX77686_ALARM2_YEAR,
+	[REG_ALARM2_DATE]    = MAX77686_ALARM2_DATE,
+};
+
 static const struct max77686_rtc_driver_data max77686_drv_data = {
 	.delay = 1600,
 	.mask  = 0x7f,
+	.map   = max77686_map,
 };
 
 static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
@@ -139,7 +201,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
 		data = 1 << RTC_RBUDR_SHIFT;
 
 	ret = regmap_update_bits(info->max77686->rtc_regmap,
-				 MAX77686_RTC_UPDATE0, data, data);
+				 info->drv_data->map[REG_RTC_UPDATE0],
+				 data, data);
 	if (ret < 0)
 		dev_err(info->dev, "%s: fail to write update reg(ret=%d, data=0x%x)\n",
 				__func__, ret, data);
@@ -164,7 +227,8 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				MAX77686_RTC_SEC, data, RTC_NR_TIME);
+			       info->drv_data->map[REG_RTC_SEC],
+			       data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read time reg(%d)\n", __func__,	ret);
 		goto out;
@@ -192,7 +256,8 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	mutex_lock(&info->lock);
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_RTC_SEC, data, RTC_NR_TIME);
+				info->drv_data->map[REG_RTC_SEC],
+				data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write time reg(%d)\n", __func__,
 				ret);
@@ -211,6 +276,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct max77686_rtc_info *info = dev_get_drvdata(dev);
 	u8 data[RTC_NR_TIME];
 	unsigned int val;
+	const unsigned int *map = info->drv_data->map;
 	int i, ret;
 
 	mutex_lock(&info->lock);
@@ -220,7 +286,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s:%d fail to read alarm reg(%d)\n",
 				__func__, __LINE__, ret);
@@ -258,6 +324,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 	u8 data[RTC_NR_TIME];
 	int ret, i;
 	struct rtc_time tm;
+	const unsigned int *map = info->drv_data->map;
 
 	if (!mutex_is_locked(&info->lock))
 		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
@@ -267,7 +334,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
@@ -280,7 +347,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 		data[i] &= ~ALARM_ENABLE_MASK;
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -297,6 +364,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 	u8 data[RTC_NR_TIME];
 	int ret;
 	struct rtc_time tm;
+	const unsigned int *map = info->drv_data->map;
 
 	if (!mutex_is_locked(&info->lock))
 		dev_warn(info->dev, "%s: should have mutex locked\n", __func__);
@@ -306,7 +374,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
@@ -327,7 +395,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -356,7 +424,8 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		goto out;
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				info->drv_data->map[REG_ALARM1_SEC],
+				data, RTC_NR_TIME);
 
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
@@ -422,7 +491,8 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 	info->rtc_24hr_mode = 1;
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				MAX77686_RTC_CONTROLM, data, ARRAY_SIZE(data));
+				info->drv_data->map[REG_RTC_CONTROLM],
+				data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write controlm reg(%d)\n",
 				__func__, ret);
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
