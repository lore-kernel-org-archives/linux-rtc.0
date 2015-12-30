Return-Path: <rtc-linux+bncBDKZNNNLXAHBBFXSRS2AKGQE2YIVVZY@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id t69si3375950pfi.1.2015.12.29.17.53.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Dec 2015 17:53:26 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O05004KWEKY1QA0@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 30 Dec 2015 01:53:22 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: s5m: Add separate field for storing
 auto-cleared mask in register config
Date: Wed, 30 Dec 2015 10:53:04 +0900
Message-id: <1451440385-8654-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1451440385-8654-1-git-send-email-k.kozlowski@samsung.com>
References: <1451440385-8654-1-git-send-email-k.kozlowski@samsung.com>
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

Some devices from S2M/S5M family use different register update masks for
different operations (alarm and register update). Now the driver uses
common register configuration and a lot of exceptions per device in code.

Before eliminating the exceptions and using specific register
configuration for given device, make the auto-cleared mask a separate
field. This is merely a refactoring.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s5m.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 85649861a6b0..559db8f72117 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -56,6 +56,8 @@ struct s5m_rtc_reg_config {
 	 * auto-cleared after successful update.
 	 */
 	unsigned int udr_update;
+	/* Auto-cleared mask in UDR field for writing time and alarm */
+	unsigned int autoclear_udr_mask;
 	/* Mask for UDR field in 'udr_update' register */
 	unsigned int udr_mask;
 };
@@ -68,6 +70,7 @@ static const struct s5m_rtc_reg_config s5m_rtc_regs = {
 	.alarm0			= S5M_ALARM0_SEC,
 	.alarm1			= S5M_ALARM1_SEC,
 	.udr_update		= S5M_RTC_UDR_CON,
+	.autoclear_udr_mask	= S5M_RTC_UDR_MASK,
 	.udr_mask		= S5M_RTC_UDR_MASK,
 };
 
@@ -82,6 +85,7 @@ static const struct s5m_rtc_reg_config s2mps_rtc_regs = {
 	.alarm0			= S2MPS_ALARM0_SEC,
 	.alarm1			= S2MPS_ALARM1_SEC,
 	.udr_update		= S2MPS_RTC_UDR_CON,
+	.autoclear_udr_mask	= S2MPS_RTC_WUDR_MASK,
 	.udr_mask		= S2MPS_RTC_WUDR_MASK,
 };
 
@@ -167,7 +171,7 @@ static inline int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
 
 	do {
 		ret = regmap_read(info->regmap, info->regs->udr_update, &data);
-	} while (--retry && (data & info->regs->udr_mask) && !ret);
+	} while (--retry && (data & info->regs->autoclear_udr_mask) && !ret);
 
 	if (!retry)
 		dev_err(info->dev, "waiting for UDR update, reached max number of retries\n");
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
