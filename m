Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF313D1AA2;
	Tue, 25 Aug 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643073; cv=none; b=Gyr1Pw9SfIEe16eigifdBTrNTF9dExFU97WKMJf04ABAV4MgA0ycSFw6pzm7heEomPfHVkUpaM6rWDy7U7X9EzygUovD3zkcanrpsOEnkYNm1I7aW1IlRjUk62LDl8sI878wo4N2IpVPn2b5A/vTIVHukXXAQV7GiJpRQEm17bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643073; c=relaxed/simple;
	bh=/BdWQgUjU/Chm0yxJNoLRTasvRpE79akpQu3IToT7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5BAJJrvrBemIZ2GOe625/YaloaW58t094JaOex4kSteI7IWcKklwFrf+Vq33pmm064XZGprh0We/vAorLrn/cnicXQnItLZqyA7Zn29cQI4559ovVpJj66iWv6o+23iUbumD8EyxoAVEDFJ1ujHxA5djrgCjD/aJqbDM2sEXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 409D92010F4;
	Tue, 25 Aug 2026 09:31:02 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wylcc-003EXv-0W;
	Tue, 25 Aug 2026 09:31:02 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2FFC58BE44;
	Tue, 25 Aug 2026 07:31:01 +0000 (UTC)
Date: Tue, 25 Aug 2026 09:31:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com, giampiero@sferalabs.cc, 
	p.rosenberger@kunbus.com, antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 0/4] rtc: pcf2127: add support for battery low voltage
 detection
Message-ID: <20260825-wild-raptor-of-tenacity-1f5c25-mkl@pengutronix.de>
References: <20260311200237.3531981-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftt4ljdmch6vlf3p"
Content-Disposition: inline
In-Reply-To: <20260311200237.3531981-1-hugo@hugovil.com>


--ftt4ljdmch6vlf3p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] rtc: pcf2127: add support for battery low voltage
 detection
MIME-Version: 1.0

Hello Alexandre,

can you pick up this patch? It has been tested by Stefan Kerkmann and
it's working for our use case.

regards,
Marc

On 11.03.2026 16:02:26, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series adds support for battery low voltage detection configur=
ation
> for RTC devicesm, with specifc changes targeted at the pcf2127/2131 devic=
es.
>
> The origin of this patch goes back to the initial commit to add support f=
or the
> PCF2131 device. On the PCF2131, the battery low voltage detection is disa=
bled by
> default at the hardware level, contrary to the PCF2127 where it is enable=
d by
> default. Because of that, a lot of people are stuck with a PCF2131 RTC de=
vice
> using a battery backup, but unable to use it!
>
> A lot of people are writing to me in private emails to report this as a b=
ug
> in the PCF2131 driver. Others (and me) have proposed to implement device =
tree
> properties to enable these functions, but this was rejected [1][2][3].
>
> It is important to note that some projects do not have the luxury to modi=
fy
> the bootloder to enable that function at boot, and for these having a DT
> property that could be put in a DT overlay would simplify a lot their lif=
e.
> Also having to rely on a userspace application to configure the RTC is al=
so
> not ideal, as some projects use stock Debian distros (for example), and
> adding a new application to their repository is not trivial or easy.
>
> So as the next best thing, this patch aims to add what is missing in the =
driver,
> the ability to enable/disable the battery low voltage detection with ioct=
ls,
> similarly to what is done with the BSM.
>
> This patch has been tested on a custom board with a PCF2131 and using my
> userspace application:
>
>     git clone -b batlow_param git@git.hugovil.com:repos/hvrtc.git
>
> Thank you.
>
> Link: https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thoms=
en@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.ne=
t/ [2]
> Link: https://lore.kernel.org/linux-rtc/20230123170731.6064430c50f5fb7b48=
4d8734@hugovil.com/ [3]
>
> Hugo Villeneuve (4):
>   rtc: pcf2127: remove redundant break statement in switch-case
>   rtc: pcf2127: add pcf2127_pwrmng_get/set
>   rtc: add battery low voltage detection feature
>   rtc: pcf2127: support battery low voltage detection function
>
>  drivers/rtc/rtc-pcf2127.c | 94 ++++++++++++++++++++++++++++++---------
>  include/uapi/linux/rtc.h  |  7 ++-
>  2 files changed, 80 insertions(+), 21 deletions(-)
>
>
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> --
> 2.47.3
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ftt4ljdmch6vlf3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCao1EswAKCRDMOmT6rpmt
0qKGAQDDKtLu5vme0Wzz7tzfncHDpyyCnC8I94/Wr/GJJlw/fAEA2sPymAZLe+Kg
ARi/CuNnvP4A1TqK+tfssrhkfhxs2gE=
=fDyR
-----END PGP SIGNATURE-----

--ftt4ljdmch6vlf3p--
