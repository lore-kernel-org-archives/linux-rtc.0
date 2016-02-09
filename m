Return-Path: <rtc-linux+bncBD2OLRXW4ABBBDWI5C2QKGQEW6W4BCI@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ui7si5198022pab.0.2016.02.09.09.38.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 09:38:22 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V7 1/5] rtc: max77686: fix checkpatch error
Date: Tue, 9 Feb 2016 22:56:30 +0530
Message-ID: <1455038794-9921-2-git-send-email-ldewangan@nvidia.com>
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

Fix following check patch error in rtc-max77686 driver:
- Alignment should match open parenthesis.
- braces {} should be used on all arms of this statement.
- Prefer using the BIT macro

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

Changes from V1:
None

Changes from V1:
None, become 2nd on series.

Changes from V5:
None

Changes from V6:
Make this as 1st of series as regmap change applied independently.

 drivers/rtc/rtc-max77686.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 0f2965d..7f1ca10 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -24,20 +24,20 @@
 
 /* RTC Control Register */
 #define BCD_EN_SHIFT			0
-#define BCD_EN_MASK			(1 << BCD_EN_SHIFT)
+#define BCD_EN_MASK			BIT(BCD_EN_SHIFT)
 #define MODEL24_SHIFT			1
-#define MODEL24_MASK			(1 << MODEL24_SHIFT)
+#define MODEL24_MASK			BIT(MODEL24_SHIFT)
 /* RTC Update Register1 */
 #define RTC_UDR_SHIFT			0
-#define RTC_UDR_MASK			(1 << RTC_UDR_SHIFT)
+#define RTC_UDR_MASK			BIT(RTC_UDR_SHIFT)
 #define RTC_RBUDR_SHIFT			4
-#define RTC_RBUDR_MASK			(1 << RTC_RBUDR_SHIFT)
+#define RTC_RBUDR_MASK			BIT(RTC_RBUDR_SHIFT)
 /* RTC Hour register */
 #define HOUR_PM_SHIFT			6
-#define HOUR_PM_MASK			(1 << HOUR_PM_SHIFT)
+#define HOUR_PM_MASK			BIT(HOUR_PM_SHIFT)
 /* RTC Alarm Enable */
 #define ALARM_ENABLE_SHIFT		7
-#define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
+#define ALARM_ENABLE_MASK		BIT(ALARM_ENABLE_SHIFT)
 
 #define REG_RTC_NONE			0xdeadbeef
 
@@ -205,9 +205,9 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 
 	tm->tm_sec = data[RTC_SEC] & mask;
 	tm->tm_min = data[RTC_MIN] & mask;
-	if (info->rtc_24hr_mode)
+	if (info->rtc_24hr_mode) {
 		tm->tm_hour = data[RTC_HOUR] & 0x1f;
-	else {
+	} else {
 		tm->tm_hour = data[RTC_HOUR] & 0x0f;
 		if (data[RTC_HOUR] & HOUR_PM_MASK)
 			tm->tm_hour += 12;
@@ -256,7 +256,7 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
 }
 
 static int max77686_rtc_update(struct max77686_rtc_info *info,
-	enum MAX77686_RTC_OP op)
+			       enum MAX77686_RTC_OP op)
 {
 	int ret;
 	unsigned int data;
@@ -547,7 +547,7 @@ out:
 }
 
 static int max77686_rtc_alarm_irq_enable(struct device *dev,
-					unsigned int enabled)
+					 unsigned int enabled)
 {
 	struct max77686_rtc_info *info = dev_get_drvdata(dev);
 	int ret;
@@ -612,7 +612,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	int ret;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct max77686_rtc_info),
-				GFP_KERNEL);
+			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -662,7 +662,8 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
-				max77686_rtc_alarm_irq, 0, "rtc-alarm1", info);
+					max77686_rtc_alarm_irq, 0,
+					"rtc-alarm1", info);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			info->virq, ret);
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
