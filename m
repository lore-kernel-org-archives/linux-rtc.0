Return-Path: <rtc-linux+bncBAABBP7V7SUQKGQE34PYTXI@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id m3si560324wia.1.2015.04.28.00.46.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 00:46:07 -0700 (PDT)
Date: Tue, 28 Apr 2015 09:45:54 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	Samuel Ortiz <sameo@linux.intel.com>, rtc-linux@googlegroups.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
	Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v3 1/3] mfd: provide RTC resource in MT6397 MFD
Message-ID: <20150428074554.GZ19431@pengutronix.de>
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

Hello,

On Tue, Apr 28, 2015 at 03:35:54PM +0800, Eddie Huang wrote:
> Provide MT6397 RTC interrupt, base address, and register in
> MT6397 MFD.
>=20
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
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
It's definitly a matter of taste if you align the rhs here, but if you
do, do it consitently. That is, either make sure that all equal signs
are in a single column (at least per struct resource), or use a single
space between variable name and =3D.

If you want to hear my personal preference: I always use a single space.
As if you have to add
	.somelongvariablename =3D somevalue

you have to touch all other lines, too, which is ugly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

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
