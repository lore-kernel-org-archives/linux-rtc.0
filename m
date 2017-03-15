Return-Path: <rtc-linux+bncBDA7X7F2WUEBB5NMUTDAKGQEUWTX2MQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id y19si600387wmd.0.2017.03.15.03.24.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2017 03:24:53 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id n11so18950207wma.0
        for <rtc-linux@googlegroups.com>; Wed, 15 Mar 2017 03:24:53 -0700 (PDT)
Date: Wed, 15 Mar 2017 10:24:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Stephen Barber <smbarber@chromium.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [rtc-linux] Re: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170315102449.bqr3hezlrdovjyrq@dell>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
 <20170214221529.6434-4-enric.balletbo@collabora.com>
 <20170314135932.ngn7uh67duzroy47@dell>
 <f934a89e-8f0b-5a74-1c6f-8b9f1d85ba72@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f934a89e-8f0b-5a74-1c6f-8b9f1d85ba72@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 14 Mar 2017, Enric Balletbo i Serra wrote:
> On 14/03/17 14:59, Lee Jones wrote:
> > On Tue, 14 Feb 2017, Enric Balletbo i Serra wrote:
> >=20
> >> From: Stephen Barber <smbarber@chromium.org>
> >>
> >> If the EC supports RTC host commands, expose an RTC device.
> >>
> >> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Acked-by: Benson Leung <bleung@chromium.org>
> >> ---
> >> Changes since v2:
> >>  - Acked by Benson Leung
> >> Changes since v1:
> >>  - none
> >>
> >>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/=
chrome/cros_ec_dev.c
> >> index 47268ec..ebe029d 100644
> >> --- a/drivers/platform/chrome/cros_ec_dev.c
> >> +++ b/drivers/platform/chrome/cros_ec_dev.c
> >> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_=
ec_dev *ec)
> >>  	kfree(msg);
> >>  }
> >> =20
> >> +static const struct mfd_cell cros_ec_rtc_devs[] =3D {
> >> +	{
> >> +		.name =3D "cros-ec-rtc",
> >> +		.id   =3D -1,
> >> +	},
> >> +};
> >> +
> >> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret =3D mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
> >> +			      ARRAY_SIZE(cros_ec_rtc_devs),
> >> +			      NULL, 0, NULL);
> >> +	if (ret)
> >> +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
> >> +}
> >=20
> > Holey poop!  Why are you using the MFD API outside of MFD?
> >=20
> > Why can't you register this from the MFD driver?
> >=20
>=20
> Actually the MFD doesn't know how to check if this feature is available o=
r not,
> instead is the platform driver cros_ec_dev who knows how to check this an=
d if it
> exists adds the rtc device.
>=20
> if (cros_ec_check_features(ec, EC_FEATURE_RTC))
> 	cros_ec_rtc_register(ec); /* add the mfd device */
>=20
> Same approach was used in the same file for the Sensors Hub (already upst=
ream). See:
>=20
>   drivers/platform/chrome/cros_ec_dev.c:462
>   drivers/platform/chrome/cros_ec_dev.c:372
>=20
> I didn't know that the MFD API was restricted outside MFD. In such case w=
hat I
> need to do is let know the MFD driver about the cros_ec_check_features
> (implemented in platform driver cros_ec_dev), this doesn't seems good to =
me but
> I might be wrong. So please, let me know which option do you prefer and i=
f it's
> the case we will need to change I'll try to do it.
>=20
> Note that I think that a similar use case is used in
> drivers/iio/common/ssp_sensors/ssp_dev.c:535, where the iio driver regist=
ers the
> sensors to the mfd.

It would be advantageous to avoid a web of inter-subsystem calls to
register devices.  I think I could bear calls to mfd_add_* from
drivers/platform, as the two subsystems are fairly interchangeable,
and it does have the added benefit of saving duplication of the device
registering code.  Calling mfd_add_* from IIO seems plain wrong though.

A better solution however and one that we've utilised in the past is
to have the MFD drivers call into the platform (i.e. drivers/platform)
drivers to see if certain devices are available.  Is this possible in
your use-case?

NB: I've just had a look at the SSP IIO driver and I have a number of
problems with it.  You should not be using that as a good example of
why mfd_add_* should be used outside of MFD.

> >>  static int ec_device_probe(struct platform_device *pdev)
> >>  {
> >>  	int retval =3D -ENOMEM;
> >> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device=
 *pdev)
> >>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> >>  		cros_ec_sensors_register(ec);
> >> =20
> >> +	/* check whether this EC instance has RTC host command support */
> >> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
> >> +		cros_ec_rtc_register(ec);
> >> +
> >>  	return 0;
> >> =20
> >>  dev_reg_failed:
> >=20

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
