Return-Path: <rtc-linux+bncBDA7X7F2WUEBBS5WRHDQKGQEL3R2KZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x22b.google.com (mail-wr0-x22b.google.com. [2a00:1450:400c:c0c::22b])
        by gmr-mx.google.com with ESMTPS id i76si1103112wmh.1.2017.04.03.07.25.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 07:25:15 -0700 (PDT)
Received: by mail-wr0-x22b.google.com with SMTP id k6so166621526wre.2
        for <rtc-linux@googlegroups.com>; Mon, 03 Apr 2017 07:25:15 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:25:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
	bleung@chromium.org, martinez.javier@gmail.com,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH 7/7] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170403142512.dlipwaocizisyipg@dell>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-8-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170324174407.25401-8-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:

> From: Stephen Barber <smbarber@chromium.org>
>=20
> If the EC supports RTC host commands, expose an RTC device.
>=20
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index bbc17ab..1ff88b1 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -51,6 +51,11 @@ static const struct mfd_cell ec_pd_cell =3D {
>  	.pdata_size =3D sizeof(pd_p),
>  };
> =20
> +static const struct mfd_cell ec_rtc_cell =3D {
> +	.name =3D "cros-ec-rtc",
> +	.id   =3D -1,

Why -1?

> +};
> +
>  static irqreturn_t ec_irq_thread(int irq, void *data)
>  {
>  	struct cros_ec_device *ec_dev =3D data;
> @@ -238,6 +243,15 @@ static void cros_ec_sensors_register(struct cros_ec_=
device *ec_dev)
>  	kfree(msg);
>  }
> =20
> +static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
> +{
> +	int ret;
> +
> +	ret =3D mfd_add_devices(ec_dev->dev, 0, &ec_rtc_cell, 1, NULL, 0, NULL)=
;

Why 0?

> +	if (ret)
> +		dev_err(ec_dev->dev, "failed to add EC RTC\n");
> +}
> +
>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev =3D ec_dev->dev;
> @@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec_dev);
> =20
> +	/* Check whether this EC has RTC support */
> +	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
> +		cros_ec_rtc_register(ec_dev);
> +
>  	if (ec_dev->max_passthru) {
>  		/*
>  		 * Register a PD device as well on top of this device.

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
