Return-Path: <rtc-linux+bncBDS7HNEFSALRBUNCV2VQKGQEO5J6JDI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p12si417431wiv.1.2015.05.31.15.55.13
        for <rtc-linux@googlegroups.com>;
        Sun, 31 May 2015 15:55:13 -0700 (PDT)
Date: Mon, 1 Jun 2015 00:55:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Loc Ho <lho@apm.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jcm@redhat.com, patches@apm.com, broonie@kernel.org
Subject: [rtc-linux] Re: [v2] rtc: Fix suspend/resume for APM X-Gene SoC RTC driver
Message-ID: <20150531225512.GA4710@piout.net>
References: <1397498944-8486-1-git-send-email-lho@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1397498944-8486-1-git-send-email-lho@apm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

This patch was never merged, can you check whether it is still useful
(I'd would say it is)?

On 14/04/2014 at 12:09:04 -0600, Loc Ho wrote :
> This patch fixes suspend/resume functions properly for the APM X-Gene
> SoC RTC driver. This patch requires the merged v2 of the APM X-Gene 
> SoC RTC driver.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Reviewed-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/rtc/rtc-xgene.c |   41 ++++++++++++++++++++++++++++++++---------
>  1 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
> index 14129cc..d533edd 100644
> --- a/drivers/rtc/rtc-xgene.c
> +++ b/drivers/rtc/rtc-xgene.c
> @@ -52,6 +52,7 @@ struct xgene_rtc_dev {
>  	void __iomem *csr_base;
>  	struct clk *clk;
>  	unsigned int irq_wake;
> +	unsigned int irq_enabled;
>  };
>  
>  static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
> @@ -104,15 +105,19 @@ static int xgene_rtc_alarm_irq_enable(struct device *dev, u32 enabled)
>  	return 0;
>  }
>  
> +static int xgene_rtc_alarm_irq_enabled(struct device *dev)
> +{
> +	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
> +
> +	return readl(pdata->csr_base + RTC_CCR) & RTC_CCR_IE ? 1 : 0;
> +}
> +
>  static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
> -	unsigned long rtc_time;
>  	unsigned long alarm_time;
>  
> -	rtc_time = readl(pdata->csr_base + RTC_CCVR);
>  	rtc_tm_to_time(&alrm->time, &alarm_time);
> -
>  	pdata->alarm_time = alarm_time;
>  	writel((u32) pdata->alarm_time, pdata->csr_base + RTC_CMR);
>  
> @@ -180,12 +185,18 @@ static int xgene_rtc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Couldn't get the clock for RTC\n");
>  		return -ENODEV;
>  	}
> -	clk_prepare_enable(pdata->clk);
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Turn on the clock and the crystal */
>  	writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	ret = device_init_wakeup(&pdev->dev, 1);
> +	if (ret) {
> +		clk_disable_unprepare(pdata->clk);
> +		return ret;
> +	}
>  
>  	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  					 &xgene_rtc_ops, THIS_MODULE);
> @@ -218,14 +229,20 @@ static int xgene_rtc_suspend(struct device *dev)
>  	int irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> +
> +	/*
> +	 * If this RTC alarm will be used for waking the system up,
> +	 * don't disable it of course. Else we just disable the alarm
> +	 * and await suspension.
> +	 */
>  	if (device_may_wakeup(&pdev->dev)) {
>  		if (!enable_irq_wake(irq))
>  			pdata->irq_wake = 1;
>  	} else {
> +		pdata->irq_enabled = xgene_rtc_alarm_irq_enabled(dev);
>  		xgene_rtc_alarm_irq_enable(dev, 0);
> -		clk_disable(pdata->clk);
> +		clk_disable_unprepare(pdata->clk);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -234,16 +251,22 @@ static int xgene_rtc_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
>  	int irq;
> +	int rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> +
>  	if (device_may_wakeup(&pdev->dev)) {
>  		if (pdata->irq_wake) {
>  			disable_irq_wake(irq);
>  			pdata->irq_wake = 0;
>  		}
>  	} else {
> -		clk_enable(pdata->clk);
> -		xgene_rtc_alarm_irq_enable(dev, 1);
> +		rc = clk_prepare_enable(pdata->clk);
> +		if (rc) {
> +			dev_err(dev, "Unable to enable clock error %d\n", rc);
> +			return rc;
> +		}
> +		xgene_rtc_alarm_irq_enable(dev, pdata->irq_enabled);
>  	}
>  
>  	return 0;

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
