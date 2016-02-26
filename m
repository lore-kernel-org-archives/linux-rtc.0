Return-Path: <rtc-linux+bncBAABBEPFYG3AKGQESY22OSA@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id i9si258471igg.1.2016.02.26.07.43.13
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
        Tony Lindgren
	<tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Laxman Dewangan
	<ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH 4/7] rtc: tps65910: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:54 +0200
Message-ID: <1456501377-16871-5-git-send-email-grygorii.strashko@ti.com>
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

tps65910 RTC IRQ is nested threaded and wired to the tps65910 inerrupt
controller. So, this flag is not required for nested irqs anymore,
since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
over system suspend") was merged.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index f42aa2b..5a3d53c 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -268,7 +268,7 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME,
+		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW,
 		dev_name(&pdev->dev), &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
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
