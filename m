Return-Path: <rtc-linux+bncBAABBXHA3KZAKGQEDHRQZNQ@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id q80si67149wmg.0.2015.11.25.23.10.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 23:10:20 -0800 (PST)
Date: Thu, 26 Nov 2015 08:10:11 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [rtc-linux] Re: [PATCHv3 1/2] watchdog: stmp3xxx: Stop the watchdog
 on system halt
Message-ID: <20151126071011.GL19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444220352-20548-1-git-send-email-harald@ccbib.org>
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

On Wed, Oct 07, 2015 at 12:19:11PM +0000, Harald Geyer wrote:
> This allows the system to actually halt even if userspace forgot to
> disable the watchdog first. Old behaviour was that the watchdog forced
> the system to boot again.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Changes since v2:
> * split this out as a separate patch
>=20
>  drivers/watchdog/stmp3xxx_rtc_wdt.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3=
xxx_rtc_wdt.c
> index 3ee6128..e09a01f 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -14,6 +14,8 @@
>  #include <linux/watchdog.h>
>  #include <linux/platform_device.h>
>  #include <linux/stmp3xxx_rtc_wdt.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> =20
>  #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
>  #define STMP3XXX_DEFAULT_TIMEOUT 19
> @@ -69,6 +71,28 @@ static struct watchdog_device stmp3xxx_wdd =3D {
>  	.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS,
>  };
> =20
> +static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
> +			  void *unused)
> +{
> +	struct device *dev =3D watchdog_get_drvdata(&stmp3xxx_wdd);
> +	struct stmp3xxx_wdt_pdata *pdata =3D dev_get_platdata(dev);
> +
> +	switch (code) {
> +	case SYS_DOWN:	/* keep enabled, system might crash while going down */
> +		break;
> +	case SYS_HALT:  /* allow the system to actually halt */

<nitpick>
You used a tab before the comment "keep enabled ...", but spaces for
"allow the system ...".
</nitpick>

> +	case SYS_POWER_OFF:
> +		wdt_stop(&stmp3xxx_wdd);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block wdt_notifier =3D {
> +	.notifier_call  =3D wdt_notify_sys,

s/  / /

> +};
> +
>  static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -84,6 +108,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *=
pdev)
>  		return ret;
>  	}
> =20
> +	if (register_reboot_notifier(&wdt_notifier))
> +		dev_warn(&pdev->dev, "cannot register reboot notifier\n");

OK, you don't fail when registering the notifier fails, but ...

>  	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
>  			stmp3xxx_wdd.timeout);
>  	return 0;
> @@ -91,6 +118,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *=
pdev)
> =20
>  static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>  {
> +	unregister_reboot_notifier(&wdt_notifier);

... I think it's not ok to unconditionally unregister it then, is it?
(Looking at how unregister_reboot_notifier is implemented it might work
as intended, but if that's only by chance I wouldn't rely on it.)

Best regards
Uwe

>  	watchdog_unregister_device(&stmp3xxx_wdd);
>  	return 0;
>  }
> --=20
> 1.7.10.4
>=20
>=20
>=20

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
