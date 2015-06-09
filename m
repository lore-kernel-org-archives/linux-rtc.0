Return-Path: <rtc-linux+bncBDYNJBOFRECBBIO73KVQKGQEFPPUFIA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com. [209.85.212.169])
        by gmr-mx.google.com with ESMTPS id ha2si58384wib.1.2015.06.09.02.19.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 02:19:29 -0700 (PDT)
Received: by wibdq8 with SMTP id dq8so9552952wib.1
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 02:19:29 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: matt.fleming@intel.com,
	linux-efi@vger.kernel.org,
	James.Bottomley@hansenpartnership.com
Cc: roy.franz@linaro.org,
	leif.lindholm@linaro.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2] efi: rtc-efi: use correct EFI 'epoch'
Date: Tue,  9 Jun 2015 11:15:35 +0200
Message-Id: <1433841335-10453-1-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
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

The rtc-efi driver declares that the EFI 'epoch' is 1/1/1998, but
the UEFI spec does not define it at all. It does define a range of
[1900, 9999] for the 'Year' member of the EFI_TIME struct, so let's
use 1900 as the minimum year and not 1998.
Also, move the validation of the year to the convert_from_efi_time()
routine where all other EFI_TIME fields are validated as well.

This prevents rtc_read_time() failures when the RTC that backs the
EFI time services is set to a date before 1998, e.g., when it has
lost power.

This also optimizes the compute_wday() routine, by replacing the for
loop with a simple arithmetic expression, and by reusing the yearday
value that we need to compute anyway when populating the
rtc_time::tm_yday field.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2:
- optimize compute_wday() to prevent adding latency to the common case to
  accommodate the exceptional case (i.e., RTC date << present date)
- move year validation to convert_from_efi_time() and check the upper bound
  as well (<= 9999)

 drivers/rtc/rtc-efi.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index cb989cd00b14..6e917e2f5e86 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -24,10 +24,6 @@
 #include <linux/efi.h>
 
 #define EFI_ISDST (EFI_TIME_ADJUST_DAYLIGHT|EFI_TIME_IN_DAYLIGHT)
-/*
- * EFI Epoch is 1/1/1998
- */
-#define EFI_RTC_EPOCH		1998
 
 /*
  * returns day of the year [0-365]
@@ -38,31 +34,24 @@ compute_yday(efi_time_t *eft)
 	/* efi_time_t.month is in the [1-12] so, we need -1 */
 	return rtc_year_days(eft->day, eft->month - 1, eft->year);
 }
+
 /*
  * returns day of the week [0-6] 0=Sunday
- *
- * Don't try to provide a year that's before 1998, please !
  */
 static int
-compute_wday(efi_time_t *eft)
+compute_wday(efi_time_t *eft, int yday)
 {
-	int y;
-	int ndays = 0;
-
-	if (eft->year < EFI_RTC_EPOCH) {
-		pr_err("EFI year < " __stringify(EFI_RTC_EPOCH) ", invalid date\n");
-		return -1;
-	}
-
-	for (y = EFI_RTC_EPOCH; y < eft->year; y++)
-		ndays += 365 + (is_leap_year(y) ? 1 : 0);
-
-	ndays += compute_yday(eft);
+	int ndays = eft->year * (365 % 7)
+		    + (eft->year - 1) / 4
+		    - (eft->year - 1) / 100
+		    + (eft->year - 1) / 400
+		    + yday;
 
 	/*
-	 * 4=1/1/1998 was a Thursday
+	 * 1/1/0000 may or may not have been a Sunday (if it ever existed at
+	 * all) but assuming it was makes this calculation work correctly.
 	 */
-	return (ndays + 4) % 7;
+	return ndays % 7;
 }
 
 static void
@@ -103,16 +92,16 @@ convert_from_efi_time(efi_time_t *eft, struct rtc_time *wtime)
 	if (!eft->month || eft->month > 12)
 		return false;
 	wtime->tm_mon  = eft->month - 1;
-	wtime->tm_year = eft->year - 1900;
 
-	/* day of the week [0-6], Sunday=0 */
-	wtime->tm_wday = compute_wday(eft);
-	if (wtime->tm_wday < 0)
+	if (eft->year < 1900 || eft->year > 9999)
 		return false;
+	wtime->tm_year = eft->year - 1900;
 
 	/* day in the year [1-365]*/
 	wtime->tm_yday = compute_yday(eft);
 
+	/* day of the week [0-6], Sunday=0 */
+	wtime->tm_wday = compute_wday(eft, wtime->tm_yday);
 
 	switch (eft->daylight & EFI_ISDST) {
 	case EFI_ISDST:
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
