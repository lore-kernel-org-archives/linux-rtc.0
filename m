Return-Path: <rtc-linux+bncBDKZNNNLXAHBBB7HRS6AKGQEDJRO3MA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id 62si151295pfx.1.2016.07.10.22.49.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 22:49:58 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA40087IYV7HQ10@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 11 Jul 2016 06:49:55 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: s3c: add device data for samsung,exynos3250-rtc
To: Randy Li <ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
 <1468056226-19128-3-git-send-email-ayaka@soulik.info>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <57833381.7050503@samsung.com>
Date: Mon, 11 Jul 2016 07:49:53 +0200
MIME-version: 1.0
In-reply-to: <1468056226-19128-3-git-send-email-ayaka@soulik.info>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/09/2016 11:23 AM, Randy Li wrote:
> The device data for samsung,exynos3250-rtc and samsung,s3c6410-rtc
> are just have a difference, but keeping using the same device data
> would cause the platform using the other IP core not work.

I cannot understand what you wanted to say here. Please rephrase it.

Why not just reverting a42e6eae457837d6a5925f4926f5ba05ccf44f89?

Best regards,
Krzysztof

> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/rtc/rtc-s3c.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 5dc18ca..e9f6151 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -810,6 +810,18 @@ static struct s3c_rtc_data const s3c6410_rtc_data = {
>  	.disable		= s3c6410_rtc_disable,
>  };
>  
> +static struct s3c_rtc_data const exynos3250_rtc_data = {
> +	.max_user_freq		= 32768,
> +	.needs_src_clk          = true,
> +	.irq_handler		= s3c6410_rtc_irq,
> +	.set_freq		= s3c6410_rtc_setfreq,
> +	.enable_tick		= s3c6410_rtc_enable_tick,
> +	.save_tick_cnt		= s3c6410_rtc_save_tick_cnt,
> +	.restore_tick_cnt	= s3c6410_rtc_restore_tick_cnt,
> +	.enable			= s3c24xx_rtc_enable,
> +	.disable		= s3c6410_rtc_disable,
> +};
> +
>  static const struct of_device_id s3c_rtc_dt_match[] = {
>  	{
>  		.compatible = "samsung,s3c2410-rtc",
> @@ -825,7 +837,7 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
>  		.data = (void *)&s3c6410_rtc_data,
>  	}, {
>  		.compatible = "samsung,exynos3250-rtc",
> -		.data = (void *)&s3c6410_rtc_data,
> +		.data = (void *)&exynos3250_rtc_data,
>  	},
>  	{ /* sentinel */ },
>  };
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
