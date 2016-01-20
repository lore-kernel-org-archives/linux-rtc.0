Return-Path: <rtc-linux+bncBAABBO4B762AKGQEI3OGTAA@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si3776049pab.0.2016.01.20.09.15.38
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jan 2016 09:15:38 -0800 (PST)
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
Subject: [rtc-linux] [PATCH 1/8] rtc: max77686: Use ARRAY_SIZE() instead of
 current array length
Date: Wed, 20 Jan 2016 14:14:41 -0300
Message-Id: <1453310088-29985-2-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
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
---

 drivers/rtc/rtc-max77686.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7184a0eda793..9599be257db4 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
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
