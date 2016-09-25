Return-Path: <rtc-linux+bncBDXJRXOM3IKRB7FHT27QKGQEWNNBWCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com. [2607:f8b0:400e:c03::236])
        by gmr-mx.google.com with ESMTPS id f12si3404343pfk.0.2016.09.25.02.08.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 02:08:11 -0700 (PDT)
Received: by mail-pa0-x236.google.com with SMTP id qn7so35654682pac.3
        for <rtc-linux@googlegroups.com>; Sun, 25 Sep 2016 02:08:11 -0700 (PDT)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	baoyou.xie@linaro.org,
	xie.baoyou@zte.com.cn,
	han.fei@zte.com.cn,
	tang.qiang007@zte.com.cn
Subject: [rtc-linux] [PATCH] rtc: rtc-jz4740: remove unused function in rtc-jz4740.c
Date: Sun, 25 Sep 2016 17:07:29 +0800
Message-Id: <1474794449-26185-1-git-send-email-baoyou.xie@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We get 1 warning when building kernel with W=1:
drivers/rtc/rtc-jz4740.c:206:6: warning: no previous prototype for 'jz4740_rtc_poweroff' [-Wmissing-prototypes]

In fact, this function is unused in
drivers/rtc/rtc-jz4740.c, but should be removed.

So this patch removes the unused function.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/rtc/rtc-jz4740.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 5e14651..4788cc0 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -203,13 +203,6 @@ static irqreturn_t jz4740_rtc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-void jz4740_rtc_poweroff(struct device *dev)
-{
-	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
-}
-EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
-
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
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
