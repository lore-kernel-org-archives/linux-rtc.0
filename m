Return-Path: <rtc-linux+bncBDS7HNEFSALRB2UHS2WQKGQEF4K7A4A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si628625wiz.0.2015.07.14.14.49.29
        for <rtc-linux@googlegroups.com>;
        Tue, 14 Jul 2015 14:49:29 -0700 (PDT)
Date: Tue, 14 Jul 2015 23:49:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, shawn.guo@linaro.org, kernel@pengutronix.de,
	linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH v4 3/7] rtc: mxc: use a second rtc clock
Message-ID: <20150714214928.GA24706@piout.net>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
 <1435965320-1478-4-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1435965320-1478-4-git-send-email-tremyfr@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/07/2015 at 01:15:16 +0200, Philippe Reynes wrote :
> The mxc RTC needs two clocks, one for the input
> reference, and one for the IP. But this driver
> was only using one clock (for the reference).
> This patch add the second clock (for the IP).
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I don't really care how the clocks are named, feel free to rename them
and keep that ack.

> ---
>  drivers/rtc/rtc-mxc.c |   41 ++++++++++++++++++++++++++++-------------
>  1 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
> index 5fc292c..4ce7e21 100644
> --- a/drivers/rtc/rtc-mxc.c
> +++ b/drivers/rtc/rtc-mxc.c
> @@ -79,7 +79,8 @@ struct rtc_plat_data {
>  	struct rtc_device *rtc;
>  	void __iomem *ioaddr;
>  	int irq;
> -	struct clk *clk;
> +	struct clk *clk_rtc;
> +	struct clk *clk_ipg;
>  	struct rtc_time g_rtc_alarm;
>  	enum imx_rtc_type devtype;
>  };
> @@ -373,17 +374,28 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	if (IS_ERR(pdata->ioaddr))
>  		return PTR_ERR(pdata->ioaddr);
>  
> -	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pdata->clk)) {
> -		dev_err(&pdev->dev, "unable to get clock!\n");
> -		return PTR_ERR(pdata->clk);
> +	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(pdata->clk_ipg)) {
> +		dev_err(&pdev->dev, "unable to get ipg clock!\n");
> +		return PTR_ERR(pdata->clk_ipg);
>  	}
>  
> -	ret = clk_prepare_enable(pdata->clk);
> +	ret = clk_prepare_enable(pdata->clk_ipg);
>  	if (ret)
>  		return ret;
>  
> -	rate = clk_get_rate(pdata->clk);
> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
> +	if (IS_ERR(pdata->clk_rtc)) {
> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> +		ret = PTR_ERR(pdata->clk_rtc);
> +		goto exit_put_clk_ipg;
> +	}
> +
> +	ret = clk_prepare_enable(pdata->clk_rtc);
> +	if (ret)
> +		goto exit_put_clk_ipg;
> +
> +	rate = clk_get_rate(pdata->clk_rtc);
>  
>  	if (rate == 32768)
>  		reg = RTC_INPUT_CLK_32768HZ;
> @@ -394,7 +406,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	else {
>  		dev_err(&pdev->dev, "rtc clock is not valid (%lu)\n", rate);
>  		ret = -EINVAL;
> -		goto exit_put_clk;
> +		goto exit_put_clk_rtc;
>  	}
>  
>  	reg |= RTC_ENABLE_BIT;
> @@ -402,7 +414,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	if (((readw(pdata->ioaddr + RTC_RTCCTL)) & RTC_ENABLE_BIT) == 0) {
>  		dev_err(&pdev->dev, "hardware module can't be enabled!\n");
>  		ret = -EIO;
> -		goto exit_put_clk;
> +		goto exit_put_clk_rtc;
>  	}
>  
>  	platform_set_drvdata(pdev, pdata);
> @@ -424,15 +436,17 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  				  THIS_MODULE);
>  	if (IS_ERR(rtc)) {
>  		ret = PTR_ERR(rtc);
> -		goto exit_put_clk;
> +		goto exit_put_clk_rtc;
>  	}
>  
>  	pdata->rtc = rtc;
>  
>  	return 0;
>  
> -exit_put_clk:
> -	clk_disable_unprepare(pdata->clk);
> +exit_put_clk_rtc:
> +	clk_disable_unprepare(pdata->clk_rtc);
> +exit_put_clk_ipg:
> +	clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return ret;
>  }
> @@ -441,7 +455,8 @@ static int mxc_rtc_remove(struct platform_device *pdev)
>  {
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(pdata->clk);
> +	clk_disable_unprepare(pdata->clk_rtc);
> +	clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return 0;
>  }
> -- 
> 1.7.4.4
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

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
