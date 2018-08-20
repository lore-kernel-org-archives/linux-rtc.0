Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTW3k (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 20 Aug 2018 18:29:40 -0400
Date: Mon, 20 Aug 2018 21:12:47 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20180820191247.GU21707@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820180716.1853-1-paul@crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.

Maybe you could consider dropping the whole dependency as we already
know it will build on every architecture.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a2ba5db36145..98c7f19256b1 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1608,7 +1608,7 @@ config RTC_DRV_MPC5121
>  
>  config RTC_DRV_JZ4740
>  	tristate "Ingenic JZ4740 SoC"
> -	depends on MACH_INGENIC || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
>  	  controllers.
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
