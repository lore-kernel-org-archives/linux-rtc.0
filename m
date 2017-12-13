Return-Path: <rtc-linux+bncBDA7X7F2WUEBB6NZYPIQKGQE32JHUZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id s29si181262eds.0.2017.12.12.23.55.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 23:55:37 -0800 (PST)
Received: by mail-wm0-x244.google.com with SMTP id 9so3073017wme.4
        for <rtc-linux@googlegroups.com>; Tue, 12 Dec 2017 23:55:37 -0800 (PST)
Date: Wed, 13 Dec 2017 07:55:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH v4 0/2] Add support for cros-ec-rtc driver.
Message-ID: <20171213075535.jv66ghgx4kjsa62w@dell>
References: <20171110215553.20696-1-enric.balletbo@collabora.com>
 <CAFqH_53pDkcXXpzvPqF9OS0ahmhHCV87925E82d0p7ym5gq=VQ@mail.gmail.com>
 <20171212160537.GF8318@piout.net>
 <20171212170525.GG8318@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20171212170525.GG8318@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 12 Dec 2017, Alexandre Belloni wrote:

> On 12/12/2017 at 17:05:37 +0100, Alexandre Belloni wrote:
> > On 12/12/2017 at 16:41:39 +0100, Enric Balletbo Serra wrote:
> > > +   Alessandro Zummo
> > > +   Alexandre Belloni
> > >=20
> > > 2017-11-10 22:55 GMT+01:00 Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com>:
> > > > Dear all,
> > > >
> > > > This is an attempt to revive some patches from that [1] patchset, s=
ome
> > > > of them are still under discussion but I think there is no reason t=
o not
> > > > have the other two in this fourth version to land upstream meanwhil=
e we
> > > > discuss about the others.
> > > >
> > > > [1] https://lkml.org/lkml/2017/7/12/182
> > > >
> > > > Changes since v3:
> > > > * Rebased an retested with current mainline using a Samsung Chromeb=
ook Plus
> > > > * Removed from patchset
> > > >   * 1/4 mfd: cros_ec: Get rid of cros_ec_check_features from cros_e=
c_dev.
> > > >   * 4/4 mfd: cros_ec: add RTC as mfd subdevice.
> > > >
> > > > Changes since v2:
> > > > - Rebase on top of mainline.
> > > > - Removed patch 'mfd: cros-ec: Fix host command buffer size' from s=
eries
> > > > as was already picked.
> > > >
> > > > Changes since v1:
> > > > - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw =
and
> > > > calibbias data' from series as was already picked.
> > > > - Removed patch 'iio: cros_ec_sensors: Fix return value to get raw =
and
> > > > calibbias data' from series as was already picked.
> > > > - Patch 2/5: Acked-by: Jonathan Cameron <***@kernel.org>
> > > >
> > > > Best regards,
> > > >
> > > >  Enric
> > > >
> > > > Stephen Barber (2):
> > > >   mfd: cros_ec: Introduce RTC commands and events definitions.
> > > >   rtc: cros-ec: add cros-ec-rtc driver.
> > > >
> > > >  drivers/rtc/Kconfig                  |  10 +
> > > >  drivers/rtc/Makefile                 |   1 +
> > > >  drivers/rtc/rtc-cros-ec.c            | 413 +++++++++++++++++++++++=
++++++++++++
> > > >  include/linux/mfd/cros_ec_commands.h |   8 +
> > > >  4 files changed, 432 insertions(+)
> > > >  create mode 100644 drivers/rtc/rtc-cros-ec.c
> > > >
> > > >
> > >=20
> > > Sorry, I just noticed that my script to add the email recipients
> > > failed and I did not add the RTC maintainers :( So this is a gentle
> > > ping cc'ing the maintainers to take in consideration these patches. I=
f
> > > you want I resend or something else just let me know please.
> > >=20
> >=20
> > I don't remember the specifics but I think the patches have the
> > necessary acks from me to go through the mfd tree (didn't we agree on
> > that ?)
> >=20
>=20
> This was the reply from Lee a while ago:
>=20
> > On Wed, 18 Jan 2017, Alexandre Belloni wrote:
> > > I don't think that one has your ack, is it ok for me to take it?
> >=20
> > This set looks MFD heavy, so it's probably best that the set goes
> > through MFD.  Once the RTC patch has been fixed of course.
>=20
> The series doesn't look MFD heavy anymore so it can also go through my
> tree. I'll let Lee decide.

Fine by me.

--=20
Lee Jones
Linaro Services Technical Lead
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
