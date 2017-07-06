Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33220 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdGFUPh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 16:15:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so2933210wrb.0
        for <linux-rtc@vger.kernel.org>; Thu, 06 Jul 2017 13:15:36 -0700 (PDT)
Subject: Re: [PATCH] rtc: hctosys: move hctosys functionality to
 rtc_device_register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
References: <14cc1b9c-66af-2e09-1ca5-07aa55025beb@gmail.com>
Message-ID: <ac408fbb-62e2-0c72-8541-97271ec405d9@gmail.com>
Date: Thu, 6 Jul 2017 22:15:25 +0200
MIME-Version: 1.0
In-Reply-To: <14cc1b9c-66af-2e09-1ca5-07aa55025beb@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 07.03.2017 um 20:10 schrieb Heiner Kallweit:
> It's a little annoying that rtc driver plus all drivers it depends on
> (e.g. I2C) have to be compiled into the kernel to be used with hctosys.
> 
> I think it would be more logical to set the system clock once the
> rtc driver has been registered. Therefore move the hctosys
> functionality to the end of rtc_device_register.
> 
> Works perfectly fine here.
> 
Do you have an opinion on this one?

Rgds, Heiner


> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/rtc/Makefile  |  1 -
>  drivers/rtc/class.c   | 38 ++++++++++++++++++++++++++++
>  drivers/rtc/hctosys.c | 70 ---------------------------------------------------
>  3 files changed, 38 insertions(+), 71 deletions(-)
>  delete mode 100644 drivers/rtc/hctosys.c
> 
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index f07297b1..f1d57b06 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -5,7 +5,6 @@
>  ccflags-$(CONFIG_RTC_DEBUG)	:= -DDEBUG
>  
>  obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
> -obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
>  obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
>  obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
>  obj-$(CONFIG_RTC_MC146818_LIB)	+= rtc-mc146818-lib.o
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 74fd9746..dcfd2e64 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -168,6 +168,13 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
>  	struct rtc_wkalrm alrm;
>  	int of_id = -1, id = -1, err;
>  
> +#if IS_ENABLED(CONFIG_RTC_HCTOSYS)
> +	struct rtc_time tm;
> +	struct timespec64 tv64 = {
> +		.tv_nsec = NSEC_PER_SEC >> 1,
> +	};
> +#endif
> +
>  	if (dev->of_node)
>  		of_id = of_alias_get_id(dev->of_node, "rtc");
>  	else if (dev->parent && dev->parent->of_node)
> @@ -246,6 +253,37 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
>  	dev_info(dev, "rtc core: registered %s as %s\n",
>  			rtc->name, dev_name(&rtc->dev));
>  
> +#if IS_ENABLED(CONFIG_RTC_HCTOSYS)
> +/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
> + * whether it stores the most close value or the value with partial
> + * seconds truncated. However, it is important that we use it to store
> + * the truncated value. This is because otherwise it is necessary,
> + * in an rtc sync function, to read both xtime.tv_sec and
> + * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
> + * of >32bits is not possible. So storing the most close value would
> + * slow down the sync API. So here we have the truncated value and
> + * the best guess is to add 0.5s.
> + */
> +	if (!strcmp(CONFIG_RTC_HCTOSYS_DEVICE, dev_name(&rtc->dev))) {
> +		err = rtc_read_time(rtc, &tm);
> +		if (err) {
> +			dev_err(dev, "hctosys: unable to read the hardware clock\n");
> +			goto hctosys_out;
> +		}
> +
> +		tv64.tv_sec = rtc_tm_to_time64(&tm);
> +
> +		err = do_settimeofday64(&tv64);
> +
> +		dev_info(dev, "setting system clock to %d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
> +			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			 tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			 (long long) tv64.tv_sec);
> +hctosys_out:
> +		rtc_hctosys_ret = err;
> +	}
> +#endif
> +
>  	return rtc;
>  
>  exit_ida:
> diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
> deleted file mode 100644
> index e1cfa068..00000000
> --- a/drivers/rtc/hctosys.c
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -/*
> - * RTC subsystem, initialize system time on startup
> - *
> - * Copyright (C) 2005 Tower Technologies
> - * Author: Alessandro Zummo <a.zummo@towertech.it>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/rtc.h>
> -
> -/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
> - * whether it stores the most close value or the value with partial
> - * seconds truncated. However, it is important that we use it to store
> - * the truncated value. This is because otherwise it is necessary,
> - * in an rtc sync function, to read both xtime.tv_sec and
> - * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
> - * of >32bits is not possible. So storing the most close value would
> - * slow down the sync API. So here we have the truncated value and
> - * the best guess is to add 0.5s.
> - */
> -
> -static int __init rtc_hctosys(void)
> -{
> -	int err = -ENODEV;
> -	struct rtc_time tm;
> -	struct timespec64 tv64 = {
> -		.tv_nsec = NSEC_PER_SEC >> 1,
> -	};
> -	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> -
> -	if (rtc == NULL) {
> -		pr_info("unable to open rtc device (%s)\n",
> -			CONFIG_RTC_HCTOSYS_DEVICE);
> -		goto err_open;
> -	}
> -
> -	err = rtc_read_time(rtc, &tm);
> -	if (err) {
> -		dev_err(rtc->dev.parent,
> -			"hctosys: unable to read the hardware clock\n");
> -		goto err_read;
> -
> -	}
> -
> -	tv64.tv_sec = rtc_tm_to_time64(&tm);
> -
> -	err = do_settimeofday64(&tv64);
> -
> -	dev_info(rtc->dev.parent,
> -		"setting system clock to "
> -		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
> -		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> -		tm.tm_hour, tm.tm_min, tm.tm_sec,
> -		(long long) tv64.tv_sec);
> -
> -err_read:
> -	rtc_class_close(rtc);
> -
> -err_open:
> -	rtc_hctosys_ret = err;
> -
> -	return err;
> -}
> -
> -late_initcall(rtc_hctosys);
> 
