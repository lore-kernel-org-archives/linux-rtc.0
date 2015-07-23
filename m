Return-Path: <rtc-linux+bncBDA7X7F2WUEBBO4GYSWQKGQEX7XFLGQ@googlegroups.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by gmr-mx.google.com with ESMTPS id fj7si874365wib.3.2015.07.23.08.07.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 08:07:38 -0700 (PDT)
Received: by wibxm9 with SMTP id xm9so212787995wib.0
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 08:07:38 -0700 (PDT)
Date: Thu, 23 Jul 2015 16:07:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V2 1/3] mfd: da9062: Support for the DA9063
 OnKey in the DA9062 core
Message-ID: <20150723150735.GJ3436@x1>
References: <cover.1437399438.git.stwiss.opensource@diasemi.com>
 <9c56142bcfae19a370da54e558f4f70e068d9529.1437399438.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <9c56142bcfae19a370da54e558f4f70e068d9529.1437399438.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 20 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD core driver support for a OnKey component
>=20
> - MFD core adds the resource da9062_onkey_resources[] for the OnKey
> - An appropriate value has been added into mfd_cell da9062_devs[] to
>   support component .name =3D "da9062-onkey" and
>   .of_compatible  =3D "dlg,da9062-onkey"
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062-core.c             total: 0 errors, 0 warnings, 523 lines checked
> Changes in V2:
>  - No change
>=20
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  drivers/mfd/da9062-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 4cf0643..0732977 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -118,6 +118,10 @@ static struct resource da9062_wdt_resources[] =3D {
>  	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
>  };
> =20
> +static struct resource da9062_onkey_resources[] =3D {
> +	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
> +};
> +
>  static const struct mfd_cell da9062_devs[] =3D {
>  	{
>  		.name		=3D "da9062-core",
> @@ -141,6 +145,13 @@ static const struct mfd_cell da9062_devs[] =3D {
>  		.resources	=3D da9062_thermal_resources,
>  		.of_compatible  =3D "dlg,da9062-thermal",
>  	},
> +	{
> +		.name		=3D "da9062-onkey",
> +		.num_resources	=3D ARRAY_SIZE(da9062_onkey_resources),
> +		.resources	=3D da9062_onkey_resources,
> +		.of_compatible =3D "dlg,da9062-onkey",
> +	},
> +
>  };
> =20
>  static int da9062_clear_fault_log(struct da9062 *chip)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
