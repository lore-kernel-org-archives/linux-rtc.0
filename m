Return-Path: <rtc-linux+bncBCOML4NU3EDRBUOCUO2AKGQE3W4TBMI@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id 185si2299819wmn.0.2016.01.03.00.52.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:52:32 -0800 (PST)
Subject: [rtc-linux] [PATCH 3/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable initialisation in _abb5zes3_rtc_set_timer()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E14E.2070606@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:52:30 +0100
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
Date: Sun, 3 Jan 2016 07:42:18 +0100

Omit explicit initialisation at the beginning for one local variable
that is redefined before its first use.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index ed9b873..33a7cf1 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -560,7 +560,7 @@ static int _abb5zes3_rtc_set_timer(struct device *dev, struct rtc_wkalrm *alarm,
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ABB5ZES3_TIMA_SEC_LEN];
 	u8 mask = ABB5ZES3_REG_TIM_CLK_TAC0 | ABB5ZES3_REG_TIM_CLK_TAC1;
-	int ret = 0;
+	int ret;
 
 	/* Program given number of seconds to Timer A registers */
 	sec_to_timer_a(secs, &regs[0], &regs[1]);
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
