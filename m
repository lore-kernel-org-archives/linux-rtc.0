Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:55005 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754754AbeASIA2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 19 Jan 2018 03:00:28 -0500
Date: Fri, 19 Jan 2018 08:27:33 +0100
From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: remove rtc-at32ap700x
Message-ID: <20180119072733.dkswccdbnisbmqi6@samfundet.no>
References: <20180118200846.14368-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118200846.14368-1-clabbe.montjoie@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Around Thu 18 Jan 2018 21:08:46 +0100 or thereabout, Corentin Labbe wrote:
> Since PLATFORM_AT32AP is an AVR32 platform which was removed, the
> rtc driver rtc-at32ap700x is useless.
> This patch remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/rtc/Kconfig          |   7 --
>  drivers/rtc/Makefile         |   1 -
>  drivers/rtc/rtc-at32ap700x.c | 287 -------------------------------------------
>  3 files changed, 295 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-at32ap700x.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index b71cc7b5fbc9..8ab5f0a5d323 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1402,13 +1402,6 @@ config RTC_DRV_PL031
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rtc-pl031.
>  
> -config RTC_DRV_AT32AP700X
> -	tristate "AT32AP700X series RTC"
> -	depends on PLATFORM_AT32AP || COMPILE_TEST
> -	help
> -	  Driver for the internal RTC (Realtime Clock) on Atmel AVR32
> -	  AT32AP700x family processors.
> -
>  config RTC_DRV_AT91RM9200
>  	tristate "AT91RM9200 or some AT91SAM9 RTC"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 6dfbbe9cd8a2..4fbf87e45a7c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -33,7 +33,6 @@ obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
>  obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
>  obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
>  obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
> -obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
>  obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
>  obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
>  obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o

<snipp diff>

-- 
Best regards,
Hans-Christian Noren Egtvedt
