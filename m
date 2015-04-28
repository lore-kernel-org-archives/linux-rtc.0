Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXFX7WUQKGQEQ6TVKHY@googlegroups.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com. [209.85.212.178])
        by gmr-mx.google.com with ESMTPS id bc3si564122wib.2.2015.04.28.03.07.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 03:07:23 -0700 (PDT)
Received: by mail-wi0-f178.google.com with SMTP id f7so13157874wie.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Apr 2015 03:07:23 -0700 (PDT)
Date: Tue, 28 Apr 2015 11:07:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v3 1/3] mfd: provide RTC resource in MT6397 MFD
Message-ID: <20150428100719.GN11956@x1>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 28 Apr 2015, Eddie Huang wrote:

> Provide MT6397 RTC interrupt, base address, and register in
> MT6397 MFD.
>=20
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

*after* Uwe's concerns have been attended to, you may add my:

Acked-by: Lee Jones <lee.jones@linaro.org>

FWIW, I quite like straight lines. :)

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc780..08cfbd1 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -21,9 +21,27 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
> =20
> +#define MT6397_RTC_BASE		0xe000
> +#define MT6397_RTC_SIZE		0x3e
> +
> +static const struct resource mt6397_rtc_resources[] =3D {
> +	{
> +		.start =3D MT6397_RTC_BASE,
> +		.end   =3D MT6397_RTC_BASE + MT6397_RTC_SIZE,
> +		.flags  =3D IORESOURCE_MEM,
> +	},
> +	{
> +		.start =3D MT6397_IRQ_RTC,
> +		.end   =3D MT6397_IRQ_RTC,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +};
> +
>  static const struct mfd_cell mt6397_devs[] =3D {
>  	{
>  		.name =3D "mt6397-rtc",
> +		.num_resources =3D ARRAY_SIZE(mt6397_rtc_resources),
> +		.resources =3D mt6397_rtc_resources,
>  		.of_compatible =3D "mediatek,mt6397-rtc",
>  	}, {
>  		.name =3D "mt6397-regulator",

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
