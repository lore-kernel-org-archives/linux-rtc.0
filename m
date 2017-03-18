Return-Path: <rtc-linux+bncBDRZXY4CYYORBEPUWTDAKGQEBKTSO7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id u134si505741ywg.2.2017.03.18.06.45.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 06:45:53 -0700 (PDT)
From: Hans de Goede <hdegoede@redhat.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	the.dr.hax@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: cmos: Do not assume irq 8 for rtc when there
 are no legacy irqs
Date: Sat, 18 Mar 2017 14:45:49 +0100
Message-Id: <20170318134549.28052-1-hdegoede@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On some systems (e.g. Intel Bay Trail systems) the legacy PIC is not
used, in this case virq 8 will be a random irq, rather then hw_irq 8
from the PIC.

Requesting virq 8 in this case will not help us to get alarm irqs and
may cause problems for other drivers which actually do need virq 8,
for example on an Asus Transformer T100TA this leads to:

[ 28.745155] genirq: Flags mismatch irq 8. 00000088 (mmc0) vs. 00000080 (rtc0)
<snip oops>
[ 28.753700] mmc0: Failed to request IRQ 8: -16
[ 28.975934] sdhci-acpi: probe of 80860F14:01 failed with error -16

This commit fixes this by making the rtc-cmos driver continue
without using an irq rather then claiming irq 8 when no irq is
specified in the pnp-info and there are no legacy-irqs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/rtc/rtc-cmos.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f4a96db..b3de973 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -41,6 +41,9 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#ifdef CONFIG_X86
+#include <asm/i8259.h>
+#endif
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <linux/mc146818rtc.h>
@@ -1193,17 +1196,23 @@ static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 {
 	cmos_wake_setup(&pnp->dev);
 
-	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0))
+	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
+		unsigned int irq = 0;
+#ifdef CONFIG_X86
 		/* Some machines contain a PNP entry for the RTC, but
 		 * don't define the IRQ. It should always be safe to
-		 * hardcode it in these cases
+		 * hardcode it on systems with a legacy PIC.
 		 */
+		if (nr_legacy_irqs())
+			irq = 8;
+#endif
 		return cmos_do_probe(&pnp->dev,
-				pnp_get_resource(pnp, IORESOURCE_IO, 0), 8);
-	else
+				pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
+	} else {
 		return cmos_do_probe(&pnp->dev,
 				pnp_get_resource(pnp, IORESOURCE_IO, 0),
 				pnp_irq(pnp, 0));
+	}
 }
 
 static void cmos_pnp_remove(struct pnp_dev *pnp)
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
