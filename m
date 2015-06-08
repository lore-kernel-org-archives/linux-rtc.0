Return-Path: <rtc-linux+bncBDCLVB47XQERBQWH2WVQKGQEC37ETRY@googlegroups.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id ct6si240213pdb.1.2015.06.08.02.43.30
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Jun 2015 02:43:30 -0700 (PDT)
From: Sylvain Chouleur <sylvain.chouleur@intel.com>
To: rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] Support of century in rtc-cmos
Date: Mon, 08 Jun 2015 11:45:19 +0200
Message-ID: <87lhfur0sw.fsf@schouleu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

If century field is supported by the RTC CMOS device, then we should use
it and then do not consider years greater that 169 as an error.

For information, the year field of the rtc_time structure contains the
value to add to 1970 to obtain the current year.

This was a hack to be able to support years for 1970 to 2069.
This patch remains compatible with this implementation.

Change-Id: I24af7eabf8efc9043092ad04e61ba69cb761000e
Signed-off-by: Sylvain Chouleur <sylvain.chouleur@intel.com>
---
 include/asm-generic/rtc.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
index fa86f240c874..4e3b6558331e 100644
--- a/include/asm-generic/rtc.h
+++ b/include/asm-generic/rtc.h
@@ -16,6 +16,9 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
@@ -46,6 +49,7 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 {
 	unsigned char ctrl;
 	unsigned long flags;
+	unsigned char century = 0;
 
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
@@ -79,6 +83,11 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 #ifdef CONFIG_MACH_DECSTATION
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 #endif
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		century = CMOS_READ(acpi_gbl_FADT.century);
+#endif
 	ctrl = CMOS_READ(RTC_CONTROL);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
@@ -90,12 +99,16 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 		time->tm_mday = bcd2bin(time->tm_mday);
 		time->tm_mon = bcd2bin(time->tm_mon);
 		time->tm_year = bcd2bin(time->tm_year);
+		century = bcd2bin(century);
 	}
 
 #ifdef CONFIG_MACH_DECSTATION
 	time->tm_year += real_year - 72;
 #endif
 
+	if (century)
+		time->tm_year += (century - 19) * 100;
+
 	/*
 	 * Account for differences between how the RTC uses the values
 	 * and how they are defined in a struct rtc_time;
@@ -122,6 +135,7 @@ static inline int __set_rtc_time(struct rtc_time *time)
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_yrs, leap_yr;
 #endif
+	unsigned char century = 0;
 
 	yrs = time->tm_year;
 	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
@@ -150,6 +164,15 @@ static inline int __set_rtc_time(struct rtc_time *time)
 		yrs = 73;
 	}
 #endif
+
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century) {
+		century = (yrs + 1900) / 100;
+		yrs %= 100;
+	}
+#endif
+
 	/* These limits and adjustments are independent of
 	 * whether the chip is in binary mode or not.
 	 */
@@ -169,6 +192,7 @@ static inline int __set_rtc_time(struct rtc_time *time)
 		day = bin2bcd(day);
 		mon = bin2bcd(mon);
 		yrs = bin2bcd(yrs);
+		century = bin2bcd(century);
 	}
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -185,6 +209,11 @@ static inline int __set_rtc_time(struct rtc_time *time)
 	CMOS_WRITE(hrs, RTC_HOURS);
 	CMOS_WRITE(min, RTC_MINUTES);
 	CMOS_WRITE(sec, RTC_SECONDS);
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		CMOS_WRITE(century, acpi_gbl_FADT.century);
+#endif
 
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
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
