Return-Path: <rtc-linux+bncBDA7X7F2WUEBBR7OT7DAKGQEWVRAWVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x22c.google.com (mail-wr0-x22c.google.com. [2a00:1450:400c:c0c::22c])
        by gmr-mx.google.com with ESMTPS id b186si196269wme.1.2017.03.14.06.59.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 06:59:35 -0700 (PDT)
Received: by mail-wr0-x22c.google.com with SMTP id u48so124713963wrc.0
        for <rtc-linux@googlegroups.com>; Tue, 14 Mar 2017 06:59:35 -0700 (PDT)
Date: Tue, 14 Mar 2017 13:59:32 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170314135932.ngn7uh67duzroy47@dell>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
 <20170214221529.6434-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170214221529.6434-4-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 14 Feb 2017, Enric Balletbo i Serra wrote:

> From: Stephen Barber <smbarber@chromium.org>
>=20
> If the EC supports RTC host commands, expose an RTC device.
>=20
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Benson Leung <bleung@chromium.org>
> ---
> Changes since v2:
>  - Acked by Benson Leung
> Changes since v1:
>  - none
>=20
>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chr=
ome/cros_ec_dev.c
> index 47268ec..ebe029d 100644
> --- a/drivers/platform/chrome/cros_ec_dev.c
> +++ b/drivers/platform/chrome/cros_ec_dev.c
> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec_=
dev *ec)
>  	kfree(msg);
>  }
> =20
> +static const struct mfd_cell cros_ec_rtc_devs[] =3D {
> +	{
> +		.name =3D "cros-ec-rtc",
> +		.id   =3D -1,
> +	},
> +};
> +
> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
> +{
> +	int ret;
> +
> +	ret =3D mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
> +			      ARRAY_SIZE(cros_ec_rtc_devs),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
> +}

Holey poop!  Why are you using the MFD API outside of MFD?

Why can't you register this from the MFD driver?

>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval =3D -ENOMEM;
> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
> =20
> +	/* check whether this EC instance has RTC host command support */
> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
> +		cros_ec_rtc_register(ec);
> +
>  	return 0;
> =20
>  dev_reg_failed:

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
