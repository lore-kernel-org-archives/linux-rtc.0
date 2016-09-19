Return-Path: <rtc-linux+bncBCL4FNGB7UHBB67BQG7QKGQERVVYV3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id 82si1631355wmg.3.2016.09.19.16.12.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2016 16:12:58 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id w84so450423wmg.0
        for <rtc-linux@googlegroups.com>; Mon, 19 Sep 2016 16:12:58 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH v4 1/2] rtc-cmos: Clear ACPI-driven alarms upon resume
Date: Tue, 20 Sep 2016 01:12:43 +0200
Message-Id: <20160919231244.6775-1-gabriele.mzt@gmail.com>
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
 drivers/rtc/rtc-cmos.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 1dec52f..fd7ec0a 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -900,6 +900,9 @@ static inline int cmos_poweroff(struct device *dev)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static void cmos_check_acpi_rtc_status(struct device *dev,
+				       unsigned char *rtc_control);
+
 static int cmos_resume(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
@@ -939,6 +942,9 @@ static int cmos_resume(struct device *dev)
 			tmp &= ~RTC_AIE;
 			hpet_mask_rtc_irq_bit(RTC_AIE);
 		} while (mask & RTC_AIE);
+
+		if (tmp & RTC_AIE)
+			cmos_check_acpi_rtc_status(dev, &tmp);
 	}
 	spin_unlock_irq(&rtc_lock);
 
@@ -976,6 +982,22 @@ static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
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
@@ -1042,12 +1064,39 @@ static void cmos_wake_setup(struct device *dev)
 	device_init_wakeup(dev, 1);
 }
 
+static void cmos_check_acpi_rtc_status(struct device *dev,
+				       unsigned char *rtc_control)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	acpi_event_status rtc_status;
+	acpi_status status;
+
+	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
+		return;
+
+	status = acpi_get_event_status(ACPI_EVENT_RTC, &rtc_status);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Could not get RTC status\n");
+	} else if (rtc_status & ACPI_EVENT_FLAG_SET) {
+		unsigned char mask;
+		*rtc_control &= ~RTC_AIE;
+		CMOS_WRITE(*rtc_control, RTC_CONTROL);
+		mask = CMOS_READ(RTC_INTR_FLAGS);
+		rtc_update_irq(cmos->rtc, 1, mask);
+	}
+}
+
 #else
 
 static void cmos_wake_setup(struct device *dev)
 {
 }
 
+static void cmos_check_acpi_rtc_status(struct device *dev,
+				       unsigned char *rtc_control)
+{
+}
+
 #endif
 
 #ifdef	CONFIG_PNP
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
