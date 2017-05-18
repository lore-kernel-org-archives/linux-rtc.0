Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58354 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755761AbdERWaT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 May 2017 18:30:19 -0400
Date: Thu, 18 May 2017 23:30:00 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Janos Laube <janos.dev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: gemini: Add optional clock handling
Message-ID: <20170518223000.GP22219@n2100.armlinux.org.uk>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, May 18, 2017 at 11:56:33PM +0200, Linus Walleij wrote:
> +	rtc->pclk = clk_get(dev, "PCLK");
> +	if (IS_ERR(rtc->pclk)) {
> +		dev_err(dev, "could not get PCLK\n");
> +	} else {
> +		ret = clk_prepare_enable(rtc->pclk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable PCLK\n");
> +			return ret;

Proper cleanup?  Maybe consider using devm_clk_get() right from the get-go?

> +		}
> +	}
> +	rtc->extclk = clk_get(dev, "EXTCLK");
> +	if (IS_ERR(rtc->extclk)) {
> +		dev_err(dev, "could not get EXTCLK\n");
> +	} else {
> +		ret = clk_prepare_enable(rtc->extclk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable EXTCLK\n");
> +			return ret;

Ditto.

> +		}
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!res)
>  		return -ENODEV;
> @@ -156,6 +180,10 @@ static int gemini_rtc_remove(struct platform_device *pdev)
>  {
>  	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
>  
> +	if (!IS_ERR(rtc->extclk))
> +		clk_disable_unprepare(rtc->extclk);
> +	if (!IS_ERR(rtc->pclk))
> +		clk_disable_unprepare(rtc->pclk);

No clk_put(), but if you used devm_clk_get(), you don't need it.

>  	rtc_device_unregister(rtc->rtc_dev);
>  
>  	return 0;
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
