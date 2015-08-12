Return-Path: <rtc-linux+bncBDKZNNNLXAHBBZM5VKXAKGQEY2U5OAY@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id zt8si403993pbc.0.2015.08.11.17.10.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 17:10:13 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSY001XF0GWU830@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 12 Aug 2015 01:10:08 +0100 (BST)
Message-id: <55CA8EDE.8000006@samsung.com>
Date: Wed, 12 Aug 2015 09:10:06 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Joonyoung Shim <jy0922.shim@samsung.com>, rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: s3c: use unified functions for
 enable/disable of clk
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
 <1439292502-22912-3-git-send-email-jy0922.shim@samsung.com>
In-reply-to: <1439292502-22912-3-git-send-email-jy0922.shim@samsung.com>
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

On 11.08.2015 20:28, Joonyoung Shim wrote:
> The driver uses clk_prepare_enable()/clk_disable_unprepare() only in
> probe only, elsewhere, use the unified functions for enable/disable of
> clk, e.g. s3c_rtc_enable_clk() / s3c_rtc_disable_clk(), so it's better
> to use them for consistency of code.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

First of all - the code is larger (9 insertions, 5 deletion) so I have
doubts if this is better.

Second - this is not equivalent change. The s3c_rtc_enable_clk/disable
calls grab spin lock which is not necessary in probe.

Best regards,
Krzysztof

> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 44b2921..abe2a6d 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -476,19 +476,21 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failed to find rtc clock\n");
>  		return PTR_ERR(info->rtc_clk);
>  	}
> -	clk_prepare_enable(info->rtc_clk);
> +	clk_prepare(info->rtc_clk);
>  
>  	if (info->data->needs_src_clk) {
>  		info->rtc_src_clk = devm_clk_get(&pdev->dev, "rtc_src");
>  		if (IS_ERR(info->rtc_src_clk)) {
>  			dev_err(&pdev->dev,
>  				"failed to find rtc source clock\n");
> -			clk_disable_unprepare(info->rtc_clk);
> +			clk_unprepare(info->rtc_clk);
>  			return PTR_ERR(info->rtc_src_clk);
>  		}
> -		clk_prepare_enable(info->rtc_src_clk);
> +		clk_prepare(info->rtc_src_clk);
>  	}
>  
> +	s3c_rtc_enable_clk(info);
> +
>  	/* check to see if everything is setup correctly */
>  	if (info->data->enable)
>  		info->data->enable(info);
> @@ -548,9 +550,11 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  	if (info->data->disable)
>  		info->data->disable(info);
>  
> +	s3c_rtc_disable_clk(info);
> +
>  	if (info->data->needs_src_clk)
> -		clk_disable_unprepare(info->rtc_src_clk);
> -	clk_disable_unprepare(info->rtc_clk);
> +		clk_unprepare(info->rtc_src_clk);
> +	clk_unprepare(info->rtc_clk);
>  
>  	return ret;
>  }
> 

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
