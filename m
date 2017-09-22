Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:48264 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751704AbdIVIHW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Sep 2017 04:07:22 -0400
Message-ID: <1506067636.26847.2.camel@mtksdaap41>
Subject: Re: [PATCH 3/4] rtc: mediatek: enhance the description for MediaTek
 PMIC based RTC
From: Eddie Huang <eddie.huang@mediatek.com>
To: <sean.wang@mediatek.com>
CC: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Fri, 22 Sep 2017 16:07:16 +0800
In-Reply-To: <0d9d5559d9d884c98ef589a8f56ab0dcb140e5e0.1506049341.git.sean.wang@mediatek.com>
References: <cover.1506049341.git.sean.wang@mediatek.com>
         <0d9d5559d9d884c98ef589a8f56ab0dcb140e5e0.1506049341.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Sean,

On Fri, 2017-09-22 at 11:33 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Give a better description for original MediaTek RTC driver as PMIC based
> RTC in order to distinguish SoC based RTC. Also turning all words with
> Mediatek to MediaTek here.
> 
> Cc: Eddie Huang <eddie.huang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/rtc/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 4226295..4500f77 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1716,14 +1716,14 @@ config RTC_DRV_MEDIATEK
>  	  will be called rtc-mediatek.
>  
>  config RTC_DRV_MT6397
> -	tristate "Mediatek Real Time Clock driver"
> +	tristate "MediaTek PMIC based RTC"
>  	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
>  	help
> -	  This selects the Mediatek(R) RTC driver. RTC is part of Mediatek
> +	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
>  	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
> -	  Mediatek(R) RTC driver.
> +	  MediaTek(R) RTC driver.
>  
> -	  If you want to use Mediatek(R) RTC interface, select Y or M here.
> +	  If you want to use MediaTek(R) RTC interface, select Y or M here.
>  
>  config RTC_DRV_XGENE
>  	tristate "APM X-Gene RTC"

Thanks your correction.

Acked-by: Eddie Huang <eddie.huang@mediatek.com>

Regards,
