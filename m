Return-Path: <rtc-linux+bncBDKZNNNLXAHBBYWCSGVAKGQEPWNLCZQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com. [2607:f8b0:400e:c03::234])
        by gmr-mx.google.com with ESMTPS id gu4si792420pac.1.2015.05.01.22.32.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 22:32:18 -0700 (PDT)
Received: by mail-pa0-x234.google.com with SMTP id tp1so109671733pab.2
        for <rtc-linux@googlegroups.com>; Fri, 01 May 2015 22:32:18 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: s3c: Integrate Exynos3250 into S3C6410
Date: Sat,  2 May 2015 14:31:49 +0900
Message-Id: <1430544709-12852-1-git-send-email-k.kozlowski.k@gmail.com>
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

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

There are now no differences between RTC on Exynos3250 and S3C6410.
Merge everything into one so duplicated code could be removed.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---
Changes since v1:
1. Add acks and reviews.
---
 drivers/rtc/rtc-s3c.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 76cbad7a99d3..a0f832362199 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -772,18 +772,6 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
 	.disable		= s3c6410_rtc_disable,
 };
 
-static struct s3c_rtc_data const exynos3250_rtc_data = {
-	.max_user_freq		= 32768,
-	.needs_src_clk		= true,
-	.irq_handler		= s3c6410_rtc_irq,
-	.set_freq		= s3c6410_rtc_setfreq,
-	.enable_tick		= s3c6410_rtc_enable_tick,
-	.save_tick_cnt		= s3c6410_rtc_save_tick_cnt,
-	.restore_tick_cnt	= s3c6410_rtc_restore_tick_cnt,
-	.enable			= s3c24xx_rtc_enable,
-	.disable		= s3c6410_rtc_disable,
-};
-
 static const struct of_device_id s3c_rtc_dt_match[] = {
 	{
 		.compatible = "samsung,s3c2410-rtc",
@@ -799,7 +787,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
 		.data = (void *)&s3c6410_rtc_data,
 	}, {
 		.compatible = "samsung,exynos3250-rtc",
-		.data = (void *)&exynos3250_rtc_data,
+		.data = (void *)&s3c6410_rtc_data,
 	},
 	{ /* sentinel */ },
 };
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
