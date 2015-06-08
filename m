Return-Path: <rtc-linux+bncBDMOV25X7AMRB2WY26VQKGQEJBGV2IY@googlegroups.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com. [66.63.167.143])
        by gmr-mx.google.com with ESMTP id xv6si426351pab.2.2015.06.08.12.26.34
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Jun 2015 12:26:34 -0700 (PDT)
Message-ID: <1433791592.2291.83.camel@HansenPartnership.com>
Subject: [rtc-linux] Re: [PATCH] efi: rtc-efi: use correct EFI 'epoch'
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org, roy.franz@linaro.org,
  leif.lindholm@linaro.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
Date: Mon, 08 Jun 2015 12:26:32 -0700
In-Reply-To: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2015-06-08 at 13:27 +0200, Ard Biesheuvel wrote:
> The rtc-efi driver declares that the EFI 'epoch' is 1/1/1998, but
> the UEFI spec does not define it at all. It does define a minimum
> of 1900 for the 'Year' member of the EFI_TIME struct, so let's use
> 1900 as the minimum year and not 1998.
> 
> This prevents rtc_read_time() failures when the RTC that backs the
> EFI time services is set to a date before 1998.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/rtc/rtc-efi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index cb989cd00b14..4a93b0bbf22c 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -25,9 +25,12 @@
>  
>  #define EFI_ISDST (EFI_TIME_ADJUST_DAYLIGHT|EFI_TIME_IN_DAYLIGHT)
>  /*
> - * EFI Epoch is 1/1/1998
> + * The UEFI spec does not literally define an epoch, but it does
> + * define EFI_TIME::Year as having a value between 1900 and 9999.
> + * (UEFI spec v2.5 paragraph 7.3)
> + * So let's use 1900 as the EFI epoch year.
>   */
> -#define EFI_RTC_EPOCH		1998
> +#define EFI_RTC_EPOCH		1900
>  
>  /*
>   * returns day of the year [0-365]
> @@ -40,8 +43,6 @@ compute_yday(efi_time_t *eft)
>  }
>  /*
>   * returns day of the week [0-6] 0=Sunday
> - *
> - * Don't try to provide a year that's before 1998, please !
>   */
>  static int
>  compute_wday(efi_time_t *eft)
> @@ -60,9 +61,9 @@ compute_wday(efi_time_t *eft)
>  	ndays += compute_yday(eft);
>  
>  	/*
> -	 * 4=1/1/1998 was a Thursday
> +	 * 1=1/1/1900 was a Monday
>  	 */
> -	return (ndays + 4) % 7;
> +	return (ndays + 1) % 7;
>  }

This is a bit nuts: increasing the for loop by a huge amount every time
we call the date just so we can cope with the odd early date.  Why not
just count backwards for the exception case?  That way the epoch becomes
an optimisation point, every year actually works, but years far before
the epoch get penalised in the loop, while our current "efficiency"
remains ... perhaps plus points if we want to move the epoch to 2015?

James

---

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index cb989cd..73f1ba6 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -40,8 +40,6 @@ compute_yday(efi_time_t *eft)
 }
 /*
  * returns day of the week [0-6] 0=Sunday
- *
- * Don't try to provide a year that's before 1998, please !
  */
 static int
 compute_wday(efi_time_t *eft)
@@ -49,16 +47,25 @@ compute_wday(efi_time_t *eft)
 	int y;
 	int ndays = 0;
 
-	if (eft->year < EFI_RTC_EPOCH) {
-		pr_err("EFI year < " __stringify(EFI_RTC_EPOCH) ", invalid date\n");
-		return -1;
+	if (unlikely(eft->year < EFI_RTC_EPOCH)) {
+		/* unlikely event, just count backwards */
+		for (y = eft->year; y < EFI_RTC_EPOCH; y++)
+			ndays -= 365 + (is_leap_year(y) ? 1 : 0);
+	} else {
+		for (y = EFI_RTC_EPOCH; y < eft->year; y++)
+			ndays += 365 + (is_leap_year(y) ? 1 : 0);
 	}
 
-	for (y = EFI_RTC_EPOCH; y < eft->year; y++)
-		ndays += 365 + (is_leap_year(y) ? 1 : 0);
-
 	ndays += compute_yday(eft);
 
+	if (ndays < 0)
+		/* 
+		 * make ndays positive by adding a multiple of seven because
+		 * clock arithmetic using % doesn't work with negative
+		 * numbers
+		 */
+		ndays += ((-ndays)/7 + 1)*7;
+
 	/*
 	 * 4=1/1/1998 was a Thursday
 	 */


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
