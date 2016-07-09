Return-Path: <rtc-linux+bncBAABBRU3QO6AKGQE52YB54A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from kozue.soulik.info (kozue.soulik.info. [108.61.200.231])
        by gmr-mx.google.com with ESMTPS id 62si219093pfx.1.2016.07.09.02.24.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jul 2016 02:24:17 -0700 (PDT)
From: Randy Li <ayaka@soulik.info>
To: k.kozlowski@samsung.com
Cc: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Randy Li <ayaka@soulik.info>
Subject: [rtc-linux] [PATCH 1/3] Revert "drivers/rtc/rtc-s3c.c: add
 .needs_src_clk to s3c6410 RTC data"
Date: Sat,  9 Jul 2016 17:23:44 +0800
Message-Id: <1468056226-19128-2-git-send-email-ayaka@soulik.info>
In-Reply-To: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This reverts commit 8792f7772f4f40ffc68bad5f28311205584b734d.
The s3c6410 rtc don't use rtc_src property, that property is designed
for Exynos5250 and Exynos5440. The problem reported in the commit
I mentioned should be fixed in the other way.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/rtc/rtc-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d01ad7e..5dc18ca 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -801,7 +801,6 @@ static struct s3c_rtc_data const s3c2443_rtc_data = {
 
 static struct s3c_rtc_data const s3c6410_rtc_data = {
 	.max_user_freq		= 32768,
-	.needs_src_clk		= true,
 	.irq_handler		= s3c6410_rtc_irq,
 	.set_freq		= s3c6410_rtc_setfreq,
 	.enable_tick		= s3c6410_rtc_enable_tick,
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
