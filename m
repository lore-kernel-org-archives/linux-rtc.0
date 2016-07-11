Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMXGRS6AKGQEFNUUX2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id c11si145694pfc.2.2016.07.10.22.48.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 22:48:34 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA400G8DYSU9Q10@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 11 Jul 2016 06:48:31 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH 1/3] Revert "drivers/rtc/rtc-s3c.c: add
 .needs_src_clk to s3c6410 RTC data"
To: Randy Li <ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
 <1468056226-19128-2-git-send-email-ayaka@soulik.info>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5783332D.7010809@samsung.com>
Date: Mon, 11 Jul 2016 07:48:29 +0200
MIME-version: 1.0
In-reply-to: <1468056226-19128-2-git-send-email-ayaka@soulik.info>
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
> This reverts commit 8792f7772f4f40ffc68bad5f28311205584b734d.
> The s3c6410 rtc don't use rtc_src property, that property is designed
> for Exynos5250 and Exynos5440. The problem reported in the commit
> I mentioned should be fixed in the other way.

... so you break in this commit all the newer platforms because the
rtc_src clock won't be enabled.

Does not look right.

Best regards,
Krzysztof

> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/rtc/rtc-s3c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index d01ad7e..5dc18ca 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -801,7 +801,6 @@ static struct s3c_rtc_data const s3c2443_rtc_data = {
>  
>  static struct s3c_rtc_data const s3c6410_rtc_data = {
>  	.max_user_freq		= 32768,
> -	.needs_src_clk		= true,
>  	.irq_handler		= s3c6410_rtc_irq,
>  	.set_freq		= s3c6410_rtc_setfreq,
>  	.enable_tick		= s3c6410_rtc_enable_tick,
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
