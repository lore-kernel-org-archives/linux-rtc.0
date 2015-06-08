Return-Path: <rtc-linux+bncBDYNJBOFRECBBUHP26VQKGQE5GLP2JY@googlegroups.com>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by gmr-mx.google.com with ESMTPS id x12si711808igx.1.2015.06.08.13.15.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 13:15:11 -0700 (PDT)
Received: by mail-ig0-f176.google.com with SMTP id sb11so1115372igb.0
        for <rtc-linux@googlegroups.com>; Mon, 08 Jun 2015 13:15:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433791592.2291.83.camel@HansenPartnership.com>
References: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
	<1433791592.2291.83.camel@HansenPartnership.com>
Date: Mon, 8 Jun 2015 22:15:11 +0200
Message-ID: <CAKv+Gu-e03H7nP5UOoSR++CkAt96qsVz1YaR4K8wRPhg7LpEqQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] efi: rtc-efi: use correct EFI 'epoch'
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matt Fleming <matt.fleming@intel.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Roy Franz <roy.franz@linaro.org>,
	Leif Lindholm <leif.lindholm@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
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

On 8 June 2015 at 21:26, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2015-06-08 at 13:27 +0200, Ard Biesheuvel wrote:
>> The rtc-efi driver declares that the EFI 'epoch' is 1/1/1998, but
>> the UEFI spec does not define it at all. It does define a minimum
>> of 1900 for the 'Year' member of the EFI_TIME struct, so let's use
>> 1900 as the minimum year and not 1998.
>>
>> This prevents rtc_read_time() failures when the RTC that backs the
>> EFI time services is set to a date before 1998.
>>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: rtc-linux@googlegroups.com
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/rtc/rtc-efi.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
>> index cb989cd00b14..4a93b0bbf22c 100644
>> --- a/drivers/rtc/rtc-efi.c
>> +++ b/drivers/rtc/rtc-efi.c
>> @@ -25,9 +25,12 @@
>>
>>  #define EFI_ISDST (EFI_TIME_ADJUST_DAYLIGHT|EFI_TIME_IN_DAYLIGHT)
>>  /*
>> - * EFI Epoch is 1/1/1998
>> + * The UEFI spec does not literally define an epoch, but it does
>> + * define EFI_TIME::Year as having a value between 1900 and 9999.
>> + * (UEFI spec v2.5 paragraph 7.3)
>> + * So let's use 1900 as the EFI epoch year.
>>   */
>> -#define EFI_RTC_EPOCH                1998
>> +#define EFI_RTC_EPOCH                1900
>>
>>  /*
>>   * returns day of the year [0-365]
>> @@ -40,8 +43,6 @@ compute_yday(efi_time_t *eft)
>>  }
>>  /*
>>   * returns day of the week [0-6] 0=Sunday
>> - *
>> - * Don't try to provide a year that's before 1998, please !
>>   */
>>  static int
>>  compute_wday(efi_time_t *eft)
>> @@ -60,9 +61,9 @@ compute_wday(efi_time_t *eft)
>>       ndays += compute_yday(eft);
>>
>>       /*
>> -      * 4=1/1/1998 was a Thursday
>> +      * 1=1/1/1900 was a Monday
>>        */
>> -     return (ndays + 4) % 7;
>> +     return (ndays + 1) % 7;
>>  }
>
> This is a bit nuts: increasing the for loop by a huge amount every time
> we call the date just so we can cope with the odd early date.  Why not
> just count backwards for the exception case?  That way the epoch becomes
> an optimisation point, every year actually works, but years far before
> the epoch get penalised in the loop, while our current "efficiency"
> remains ... perhaps plus points if we want to move the epoch to 2015?
>

The 'epoch' is defined by the UEFI spec as starting at 1900, and
changing it to 2015 to optimize this for loop is equally silly imo.
Note that the core purpose of the patch is to change the cutoff point
below which years are rejected, but that context does not appear in
the diff.

rtc_time64_to_tm() already has a better way of counting the leap days
between two years. I'd be happy to propose a followup patch that gets
rid of the for loop entirely.
But those are two separate issues imo.

-- 
Ard.

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
