Return-Path: <rtc-linux+bncBAABBD7FYG3AKGQENZZ5RSQ@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id c15si242563igm.1.2016.02.26.07.43.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 07:43:11 -0800 (PST)
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <rtc-linux@googlegroups.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Tony Lindgren <tony@atomide.com>,
        Roger
 Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] [PATCH 1/7] extcon: palmas: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:51 +0200
Message-ID: <1456501377-16871-2-git-send-email-grygorii.strashko@ti.com>
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

Palams extcon IRQs are nested threaded and wired to the Palmas
inerrupt controller. So, this flag is not required for nested irqs
anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
nested_thread irqs over system suspend") was merged.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/extcon/extcon-palmas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 93c30a8..0a861b3 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -266,7 +266,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 				palmas_usb->id_irq,
 				NULL, palmas_id_irq_handler,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas_usb_id", palmas_usb);
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
@@ -304,7 +304,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 				palmas_usb->vbus_irq, NULL,
 				palmas_vbus_irq_handler,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas_usb_vbus", palmas_usb);
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
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
