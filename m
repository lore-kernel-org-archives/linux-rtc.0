Return-Path: <rtc-linux+bncBCV3TM5A74DRB7UJROVQKGQE6Q5D3YI@googlegroups.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com. [209.85.192.176])
        by gmr-mx.google.com with ESMTPS id xv6si993726pab.2.2015.05.24.23.45.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 23:45:18 -0700 (PDT)
Received: by pdbqa5 with SMTP id qa5so63763401pdb.0
        for <rtc-linux@googlegroups.com>; Sun, 24 May 2015 23:45:18 -0700 (PDT)
Date: Mon, 25 May 2015 14:44:28 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 1/6] rtc: arm: imx: snvs: change use syscon
 to access register
Message-ID: <20150525064427.GG3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 22, 2015 at 10:36:34PM +0800, Frank.Li@freescale.com wrote:
>  static int snvs_rtc_probe(struct platform_device *pdev)
>  {
>  	struct snvs_rtc_data *data;
>  	struct resource *res;
>  	int ret;
> +	struct device_node *snvs_np;
> +	void __iomem *mmio;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(data->ioaddr))
> -		return PTR_ERR(data->ioaddr);
> +	snvs_np = of_get_parent(pdev->dev.of_node);
> +	if (!snvs_np)
> +		return -ENODEV;
> +
> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;

As I commented on dts patch, we should probably follow syscon-poweroff
to have 'regmap' and 'offset' properties.

Shawn

> +	} else {
> +		pr_warn("snvs rtc: you use old dts file, please update it\n");
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +		mmio = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mmio))
> +			return PTR_ERR(mmio);
> +
> +		data->regmap = devm_regmap_init_mmio(&pdev->dev, mmio, &snvs_rtc_config);
> +	}
> +
> +	of_node_put(snvs_np);
> +
> +	if (!data->regmap) {
> +		pr_err("Can't snvs syscon\n");
> +		return -ENODEV;
> +	}
>  
>  	data->irq = platform_get_irq(pdev, 0);
>  	if (data->irq < 0)
> @@ -276,13 +282,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> -	spin_lock_init(&data->lock);
> -
>  	/* Initialize glitch detect */
> -	writel(SNVS_LPPGDR_INIT, data->ioaddr + SNVS_LPPGDR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPPGDR, SNVS_LPPGDR_INIT);
>  
>  	/* Clear interrupt status */
> -	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
>  
>  	/* Enable RTC */
>  	snvs_rtc_enable(data, true);
> -- 
> 1.9.1
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
