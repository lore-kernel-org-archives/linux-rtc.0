Return-Path: <rtc-linux+bncBDEKVJM7XAHRBXEW263AKGQE3WBAZMI@googlegroups.com>
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.130])
        by gmr-mx.google.com with ESMTPS id ff2si4871796pad.2.2016.03.01.09.03.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 09:03:23 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: vr41xx: remove unused function:
Date: Tue,  1 Mar 2016 18:03:12 +0100
Message-Id: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
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

The vr41xx_rtc_alarm_irq_enable function is never called
has no effect other than producing a warning:

drivers/rtc/rtc-vr41xx.c:228:12: error: 'vr41xx_rtc_alarm_irq_enable' defined but not used [-Werror=unused-function]

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-vr41xx.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282275b3..68cb63ef1e44 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -225,24 +225,6 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 	return 0;
 }
 
-static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	spin_lock_irq(&rtc_lock);
-	if (enabled) {
-		if (!alarm_enabled) {
-			enable_irq(aie_irq);
-			alarm_enabled = 1;
-		}
-	} else {
-		if (alarm_enabled) {
-			disable_irq(aie_irq);
-			alarm_enabled = 0;
-		}
-	}
-	spin_unlock_irq(&rtc_lock);
-	return 0;
-}
-
 static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = (struct platform_device *)dev_id;
-- 
2.7.0

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
