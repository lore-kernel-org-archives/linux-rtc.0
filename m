Return-Path: <rtc-linux+bncBCO3XAUMTIFRBJFX3G4AKGQEMILY3IY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id au10si205527igc.3.2016.04.19.09.24.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 09:24:03 -0700 (PDT)
From: Nishanth Menon <nm@ti.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Michael Lange <linuxstuff@milaw.biz>
Subject: [rtc-linux] [PATCH] rtc: ds1307: Use irq when available for
 wakeup-source device
Date: Tue, 19 Apr 2016 11:23:54 -0500
Message-ID: <1461083034-9227-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

With commit 8bc2a40730ec ("rtc: ds1307: add support for the
DT property 'wakeup-source'") we lost the ability for rtc irq
functionality for devices that are actually hooked on a real IRQ
line and have capability to wakeup as well. This is not an expected
behavior. So, instead of just not requesting IRQ, skip the IRQ
requirement only if interrupts are not defined for the device.

Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Michael Lange <linuxstuff@milaw.biz>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee5bae1..74cd5cd544ee 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1531,7 +1531,7 @@ read_rtc:
 		return PTR_ERR(ds1307->rtc);
 	}
 
-	if (ds1307_can_wakeup_device) {
+	if (ds1307_can_wakeup_device && ds1307->client->irq <= 0) {
 		/* Disable request for an IRQ */
 		want_irq = false;
 		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
-- 
2.8.0

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
