Return-Path: <rtc-linux+bncBAABBEMOT62QKGQE2UTNZLI@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si277282pac.2.2016.01.26.11.20.49
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 11:20:49 -0800 (PST)
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
Subject: [rtc-linux] [PATCH v3 04/10] rtc: max77686: Use a driver data struct
 instead hard-coded values
Date: Tue, 26 Jan 2016 16:20:14 -0300
Message-Id: <1453836020-29579-5-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
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

The driver has some hard-coded values such as the minimum delay needed
before a RTC update or the mask used for the sec/min/hour/etc registers.

Use a data structure that contains these values and pass as driver data
using the platform device ID table for each device.

This allows to make the driver's ops callbacks more generic so other RTC
that are similar but don't have the same values can also be supported.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

---

Changes in v3:
- Fix max77686 delay. Suggested by Krzysztof Kozlowski.
- Assign mask to u8 instead of int. Suggested by Krzysztof Kozlowski.
- Add Laxman Dewangan's Acked-by tag to patch #4.

Changes in v2:
- Add a max77686 prefix to rtc_driver_data. Suggested by Krzysztof Kozlowski.
- Comment about the .delay and .mask fields. Suggested by Krzysztof Kozlowski.
- Change .mask type to u8. Suggested by Krzysztof Kozlowski.
- Make .drv_data field const. Suggested by Krzysztof Kozlowski.
- Don't cast to drop const on .drv_data asign. Suggested by Krzysztof Kozlowski.
- Use platform_get_device_id() macro. Suggested by Krzysztof Kozlowski.

 drivers/rtc/rtc-max77686.c | 51 ++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 025a17a95da3..8c4ca35029c3 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -41,8 +41,6 @@
 #define ALARM_ENABLE_SHIFT		7
 #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
 
-#define MAX77686_RTC_UPDATE_DELAY	16000
-
 enum {
 	RTC_SEC = 0,
 	RTC_MIN,
@@ -54,6 +52,13 @@ enum {
 	RTC_NR_TIME
 };
 
+struct max77686_rtc_driver_data {
+	/* Minimum usecs needed for a RTC update */
+	unsigned long		delay;
+	/* Mask used to read RTC registers value */
+	u8			mask;
+};
+
 struct max77686_rtc_info {
 	struct device		*dev;
 	struct max77686_dev	*max77686;
@@ -63,6 +68,8 @@ struct max77686_rtc_info {
 
 	struct regmap		*regmap;
 
+	const struct max77686_rtc_driver_data *drv_data;
+
 	int virq;
 	int rtc_24hr_mode;
 };
@@ -72,12 +79,19 @@ enum MAX77686_RTC_OP {
 	MAX77686_RTC_READ,
 };
 
+static const struct max77686_rtc_driver_data max77686_drv_data = {
+	.delay = 16000,
+	.mask  = 0x7f,
+};
+
 static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
-				   int rtc_24hr_mode)
+				    struct max77686_rtc_info *info)
 {
-	tm->tm_sec = data[RTC_SEC] & 0x7f;
-	tm->tm_min = data[RTC_MIN] & 0x7f;
-	if (rtc_24hr_mode)
+	u8 mask = info->drv_data->mask;
+
+	tm->tm_sec = data[RTC_SEC] & mask;
+	tm->tm_min = data[RTC_MIN] & mask;
+	if (info->rtc_24hr_mode)
 		tm->tm_hour = data[RTC_HOUR] & 0x1f;
 	else {
 		tm->tm_hour = data[RTC_HOUR] & 0x0f;
@@ -86,10 +100,10 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 	}
 
 	/* Only a single bit is set in data[], so fls() would be equivalent */
-	tm->tm_wday = ffs(data[RTC_WEEKDAY] & 0x7f) - 1;
+	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
 	tm->tm_mday = data[RTC_DATE] & 0x1f;
 	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
-	tm->tm_year = (data[RTC_YEAR] & 0x7f) + 100;
+	tm->tm_year = (data[RTC_YEAR] & mask) + 100;
 	tm->tm_yday = 0;
 	tm->tm_isdst = 0;
 }
@@ -117,6 +131,7 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
 {
 	int ret;
 	unsigned int data;
+	unsigned long delay = info->drv_data->delay;
 
 	if (op == MAX77686_RTC_WRITE)
 		data = 1 << RTC_UDR_SHIFT;
@@ -129,9 +144,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
 		dev_err(info->dev, "%s: fail to write update reg(ret=%d, data=0x%x)\n",
 				__func__, ret, data);
 	else {
-		/* Minimum 16ms delay required before RTC update. */
-		usleep_range(MAX77686_RTC_UPDATE_DELAY,
-			     MAX77686_RTC_UPDATE_DELAY * 2);
+		/* Minimum delay required before RTC update. */
+		usleep_range(delay, delay * 2);
 	}
 
 	return ret;
@@ -156,7 +170,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		goto out;
 	}
 
-	max77686_rtc_data_to_tm(data, tm, info->rtc_24hr_mode);
+	max77686_rtc_data_to_tm(data, tm, info);
 
 	ret = rtc_valid_tm(tm);
 
@@ -213,7 +227,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		goto out;
 	}
 
-	max77686_rtc_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
+	max77686_rtc_data_to_tm(data, &alrm->time, info);
 
 	alrm->enabled = 0;
 	for (i = 0; i < ARRAY_SIZE(data); i++) {
@@ -260,7 +274,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 		goto out;
 	}
 
-	max77686_rtc_data_to_tm(data, &tm, info->rtc_24hr_mode);
+	max77686_rtc_data_to_tm(data, &tm, info);
 
 	for (i = 0; i < ARRAY_SIZE(data); i++)
 		data[i] &= ~ALARM_ENABLE_MASK;
@@ -299,7 +313,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		goto out;
 	}
 
-	max77686_rtc_data_to_tm(data, &tm, info->rtc_24hr_mode);
+	max77686_rtc_data_to_tm(data, &tm, info);
 
 	data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
 	data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
@@ -307,7 +321,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 	data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
 	if (data[RTC_MONTH] & 0xf)
 		data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
-	if (data[RTC_YEAR] & 0x7f)
+	if (data[RTC_YEAR] & info->drv_data->mask)
 		data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
 	if (data[RTC_DATE] & 0x1f)
 		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
@@ -423,6 +437,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *max77686 = dev_get_drvdata(pdev->dev.parent);
 	struct max77686_rtc_info *info;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	int ret;
 
 	dev_info(&pdev->dev, "%s\n", __func__);
@@ -436,6 +451,8 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	info->dev = &pdev->dev;
 	info->max77686 = max77686;
 	info->rtc = max77686->rtc;
+	info->drv_data = (const struct max77686_rtc_driver_data *)
+		id->driver_data;
 
 	platform_set_drvdata(pdev, info);
 
@@ -510,7 +527,7 @@ static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
 			 max77686_rtc_suspend, max77686_rtc_resume);
 
 static const struct platform_device_id rtc_id[] = {
-	{ "max77686-rtc", 0 },
+	{ "max77686-rtc", .driver_data = (kernel_ulong_t)&max77686_drv_data, },
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
