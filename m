Return-Path: <rtc-linux+bncBCAMRWGQV4CRBV4W7KZAKGQECQMTIDA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.mleia.com (mleia.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id b62si45561wmc.0.2015.12.01.22.10.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 22:10:30 -0800 (PST)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: lpc32xx: remove irq > NR_IRQS check from probe()
Date: Wed,  2 Dec 2015 08:10:28 +0200
Message-Id: <1449036628-20539-1-git-send-email-vz@mleia.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

If the driver is used on an ARM platform with SPARSE_IRQ defined,
semantics of NR_IRQS is different (minimal value of virtual irqs)
and by default it is set to 16, see arch/arm/include/asm/irq.h.

This value may be less than the actual number of virtual irqs, which
may break the driver initialization. The check removal allows to use
the driver on such a platform, and, if irq controller driver works
correctly, the check is not needed on legacy platforms.

Fixes a runtime problem:

  rtc-lpc32xx 40024000.rtc: Can't get interrupt resource

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/rtc/rtc-lpc32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index f923f73..887871c 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -205,7 +205,7 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 	u32 tmp;
 
 	rtcirq = platform_get_irq(pdev, 0);
-	if (rtcirq < 0 || rtcirq >= NR_IRQS) {
+	if (rtcirq < 0) {
 		dev_warn(&pdev->dev, "Can't get interrupt resource\n");
 		rtcirq = -1;
 	}
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
