Return-Path: <rtc-linux+bncBDA7X7F2WUEBBLHGUG6QKGQEA2D5ULA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id i193si991054wmg.1.2016.08.08.04.55.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 04:55:24 -0700 (PDT)
Received: by mail-wm0-x230.google.com with SMTP id q128so19616554wma.1
        for <rtc-linux@googlegroups.com>; Mon, 08 Aug 2016 04:55:24 -0700 (PDT)
Date: Mon, 8 Aug 2016 12:56:51 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v5 4/7] rtc: ac100: Add clk output support
Message-ID: <20160808115651.GO5243@dell>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
 <1467988422-17934-5-git-send-email-wens@csie.org>
 <20160708162932.GN22202@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160708162932.GN22202@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 08 Jul 2016, Alexandre Belloni wrote:

> On 08/07/2016 at 22:33:39 +0800, Chen-Yu Tsai wrote :
> > The AC100's RTC side has 3 clock outputs on external pins, which can
> > provide a clock signal to the SoC or other modules, such as WiFi or
> > GSM modules.
> >=20
> > Support this with a custom clk driver integrated with the rtc driver.
> >=20
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>=20
> > ---
> > Changes since v4: none
> >=20
> > Changes since v3:
> >=20
> >   - Renamed clk32k prefixes to clkout, except for the internal 32k clk
> >   - Changed default clk output names to "ac100-cko{1,2,3}-rtc"
> >   - Moved 4M ADDA clk to codec side
> >=20
> > Changes since v2: none
> > Changes since v1: none
> >=20
> > ---
> >  drivers/rtc/rtc-ac100.c | 302 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 302 insertions(+)

Applied, thanks.

> > diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> > index 5a9ca89d04c7..70b4fd0f6122 100644
> > --- a/drivers/rtc/rtc-ac100.c
> > +++ b/drivers/rtc/rtc-ac100.c
> > @@ -16,6 +16,7 @@
> >   */
> > =20
> >  #include <linux/bcd.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/device.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -31,6 +32,15 @@
> >  /* Control register */
> >  #define AC100_RTC_CTRL_24HOUR	BIT(0)
> > =20
> > +/* Clock output register bits */
> > +#define AC100_CLKOUT_PRE_DIV_SHIFT	5
> > +#define AC100_CLKOUT_PRE_DIV_WIDTH	3
> > +#define AC100_CLKOUT_MUX_SHIFT		4
> > +#define AC100_CLKOUT_MUX_WIDTH		1
> > +#define AC100_CLKOUT_DIV_SHIFT		1
> > +#define AC100_CLKOUT_DIV_WIDTH		3
> > +#define AC100_CLKOUT_EN			BIT(0)
> > +
> >  /* RTC */
> >  #define AC100_RTC_SEC_MASK	GENMASK(6, 0)
> >  #define AC100_RTC_MIN_MASK	GENMASK(6, 0)
> > @@ -67,14 +77,292 @@
> >  #define AC100_YEAR_MAX				2069
> >  #define AC100_YEAR_OFF				(AC100_YEAR_MIN - 1900)
> > =20
> > +struct ac100_clkout {
> > +	struct clk_hw hw;
> > +	struct regmap *regmap;
> > +	u8 offset;
> > +};
> > +
> > +#define to_ac100_clkout(_hw) container_of(_hw, struct ac100_clkout, hw=
)
> > +
> > +#define AC100_RTC_32K_NAME	"ac100-rtc-32k"
> > +#define AC100_RTC_32K_RATE	32768
> > +#define AC100_CLKOUT_NUM	3
> > +
> > +static const char * const ac100_clkout_names[AC100_CLKOUT_NUM] =3D {
> > +	"ac100-cko1-rtc",
> > +	"ac100-cko2-rtc",
> > +	"ac100-cko3-rtc",
> > +};
> > +
> >  struct ac100_rtc_dev {
> >  	struct rtc_device *rtc;
> >  	struct device *dev;
> >  	struct regmap *regmap;
> >  	int irq;
> >  	unsigned long alarm;
> > +
> > +	struct clk_hw *rtc_32k_clk;
> > +	struct ac100_clkout clks[AC100_CLKOUT_NUM];
> > +	struct clk_hw_onecell_data *clk_data;
> >  };
> > =20
> > +/**
> > + * Clock controls for 3 clock output pins
> > + */
> > +
> > +static const struct clk_div_table ac100_clkout_prediv[] =3D {
> > +	{ .val =3D 0, .div =3D 1 },
> > +	{ .val =3D 1, .div =3D 2 },
> > +	{ .val =3D 2, .div =3D 4 },
> > +	{ .val =3D 3, .div =3D 8 },
> > +	{ .val =3D 4, .div =3D 16 },
> > +	{ .val =3D 5, .div =3D 32 },
> > +	{ .val =3D 6, .div =3D 64 },
> > +	{ .val =3D 7, .div =3D 122 },
> > +	{ },
> > +};
> > +
> > +/* Abuse the fact that one parent is 32768 Hz, and the other is 4 MHz =
*/
> > +static unsigned long ac100_clkout_recalc_rate(struct clk_hw *hw,
> > +					      unsigned long prate)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +	unsigned int reg, div;
> > +
> > +	regmap_read(clk->regmap, clk->offset, &reg);
> > +
> > +	/* Handle pre-divider first */
> > +	if (prate !=3D AC100_RTC_32K_RATE) {
> > +		div =3D (reg >> AC100_CLKOUT_PRE_DIV_SHIFT) &
> > +			((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1);
> > +		prate =3D divider_recalc_rate(hw, prate, div,
> > +					    ac100_clkout_prediv, 0);
> > +	}
> > +
> > +	div =3D (reg >> AC100_CLKOUT_DIV_SHIFT) &
> > +		(BIT(AC100_CLKOUT_DIV_WIDTH) - 1);
> > +	return divider_recalc_rate(hw, prate, div, NULL,
> > +				   CLK_DIVIDER_POWER_OF_TWO);
> > +}
> > +
> > +static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long r=
ate,
> > +				    unsigned long prate)
> > +{
> > +	unsigned long best_rate =3D 0, tmp_rate, tmp_prate;
> > +	int i;
> > +
> > +	if (prate =3D=3D AC100_RTC_32K_RATE)
> > +		return divider_round_rate(hw, rate, &prate, NULL,
> > +					  AC100_CLKOUT_DIV_WIDTH,
> > +					  CLK_DIVIDER_POWER_OF_TWO);
> > +
> > +	for (i =3D 0; ac100_clkout_prediv[i].div; i++) {
> > +		tmp_prate =3D DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
> > +		tmp_rate =3D divider_round_rate(hw, rate, &tmp_prate, NULL,
> > +					      AC100_CLKOUT_DIV_WIDTH,
> > +					      CLK_DIVIDER_POWER_OF_TWO);
> > +
> > +		if (tmp_rate > rate)
> > +			continue;
> > +		if (rate - tmp_rate < best_rate - tmp_rate)
> > +			best_rate =3D tmp_rate;
> > +	}
> > +
> > +	return best_rate;
> > +}
> > +
> > +static int ac100_clkout_determine_rate(struct clk_hw *hw,
> > +				       struct clk_rate_request *req)
> > +{
> > +	struct clk_hw *best_parent;
> > +	unsigned long best =3D 0;
> > +	int i, num_parents =3D clk_hw_get_num_parents(hw);
> > +
> > +	for (i =3D 0; i < num_parents; i++) {
> > +		struct clk_hw *parent =3D clk_hw_get_parent_by_index(hw, i);
> > +		unsigned long tmp, prate =3D clk_hw_get_rate(parent);
> > +
> > +		tmp =3D ac100_clkout_round_rate(hw, req->rate, prate);
> > +
> > +		if (tmp > req->rate)
> > +			continue;
> > +		if (req->rate - tmp < req->rate - best) {
> > +			best =3D tmp;
> > +			best_parent =3D parent;
> > +		}
> > +	}
> > +
> > +	if (!best)
> > +		return -EINVAL;
> > +
> > +	req->best_parent_hw =3D best_parent;
> > +	req->best_parent_rate =3D best;
> > +	req->rate =3D best;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ac100_clkout_set_rate(struct clk_hw *hw, unsigned long rate=
,
> > +				 unsigned long prate)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +	int div =3D 0, pre_div =3D 0;
> > +
> > +	do {
> > +		div =3D divider_get_val(rate * ac100_clkout_prediv[pre_div].div,
> > +				      prate, NULL, AC100_CLKOUT_DIV_WIDTH,
> > +				      CLK_DIVIDER_POWER_OF_TWO);
> > +		if (div >=3D 0)
> > +			break;
> > +	} while (prate !=3D AC100_RTC_32K_RATE &&
> > +		 ac100_clkout_prediv[++pre_div].div);
> > +
> > +	if (div < 0)
> > +		return div;
> > +
> > +	pre_div =3D ac100_clkout_prediv[pre_div].val;
> > +
> > +	regmap_update_bits(clk->regmap, clk->offset,
> > +			   ((1 << AC100_CLKOUT_DIV_WIDTH) - 1) << AC100_CLKOUT_DIV_SHIFT |
> > +			   ((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1) << AC100_CLKOUT_PRE_DIV_=
SHIFT,
> > +			   (div - 1) << AC100_CLKOUT_DIV_SHIFT |
> > +			   (pre_div - 1) << AC100_CLKOUT_PRE_DIV_SHIFT);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ac100_clkout_prepare(struct clk_hw *hw)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +
> > +	return regmap_update_bits(clk->regmap, clk->offset, AC100_CLKOUT_EN,
> > +				  AC100_CLKOUT_EN);
> > +}
> > +
> > +static void ac100_clkout_unprepare(struct clk_hw *hw)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +
> > +	regmap_update_bits(clk->regmap, clk->offset, AC100_CLKOUT_EN, 0);
> > +}
> > +
> > +static int ac100_clkout_is_prepared(struct clk_hw *hw)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +	unsigned int reg;
> > +
> > +	regmap_read(clk->regmap, clk->offset, &reg);
> > +
> > +	return reg & AC100_CLKOUT_EN;
> > +}
> > +
> > +static u8 ac100_clkout_get_parent(struct clk_hw *hw)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +	unsigned int reg;
> > +
> > +	regmap_read(clk->regmap, clk->offset, &reg);
> > +
> > +	return (reg >> AC100_CLKOUT_MUX_SHIFT) & 0x1;
> > +}
> > +
> > +static int ac100_clkout_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct ac100_clkout *clk =3D to_ac100_clkout(hw);
> > +
> > +	return regmap_update_bits(clk->regmap, clk->offset,
> > +				  BIT(AC100_CLKOUT_MUX_SHIFT),
> > +				  index ? BIT(AC100_CLKOUT_MUX_SHIFT) : 0);
> > +}
> > +
> > +static const struct clk_ops ac100_clkout_ops =3D {
> > +	.prepare	=3D ac100_clkout_prepare,
> > +	.unprepare	=3D ac100_clkout_unprepare,
> > +	.is_prepared	=3D ac100_clkout_is_prepared,
> > +	.recalc_rate	=3D ac100_clkout_recalc_rate,
> > +	.determine_rate	=3D ac100_clkout_determine_rate,
> > +	.get_parent	=3D ac100_clkout_get_parent,
> > +	.set_parent	=3D ac100_clkout_set_parent,
> > +	.set_rate	=3D ac100_clkout_set_rate,
> > +};
> > +
> > +static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
> > +{
> > +	struct device_node *np =3D chip->dev->of_node;
> > +	const char *parents[2] =3D {AC100_RTC_32K_NAME};
> > +	int i, ret;
> > +
> > +	chip->clk_data =3D devm_kzalloc(chip->dev, sizeof(*chip->clk_data) +
> > +						 sizeof(*chip->clk_data->hws) *
> > +						 AC100_CLKOUT_NUM,
> > +						 GFP_KERNEL);
> > +	if (!chip->clk_data)
> > +		return -ENOMEM;
> > +
> > +	chip->rtc_32k_clk =3D clk_hw_register_fixed_rate(chip->dev,
> > +						       AC100_RTC_32K_NAME,
> > +						       NULL, 0,
> > +						       AC100_RTC_32K_RATE);
> > +	if (IS_ERR(chip->rtc_32k_clk)) {
> > +		ret =3D PTR_ERR(chip->rtc_32k_clk);
> > +		dev_err(chip->dev, "Failed to register RTC-32k clock: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	parents[1] =3D of_clk_get_parent_name(np, 0);
> > +	if (!parents[1]) {
> > +		dev_err(chip->dev, "Failed to get ADDA 4M clock\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < AC100_CLKOUT_NUM; i++) {
> > +		struct ac100_clkout *clk =3D &chip->clks[i];
> > +		struct clk_init_data init =3D {
> > +			.name =3D ac100_clkout_names[i],
> > +			.ops =3D &ac100_clkout_ops,
> > +			.parent_names =3D parents,
> > +			.num_parents =3D ARRAY_SIZE(parents),
> > +			.flags =3D 0,
> > +		};
> > +
> > +		clk->regmap =3D chip->regmap;
> > +		clk->offset =3D AC100_CLKOUT_CTRL1 + i;
> > +		clk->hw.init =3D &init;
> > +
> > +		ret =3D devm_clk_hw_register(chip->dev, &clk->hw);
> > +		if (ret) {
> > +			dev_err(chip->dev, "Failed to register clk '%s': %d\n",
> > +				init.name, ret);
> > +			goto err_unregister_rtc_32k;
> > +		}
> > +
> > +		chip->clk_data->hws[i] =3D &clk->hw;
> > +	}
> > +
> > +	chip->clk_data->num =3D i;
> > +	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_d=
ata);
> > +	if (ret)
> > +		goto err_unregister_rtc_32k;
> > +
> > +	return 0;
> > +
> > +err_unregister_rtc_32k:
> > +	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
> > +
> > +	return ret;
> > +}
> > +
> > +static void ac100_rtc_unregister_clks(struct ac100_rtc_dev *chip)
> > +{
> > +	of_clk_del_provider(chip->dev->of_node);
> > +	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
> > +}
> > +
> > +/**
> > + * RTC related bits
> > + */
> >  static int ac100_rtc_get_time(struct device *dev, struct rtc_time *rtc=
_tm)
> >  {
> >  	struct ac100_rtc_dev *chip =3D dev_get_drvdata(dev);
> > @@ -300,11 +588,24 @@ static int ac100_rtc_probe(struct platform_device=
 *pdev)
> >  		return PTR_ERR(chip->rtc);
> >  	}
> > =20
> > +	ret =3D ac100_rtc_register_clks(chip);
> > +	if (ret)
> > +		return ret;
> > +
> >  	dev_info(&pdev->dev, "RTC enabled\n");
> > =20
> >  	return 0;
> >  }
> > =20
> > +static int ac100_rtc_remove(struct platform_device *pdev)
> > +{
> > +	struct ac100_rtc_dev *chip =3D platform_get_drvdata(pdev);
> > +
> > +	ac100_rtc_unregister_clks(chip);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct of_device_id ac100_rtc_match[] =3D {
> >  	{ .compatible =3D "x-powers,ac100-rtc" },
> >  	{ },
> > @@ -313,6 +614,7 @@ MODULE_DEVICE_TABLE(of, ac100_rtc_match);
> > =20
> >  static struct platform_driver ac100_rtc_driver =3D {
> >  	.probe		=3D ac100_rtc_probe,
> > +	.remove		=3D ac100_rtc_remove,
> >  	.driver		=3D {
> >  		.name		=3D "ac100-rtc",
> >  		.of_match_table	=3D of_match_ptr(ac100_rtc_match),
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
