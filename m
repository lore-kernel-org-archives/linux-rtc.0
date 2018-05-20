Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:60172 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeETSFW (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 20 May 2018 14:05:22 -0400
Date: Sun, 20 May 2018 20:05:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] rtc: pcf2127: add support for accessing internal static
 RAM
Message-ID: <20180520180520.GC23730@piout.net>
References: <20180520133723.30547-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180520133723.30547-1-u.kleine-koenig@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 20/05/2018 15:37:23+0200, Uwe Kleine-König wrote:
>  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> -			const char *name)
> +			const char *name, bool has_nvmem)
>  {
>  	struct pcf2127 *pcf2127;
> +	int ret = 0;
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> @@ -200,8 +242,21 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  
>  	pcf2127->rtc = devm_rtc_device_register(dev, name, &pcf2127_rtc_ops,
>  						THIS_MODULE);
> +	if (IS_ERR(pcf2127->rtc))
> +		return PTR_ERR(pcf2127->rtc);
> +
> +	if (has_nvmem) {
> +		struct nvmem_config nvmem_cfg = {
> +			.priv = pcf2127,
> +			.reg_read = pcf2127_nvmem_read,
> +			.reg_write = pcf2127_nvmem_write,
> +			.size = 512,
> +		};
> +
> +		ret = rtc_nvmem_register(pcf2127->rtc, &nvmem_cfg);
> +	}
>  
> -	return PTR_ERR_OR_ZERO(pcf2127->rtc);
> +	return ret;

You must not return an error here once devm_rtc_device_register has
succeeded. You have the choice between ignoring the nvmem registration
error or switching to devm_rtc_allocate_device/rtc_register_device().

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
