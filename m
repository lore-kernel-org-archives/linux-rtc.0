Return-Path: <rtc-linux+bncBCOML4NU3EDRB26EUO2AKGQEP7J3VPY@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.15.3])
        by gmr-mx.google.com with ESMTPS id 202si2322120wmf.2.2016.01.03.00.57.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:57:15 -0800 (PST)
Subject: [rtc-linux] [PATCH 8/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_set_timer()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E268.9090600@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:57:12 +0100
MIME-Version: 1.0
In-Reply-To: <5688DF2D.6090204@users.sourceforge.net>
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:19:32 +0100

Pass a value directly in a call of the function "regmap_update_bits"
instead of an extra initialisation for one local variable at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 88f1d0b..fed52d0 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -561,7 +561,6 @@ static int _abb5zes3_rtc_set_timer(struct device *dev, struct rtc_wkalrm *alarm,
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ABB5ZES3_TIMA_SEC_LEN];
-	u8 mask = ABB5ZES3_REG_TIM_CLK_TAC0 | ABB5ZES3_REG_TIM_CLK_TAC1;
 	int ret;
 
 	/* Program given number of seconds to Timer A registers */
@@ -575,7 +574,9 @@ static int _abb5zes3_rtc_set_timer(struct device *dev, struct rtc_wkalrm *alarm,
 
 	/* Configure Timer A as a watchdog timer */
 	ret = regmap_update_bits(data->regmap, ABB5ZES3_REG_TIM_CLK,
-				 mask, ABB5ZES3_REG_TIM_CLK_TAC1);
+				 ABB5ZES3_REG_TIM_CLK_TAC0
+				 | ABB5ZES3_REG_TIM_CLK_TAC1,
+				 ABB5ZES3_REG_TIM_CLK_TAC1);
 	if (ret)
 		dev_err(dev, "%s: failed to update timer\n", __func__);
 
-- 
2.6.3

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
