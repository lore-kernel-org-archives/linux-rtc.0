Return-Path: <rtc-linux+bncBDXMLNOH5ANRBNOH3XCQKGQEYYULWFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id s64si1131131pfk.0.2017.03.01.16.13.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 16:13:41 -0800 (PST)
Date: Thu, 2 Mar 2017 01:13:32 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: omap: remove incorrect __exit markups
Message-ID: <20170302001332.cooiz5s4nac3iury@earth>
References: <20170301233323.GA8881@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3n3c3iy7r7l35q6"
In-Reply-To: <20170301233323.GA8881@dtor-ws>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--y3n3c3iy7r7l35q6
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Wed, Mar 01, 2017 at 03:33:23PM -0800, Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe(), which specifically disables sysfs bind/unbind
> attributes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/rtc/rtc-omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 51e52446eacb..fa856d9c5e23 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -844,7 +844,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit omap_rtc_remove(struct platform_device *pdev)
> +static int omap_rtc_remove(struct platform_device *pdev)
>  {
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>  	u8 reg;
> @@ -964,7 +964,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  
>  static struct platform_driver omap_rtc_driver = {
>  	.probe		= omap_rtc_probe,
> -	.remove		= __exit_p(omap_rtc_remove),
> +	.remove		= omap_rtc_remove,
>  	.shutdown	= omap_rtc_shutdown,
>  	.driver		= {
>  		.name	= "omap_rtc",

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--y3n3c3iy7r7l35q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli3Y6sACgkQ2O7X88g7
+poBPxAAme6gBdEtcfo8TkPcR8cDXN9SsF5g9bDvblBE7ZMXO/35069oBEqJ0U5u
5IaFGjdC6Csvv/3SfhOd5CzmBndM1YGaD4CGQ1mafOeA07Gcu8fG/sezysxUTPhr
p8a7iYD+MDnDkObYHweccOFxj8GDwv6Lk/cp33DSlBLCn2ucyoeBbNI9RUiBzCHf
QeQEbzP1jjRWR7JWe1XV5OaDesgpPl/zJZ29gAl5qFQf8lMPdbCCBLn23DMzb5GE
Kt/SzA15J8ir7ucrdg37QHAoRoskwN06QNpWXoGBP9F1KxxYSoPlVn+gwCkpxplN
SknBTiiu/IDkvnnnt3+oSNf5OU7uZ4jJYcFCX1stYIt6OcDPYv5BdjO2q8evGLxN
oS319R3BEYLYD8cBVeIIjy6hYdD1oPJA3Gs3bHlKtZZGM8kDiBp4Gq1DYkNdZZAl
fvpaJ50jAwqJ8cM9pPHrJXw7Y1r5gaHVv+VE4kEKnEpzv0kw3N/unZAabM36NvAb
yJfDx8VJbzrxvVxdCkBa+Bk2TBg2sAjvuBrx6PMfpKwUFAM9y2ecsSNGN+9AQMhc
uW1ovxNn3vUlnjCK2FnnuAHtwj0u96nfDWSp2F6+3KJmLYlZZk+httEoVrl+izYF
kzYhjlueaYzSSkG/Sr5ekU0LfMTlMmRvQvMP2iSbNCEUsH2OFX4=
=ClCt
-----END PGP SIGNATURE-----

--y3n3c3iy7r7l35q6--
