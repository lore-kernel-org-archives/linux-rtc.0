Return-Path: <rtc-linux+bncBD747RFBYUPBB3EJXCYQKGQE4K5D4OA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id pe1si3458579pac.2.2015.10.26.03.48.12
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Oct 2015 03:48:12 -0700 (PDT)
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWT02U6IQ0B0WA0@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 26 Oct 2015 19:48:11 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: lee.jones@linaro.org, broonie@kernel.org
Cc: k.kozlowski@samsung.com, mturquette@baylibre.com,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Date: Mon, 26 Oct 2015 16:06:43 +0530
Message-id: <1445855803-26973-6-git-send-email-alim.akhtar@samsung.com>
In-reply-to: <1445855803-26973-1-git-send-email-alim.akhtar@samsung.com>
References: <1445855803-26973-1-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

RTC found in s2mps15 is almost same as one found in s2mps14.
This patch add required changes to enable s2mps15 rtc timer.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/rtc/rtc-s5m.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index f2504b4eef34..ac3286a267ba 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -188,6 +188,7 @@ static inline int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
 		ret = regmap_read(info->regmap, S5M_RTC_STATUS, &val);
 		val &= S5M_ALARM0_STATUS;
 		break;
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		ret = regmap_read(info->s5m87xx->regmap_pmic, S2MPS14_REG_ST2,
@@ -253,6 +254,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 		data &= ~S5M_RTC_TIME_EN_MASK;
 		break;
 	case S2MPS14X:
+	case S2MPS15X:
 		data |= S2MPS_RTC_RUDR_MASK;
 		break;
 	case S2MPS13X:
@@ -317,7 +319,8 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	u8 data[info->regs->regs_count];
 	int ret;
 
-	if (info->device_type == S2MPS14X || info->device_type == S2MPS13X) {
+	if (info->device_type == S2MPS14X || info->device_type == S2MPS15X ||
+						info->device_type == S2MPS13X) {
 		ret = regmap_update_bits(info->regmap,
 				info->regs->rtc_udr_update,
 				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
@@ -339,6 +342,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		break;
 
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		s5m8767_data_to_tm(data, tm, info->rtc_24hr_mode);
@@ -366,6 +370,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		s5m8763_tm_to_data(tm, data);
 		break;
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		ret = s5m8767_tm_to_data(tm, data);
@@ -414,6 +419,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		break;
 
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		s5m8767_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
@@ -463,6 +469,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 		break;
 
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		for (i = 0; i < info->regs->regs_count; i++)
@@ -508,6 +515,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 		break;
 
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		data[RTC_SEC] |= ALARM_ENABLE_MASK;
@@ -548,6 +556,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		break;
 
 	case S5M8767X:
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		s5m8767_tm_to_data(&alrm->time, data);
@@ -631,6 +640,7 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 		ret = regmap_raw_write(info->regmap, S5M_ALARM0_CONF, data, 2);
 		break;
 
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
@@ -679,6 +689,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MPS15X:
 	case S2MPS14X:
 	case S2MPS13X:
 		regmap_cfg = &s2mps14_rtc_regmap_config;
@@ -805,6 +816,7 @@ static const struct platform_device_id s5m_rtc_id[] = {
 	{ "s5m-rtc",		S5M8767X },
 	{ "s2mps13-rtc",	S2MPS13X },
 	{ "s2mps14-rtc",	S2MPS14X },
+	{ "s2mps15-rtc",	S2MPS15X },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, s5m_rtc_id);
-- 
1.7.10.4

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
