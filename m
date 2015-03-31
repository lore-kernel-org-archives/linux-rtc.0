Return-Path: <rtc-linux+bncBDS7HNEFSALRBXWT46UAKGQETKL4UJQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id sf8si686028wic.2.2015.03.30.17.27.10
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Mar 2015 17:27:10 -0700 (PDT)
Date: Tue, 31 Mar 2015 02:27:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate
 Exynos3250 into S3C6410
Message-ID: <20150331002709.GF3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c

On 30/03/2015 at 17:19:32 +0200, Krzysztof Kozlowski wrote :
> There are now no differences between RTC on Exynos3250 and S3C6410.
> Merge everything into one so duplicated code could be removed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-s3c.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index fb0c569765c6..5e162eaad277 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -774,18 +774,6 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
>  	.disable		= s3c6410_rtc_disable,
>  };
>  
> -static struct s3c_rtc_data const exynos3250_rtc_data = {
> -	.max_user_freq		= 32768,
> -	.needs_src_clk		= true,
> -	.irq_handler		= s3c6410_rtc_irq,
> -	.set_freq		= s3c6410_rtc_setfreq,
> -	.enable_tick		= s3c6410_rtc_enable_tick,
> -	.save_tick_cnt		= s3c6410_rtc_save_tick_cnt,
> -	.restore_tick_cnt	= s3c6410_rtc_restore_tick_cnt,
> -	.enable			= s3c24xx_rtc_enable,
> -	.disable		= s3c6410_rtc_disable,
> -};
> -
>  static const struct of_device_id s3c_rtc_dt_match[] = {
>  	{
>  		.compatible = "samsung,s3c2410-rtc",
> @@ -801,7 +789,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
>  		.data = (void *)&s3c6410_rtc_data,
>  	}, {
>  		.compatible = "samsung,exynos3250-rtc",
> -		.data = (void *)&exynos3250_rtc_data,
> +		.data = (void *)&s3c6410_rtc_data,
>  	},
>  	{ /* sentinel */ },
>  };
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
