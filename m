Return-Path: <rtc-linux+bncBCL4FNGB7UHBBY6A427AKGQEUVVPWSY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id p199si2038090wmd.1.2016.09.14.12.09.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2016 12:09:23 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id 133so1840128wmq.2
        for <rtc-linux@googlegroups.com>; Wed, 14 Sep 2016 12:09:23 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH v3 1/2] rtc-cmos: Clear ACPI-driven alarms upon resume
Date: Wed, 14 Sep 2016 21:08:40 +0200
Message-Id: <20160914190841.10684-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Currently ACPI-driven alarms are not cleared when they wake the
system. As consequence, expired alarms must be manually cleared to
program a new alarm. Fix this by correctly handling ACPI-driven
alarms.

More specifically, the ACPI specification [1] provides for two
alternative implementations of the RTC. Depending on the
implementation, the driver either clear the alarm from the resume
callback or from ACPI interrupt handler:

 - The platform has the RTC wakeup status fixed in hardware
   (ACPI_FADT_FIXED_RTC is 0). In this case the driver can determine
   if the RTC was the reason of the wakeup from the resume callback
   by reading the RTC status register.

 - The platform has no fixed hardware feature event bits. In this
   case a GPE is used to wake the system and the driver clears the
   alarm from its handler.

[1] http://www.acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 1dec52f..6042257 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -939,6 +939,22 @@ static int cmos_resume(struct device *dev)
 			tmp &= ~RTC_AIE;
 			hpet_mask_rtc_irq_bit(RTC_AIE);
 		} while (mask & RTC_AIE);
+
+		if ((tmp & RTC_AIE) &&
+		    !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
+			acpi_status status;
+			acpi_event_status rtc_status;
+
+			status = acpi_get_event_status(ACPI_EVENT_RTC,
+						       &rtc_status);
+			if (ACPI_FAILURE(status)) {
+				dev_err(dev, "Could not get RTC status\n");
+			} else if (rtc_status & ACPI_EVENT_FLAG_SET) {
+				tmp &= ~RTC_AIE;
+				CMOS_WRITE(tmp, RTC_CONTROL);
+				rtc_update_irq(cmos->rtc, 1, mask);
+			}
+		}
 	}
 	spin_unlock_irq(&rtc_lock);
 
@@ -976,6 +992,22 @@ static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
 static u32 rtc_handler(void *context)
 {
 	struct device *dev = context;
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	unsigned char rtc_control;
+	unsigned char rtc_intr;
+
+	spin_lock_irq(&rtc_lock);
+	if (!cmos_rtc.suspend_ctrl)
+		rtc_control = cmos_rtc.suspend_ctrl;
+	else
+		rtc_control = CMOS_READ(RTC_CONTROL);
+	if (rtc_control & RTC_AIE) {
+		cmos_rtc.suspend_ctrl &= ~RTC_AIE;
+		CMOS_WRITE(rtc_control, RTC_CONTROL);
+		rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
+		rtc_update_irq(cmos->rtc, 1, rtc_intr);
+	}
+	spin_unlock_irq(&rtc_lock);
 
 	pm_wakeup_event(dev, 0);
 	acpi_clear_event(ACPI_EVENT_RTC);
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
