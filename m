Return-Path: <rtc-linux+bncBDS7HNEFSALRBUU7W24QKGQE4WEJNNQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e64si554620wmi.3.2016.05.06.23.48.49
        for <rtc-linux@googlegroups.com>;
        Fri, 06 May 2016 23:48:49 -0700 (PDT)
Date: Sat, 7 May 2016 08:48:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Lee Jones <lee.jones@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, rtc-linux@googlegroups.com,
	r.baldyga@hackerion.com,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v6 6/9] rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
Message-ID: <20160507064845.GD2890@piout.net>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-5-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462519636-3250-5-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/05/2016 at 09:27:13 +0200, Krzysztof Kozlowski wrote :
> The regmap_irq_get_virq() can return zero or negative ERRNO, so it is
> insufficient to check only for non-zero value.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
> index 4998aee0f07f..1a06e17ebe9b 100644
> --- a/drivers/rtc/rtc-max8997.c
> +++ b/drivers/rtc/rtc-max8997.c
> @@ -497,7 +497,7 @@ static int max8997_rtc_probe(struct platform_device *pdev)
>  	}
>  
>  	virq = regmap_irq_get_virq(max8997->irq_data, MAX8997_PMICIRQ_RTCA1);
> -	if (!virq) {
> +	if (virq <= 0) {
>  		dev_err(&pdev->dev, "Failed to create mapping alarm IRQ\n");
>  		ret = -ENXIO;
>  		goto err_out;
> -- 
> 1.9.1
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
