Return-Path: <rtc-linux+bncBD2OLRXW4ABBBFOI5C2QKGQEC2KVFFI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id u66si5398473pfa.2.2016.02.09.09.38.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 09:38:29 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V7 3/5] rtc: max77686: avoid reference of parent
 device info multiple places
Date: Tue, 9 Feb 2016 22:56:32 +0530
Message-ID: <1455038794-9921-4-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Get rid of referring parent device info for register access
all the places by making regmap as part of max77686 rtc
device info. This will also remove the need of storing parent
device info in max77686 rtc device info as this is no more required.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Changes from V1:
None, added reviewed/tested by.

Changes form V2:
- Fix typo in description.

Changes form V3:
- None, become 4ths in series.

Changes from V4:
None

Changes from V5:
None

Changes from V6:
Make this as 3rd of series as regmap change applied independently.

 drivers/rtc/rtc-max77686.c | 52 ++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 28330e8..8fe1092 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -74,12 +74,12 @@ struct max77686_rtc_driver_data {
 
 struct max77686_rtc_info {
 	struct device		*dev;
-	struct max77686_dev	*max77686;
 	struct i2c_client	*rtc;
 	struct rtc_device	*rtc_dev;
 	struct mutex		lock;
 
 	struct regmap		*regmap;
+	struct regmap		*rtc_regmap;
 
 	const struct max77686_rtc_driver_data *drv_data;
 
@@ -267,7 +267,7 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
 	else
 		data = 1 << RTC_RBUDR_SHIFT;
 
-	ret = regmap_update_bits(info->max77686->rtc_regmap,
+	ret = regmap_update_bits(info->rtc_regmap,
 				 info->drv_data->map[REG_RTC_UPDATE0],
 				 data, data);
 	if (ret < 0)
@@ -293,7 +293,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_bulk_read(info->max77686->rtc_regmap,
+	ret = regmap_bulk_read(info->rtc_regmap,
 			       info->drv_data->map[REG_RTC_SEC],
 			       data, ARRAY_SIZE(data));
 	if (ret < 0) {
@@ -322,7 +322,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	mutex_lock(&info->lock);
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap,
+	ret = regmap_bulk_write(info->rtc_regmap,
 				info->drv_data->map[REG_RTC_SEC],
 				data, ARRAY_SIZE(data));
 	if (ret < 0) {
@@ -351,8 +351,8 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-			       map[REG_ALARM1_SEC], data, ARRAY_SIZE(data));
+	ret = regmap_bulk_read(info->rtc_regmap, map[REG_ALARM1_SEC],
+			       data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 		goto out;
@@ -370,8 +370,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 			goto out;
 		}
 
-		ret = regmap_read(info->max77686->rtc_regmap,
-				  map[REG_RTC_AE1], &val);
+		ret = regmap_read(info->rtc_regmap, map[REG_RTC_AE1], &val);
 		if (ret < 0) {
 			dev_err(info->dev,
 				"fail to read alarm enable(%d)\n", ret);
@@ -390,7 +389,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	}
 
 	alrm->pending = 0;
-	ret = regmap_read(info->max77686->regmap, MAX77686_REG_STATUS2, &val);
+	ret = regmap_read(info->regmap, MAX77686_REG_STATUS2, &val);
 	if (ret < 0) {
 		dev_err(info->dev, "Fail to read status2 reg(%d)\n", ret);
 		goto out;
@@ -426,12 +425,10 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 			goto out;
 		}
 
-		ret = regmap_write(info->max77686->rtc_regmap,
-				   map[REG_RTC_AE1], 0);
+		ret = regmap_write(info->rtc_regmap, map[REG_RTC_AE1], 0);
 	} else {
-		ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				       map[REG_ALARM1_SEC], data,
-				       ARRAY_SIZE(data));
+		ret = regmap_bulk_read(info->rtc_regmap, map[REG_ALARM1_SEC],
+				       data, ARRAY_SIZE(data));
 		if (ret < 0) {
 			dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 			goto out;
@@ -442,9 +439,8 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 		for (i = 0; i < ARRAY_SIZE(data); i++)
 			data[i] &= ~ALARM_ENABLE_MASK;
 
-		ret = regmap_bulk_write(info->max77686->rtc_regmap,
-					map[REG_ALARM1_SEC], data,
-					ARRAY_SIZE(data));
+		ret = regmap_bulk_write(info->rtc_regmap, map[REG_ALARM1_SEC],
+					data, ARRAY_SIZE(data));
 	}
 
 	if (ret < 0) {
@@ -472,12 +468,11 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	if (info->drv_data->alarm_enable_reg) {
-		ret = regmap_write(info->max77686->rtc_regmap, map[REG_RTC_AE1],
+		ret = regmap_write(info->rtc_regmap, map[REG_RTC_AE1],
 				   MAX77802_ALARM_ENABLE_VALUE);
 	} else {
-		ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				       map[REG_ALARM1_SEC], data,
-				       ARRAY_SIZE(data));
+		ret = regmap_bulk_read(info->rtc_regmap, map[REG_ALARM1_SEC],
+				       data, ARRAY_SIZE(data));
 		if (ret < 0) {
 			dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 			goto out;
@@ -496,9 +491,8 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		if (data[RTC_DATE] & 0x1f)
 			data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
 
-		ret = regmap_bulk_write(info->max77686->rtc_regmap,
-					map[REG_ALARM1_SEC], data,
-					ARRAY_SIZE(data));
+		ret = regmap_bulk_write(info->rtc_regmap, map[REG_ALARM1_SEC],
+					data, ARRAY_SIZE(data));
 	}
 
 	if (ret < 0) {
@@ -527,7 +521,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap,
+	ret = regmap_bulk_write(info->rtc_regmap,
 				info->drv_data->map[REG_ALARM1_SEC],
 				data, ARRAY_SIZE(data));
 
@@ -593,7 +587,7 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 
 	info->rtc_24hr_mode = 1;
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap,
+	ret = regmap_bulk_write(info->rtc_regmap,
 				info->drv_data->map[REG_RTC_CONTROLM],
 				data, ARRAY_SIZE(data));
 	if (ret < 0) {
@@ -619,13 +613,13 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 	info->dev = &pdev->dev;
-	info->max77686 = max77686;
 	info->rtc = max77686->rtc;
 	info->drv_data = (const struct max77686_rtc_driver_data *)
 		id->driver_data;
 
-	if (!info->drv_data->separate_i2c_addr)
-		info->max77686->rtc_regmap = info->max77686->regmap;
+	info->regmap = max77686->regmap;
+	info->rtc_regmap = (info->drv_data->separate_i2c_addr) ?
+			    max77686->rtc_regmap : info->regmap;
 
 	platform_set_drvdata(pdev, info);
 
-- 
2.1.4

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
