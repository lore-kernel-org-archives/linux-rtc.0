Return-Path: <rtc-linux+bncBDS7HNEFSALRBJN4VK3QKGQEGKTSWXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si349110wml.0.2016.03.17.05.08.05
        for <rtc-linux@googlegroups.com>;
        Thu, 17 Mar 2016 05:08:05 -0700 (PDT)
Date: Thu, 17 Mar 2016 13:08:04 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Burton <paul.burton@imgtec.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/5] rtc: rtc-jz4740: Add support for devicetree
Message-ID: <20160317120804.GD3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-3-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457217531-26064-3-git-send-email-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/03/2016 at 23:38:49 +0100, Paul Cercueil wrote :
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 47617bd..3914b1c 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>  #include <linux/slab.h>
> @@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
>  
> +static const struct of_device_id jz4740_rtc_of_match[] = {
> +	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
> +	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },

ingenic is not in Documentation/devicetree/bindings/vendor-prefixes.txt,
you have to add it there before using it.

Also, no space is necessary after the "(void *)" cast.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
> +
>  static int jz4740_rtc_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -252,12 +260,17 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
>  	uint32_t scratchpad;
>  	struct resource *mem;
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	const struct of_device_id *of_id = of_match_device(
> +			jz4740_rtc_of_match, &pdev->dev);
>  
>  	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>  	if (!rtc)
>  		return -ENOMEM;
>  
> -	rtc->type = id->driver_data;
> +	if (of_id)
> +		rtc->type = (enum jz4740_rtc_type) of_id->data;

No space after that cast either.

> +	else
> +		rtc->type = id->driver_data;
>  
>  	rtc->irq = platform_get_irq(pdev, 0);
>  	if (rtc->irq < 0) {
> @@ -345,6 +358,7 @@ static struct platform_driver jz4740_rtc_driver = {
>  	.driver	 = {
>  		.name  = "jz4740-rtc",
>  		.pm    = JZ4740_RTC_PM_OPS,
> +		.of_match_table = of_match_ptr(jz4740_rtc_of_match),
>  	},
>  	.id_table = jz4740_rtc_ids,
>  };
> -- 
> 2.7.0
> 

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
