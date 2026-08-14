Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BA3A7586
	for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748777; cv=none; b=UJSRTthrN0iT3X2iYJVO1z1cmIUE13ad38XwKTFZb+FcZgpk1Gza5w8VZTxHPPhhFFfKk7t2WvSBFAnPvDaxSO7u8xO0PQObg2y1pVvm0PcINYaeT4Nvjd9E1Z6aict/bZjCAGFb8DXwH/StyXYJDZTZTP3uL5R9PY/c+ugTBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748777; c=relaxed/simple;
	bh=1TpSUfASlPYD6vkolB41pNnkgQFwJ5CZAHQhOHVxR9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMha99D0HmG0hxBFAy9TCJO/WF3p7MALzOaDBiAHkk37I1rKesj5IcNAelS3kLnQmJ2GXFufy8E8CRDsW6yv03+USiQ9EMYaBbMG82mo0s/VkNMFeCjvreC3XU7eKml9Wuimt158GttHZfLwjyqKpt0BLJzzAax4X6QNSJ1A+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l7GMIIOj; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l7GMIIOj"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 34BFE240103
	for <linux-rtc@vger.kernel.org>; Sat, 15 Aug 2026 01:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786748773;
	bh=duys7+8s+gASCH3kpoA/OFIn50y/yFTrHBputIyJi6w=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=l7GMIIOjHzspips0gsYJUaNJEU9rfOD5h72Sm5F2NcN8u7cs/yC5S5oz+PE9iOvj4
	 iaP8tcEykpGZYbf0TrZiuFlLxOP8sOkybBzbEL8r+WzCPcWXfb76K8ACq9bw4bNGh5
	 Ajacpgyt28VyveeVmBSvV9+JWa70Ri1EnR7Xrk/urww/2w6iRVIO58EFlBilw8VXbx
	 kW+zZRxgqv1EuZC4nezWhZ/CZ7trwEE4gjNx/BggMDt/TVGXkEU7uf0DDYO8MKF6Aa
	 Ivq/WDRg32VedgB8uitE/3SIwNjDTRlSA4aVd6KQbtNC47yAt6AoEa3lLtox+NOvdX
	 rsgU3okQnxfpQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hMHsJ2fkCz6tsf;
	Sat, 15 Aug 2026 01:06:12 +0200 (CEST)
Message-ID: <06254c4859f8f11858bc950a52c1214c4e13f87e.camel@posteo.de>
Subject: Re: [PATCH v4 1/6] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
Date: Fri, 14 Aug 2026 23:06:12 +0000
In-Reply-To: <20260814230443.5D6451F000E9@smtp.kernel.org>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
	 <20260815-rtc_s35390a_int1-v4-1-3133309c365f@posteo.de>
	 <20260814230443.5D6451F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Y+aJ1fG7DBSjhDBewXiA"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-Y+aJ1fG7DBSjhDBewXiA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-14 at 23:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Invalid use of the `wakeup-parent` property on an RTC end-device.
> --
>=20
> --- Patch [1]: [PATCH v4 1/6] dt-bindings: rtc: Add pinctrl for S35390A -=
--
> commit 58cc609a743d62ad0839cf063b2bd4bf9603a2d0
> Author: Markus Probst <markus.probst@posteo.de>
> Subject: dt-bindings: rtc: Add pinctrl for S35390A
>=20
> This commit converts the devicetree bindings for the S-35390A RTC into a
> standalone YAML schema. It also adds properties to configure individual p=
ins
> via pinctrl to allow the interrupt signal 1 to be used for wakeup alarms.
>=20
> > diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/D=
ocumentation/devicetree/bindings/rtc/sii,s35390a.yaml
> > new file mode 100644
> > index 0000000000000..d9da3abbbd518
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
>=20
> [ ... ]
>=20
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: Supports up to 2 interrupt lines via the INT1 and INT=
2 pins.
> > +
> > +  wakeup-parent: true
> > +
> > +  wakeup-source: true
>=20
> [Severity: Low]
> Is wakeup-parent appropriate for this device? The wakeup-parent property =
is
> typically defined strictly for cascaded interrupt controllers to specify =
an
> upstream wakeup-capable interrupt controller. Since this is an end device=
,
> should it only use the wakeup-source boolean instead?

If it is connected to an interrupt controller and the interrupt
controller then causes the wakeup, wakeup-parent should be used here.

>=20
> [ ... ]
>=20
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc@30 {
> > +            compatible =3D "sii,s35390a";
> > +            reg =3D <0x30>;
> > +            pinctrl-0 =3D <&rtc_pins_default>;
> > +            pinctrl-names =3D "default";
> > +
> > +            wakeup-parent =3D <&int>;
>=20
> [Severity: Low]
> Should this example be updated to remove the wakeup-parent assignment,
> assuming the property is dropped from the schema above?
>=20
> [ ... ]

--=-Y+aJ1fG7DBSjhDBewXiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp/n2MbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSKWEP/3WfFNrYKZ64Wn61F/3n
hlI9BhXTDbL6bCzMzZKg9Ys1StrauNpld6sTCYekEfPay2Haee/NxdQyb/t+N6A/
K8ljGHqVk+68NrH0wwlzF5BkSr7+8XBfS+D8LclB7cegndTizKNfODCWAbW0b+WK
3UMfs2hKrbslRC6SP3lFm/Li9FSqxQbiomdjzbt/cmSYxV5iqRNy0+nuJkFtyJ25
ihX+UpjCtpvmHqOia8sS755OF7PZN88gcDm37v6MEgJziNooNIPptls9+V3Q7xMp
y330L80WUCYFOmHCFv/ZDNPD1Bsj0hSKyCy+dXPK5fdPe28aMDJ3AzXYyOkbxIsB
UdsLhzTU42UbaLX4kS4xNzD9o3UkOSqZxSRPWDmiMP2wqNbEGmedC8rLFEhdB/ZU
cqfVgTpIltrk5FoBxe+NwZji5ssdyVd5/+pdVcMaXot7/q7JZpsb0Pgw8xUoIgHO
pMf7g6xu2ZDLA+OGkM0SGwvexiaWJbLrznHVpHadu0JUy1W6YitESK4I6RSvpkDS
NtPzWENSPbwiiFL+T+MPcd3MdVBA6LxHojfbsV+czb2pN2D8P9AxilkV12qVPSm+
anI6oVHkdNmYqNtLkHYcBBKCsKGabvw45PBcjFYfPVDz0Mtf0Izsn7vnab1CIyvW
o8tdZBzBRvJF3KzZGnqiaoY1
=CNfC
-----END PGP SIGNATURE-----

--=-Y+aJ1fG7DBSjhDBewXiA--
