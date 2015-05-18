Return-Path: <rtc-linux+bncBAABBUXK42VAKGQEBI43BOQ@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id p12si335874wiv.1.2015.05.18.02.48.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 May 2015 02:48:01 -0700 (PDT)
Date: Mon, 18 May 2015 11:47:55 +0200
From: Borislav Petkov <bp@suse.de>
To: Adrian Huang <adrianhuang0701@gmail.com>, diego.ercolani@gmail.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Brecht Machiels <brecht@mos6581.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>, Egbert Eich <eich@suse.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
Message-ID: <20150518094755.GC23662@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 08, 2015 at 05:34:25PM +0800, Adrian Huang wrote:
> Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
> added a special quirk is not needed because PATCH [2/2] of this
> patchset makes the kernel more robust:
> rtc: restore the RTC alarm time to the configured alarm time in BIOS
> Setup
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/rtc/rtc-cmos.c | 52 --------------------------------------------------
>  1 file changed, 52 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index a82556a..9754564 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -29,8 +29,6 @@
>   * other drivers and utilities on correctly configured systems.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -41,7 +39,6 @@
>  #include <linux/pm.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> -#include <linux/dmi.h>
>  
>  /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
>  #include <asm-generic/rtc.h>
> @@ -380,50 +377,6 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	return 0;
>  }
>  
> -/*
> - * Do not disable RTC alarm on shutdown - workaround for b0rked BIOSes.
> - */
> -static bool alarm_disable_quirk;
> -
> -static int __init set_alarm_disable_quirk(const struct dmi_system_id *id)
> -{
> -	alarm_disable_quirk = true;
> -	pr_info("BIOS has alarm-disable quirk - RTC alarms disabled\n");
> -	return 0;
> -}
> -
> -static const struct dmi_system_id rtc_quirks[] __initconst = {
> -	/* https://bugzilla.novell.com/show_bug.cgi?id=805740 */
> -	{
> -		.callback = set_alarm_disable_quirk,
> -		.ident    = "IBM Truman",
> -		.matches  = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "4852570"),
> -		},

So, your series really fix the reboot issue on this already notoriously
buggy box.

I did try to confirm it 5 times just to be sure and in all 5, the box
remained off.

We're testing another box currently which has the same issue.

Now, for the next version of your patches, I'd ask you to put this patch
second. I.e., you want to introduce the new fix first and *then* remove
the quirk as this way we have a window where no quirk will be in place
and possible bisection will be disturbed needlessly even though we can
help it.

> -	},
> -	/* https://bugzilla.novell.com/show_bug.cgi?id=812592 */
> -	{
> -		.callback = set_alarm_disable_quirk,
> -		.ident    = "Gigabyte GA-990XA-UD3",
> -		.matches  = {
> -			DMI_MATCH(DMI_SYS_VENDOR,
> -					"Gigabyte Technology Co., Ltd."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA-990XA-UD3"),
> -		},

Looking at the bugzilla entry above, that should be Diego's box.

Diego, would you be able to test these patches? They're a better fix
than what I did last year.

If you want me to prepare an openSUSE kernel for you, let me know and
I'll do one. I'd only need to know which distro.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

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
