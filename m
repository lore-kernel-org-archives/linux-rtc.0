Return-Path: <rtc-linux+bncBD2ZNBF5VYJRB2HUYG2QKGQE4NBNCYA@googlegroups.com>
Date: Tue, 2 Feb 2016 10:44:07 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 03/11] drivers: rtc: allow compilation of
 sun6i RTC for all sunxi SoCs
Message-ID: <20160202094407.GL4652@lukather>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
In-Reply-To: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Feb 01, 2016 at 05:39:22PM +0000, Andre Przywara wrote:
> At the moment the "sun6i" RTC drivers depends on having two specific
> SoC families selected.
> The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
> to allow inclusion of the driver for all Allwinner SoCs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWsHpnAAoJEBx+YmzsjxAgqFAP/3hUYWhyOuVC7i+MaQSuSTBg
j2h7FNagMcSz1rLOCXDamCISGy8OX81QLgVXPKgzAk/5gRjStBRzUE2uzfRGX7As
iyLPiECcBpjgWcJ7W1Ao4LNI4JDfwOCQeVjIXsDrk+XvWf22ov7sMApgP9JebYTj
la2chLJ/hqG1XYjtIrghBele+OB9t8hlvBEhCDyFxFa3sPBXWnhGRqK4expWAdtp
eyrr0/nv0ari6w7O8G4EftBb5eLG7BuD6Fit8eKx1e8U8gFpi92PPsYRvQbVjBNc
b5slWaRj7TAfsTfoi8T9lNEKOLEZ403rywMgrwuWj7iDXZ7aY5xaeIGNdvIo3HPI
ZAqk2CN3r5mLXUIRlqmb5AgSevObsHIuIdViZ8XaWc7W3frmwCfz7l5QoOk5JMU7
nn7Z1uF89QqcPU8GdZRA4guIkLdXRFi/grrcBrGmcPu7WBk5/aiITlpWvXpIJWS8
T7wJHVGMQ6tqlBhqPmg0itHXgACrY9jmTx9VYB+cP69XW1eadZjVIKaXSjYdd5/+
H0RxV6FTkXyNtiBC8RLgVns0m+BP+HjsZLhmvYeX9w+FZseJUevhd+QL8/he1B4e
xkXplXPjcKfiyXoWp8bIsNUbO3ILOX3Bi//ewrquWWSmRK26NBl48TigyWhwAkur
Q9xNdq4dnNQHpBlNKDWK
=DXFr
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--
