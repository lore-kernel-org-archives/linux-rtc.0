Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSV2TTAAKGQEJE5CB5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id y131si136084wmb.1.2016.10.19.00.14.18
        for <rtc-linux@googlegroups.com>;
        Wed, 19 Oct 2016 00:14:18 -0700 (PDT)
Date: Wed, 19 Oct 2016 09:14:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Kim <andrew.kim@intel.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: add century field data boundary
Message-ID: <20161019071417.jiavk2pzy6k3q5m5@piout.net>
References: <1475604278-51703-1-git-send-email-andrew.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475604278-51703-1-git-send-email-andrew.kim@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

You should probably copy the x86 maintainers as part of that patch
touches code for that architecture.

On 04/10/2016 at 11:04:38 -0700, Andrew Kim wrote :
> According to ACPI specification, the century field data
> should be ranged 0-63. so if it's over this range, it could
> cause system RTC settings error including alarmwakeup settings.
> So it's required to have this boundary for safe RTC init settings.
> 
> Signed-off-by: Andrew Kim <andrew.kim@intel.com>
> ---
>  arch/x86/kernel/rtc.c          | 7 +++++--
>  drivers/rtc/rtc-mc146818-lib.c | 7 +++++--
>  include/linux/mc146818rtc.h    | 2 ++
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index 79c6311c..feac180 100644
> --- a/arch/x86/kernel/rtc.c
> +++ b/arch/x86/kernel/rtc.c
> @@ -84,8 +84,11 @@ void mach_get_cmos_time(struct timespec *now)
>  
>  #ifdef CONFIG_ACPI
>  	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
> -	    acpi_gbl_FADT.century)
> -		century = CMOS_READ(acpi_gbl_FADT.century);
> +	    acpi_gbl_FADT.century) {
> +		if ((century = CMOS_READ(acpi_gbl_FADT.century)) >


checkpatch complains about using an assignment in an if() which I find
justifiable. Can you change that?


> +			RTC_CENTURY_LIMIT)
> +			century = 0;
> +	}
>  #endif
>  
>  	status = CMOS_READ(RTC_CONTROL);
> diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
> index 2f1772a..1d83c2c 100644
> --- a/drivers/rtc/rtc-mc146818-lib.c
> +++ b/drivers/rtc/rtc-mc146818-lib.c
> @@ -61,8 +61,11 @@ unsigned int mc146818_get_time(struct rtc_time *time)
>  #endif
>  #ifdef CONFIG_ACPI
>  	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
> -	    acpi_gbl_FADT.century)
> -		century = CMOS_READ(acpi_gbl_FADT.century);
> +	    acpi_gbl_FADT.century) {
> +		if ((century = CMOS_READ(acpi_gbl_FADT.century)) >
> +			RTC_CENTURY_LIMIT)
> +			century = 0;
> +	}
>  #endif
>  	ctrl = CMOS_READ(RTC_CONTROL);
>  	spin_unlock_irqrestore(&rtc_lock, flags);
> diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
> index a585b4b..199065a 100644
> --- a/include/linux/mc146818rtc.h
> +++ b/include/linux/mc146818rtc.h
> @@ -122,6 +122,8 @@ struct cmos_rtc_board_info {
>  #define RTC_IO_EXTENT_USED      RTC_IO_EXTENT
>  #endif /* ARCH_RTC_LOCATION */
>  
> +#define RTC_CENTURY_LIMIT 0x3F
> +
>  unsigned int mc146818_get_time(struct rtc_time *time);
>  int mc146818_set_time(struct rtc_time *time);
>  
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
