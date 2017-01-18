Return-Path: <rtc-linux+bncBDA7X7F2WUEBBZPB7TBQKGQEFX7LDPQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id 133si1378408wmj.1.2017.01.18.01.09.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2017 01:09:57 -0800 (PST)
Received: by mail-wm0-x232.google.com with SMTP id r144so14473081wme.1
        for <rtc-linux@googlegroups.com>; Wed, 18 Jan 2017 01:09:57 -0800 (PST)
Date: Wed, 18 Jan 2017 09:13:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH 4/4] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170118091350.GC3718@dell>
References: <20170111165221.17337-1-enric.balletbo@collabora.com>
 <20170111165221.17337-4-enric.balletbo@collabora.com>
 <20170118020156.ynayqtudiu5j2db3@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170118020156.ynayqtudiu5j2db3@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 18 Jan 2017, Alexandre Belloni wrote:
> I don't think that one has your ack, is it ok for me to take it?

This set looks MFD heavy, so it's probably best that the set goes
through MFD.  Once the RTC patch has been fixed of course.

Unless you want to take the whole set, in which case I'll need a
signed immutable branch from you.

> On 11/01/2017 at 17:52:21 +0100, Enric Balletbo i Serra wrote :
> > From: Stephen Barber <smbarber@chromium.org>
> >=20
> > If the EC supports RTC host commands, expose an RTC device.
> >=20
> > Signed-off-by: Stephen Barber <smbarber@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/c=
hrome/cros_ec_dev.c
> > index 47268ec..ebe029d 100644
> > --- a/drivers/platform/chrome/cros_ec_dev.c
> > +++ b/drivers/platform/chrome/cros_ec_dev.c
> > @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_e=
c_dev *ec)
> >  	kfree(msg);
> >  }
> > =20
> > +static const struct mfd_cell cros_ec_rtc_devs[] =3D {
> > +	{
> > +		.name =3D "cros-ec-rtc",
> > +		.id   =3D -1,
> > +	},
> > +};
> > +
> > +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
> > +{
> > +	int ret;
> > +
> > +	ret =3D mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
> > +			      ARRAY_SIZE(cros_ec_rtc_devs),
> > +			      NULL, 0, NULL);
> > +	if (ret)
> > +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
> > +}
> > +
> >  static int ec_device_probe(struct platform_device *pdev)
> >  {
> >  	int retval =3D -ENOMEM;
> > @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device =
*pdev)
> >  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> >  		cros_ec_sensors_register(ec);
> > =20
> > +	/* check whether this EC instance has RTC host command support */
> > +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
> > +		cros_ec_rtc_register(ec);
> > +
> >  	return 0;
> > =20
> >  dev_reg_failed:
>=20

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
