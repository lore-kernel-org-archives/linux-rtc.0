Return-Path: <rtc-linux+bncBCGLJQVNREJBBFHYTO2QKGQE7PTSLLY@googlegroups.com>
Received: from mailgw02.hq.mediatek.com ([210.61.82.184])
        by gmr-mx.google.com with ESMTP id tn7si2496116pac.1.2016.01.25.20.54.43
        for <rtc-linux@googlegroups.com>;
        Mon, 25 Jan 2016 20:54:44 -0800 (PST)
Message-ID: <1453784080.15263.2.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: add IRQ domain dependency
From: Eddie Huang <eddie.huang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, Wei-Ning Huang
	<wnhuang@chromium.org>, Tianping Fang <tianping.fang@mediatek.com>, "Henry
 Chen" <henryc.chen@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>,
	<rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 26 Jan 2016 12:54:40 +0800
In-Reply-To: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
References: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2016-01-25 at 17:04 +0100, Arnd Bergmann wrote:
> The mt6397 RTC driver can be built either when the MFD_MT6397 driver
> is enabled (which selects IRQ_DOMAIN), or when compile testing.
> The latter however fails without IRQ domains:
> 
> drivers/rtc/rtc-mt6397.c: In function 'mtk_rtc_probe':
> drivers/rtc/rtc-mt6397.c:326:13: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
>   rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> 
> This adds an explicit dependency for the COMPILE_TEST case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 376322f71fd5..4395608bf7fc 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1603,7 +1603,7 @@ config RTC_DRV_MOXART
>  
>  config RTC_DRV_MT6397
>  	tristate "Mediatek Real Time Clock driver"
> -	depends on MFD_MT6397 || COMPILE_TEST
> +	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
>  	help
>  	  This selects the Mediatek(R) RTC driver. RTC is part of Mediatek
>  	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select

Hi Arnd,

Thanks your correction.
Acked-by: Eddie Huang <eddie.huang@mediatek.com>

Regards,
Eddie


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
