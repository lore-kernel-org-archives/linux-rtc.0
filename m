Return-Path: <rtc-linux+bncBD2OLRXW4ABBBEOI5C2QKGQEA2T5IIY@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id ff2si2448934pad.2.2016.02.09.09.38.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 09:38:25 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V7 2/5] rtc: max77686: use rtc regmap to access
 RTC registers
Date: Tue, 9 Feb 2016 22:56:31 +0530
Message-ID: <1455038794-9921-3-git-send-email-ldewangan@nvidia.com>
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

rtc_regmap should be used to access all RTC registers instead
of parent regmap regardless of what chip or property have it.

This makes the register access uniform and extendible for other
chips.

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

Changes from V2:
None

Changes from V3:
None, become 3rd on series.

Changes from V5:
None

Changes from V6:
Make this as 2nd of series as regmap change applied independently.

 drivers/rtc/rtc-max77686.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7f1ca10..28330e8 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -370,7 +370,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 			goto out;
 		}
 
-		ret = regmap_read(info->max77686->regmap,
+		ret = regmap_read(info->max77686->rtc_regmap,
 				  map[REG_RTC_AE1], &val);
 		if (ret < 0) {
 			dev_err(info->dev,
@@ -426,7 +426,8 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
 			goto out;
 		}
 
-		ret = regmap_write(info->max77686->regmap, map[REG_RTC_AE1], 0);
+		ret = regmap_write(info->max77686->rtc_regmap,
+				   map[REG_RTC_AE1], 0);
 	} else {
 		ret = regmap_bulk_read(info->max77686->rtc_regmap,
 				       map[REG_ALARM1_SEC], data,
@@ -471,7 +472,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
 		goto out;
 
 	if (info->drv_data->alarm_enable_reg) {
-		ret = regmap_write(info->max77686->regmap, map[REG_RTC_AE1],
+		ret = regmap_write(info->max77686->rtc_regmap, map[REG_RTC_AE1],
 				   MAX77802_ALARM_ENABLE_VALUE);
 	} else {
 		ret = regmap_bulk_read(info->max77686->rtc_regmap,
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
