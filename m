Return-Path: <rtc-linux+bncBDYNJBOFRECBBHXY2WVQKGQECW56T7Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id q10si22501wiz.0.2015.06.08.04.27.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 04:27:26 -0700 (PDT)
Received: by wibdq8 with SMTP id dq8so81515724wib.1
        for <rtc-linux@googlegroups.com>; Mon, 08 Jun 2015 04:27:26 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: matt.fleming@intel.com,
	linux-efi@vger.kernel.org
Cc: roy.franz@linaro.org,
	leif.lindholm@linaro.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] efi: rtc-efi: use correct EFI 'epoch'
Date: Mon,  8 Jun 2015 13:27:14 +0200
Message-Id: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
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
the UEFI spec does not define it at all. It does define a minimum
of 1900 for the 'Year' member of the EFI_TIME struct, so let's use
1900 as the minimum year and not 1998.

This prevents rtc_read_time() failures when the RTC that backs the
EFI time services is set to a date before 1998.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/rtc/rtc-efi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index cb989cd00b14..4a93b0bbf22c 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -25,9 +25,12 @@
 
 #define EFI_ISDST (EFI_TIME_ADJUST_DAYLIGHT|EFI_TIME_IN_DAYLIGHT)
 /*
- * EFI Epoch is 1/1/1998
+ * The UEFI spec does not literally define an epoch, but it does
+ * define EFI_TIME::Year as having a value between 1900 and 9999.
+ * (UEFI spec v2.5 paragraph 7.3)
+ * So let's use 1900 as the EFI epoch year.
  */
-#define EFI_RTC_EPOCH		1998
+#define EFI_RTC_EPOCH		1900
 
 /*
  * returns day of the year [0-365]
@@ -40,8 +43,6 @@ compute_yday(efi_time_t *eft)
 }
 /*
  * returns day of the week [0-6] 0=Sunday
- *
- * Don't try to provide a year that's before 1998, please !
  */
 static int
 compute_wday(efi_time_t *eft)
@@ -60,9 +61,9 @@ compute_wday(efi_time_t *eft)
 	ndays += compute_yday(eft);
 
 	/*
-	 * 4=1/1/1998 was a Thursday
+	 * 1=1/1/1900 was a Monday
 	 */
-	return (ndays + 4) % 7;
+	return (ndays + 1) % 7;
 }
 
 static void
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
