Return-Path: <rtc-linux+bncBDA7X7F2WUEBBSVGZK5QKGQEF7LMRMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id a6si1029334wma.1.2016.06.28.08.10.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 08:10:02 -0700 (PDT)
Received: by mail-wm0-x22c.google.com with SMTP id a66so32453311wme.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Jun 2016 08:10:02 -0700 (PDT)
Date: Tue, 28 Jun 2016 16:10:54 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/5] mfd: pm8921: Add support for pm8018
Message-ID: <20160628151054.GP24982@dell>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466759887-25394-2-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 24 Jun 2016, Neil Armstrong wrote:

> In order to support the Qualcomm MDM9615 PMIC, add support for the
> pm8018 in pm8921 mfd driver.
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mfd/pm8921-core.c | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
> index 1b7ec08..0e3a2ea 100644
> --- a/drivers/mfd/pm8921-core.c
> +++ b/drivers/mfd/pm8921-core.c
> @@ -309,6 +309,7 @@ static const struct regmap_config ssbi_regmap_config =
=3D {
>  };
> =20
>  static const struct of_device_id pm8921_id_table[] =3D {
> +	{ .compatible =3D "qcom,pm8018", },
>  	{ .compatible =3D "qcom,pm8058", },
>  	{ .compatible =3D "qcom,pm8921", },
>  	{ }

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
