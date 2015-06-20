Return-Path: <rtc-linux+bncBDS7HNEFSALRBS7OSKWAKGQEUB4CKUQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si307126wib.2.2015.06.19.17.43.55
        for <rtc-linux@googlegroups.com>;
        Fri, 19 Jun 2015 17:43:55 -0700 (PDT)
Date: Sat, 20 Jun 2015 02:43:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Chao Xie <chao.xie@marvell.com>
Subject: Re: [rtc-linux] [PATCH-v2] rtc: 88pm80x: add device tree support
Message-ID: <20150620004354.GY27492@piout.net>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
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

On 18/06/2015 at 00:28:06 +0530, Vaibhav Hiremath wrote :
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (pdata == NULL)
> -		dev_warn(&pdev->dev, "No platform data!\n");
> +	if (!pdata && !node) {
> +		dev_err(&pdev->dev,
> +			"pm80x-rtc requires platform data or of_node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pdata) {
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

I had troubles to follow the rtc_wakeup initialization cleanup but it
seems OK. However, I'm wondering why you are adding DT support as this
will always be probed from the MFD driver which pass the platform_data
and avoids that allocation.

> +		if (!pdata) {
> +			dev_err(&pdev->dev, "failed to allocate memory\n");
> +			return -ENOMEM;
> +		}
> +	}
>  
>  	info =
>  	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
> @@ -327,11 +336,8 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
>  	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
>  			   PM800_RTC1_USE_XO);
>  
> -	if (pm80x_pdata) {
> -		pdata = pm80x_pdata->rtc;
> -		if (pdata)
> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
> -	}
> +	/* remeber whether this power up is caused by PMIC RTC or not */
remember -^


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
