Return-Path: <rtc-linux+bncBDL3F4G2ZAIBBUV446UAKGQEZDGFRGA@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id iw3si1316819pbd.1.2015.03.30.16.37.54
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 16:37:54 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM100MBTTN4PJA0@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 31 Mar 2015 08:37:52 +0900 (KST)
Message-id: <5519DE4F.3080608@samsung.com>
Date: Tue, 31 Mar 2015 08:37:51 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate
 Exynos3250 into S3C6410
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/31/2015 12:19 AM, Krzysztof Kozlowski wrote:
> There are now no differences between RTC on Exynos3250 and S3C6410.
> Merge everything into one so duplicated code could be removed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
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
> 

Looks good to me.

Reviewd-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

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
