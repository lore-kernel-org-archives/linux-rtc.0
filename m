Return-Path: <rtc-linux+bncBDY3NC743AGBBV4ZTS3QKGQE5FJQ4LI@googlegroups.com>
Received: from smtprelay.hostedemail.com (smtprelay0246.hostedemail.com. [216.40.44.246])
        by gmr-mx.google.com with ESMTPS id uw3si1029194igb.1.2016.03.14.12.11.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 12:11:19 -0700 (PDT)
Message-ID: <1457982675.11972.119.camel@perches.com>
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Don't print an error on probe deferral
From: Joe Perches <joe@perches.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>,  rtc-linux@googlegroups.com
Date: Mon, 14 Mar 2016 12:11:15 -0700
In-Reply-To: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
References: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2016-03-14 at 16:05 -0300, Javier Martinez Canillas wrote:
> The clock and source clock looked up by the driver may not be available
> just because the clock controller driver was not probed yet so printing
> an error in this case is not correct and only adds confusion to users.
>=20
> However, knowing that a driver's probe was deferred may be useful so it
> can be printed as debug information.
[]
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
[]
> @@ -501,18 +501,27 @@ static int s3c_rtc_probe(struct platform_device *pd=
ev)
> =C2=A0
> =C2=A0	info->rtc_clk =3D devm_clk_get(&pdev->dev, "rtc");
> =C2=A0	if (IS_ERR(info->rtc_clk)) {
> -		dev_err(&pdev->dev, "failed to find rtc clock\n");
> -		return PTR_ERR(info->rtc_clk);
> +		ret =3D PTR_ERR(info->rtc_clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to find rtc clock\n");
> +		else
> +			dev_dbg(&pdev->dev, "probe deferred due rtc clock\n");
> +		return ret;
> =C2=A0	}
> =C2=A0	clk_prepare_enable(info->rtc_clk);
> =C2=A0
> =C2=A0	if (info->data->needs_src_clk) {
> =C2=A0		info->rtc_src_clk =3D devm_clk_get(&pdev->dev, "rtc_src");
> =C2=A0		if (IS_ERR(info->rtc_src_clk)) {
> -			dev_err(&pdev->dev,
> -				"failed to find rtc source clock\n");
> +			ret =3D PTR_ERR(info->rtc_src_clk);
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(&pdev->dev,
> +					"failed to find rtc source clock\n");
> +			else
> +				dev_dbg(&pdev->dev,
> +					"probe deferred due rtc source clock\n");
> =C2=A0			clk_disable_unprepare(info->rtc_clk);
> -			return PTR_ERR(info->rtc_src_clk);
> +			return ret;
> =C2=A0		}
> =C2=A0		clk_prepare_enable(info->rtc_src_clk);
> =C2=A0	}

Maybe the debug logging messages could be object->action like:

	rtc clock probe deferred
	rtc source clock probe deferred


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
