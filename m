Return-Path: <rtc-linux+bncBDKZNNNLXAHBBSFVZK2QKGQECMPMI7I@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id 12si1072637pfb.1.2016.02.03.16.26.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Feb 2016 16:26:48 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Z00LL7YKJBX50@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 04 Feb 2016 00:26:43 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Cc: ldewangan@nvidia.com, javier@osg.samsung.com
Subject: [rtc-linux] [PATCH] rtc: max77686: Properly handle
 regmap_irq_get_virq() error code
Date: Thu, 04 Feb 2016 09:26:35 +0900
Message-id: <1454545595-31725-1-git-send-email-k.kozlowski@samsung.com>
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

The regmap_irq_get_virq() can return 0 or -EINVAL in error conditions
but driver checked only for value of 0.

This could lead to a cast of -EINVAL to an unsigned int used as a
interrupt number for devm_request_threaded_irq(). Although this is not
yet fatal (devm_request_threaded_irq() will just fail with -EINVAL) but
might be a misleading when diagnosing errors.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq")

---

Patch rebased on current mainline, not RTC tree, because IMHO it is
a candidate for current RC-cycle.

Not marking cc-stable because behavior is not fatal - unless there is
an interrupt with number 4294967274 (then it would be successfully
requested for RTC driver).
---
 drivers/rtc/rtc-max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7184a0eda793..725dccae24e7 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -465,7 +465,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 	info->virq = regmap_irq_get_virq(max77686->rtc_irq_data,
 					 MAX77686_RTCIRQ_RTCA1);
-	if (!info->virq) {
+	if (info->virq <= 0) {
 		ret = -ENXIO;
 		goto err_rtc;
 	}
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
