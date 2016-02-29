Return-Path: <rtc-linux+bncBD2OLRXW4ABBB4MG2G3AKGQEI4TQVOI@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ff2si3912363pad.2.2016.02.29.05.11.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 05:11:13 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <k.kozlowski@samsung.com>, <alexandre.belloni@free-electrons.com>,
	<a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <javier@osg.samsung.com>,
	<rklein@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: max77686: Use REGMAP_IRQ_REG for
 regmap-rtc-irqs initialisation
Date: Mon, 29 Feb 2016 18:28:25 +0530
Message-ID: <1456750705-13579-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
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

use macro REGMAP_IRQ_REG from regmap.h to initialise the
regmap irq table for max77686.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/rtc/rtc-max77686.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 39d529a..0cb422b 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -174,12 +174,12 @@ static const unsigned int max77686_map[REG_RTC_END] = {
 
 static const struct regmap_irq max77686_rtc_irqs[] = {
 	/* RTC interrupts */
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
+	REGMAP_IRQ_REG(0, 0, MAX77686_RTCINT_RTC60S_MSK),
+	REGMAP_IRQ_REG(1, 0, MAX77686_RTCINT_RTCA1_MSK),
+	REGMAP_IRQ_REG(2, 0, MAX77686_RTCINT_RTCA2_MSK),
+	REGMAP_IRQ_REG(3, 0, MAX77686_RTCINT_SMPL_MSK),
+	REGMAP_IRQ_REG(4, 0, MAX77686_RTCINT_RTC1S_MSK),
+	REGMAP_IRQ_REG(5, 0, MAX77686_RTCINT_WTSR_MSK),
 };
 
 static const struct regmap_irq_chip max77686_rtc_irq_chip = {
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
