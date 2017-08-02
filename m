Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdHBQT3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 12:19:29 -0400
Date: Wed, 2 Aug 2017 09:19:26 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        alexandre.belloni@free-electrons.com
Subject: Re: [RFCv2] rtc: ds1307: add square wave output from ds1308
Message-ID: <20170802161926.GQ2146@codeaurora.org>
References: <20170802052727.18289-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802052727.18289-1-sean.nyekjaer@prevas.dk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 08/02, Sean Nyekjaer wrote:
> Add square wave output to generic clock framework

s/to/via the/

perhaps? This makes it sound like we're adding square wave output
support in the generic clock framework by some new clk API or
something.

> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> @@ -1056,6 +1057,13 @@ enum {
>  #define clk_32khz_to_ds1307(clk)	\
>  	container_of(clk, struct ds1307, clks[DS3231_CLK_32KHZ])
>  
> +static int ds1308_clk_sqw_rates[] = {

const?

> +	1,
> +	4096,
> +	8192,
> +	32768,
> +};
> +
>  static int ds3231_clk_sqw_rates[] = {
>  	1,
>  	1024,
> @@ -1076,6 +1097,24 @@ static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
>  	return ret;
>  }
>  
> +static unsigned long ds1308_clk_sqw_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
> +	int control, ret;
> +	int rate_sel = 0;
> +
> +	ret = regmap_read(ds1307->regmap, DS1307_REG_CONTROL, &control);
> +	if (ret)
> +		return ret;
> +	if (control & DS1307_BIT_RS0)
> +		rate_sel += 1;
> +	if (control & DS1307_BIT_RS1)
> +		rate_sel += 2;
> +
> +	return ds1308_clk_sqw_rates[rate_sel];

rate_sel can't be out of bounds on the array here, right?

> +}
> +
>  static unsigned long ds3231_clk_sqw_recalc_rate(struct clk_hw *hw,
>  						unsigned long parent_rate)
>  {
> @@ -1146,6 +1237,18 @@ static void ds3231_clk_sqw_unprepare(struct clk_hw *hw)
>  	ds1337_write_control(ds1307, DS1337_BIT_INTCN, DS1337_BIT_INTCN);
>  }
>  
> +static int ds1308_clk_sqw_is_prepared(struct clk_hw *hw)
> +{
> +	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
> +	int control, ret;
> +
> +	ret = regmap_read(ds1307->regmap, DS1307_REG_CONTROL, &control);
> +	if (ret)
> +		return ret;

This should return 0 on failure? The is_prepared() clk op has an
int return value, but the return value is interpreted as a bool.

> +
> +	return control & DS1307_BIT_SQWE;
> +}
> +
>  static int ds3231_clk_sqw_is_prepared(struct clk_hw *hw)
>  {
>  	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
> @@ -1231,6 +1350,44 @@ static struct clk_init_data ds3231_clks_init[] = {
>  	},
>  };
>  
> +static int ds1308_clks_register(struct ds1307 *ds1307)
> +{
> +	struct device_node *node = ds1307->dev->of_node;
> +	struct clk_onecell_data	*onecell;
> +	int i;
> +
> +	onecell = devm_kzalloc(ds1307->dev, sizeof(*onecell), GFP_KERNEL);
> +	if (!onecell)
> +		return -ENOMEM;
> +
> +	onecell->clk_num = ARRAY_SIZE(ds1308_clks_init);
> +	onecell->clks = devm_kcalloc(ds1307->dev, onecell->clk_num,
> +				     sizeof(onecell->clks[0]), GFP_KERNEL);
> +	if (!onecell->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(ds1308_clks_init); i++) {
> +		struct clk_init_data init = ds1308_clks_init[i];
> +
> +		/* optional override of the clockname */
> +		of_property_read_string_index(node, "clock-output-names", i,
> +						&init.name);
> +		ds1307->clks[i].init = &init;
> +
> +		onecell->clks[i] = devm_clk_register(ds1307->dev,
> +						     &ds1307->clks[i]);

Can you please use devm_clk_hw_register() instead?

> +		if (IS_ERR(onecell->clks[i]))
> +			return PTR_ERR(onecell->clks[i]);
> +	}
> +
> +	if (!node)
> +		return 0;
> +
> +	of_clk_add_provider(node, of_clk_src_onecell_get, onecell);

And of_clk_add_hw_provider()?

> +
> +	return 0;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
