Return-Path: <rtc-linux+bncBAABBEPFYG3AKGQESY22OSA@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id xh11si242911igb.0.2016.02.26.07.43.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 07:43:13 -0800 (PST)
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <rtc-linux@googlegroups.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Nishanth Menon
	<nm@ti.com>
Subject: [rtc-linux] [PATCH 5/7] rtc: tps80031: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:55 +0200
Message-ID: <1456501377-16871-6-git-send-email-grygorii.strashko@ti.com>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
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

tps80031 RTC IRQ is nested threaded and wired to the tps80031
inerrupt controller. So, this flag is not required for nested irqs
anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
nested_thread irqs over system suspend") was merged.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-tps80031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps80031.c b/drivers/rtc/rtc-tps80031.c
index 27e254c..737f26e 100644
--- a/drivers/rtc/rtc-tps80031.c
+++ b/drivers/rtc/rtc-tps80031.c
@@ -287,7 +287,7 @@ static int tps80031_rtc_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 			tps80031_rtc_irq,
-			IRQF_ONESHOT | IRQF_EARLY_RESUME,
+			IRQF_ONESHOT,
 			dev_name(&pdev->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request IRQ:%d failed, err = %d\n",
-- 
2.7.2

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
