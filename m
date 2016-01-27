Return-Path: <rtc-linux+bncBAABBZ7WUC2QKGQEGH6XG2Y@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 190si462289pfb.1.2016.01.26.19.37.11
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 19:37:11 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Andi Shyti <andi.shyti@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [rtc-linux] [PATCH v4 02/10] rtc: max77686: Use ARRAY_SIZE() instead
 of current array length
Date: Wed, 27 Jan 2016 00:36:38 -0300
Message-Id: <1453865806-4661-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
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

It is better to use the ARRAY_SIZE() macro instead of the array length
to avoid bugs if the array is later changed and the length not updated.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

---

Changes in v4:
- Add Andi Shyti's Reviewed-by to patch #2.

Changes in v3:
- Add Krzysztof Kozlowski's Tested-by tag to patch #2.
- Add Laxman Dewangan's Acked-by tag to patch #2.
- Use ARRAY_SIZE() in all places. Suggested by Laxman Dewangan.

Changes in v2:
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #2.

 drivers/rtc/rtc-max77686.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 6653c3d11b66..d84a50c9f7f7 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -149,7 +149,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				MAX77686_RTC_SEC, data, RTC_NR_TIME);
+				MAX77686_RTC_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read time reg(%d)\n", __func__,	ret);
 		goto out;
@@ -177,7 +177,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	mutex_lock(&info->lock);
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_RTC_SEC, data, RTC_NR_TIME);
+				 MAX77686_RTC_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write time reg(%d)\n", __func__,
 				ret);
@@ -205,7 +205,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s:%d fail to read alarm reg(%d)\n",
 				__func__, __LINE__, ret);
@@ -215,7 +215,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	max77686_rtc_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
 
 	alrm->enabled = 0;
-	for (i = 0; i < RTC_NR_TIME; i++) {
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
 		if (data[i] & ALARM_ENABLE_MASK) {
 			alrm->enabled = 1;
 			break;
@@ -252,7 +252,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
@@ -261,11 +261,11 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 
 	max77686_rtc_data_to_tm(data, &tm, info->rtc_24hr_mode);
 
-	for (i = 0; i < RTC_NR_TIME; i++)
+	for (i = 0; i < ARRAY_SIZE(data); i++)
 		data[i] &= ~ALARM_ENABLE_MASK;
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -291,7 +291,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
 				__func__, ret);
@@ -312,7 +312,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
 				__func__, ret);
@@ -341,7 +341,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		goto out;
 
 	ret = regmap_bulk_write(info->max77686->rtc_regmap,
-				 MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
+				 MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
 
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
@@ -406,7 +406,8 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 
 	info->rtc_24hr_mode = 1;
 
-	ret = regmap_bulk_write(info->max77686->rtc_regmap, MAX77686_RTC_CONTROLM, data, 2);
+	ret = regmap_bulk_write(info->max77686->rtc_regmap,
+				MAX77686_RTC_CONTROLM, data, ARRAY_SIZE(data));
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
