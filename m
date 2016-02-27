Return-Path: <rtc-linux+bncBAABBG5WY63AKGQEDSF23VA@googlegroups.com>
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk. [2a01:8000:1ffa:f003:bc9d:1dff:fe9b:7466])
        by gmr-mx.google.com with ESMTPS id c140si27969wmh.1.2016.02.27.09.21.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Feb 2016 09:21:31 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 7/7] iio: adc: palmas: Drop IRQF_EARLY_RESUME flag
To: Grygorii Strashko <grygorii.strashko@ti.com>,
 Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
 <1456501377-16871-8-git-send-email-grygorii.strashko@ti.com>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Nishanth Menon <nm@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56D1DB19.5030504@kernel.org>
Date: Sat, 27 Feb 2016 17:21:29 +0000
MIME-Version: 1.0
In-Reply-To: <1456501377-16871-8-git-send-email-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/02/16 15:42, Grygorii Strashko wrote:
> Palmas gpadc IRQs are nested threaded and this flag is not required for nested
> irqs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread
> irqs over system suspend") was merged.
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/palmas_gpadc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index f42eb8a..2bbf0c5 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -534,7 +534,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	}
>  	ret = request_threaded_irq(adc->irq, NULL,
>  		palmas_gpadc_irq,
> -		IRQF_ONESHOT | IRQF_EARLY_RESUME, dev_name(adc->dev),
> +		IRQF_ONESHOT, dev_name(adc->dev),
>  		adc);
>  	if (ret < 0) {
>  		dev_err(adc->dev,
> @@ -549,7 +549,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
>  		ret = request_threaded_irq(adc->irq_auto_0, NULL,
>  				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas-adc-auto-0", adc);
>  		if (ret < 0) {
>  			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
> @@ -565,7 +565,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
>  		ret = request_threaded_irq(adc->irq_auto_1, NULL,
>  				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas-adc-auto-1", adc);
>  		if (ret < 0) {
>  			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
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
