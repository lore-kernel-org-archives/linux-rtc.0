Return-Path: <rtc-linux+bncBDA7X7F2WUEBBB4I3O6QKGQEPYKRJAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id i193si158183wmg.1.2016.08.19.01.32.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 01:32:07 -0700 (PDT)
Received: by mail-wm0-x22c.google.com with SMTP id q128so25069506wma.1
        for <rtc-linux@googlegroups.com>; Fri, 19 Aug 2016 01:32:07 -0700 (PDT)
Date: Fri, 19 Aug 2016 09:33:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	dianders@chromium.org, zyw@rock-chips.com, robh+dt@kernel.org,
	mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Subject: [rtc-linux] Re: [PATCH v7 1/4] mfd: RK808: Add RK818 support
Message-ID: <20160819083336.GI4254@dell>
References: <1470819907-11237-1-git-send-email-w.egorov@phytec.de>
 <1470819907-11237-2-git-send-email-w.egorov@phytec.de>
 <20160818143440.GG4254@dell>
 <57B6A4D1.20108@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57B6A4D1.20108@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 19 Aug 2016, Wadim Egorov wrote:
> On 18.08.2016 16:34, Lee Jones wrote:
> > On Wed, 10 Aug 2016, Wadim Egorov wrote:
> >
> >> The RK818 chip is a Power Management IC (PMIC) for multimedia and hand=
held
> >> devices. It contains the following components:
> >>
> >> - Regulators
> >> - RTC
> >> - Clocking
> >> - Battery support
> >>
> >> Both RK808 and RK818 chips are using a similar register map,
> >> so we can reuse the RTC and Clocking functionality.
> >>
> >> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> >> Tested-by: Andy Yan <andy.yan@rock-chips.com>
> >> ---
> >> Changes since v6:
> >> - Squashed in the patch
> >>   mfd: RK808: Fetch PMIC variant from chip id register
> >>
> >> ---
> >>  drivers/mfd/Kconfig       |   4 +-
> >>  drivers/mfd/rk808.c       | 226 +++++++++++++++++++++++++++++++++++++=
++-------
> >>  include/linux/mfd/rk808.h | 154 +++++++++++++++++++++++++++++--
> >>  3 files changed, 342 insertions(+), 42 deletions(-)

[...]

> >>  struct rk808_reg_data {
> >>  	int addr;
> >> @@ -57,6 +62,14 @@ static bool rk808_is_volatile_reg(struct device *de=
v, unsigned int reg)
> >>  	return false;
> >>  }
> >> =20
> >> +static const struct regmap_config rk818_regmap_config =3D {
> >> +	.reg_bits =3D 8,
> >> +	.val_bits =3D 8,
> >> +	.max_register =3D RK818_USB_CTRL_REG,
> >> +	.cache_type =3D REGCACHE_RBTREE,
> >> +	.volatile_reg =3D rk808_is_volatile_reg,
> >> +};
> >> +
> >>  static const struct regmap_config rk808_regmap_config =3D {
> >>  	.reg_bits =3D 8,
> >>  	.val_bits =3D 8,
> >> @@ -79,11 +92,21 @@ static const struct mfd_cell rk808s[] =3D {
> >>  	{
> >>  		.name =3D "rk808-rtc",
> >>  		.num_resources =3D ARRAY_SIZE(rtc_resources),
> >> -		.resources =3D &rtc_resources[0],
> >> +		.resources =3D rtc_resources,
> > ?
>=20
> you told me to change this

It's an unrelated change that has nothing to do with this patch, which
is why I am confused.

But it's okay, I'll let it sneak in on this occasion, rather than
asking you to send a separate patch.

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
