Return-Path: <rtc-linux+bncBDKZNNNLXAHBBE6T4WUAKGQE2MSTJGA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id gu4si1130862pac.1.2015.03.30.08.19.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-MD5 bits=128/128);
        Mon, 30 Mar 2015 08:19:47 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NM1007746RN6490@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 30 Mar 2015 16:23:47 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate Exynos3250
 into S3C6410
Date: Mon, 30 Mar 2015 17:19:32 +0200
Message-id: <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
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

There are now no differences between RTC on Exynos3250 and S3C6410.
Merge everything into one so duplicated code could be removed.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index fb0c569765c6..5e162eaad277 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -774,18 +774,6 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
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
@@ -801,7 +789,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
 		.data = (void *)&s3c6410_rtc_data,
 	}, {
 		.compatible = "samsung,exynos3250-rtc",
-		.data = (void *)&exynos3250_rtc_data,
+		.data = (void *)&s3c6410_rtc_data,
 	},
 	{ /* sentinel */ },
 };
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
