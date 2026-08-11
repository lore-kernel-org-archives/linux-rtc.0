Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB17459AF9
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469994; cv=none; b=aLyn4B/HbfD22EFg7DQkoOzhjCVi0A9MD3F29f27aU6ji9MuzlG9S/leXO+zTKh1Fr9BrSzHPJkdpdNVPanyOwfzyPtLWp3Rt1iCdT6yu4mZlBDVHPh+LFX0ups+9R/lqM/XD+pT9fTd3qV+qJtLXd3bSjOBZETE8ZkW//kBOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469994; c=relaxed/simple;
	bh=gdxAJWXAXm8vC2GYzmDIecnbeUyLLEflYFnHKLZUbuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/5jkKw+crU20cKLGN+Ll5HaVkWh0kklkv3tIkOoJGGftVoNa61AY9pSiUsW5x7Gl0nC1XZpwkUrcYgZLza41HdwOhXO5y7gVk1/EGO8SazZulwzx+/v4gCxS61RtZkVnm337QRKBltVtoCrs0Km4BFF8pqno88qOgJYr4StyEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l4vx5laG; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l4vx5laG"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B435D240101
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786469989;
	bh=VzbJi0W45vM9k6SDfgIZUxnSMp1CK4LGKfLqzBNaI54=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=l4vx5laGcDYajeCrweJ1sJ3lWwjD1NW2MGY52pxsnr+eof5hiQXL5fqYnlnzXSr4j
	 GYVG+QS3heUa5xR6G3910qXS4ZUrBLeIFM1djyC9XO6l192Br9afYC+RrmgNYWUI7U
	 XMM0FeWsI7DYHuTLHqJNSznxtxfg7sRvJFYLVg9pb8RJU2JLBD3OSmQuRRBwk1TPjo
	 lNfScpLD30hwkzG2XT4qGeK9v+8Z8EmFXIkN2G+xdWDh6StKiss6bIMGDWOF4fC7XC
	 /ZXfXmLMjxeWIoTnE39bkZJw3WmSHIk/DQwhPqXIb0jirUhWljZBZKtSS0KA0LB6cJ
	 dVi9KWAqVzMvw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hKJm46CRtz9rxV;
	Tue, 11 Aug 2026 19:39:48 +0200 (CEST)
Message-ID: <1d76e37a92549a0c131fa8a1b7075a1475ac5bdb.camel@posteo.de>
Subject: Re: [PATCH v3 4/5] rtc: s35390a: Add pinctrl
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
Date: Tue, 11 Aug 2026 17:39:49 +0000
In-Reply-To: <20260805205149.E9F3A1F000E9@smtp.kernel.org>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
	 <20260805-rtc_s35390a_int1-v3-4-e836faba3e25@posteo.de>
	 <20260805205149.E9F3A1F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-r+aTSHgWGy8cfSgWm06J"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-r+aTSHgWGy8cfSgWm06J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-05 at 20:51 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] The driver initiates I2C communication with the hardware before =
honoring the required Power-On Circuit (POC) delay, violating the initializ=
ation sequence.
> - [High] The pinctrl driver cannot parse device tree pin configuration no=
des because it is missing the `dt_node_to_map` callback.
> - [High] Reading the `STATUS1` register to check or clear pending alarms =
inadvertently clears the alarm flags for both pins, causing lost wakeup eve=
nts.
> - [Medium] The driver introduces a hard dependency on `CONFIG_PINCTRL`, b=
reaking existing kernel configurations.
> --
>=20
> --- Patch [4]: [PATCH v3 4/5] rtc: s35390a: Add pinctrl ---
> commit f348aaf86d41faa0c844cc513c01b349d5a5d4e3
> Author: Markus Probst <markus.probst@posteo.de>
> Subject: rtc: s35390a: Add pinctrl
>=20
> Allow configuration of pin functions, including keeping previous config,
> disabling output, waking up, and minute periodical interrupt. Fallback to
> previous behavior if not configured.
>=20
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 01def82318731..4e0374129a4ed 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -668,6 +668,7 @@ config RTC_DRV_RC5T619
> > =20
> >  config RTC_DRV_S35390A
> >  	tristate "Seiko Instruments S-35390A"
> > +	depends on PINCTRL
>=20
> [Severity: Medium]
> Since the kernel pinctrl subsystem provides dummy stubs when CONFIG_PINCT=
RL is
> disabled, should this be a hard dependency? This will prevent building th=
e
> driver on platforms without pinctrl support, breaking existing configurat=
ions.
It does not provide dummy stubs.

>=20
> > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > index 575bb256eb258..d63bdeff8cdbc 100644
> > --- a/drivers/rtc/rtc-s35390a.c
> > +++ b/drivers/rtc/rtc-s35390a.c
> [ ... ]
> > @@ -343,33 +343,35 @@ static int s35390a_rtc_set_alarm(struct device *d=
ev, struct rtc_wkalrm *alm)
> [ ... ]
> > +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> > +	if (err < 0)
> > +		return err;
> > +
> > +	/* clear pending interrupt (in STATUS1 only), if any */
> > +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &tmp, sizeof(tm=
p));
> > +	if (err < 0)
> > +		return err;
>=20
> [Severity: High]
> Since reading STATUS1 acts as a clear-on-read for both INT1 and INT2 inte=
rrupt
> flags, won't this unconditional read wipe out any pending interrupts for =
the
> other pin?
The only pending interrupt supported by the driver should be the wakeup
alarm, which needs to be cleared in this function in order to set
another alarm.

