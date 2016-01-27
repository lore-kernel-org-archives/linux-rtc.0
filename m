Return-Path: <rtc-linux+bncBDKZNNNLXAHBBRWPUG2QKGQEFLYRCEY@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ui7si606738pab.0.2016.01.26.22.46.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 22:46:29 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L00GWPMTDOI10@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 06:46:25 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andi Shyti <andi.shyti@samsung.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH] rtc: max77686: Cleanup and reduce dmesg output
Date: Wed, 27 Jan 2016 15:46:11 +0900
Message-id: <1453877171-30510-1-git-send-email-k.kozlowski@samsung.com>
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

Cleanup of entire driver of its dmesg output:
1. Remove printing of the function name, because printing device name is
   sufficient. This also makes the dev_err()-like functions more compact
   and readable (not need of line break).
2. Lower from info to debug printing of each RTC interrupt (no need to
   make noise on each alarm).
3. Remove dev_info() at beginning of probe because a message is already
   always printed by either probe failure or from registering the RTC
   device as /dev/rtcX.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Patch rebased on top of Javier's v4:
[PATCH v4 00/10] rtc: max77686: Extend driver and add max77802 support
http://www.spinics.net/lists/arm-kernel/msg477194.html

Feel free to join with these series.
---
 drivers/rtc/rtc-max77686.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index da47b1d85793..5a03e1ecad83 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -271,8 +271,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
 				 info->drv_data->map[REG_RTC_UPDATE0],
 				 data, data);
 	if (ret < 0)
-		dev_err(info->dev, "%s: fail to write update reg(ret=%d, data=0x%x)\n",
-				__func__, ret, data);
+		dev_err(info->dev, "Fail to write update reg(ret=%d, data=0x%x)\n",
+			ret, data);
 	else {
 		/* Minimum delay required before RTC update. */
 		usleep_range(delay, delay * 2);
@@ -297,7 +297,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			       info->drv_data->map[REG_RTC_SEC],
 			       data, ARRAY_SIZE(data));
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to read time reg(%d)\n", __func__,	ret);
+		dev_err(info->dev, "Fail to read time reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -326,8 +326,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
 				info->drv_data->map[REG_RTC_SEC],
 				data, ARRAY_SIZE(data));
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write time reg(%d)\n", __func__,
-				ret);
+		dev_err(info->dev, "Fail to write time reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -355,8 +354,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ret = regmap_bulk_read(info->max77686->rtc_regmap,
 			       map[REG_ALARM1_SEC], data, ARRAY_SIZE(data));
 	if (ret < 0) {
-		dev_err(info->dev, "%s:%d fail to read alarm reg(%d)\n",
-				__func__, __LINE__, ret);
+		dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -394,8 +392,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->pending = 0;
 	ret = regmap_read(info->max77686->regmap, MAX77686_REG_STATUS2, &val);
 	if (ret < 0) {
-		dev_err(info->dev, "%s:%d fail to read status2 reg(%d)\n",
-				__func__, __LINE__, ret);
+		dev_err(info->dev, "Fail to read status2 reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -426,8 +423,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 				       map[REG_ALARM1_SEC], data,
 				       ARRAY_SIZE(data));
 		if (ret < 0) {
-			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
-				__func__, ret);
+			dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 			goto out;
 		}
 
@@ -452,8 +448,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 	}
 
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
-				__func__, ret);
+		dev_err(info->dev, "Fail to write alarm reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -481,8 +476,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 				       map[REG_ALARM1_SEC], data,
 				       ARRAY_SIZE(data));
 		if (ret < 0) {
-			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
-				__func__, ret);
+			dev_err(info->dev, "Fail to read alarm reg(%d)\n", ret);
 			goto out;
 		}
 
@@ -508,8 +502,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 	}
 
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
-				__func__, ret);
+		dev_err(info->dev, "Fail to write alarm reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -539,8 +532,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 				data, ARRAY_SIZE(data));
 
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
-				__func__, ret);
+		dev_err(info->dev, "Fail to write alarm reg(%d)\n", ret);
 		goto out;
 	}
 
@@ -575,7 +567,7 @@ static irqreturn_t max77686_rtc_alarm_irq(int irq, void *data)
 {
 	struct max77686_rtc_info *info = data;
 
-	dev_info(info->dev, "%s:irq(%d)\n", __func__, irq);
+	dev_dbg(info->dev, "RTC alarm IRQ: %d\n", irq);
 
 	rtc_update_irq(info->rtc_dev, 1, RTC_IRQF | RTC_AF);
 
@@ -605,8 +597,7 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 				info->drv_data->map[REG_RTC_CONTROLM],
 				data, ARRAY_SIZE(data));
 	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to write controlm reg(%d)\n",
-				__func__, ret);
+		dev_err(info->dev, "Fail to write controlm reg(%d)\n", ret);
 		return ret;
 	}
 
@@ -621,8 +612,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	int ret;
 
-	dev_info(&pdev->dev, "%s\n", __func__);
-
 	info = devm_kzalloc(&pdev->dev, sizeof(struct max77686_rtc_info),
 				GFP_KERNEL);
 	if (!info)
@@ -662,7 +651,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 	if (!max77686->rtc_irq_data) {
 		ret = -EINVAL;
-		dev_err(&pdev->dev, "%s: no RTC regmap IRQ chip\n", __func__);
+		dev_err(&pdev->dev, "No RTC regmap IRQ chip\n");
 		goto err_rtc;
 	}
 
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
