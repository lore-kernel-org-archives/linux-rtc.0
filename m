Return-Path: <rtc-linux+bncBCPKXLX44AMBB5P25GUAKGQEELU5YRA@googlegroups.com>
Received: from cvs.linux-mips.org (eddie.linux-mips.org. [148.251.95.138])
        by gmr-mx.google.com with ESMTP id el6si806239wib.0.2015.03.31.03.56.52
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Mar 2015 03:56:52 -0700 (PDT)
Received: from localhost.localdomain ([127.0.0.1]:55960 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009582AbbCaK4v1eI6I (ORCPT
        <rfc822;rtc-linux@googlegroups.com>); Tue, 31 Mar 2015 12:56:51 +0200
Date: Tue, 31 Mar 2015 12:56:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Joshua Kinard <kumba@gentoo.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2] MIPS: IP32: Add platform data hooks to use
 DS1685 driver
Message-ID: <20150331105650.GA28951@linux-mips.org>
References: <54EFD536.2080508@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <54EFD536.2080508@gentoo.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Feb 26, 2015 at 09:23:50PM -0500, Joshua Kinard wrote:

> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
> is updated as well.

In general - good cleanup.  But:

> index 511e9ff..ec9eb7f 100644
> --- a/arch/mips/sgi-ip32/ip32-platform.c
> +++ b/arch/mips/sgi-ip32/ip32-platform.c
[...]
>  MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
> +MODULE_DESCRIPTION("IP32 platform setup for SGI IP32 aka O2");

This isn't even a kernel module so I've just nuked all these MODULE_*
calls.

> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
> index 44b3470..ef21706 100644
> --- a/arch/mips/sgi-ip32/ip32-reset.c
> +++ b/arch/mips/sgi-ip32/ip32-reset.c
[...]
> -static void ip32_machine_restart(char *cmd)
> +static __noreturn void ip32_poweroff(void *data)
>  {
> -	crime->control = CRIME_CONTROL_HARD_RESET;
> -	while (1);
> -}
> +	void (*poweroff_func)(struct platform_device *) =
> +		symbol_get(ds1685_rtc_poweroff);
> +
> +#ifdef CONFIG_MODULES
> +	/* If the first __symbol_get failed, our module wasn't loaded. */
> +	if (!poweroff_func) {
> +		request_module("rtc-ds1685");
> +		poweroff_func = symbol_get(ds1685_rtc_poweroff);
> +	}
> +#endif

symbol_get() calls are high on my list of items that indicate a piece of
code is probably ill-structured.

While RTCs often deal with power the RTC really only wants to deal with
time and so power stuff should rather go elsewhere.  I suggest to take a
look at drivers/power/reset/.  A small driver there could set pm_power_off
approriately.  drivers/power/reset/restart-poweroff.c is a very compact
example.

> -	shuting_down = 1;
> +	shutting_down = 1;

I'm amazed nobody of the church of speel patchology has caught this earlier.

> @@ -190,15 +141,12 @@ static __init int ip32_reboot_setup(void)
>  
>  	_machine_restart = ip32_machine_restart;
>  	_machine_halt = ip32_machine_halt;
> -	pm_power_off = ip32_machine_power_off;
> +	pm_power_off = ip32_machine_halt;

So halt and power_off no do the same?

  Ralf

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