>=20
> [ ... ]
> > @@ -453,13 +528,181 @@ static int s35390a_nvmem_write(void *priv, unsig=
ned int offset, void *val,
> [ ... ]
> > +	case S35390A_FUNC_WAKEUP:
> > +		flag =3D group =3D=3D 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MOD=
E_ALARM;
> > +		if ((buf & mask) !=3D flag) {
> > +			buf =3D (buf & ~mask) | S35390A_INT_MODE_NOINTR;
> > +			break;
> > +		}
> > +
> > +		err =3D s35390a_read_status(s35390a, &status1);
>=20
> [Severity: High]
> Similarly, if s35390a_pinctrl_set_mux() is called twice during initializa=
tion
> (once for each pin), won't the first call to s35390a_read_status() clear =
the
> flags for both pins, causing the second call to lose any pending wakeup e=
vent?
Yes.

>=20
> [ ... ]
> > +static const struct pinctrl_ops s35390a_pinctrl_ops =3D {
> > +	.get_groups_count =3D s35390a_pinctrl_get_groups_count,
> > +	.get_group_name =3D s35390a_pinctrl_get_group_name,
> > +	.get_group_pins =3D s35390a_pinctrl_get_group_pins,
> > +};
>=20
> [Severity: High]
> Is this struct missing the dt_node_to_map callback (e.g.,
> pinconf_generic_dt_node_to_map_all)? Without it, the pinctrl subsystem wi=
ll fail
> with -ENODEV during pinctrl_dt_to_map(), which ignores any custom pin
> multiplexing requested via device tree.
Possibly.
>=20
> [ ... ]
> > @@ -493,39 +741,16 @@ static int s35390a_probe(struct i2c_client *clien=
t)
> [ ... ]
> > +	err =3D s35390a_disable_test_mode(s35390a);
> > +	if (err < 0) {
> > +		dev_err(dev, "error disabling test mode\n");
> > +		return err;
> > +	}
> [ ... ]
> > +	err =3D devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s3=
5390a, &pctl);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "pinctrl register failed\n");
> > +
> > +	err =3D pinctrl_enable(pctl);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "pinctrl enable failed\n");
> [ ... ]
> > +	err =3D s35390a_read_status(s35390a, &status1);
> > +	if (err < 0) {
> > +		dev_err(dev, "error resetting chip\n");
> > +		return err;
> > +	}
>=20
> [Severity: High]
> Does moving the s35390a_read_status() call to later in the probe sequence=
 violate
> the Power-On Circuit delay?
>=20
> The s35390a_disable_test_mode() and pinctrl_enable() calls both trigger I=
2C
> communication. If the hardware is still in the 0.5-second POC delay perio=
d,
> communicating with it before checking the POC flag in s35390a_read_status=
()
> might lead to I2C bus hangs or silent failures on cold boot.
Yes.


--=-r+aTSHgWGy8cfSgWm06J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp7XmQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZaQQAKF1UXCV4vQUOL4tchZe
AWdACO/L0PKwMWYOxiKTf4c4JyxfrfYpWroWFlL3jzIVGfiKG1CK2zFMLPJQ1Vvj
BJid4SyfQjhvzLcI0BAD5bxanViZXBgemvupPPriuhbL54oNpJSZoDYSVRADXB4T
52fY7KHGPZluaq6N/Mk3VF/fEGO6EkUqoNfVjL/bvWE0DOO24pl21pHkWP32U2I/
LOhGwtdUd1eQXv0xRN7+KtsBpWZXgA1GlIePDipOqHb2d92B+C25CvLa+2fwh0+a
QIPomvjlOJM72ALuB/cdENmF9PsMEwIv/vE0lDtpeu6C0JIZgUpBnk/U06XV/s7v
Y73JU60qRW+6BcYnEWtIVxjh9AIDm/wDN9JecA9d6MrrHucQuarjSQG5J0HI7NxZ
Hu649ehxe3yRvBgL64TMM9dJTqeASBX25cz9vv2IaNFnhdUmMtgt1ZfJHdsYuiyN
t2lKHyByg95EwAdgKQ9OKJOHL+wlnuGQPNgAm7M6aFYg8qZad9DkWs6sY7nzlqsE
aIhTpT+uBaSi18UBXdStE0LnBFcUh/5fOnrxfA+dFI04AhXASjXCS05wKdPCrXJT
5q/JZ3b55tGlnWt5HpIEStguScq9hNKY9CBJ7TXhk49ehb7UOHByX96qHvoc2g3J
ofsRMTZ02dY2qcXSR/jVRaTq
=EGaF
-----END PGP SIGNATURE-----

--=-r+aTSHgWGy8cfSgWm06J--
