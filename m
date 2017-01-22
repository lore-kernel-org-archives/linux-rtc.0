Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZP5SLCAKGQEAR5TMFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h198si774544wmg.1.2017.01.22.06.17.09
        for <rtc-linux@googlegroups.com>;
        Sun, 22 Jan 2017 06:17:09 -0800 (PST)
Date: Sun, 22 Jan 2017 15:17:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/6] rtc: sun6i: Expose the 32kHz oscillator
Message-ID: <20170122141708.gccmxpeukuglal6i@piout.net>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
 <f1b2a5053cf143dccf110ab0d40c082903a958a7.1484927680.git-series.maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f1b2a5053cf143dccf110ab0d40c082903a958a7.1484927680.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 20/01/2017 at 16:56:38 +0100, Maxime Ripard wrote :
> +
> +	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		pr_crit("Can't allocate RTC structure\n");
> +

The message is unnecessary but you probably want to stop there and
return.

> +	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (!rtc->base) {
> +		pr_crit("Can't map RTC registers");
> +		return;
> +	}
> +
> +	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
> +								"rtc-int-osc",
> +								NULL, 0,
> +								667000,
> +								300000000);
> +	if (IS_ERR(rtc->int_osc)) {
> +		pr_crit("Couldn't register the internal oscillator\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Due to the missing clocks property we had to express the
> +	 * parenthood with the external oscillator that cannot fix (or
> +	 * at least expect to have) in the old DTs, we have to be a
> +	 * bit smart here.
> +	 *
> +	 * We deal with that by simply registering the internal
> +	 * oscillator as our parent in all cases, and try to get the
> +	 * external oscillator from the DT.
> +	 *
> +	 * In the case where we don't have it, of_clk_get_parent_name
> +	 * will return NULL, which is ok, and of_clk_get_parent_count
> +	 * will return 0, which is fine too. We will just register a
> +	 * single parent, everything works.
> +	 */
> +	parents[0] = clk_hw_get_name(rtc->int_osc);
> +	parents[1] = of_clk_get_parent_name(node, 0);
> +
> +	rtc->hw.init = &init;
> +
> +	init.parent_names = parents;
> +	init.num_parents = of_clk_get_parent_count(node) + 1;
> +	init.name = "rtc-osc";
> +	of_property_read_string(node, "clock-output-names", &init.name);
> +
> +	rtc->losc = clk_register(NULL, &rtc->hw);
> +	if (IS_ERR(rtc->losc)) {
> +		pr_crit("Couldn't register the LOSC clock\n");
> +		return;
> +	}
> +
> +	of_clk_add_hw_provider(node, of_clk_hw_simple_get, &rtc->hw);
> +
> +	/* Yes, I know, this is ugly. */
> +	sun6i_rtc = rtc;
> +}
> +CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
> +		      sun6i_rtc_clk_init);
> +
>  static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
>  {
>  	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
> @@ -349,22 +476,15 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
>  
>  static int sun6i_rtc_probe(struct platform_device *pdev)
>  {
> -	struct sun6i_rtc_dev *chip;
> -	struct resource *res;
> +	struct sun6i_rtc_dev *chip = sun6i_rtc;
>  	int ret;
>  
> -	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> -		return -ENOMEM;
> +		return -ENODEV;
>  
>  	platform_set_drvdata(pdev, chip);
>  	chip->dev = &pdev->dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	chip->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(chip->base))
> -		return PTR_ERR(chip->base);
> -
>  	chip->irq = platform_get_irq(pdev, 0);
>  	if (chip->irq < 0) {
>  		dev_err(&pdev->dev, "No IRQ resource\n");
> @@ -404,6 +524,8 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
>  	/* disable alarm wakeup */
>  	writel(0, chip->base + SUN6I_ALARM_CONFIG);
>  
> +	clk_prepare_enable(chip->losc);
> +
>  	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
>  					&sun6i_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(chip->rtc)) {
> -- 
> git-series 0.8.11

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
