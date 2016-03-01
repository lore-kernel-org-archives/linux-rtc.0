Return-Path: <rtc-linux+bncBDTKFPPJUEHRBAO3223AKGQE2HGITCA@googlegroups.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id s141si15609wmd.1.2016.03.01.06.56.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 06:56:00 -0800 (PST)
Received: by mail-wm0-x233.google.com with SMTP id p65so37123239wmp.0
        for <rtc-linux@googlegroups.com>; Tue, 01 Mar 2016 06:56:00 -0800 (PST)
Date: Tue, 1 Mar 2016 15:55:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-vr41xx: remove unused function
Message-ID: <20160301145558.GC26201@ulmo>
References: <1456836981-30999-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
In-Reply-To: <1456836981-30999-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 06:26:21PM +0530, Sudip Mukherjee wrote:
> We were getting build warning about:
> drivers/rtc/rtc-vr41xx.c:228:12: warning: =E2=80=98vr41xx_rtc_alarm_irq_e=
nable=E2=80=99
> defined but not used
>=20
> The function vr41xx_rtc_alarm_irq_enable() was not used anywhere.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>=20
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/112780206
>=20
>  drivers/rtc/rtc-vr41xx.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
> index f64c282..68cb63e 100644
> --- a/drivers/rtc/rtc-vr41xx.c
> +++ b/drivers/rtc/rtc-vr41xx.c
> @@ -225,24 +225,6 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsi=
gned int cmd, unsigned long
>  	return 0;
>  }
> =20
> -static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned int =
enabled)
> -{
> -	spin_lock_irq(&rtc_lock);
> -	if (enabled) {
> -		if (!alarm_enabled) {
> -			enable_irq(aie_irq);
> -			alarm_enabled =3D 1;
> -		}
> -	} else {
> -		if (alarm_enabled) {
> -			disable_irq(aie_irq);
> -			alarm_enabled =3D 0;
> -		}
> -	}
> -	spin_unlock_irq(&rtc_lock);
> -	return 0;
> -}
> -

I don't think it's supposed to be unused, rather back at the time it
simply wasn't hooked up to the rtc_class_ops.

Here's what I used.

Thierry

--- >8 ---
>From 91c39e61b10551f8fbdb55cadbc29a104071bea2 Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding@nvidia.com>
Date: Tue, 1 Mar 2016 15:50:25 +0100
Subject: [PATCH] rtc: vr41xx: Hook up ->alarm_irq_enable()

The vr41xx_rtc_alarm_irq_enable() function was extracted in commit
16380c153a69 ("RTC: Convert rtc drivers to use the alarm_irq_enable
method") from a more generic IOCTL handler. However the function was
never hooked up to the struct rtc_class_ops to which a new callback
had earlier been added for this purpose in commit 099e657625e8 ("rtc:
add alarm/update irq interfaces").

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/rtc/rtc-vr41xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282275b3..898fdd03668d 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -278,6 +278,7 @@ static const struct rtc_class_ops vr41xx_rtc_ops =3D {
 	.set_time	=3D vr41xx_rtc_set_time,
 	.read_alarm	=3D vr41xx_rtc_read_alarm,
 	.set_alarm	=3D vr41xx_rtc_set_alarm,
+	.alarm_irq_enable =3D vr41xx_rtc_alarm_irq_enable,
 };
=20
 static int rtc_probe(struct platform_device *pdev)
--=20
2.7.1

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

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1a18AAoJEN0jrNd/PrOhXO4QAIPejJxvD5R+txLKVt4q05JJ
A0xRGJM/Wt6yDozdMhbfYXiRy4Fuv79rIdxX4x+llL6HPCVsYAEn34IYFiquUGfA
MTkc6145yh7A3TkVEni0l+NR0py3eDlUFpExqlsXiNmj2rG8XZPl3EYM0FZABrN0
MizRdsfJOYeHx1fdP6rPCAbcUrZNr1gqbLhvMQljbVeAY9fCUou1ZNwa8j7mT2BW
XAgh6gyDaTEDhbsFlPQfwTnW/UJUNUALiGDUPJ+PH/C9OhaX4e0cM1IPK4IKmHQt
Ln2NnNgfTc1m/waSgnF3VejKRoDZbBVJ/t953RQWeYk6eTsKzwifA6Gqz7Vnapf3
QGUAS65q9i5UBIRkf6AL/E2NTyhqP6+qwKOa9jOFNKvE/Ss6TsBZs9e0g1gjgblu
mB7nl4R5ThqZdrYQu69r0RVaPWObKEgC4Zj8ZOCOoc12b5PlE4EfRxFfQ5501VPa
pL2ukp6ts1waJSzfm/ajFJtvnrTYm+9Tg96lAwoZt36++mSTb/JiPfxjk0jTO14H
VgSv0iFlvcsKGtfy79Yrmp0Wa2PRZhG9uRPRQ8Scl7ss5duMdBNVQfSfpK4r60V3
J69U1o0P63qKbkaE3+4O4g1O2pHnv9UDJc2AFz55GelwfxaTfgqDgNkQUyfIe8Jz
/6Zpq/WB+leEt3tKKiCp
=KVKk
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
