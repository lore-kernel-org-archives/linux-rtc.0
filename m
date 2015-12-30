Return-Path: <rtc-linux+bncBDKZNNNLXAHBBE7SRS2AKGQERPPPRHA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id ui7si1556932pab.0.2015.12.29.17.53.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Dec 2015 17:53:23 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O050011JEKVEPA0@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 30 Dec 2015 01:53:19 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [rtc-linux] [PATCH 1/3] rtc: s5m: Cleanup by removing useless 'rtc'
 prefix from fields
Date: Wed, 30 Dec 2015 10:53:03 +0900
Message-id: <1451440385-8654-1-git-send-email-k.kozlowski@samsung.com>
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

Remove the 'rtc' prefix from some of the fields in struct
s5m_rtc_reg_config because it is obvious - this is a RTC driver. No
functional changes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s5m.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 0d68a85dd429..85649861a6b0 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -55,9 +55,9 @@ struct s5m_rtc_reg_config {
 	 * will enable update of time or alarm register. Then it will be
 	 * auto-cleared after successful update.
 	 */
-	unsigned int rtc_udr_update;
-	/* Mask for UDR field in 'rtc_udr_update' register */
-	unsigned int rtc_udr_mask;
+	unsigned int udr_update;
+	/* Mask for UDR field in 'udr_update' register */
+	unsigned int udr_mask;
 };
 
 /* Register map for S5M8763 and S5M8767 */
@@ -67,8 +67,8 @@ static const struct s5m_rtc_reg_config s5m_rtc_regs = {
 	.ctrl			= S5M_ALARM1_CONF,
 	.alarm0			= S5M_ALARM0_SEC,
 	.alarm1			= S5M_ALARM1_SEC,
-	.rtc_udr_update		= S5M_RTC_UDR_CON,
-	.rtc_udr_mask		= S5M_RTC_UDR_MASK,
+	.udr_update		= S5M_RTC_UDR_CON,
+	.udr_mask		= S5M_RTC_UDR_MASK,
 };
 
 /*
@@ -81,8 +81,8 @@ static const struct s5m_rtc_reg_config s2mps_rtc_regs = {
 	.ctrl			= S2MPS_RTC_CTRL,
 	.alarm0			= S2MPS_ALARM0_SEC,
 	.alarm1			= S2MPS_ALARM1_SEC,
-	.rtc_udr_update		= S2MPS_RTC_UDR_CON,
-	.rtc_udr_mask		= S2MPS_RTC_WUDR_MASK,
+	.udr_update		= S2MPS_RTC_UDR_CON,
+	.udr_mask		= S2MPS_RTC_WUDR_MASK,
 };
 
 struct s5m_rtc_info {
@@ -166,9 +166,8 @@ static inline int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
 	unsigned int data;
 
 	do {
-		ret = regmap_read(info->regmap, info->regs->rtc_udr_update,
-				&data);
-	} while (--retry && (data & info->regs->rtc_udr_mask) && !ret);
+		ret = regmap_read(info->regmap, info->regs->udr_update, &data);
+	} while (--retry && (data & info->regs->udr_mask) && !ret);
 
 	if (!retry)
 		dev_err(info->dev, "waiting for UDR update, reached max number of retries\n");
@@ -214,7 +213,7 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 	int ret;
 	unsigned int data;
 
-	ret = regmap_read(info->regmap, info->regs->rtc_udr_update, &data);
+	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to read update reg(%d)\n", ret);
 		return ret;
@@ -223,21 +222,20 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 	switch (info->device_type) {
 	case S5M8763X:
 	case S5M8767X:
-		data |= info->regs->rtc_udr_mask | S5M_RTC_TIME_EN_MASK;
+		data |= info->regs->udr_mask | S5M_RTC_TIME_EN_MASK;
 	case S2MPS15X:
 		/* As per UM, for write time register, set WUDR bit to high */
 		data |= S2MPS15_RTC_WUDR_MASK;
 		break;
 	case S2MPS14X:
 	case S2MPS13X:
-		data |= info->regs->rtc_udr_mask;
+		data |= info->regs->udr_mask;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-
-	ret = regmap_write(info->regmap, info->regs->rtc_udr_update, data);
+	ret = regmap_write(info->regmap, info->regs->udr_update, data);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to write update reg(%d)\n", ret);
 		return ret;
@@ -253,14 +251,14 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 	int ret;
 	unsigned int data;
 
-	ret = regmap_read(info->regmap, info->regs->rtc_udr_update, &data);
+	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to read update reg(%d)\n",
 			__func__, ret);
 		return ret;
 	}
 
-	data |= info->regs->rtc_udr_mask;
+	data |= info->regs->udr_mask;
 	switch (info->device_type) {
 	case S5M8763X:
 	case S5M8767X:
@@ -268,7 +266,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 		break;
 	case S2MPS15X:
 		/* As per UM, for write alarm, set A_UDR(bit[4]) to high
-		 * rtc_udr_mask above sets bit[4]
+		 * udr_mask above sets bit[4]
 		 */
 		break;
 	case S2MPS14X:
@@ -281,7 +279,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 		return -EINVAL;
 	}
 
-	ret = regmap_write(info->regmap, info->regs->rtc_udr_update, data);
+	ret = regmap_write(info->regmap, info->regs->udr_update, data);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write update reg(%d)\n",
 			__func__, ret);
@@ -292,7 +290,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 
 	/* On S2MPS13 the AUDR is not auto-cleared */
 	if (info->device_type == S2MPS13X)
-		regmap_update_bits(info->regmap, info->regs->rtc_udr_update,
+		regmap_update_bits(info->regmap, info->regs->udr_update,
 				   S2MPS13_RTC_AUDR_MASK, 0);
 
 	return ret;
@@ -339,7 +337,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (info->device_type == S2MPS15X || info->device_type == S2MPS14X ||
 			info->device_type == S2MPS13X) {
 		ret = regmap_update_bits(info->regmap,
-				info->regs->rtc_udr_update,
+				info->regs->udr_update,
 				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
 		if (ret) {
 			dev_err(dev,
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
