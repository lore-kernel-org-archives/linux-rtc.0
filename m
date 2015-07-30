Return-Path: <rtc-linux+bncBCR2DK7W6QHBBNXK46WQKGQEIZBVI2Q@googlegroups.com>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com. [212.144.249.243])
        by gmr-mx.google.com with ESMTPS id ct6si97408pdb.1.2015.07.30.02.58.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 02:58:13 -0700 (PDT)
Message-ID: <55B9F4F1.2060901@atmel.com>
Date: Thu, 30 Jul 2015 11:57:05 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <rtc-linux@googlegroups.com>,
	Alessandro Zummo <a.zummo@towertech.it>, <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 1/5] rtc: at91sam9: properly handle error case
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Le 30/07/2015 02:24, Alexandre Belloni a =C3=A9crit :
> In case of a probe error, it is possible to abort after issuing
> clk_prepare_enable(). Ensure the clock is disabled and unprepared in that
> case.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>  drivers/rtc/rtc-at91sam9.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 5ccaee32df72..152cd816cc43 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -451,8 +451,10 @@ static int at91_rtc_probe(struct platform_device *pd=
ev)
> =20
>  	rtc->rtcdev =3D devm_rtc_device_register(&pdev->dev, pdev->name,
>  					&at91_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtcdev))
> -		return PTR_ERR(rtc->rtcdev);
> +	if (IS_ERR(rtc->rtcdev)) {
> +		ret =3D PTR_ERR(rtc->rtcdev);
> +		goto err_clk;
> +	}
> =20
>  	/* register irq handler after we know what name we'll use */
>  	ret =3D devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
> @@ -460,7 +462,7 @@ static int at91_rtc_probe(struct platform_device *pde=
v)
>  			       dev_name(&rtc->rtcdev->dev), rtc);
>  	if (ret) {
>  		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
> -		return ret;
> +		goto err_clk;
>  	}
> =20
>  	/* NOTE:  sam9260 rev A silicon has a ROM bug which resets the
> @@ -474,6 +476,11 @@ static int at91_rtc_probe(struct platform_device *pd=
ev)
>  				dev_name(&rtc->rtcdev->dev));
> =20
>  	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(rtc->sclk);
> +
> +	return ret;
>  }
> =20
>  /*
>=20


--=20
Nicolas Ferre

--=20
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
