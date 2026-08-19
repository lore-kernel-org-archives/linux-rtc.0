Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE5391853
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180238; cv=none; b=QVAOBu3sGBGLaZXKRw1714uH7UNJ9HOtOHxqSGg9oXLhhM+Rj8vUwm7GzEaGtoxrTEpwnAyHyVGafwb9s16BDTqFtKWnhVnHH5bi5feM4ikyB/jUNnZVVqeTsFuVs7f0Q71/ttymvDRhx9oZULFSwauXPfq6eTKv4/9U4VWHx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180238; c=relaxed/simple;
	bh=J49B1AZ0OVw/KiksVkRxGAVMK9Ri8L4loxZoxHlI4SQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqIbHip4ppo47qNLVZUyTH6mDuneEkhdxKVkxIKkY/h2QluqosLjYBeRl00KM4rpUF5bW8GKL2nCNtSbbzV5ZwQ+hEfiHn9GYTldmEhIU73fnJqRLQVBL1lGf9RTSgW1PRqKdE7nlfSgUPQQCcii9+R2zu82b8N6MmXT027JQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QeZb5bZ2; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QeZb5bZ2"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 010A4240104
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 00:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787180234;
	bh=35HTvJnNYf+Y6yPGlSnbtku71ctHu0ZAU5ecuv7uRts=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=QeZb5bZ2BUq9EJg7E1/rb8+r5w4G4hME68p20+oQop1hGkzZP3cBM9hoRWLh8bk6l
	 2Mb0es3Ec37z4ur/FX1VpQNeX8Vr6bjdI8c5IYNULsg6yOF3hm4vIqm6Rb3zou3B9S
	 5pdgNzwuGTt9IOLYAC1AJjYJBztd5XYhwbKZ2lPpqflvolzINZ/+LgZXfT5kSUK812
	 uapoClzHPTDdvwmbVTt6MMa6c2OtCbVFLQtIL6nh1o2iPGbNeXRKO2DDK5J4mO0gYi
	 vL4bqMQwWQbxAbMhQgi+c+kPEcfbdvmXJaKnLGBWkjpnaU+B52quiAXlGku+4SAy3o
	 vDku2RG+YLroA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hQMQb42wVz6trs;
	Thu, 20 Aug 2026 00:57:11 +0200 (CEST)
Message-ID: <da52511e1257d1a3d01ad78b53eb983162c66003.camel@posteo.de>
Subject: Re: [PATCH v5 4/6] rtc: s35390a: force 24-hour mode
From: Markus Probst <markus.probst@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth	
 <sebastian.hesselbarth@gmail.com>, Michael Langer	
 <michael.brainbug.langer@googlemail.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 19 Aug 2026 22:57:13 +0000
In-Reply-To: <202608192220436c9c7207@mail.local>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
	 <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
	 <202608192220436c9c7207@mail.local>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+m6o0kZ90Z5oSoDP9C6X"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-+m6o0kZ90Z5oSoDP9C6X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-20 at 00:20 +0200, Alexandre Belloni wrote:
> On 19/08/2026 22:05:56+0000, Markus Probst wrote:
> > Instead of trying to remember the current 12/24-hour mode, which could
> > result in time corruption if out of sync, we force the use of the 24-ho=
ur
> > mode. Set to 24-hour mode if in 12-hour mode on startup and assume
> > 24-hour mode. The 24-hour mode is already forced on reset.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/rtc/rtc-s35390a.c | 67 +++++++++++++++++++++------------------=
--------
> >  1 file changed, 30 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > index 575bb256eb25..b34a3f7e8476 100644
> > --- a/drivers/rtc/rtc-s35390a.c
> > +++ b/drivers/rtc/rtc-s35390a.c
> > @@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
> > =20
> >  struct s35390a {
> >  	struct i2c_client *client[8];
> > -	int twentyfourhour;
> >  };
> > =20
> >  static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf,=
 int len)
> > @@ -181,31 +180,6 @@ static int s35390a_disable_test_mode(struct s35390=
a *s35390a)
> >  	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf)=
);
> >  }
> > =20
> > -static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
> > -{
> > -	if (s35390a->twentyfourhour)
> > -		return bin2bcd(hour);
> > -
> > -	if (hour < 12)
> > -		return bin2bcd(hour);
> > -
> > -	return 0x40 | bin2bcd(hour - 12);
> > -}
> > -
> > -static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
> > -{
> > -	unsigned hour;
> > -
> > -	if (s35390a->twentyfourhour)
> > -		return bcd2bin(reg & 0x3f);
> > -
> > -	hour =3D bcd2bin(reg & 0x3f);
> > -	if (reg & 0x40)
> > -		hour +=3D 12;
> > -
> > -	return hour;
> > -}
> > -
> >  static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *t=
m)
> >  {
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> > @@ -225,7 +199,7 @@ static int s35390a_rtc_set_time(struct device *dev,=
 struct rtc_time *tm)
> >  	buf[S35390A_BYTE_MONTH] =3D bin2bcd(tm->tm_mon + 1);
> >  	buf[S35390A_BYTE_DAY] =3D bin2bcd(tm->tm_mday);
> >  	buf[S35390A_BYTE_WDAY] =3D bin2bcd(tm->tm_wday);
> > -	buf[S35390A_BYTE_HOURS] =3D s35390a_hr2reg(s35390a, tm->tm_hour);
> > +	buf[S35390A_BYTE_HOURS] =3D bin2bcd(tm->tm_hour);
> >  	buf[S35390A_BYTE_MINS] =3D bin2bcd(tm->tm_min);
> >  	buf[S35390A_BYTE_SECS] =3D bin2bcd(tm->tm_sec);
> > =20
> > @@ -256,7 +230,7 @@ static int s35390a_rtc_read_time(struct device *dev=
, struct rtc_time *tm)
> > =20
> >  	tm->tm_sec =3D bcd2bin(buf[S35390A_BYTE_SECS]);
> >  	tm->tm_min =3D bcd2bin(buf[S35390A_BYTE_MINS]);
> > -	tm->tm_hour =3D s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
> > +	tm->tm_hour =3D bcd2bin(buf[S35390A_BYTE_HOURS] & 0x3f);
> >  	tm->tm_wday =3D bcd2bin(buf[S35390A_BYTE_WDAY]);
> >  	tm->tm_mday =3D bcd2bin(buf[S35390A_BYTE_DAY]);
> >  	tm->tm_mon =3D bcd2bin(buf[S35390A_BYTE_MONTH]) - 1;
> > @@ -325,8 +299,7 @@ static int s35390a_rtc_set_alarm(struct device *dev=
, struct rtc_wkalrm *alm)
> >  	else
> >  		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
> > =20
> > -	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> > -			alm->time.tm_hour) | 0x80;
> > +	buf[S35390A_ALRM_BYTE_HOURS] =3D bin2bcd(alm->time.tm_hour) | 0x80;
> >  	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
> > =20
> >  	if (alm->time.tm_hour >=3D 12)
> > @@ -381,8 +354,7 @@ static int s35390a_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *alm)
> > =20
> >  	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
> >  		alm->time.tm_hour =3D
> > -			s35390a_reg2hr(s35390a,
> > -				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
> > +			bcd2bin(buf[S35390A_ALRM_BYTE_HOURS] & 0x3f);
> > =20
> >  	if (buf[S35390A_ALRM_BYTE_MINS] & 0x80)
> >  		alm->time.tm_min =3D bcd2bin(buf[S35390A_ALRM_BYTE_MINS] & ~0x80);
> > @@ -459,7 +431,7 @@ static int s35390a_probe(struct i2c_client *client)
> >  	unsigned int i;
> >  	struct s35390a *s35390a;
> >  	struct rtc_device *rtc;
> > -	u8 buf, status1;
> > +	u8 buf, status1, time[7];
> >  	struct device *dev =3D &client->dev;
> >  	struct nvmem_config nvmem_cfg =3D {
> >  		.name =3D "s35390a_nvram",
> > @@ -503,10 +475,31 @@ static int s35390a_probe(struct i2c_client *clien=
t)
> >  		return err_read;
> >  	}
> > =20
> > -	if (status1 & S35390A_FLAG_24H)
> > -		s35390a->twentyfourhour =3D 1;
> > -	else
> > -		s35390a->twentyfourhour =3D 0;
> > +	if (!(status1 & S35390A_FLAG_24H) && err_read !=3D 1) {
> > +		unsigned int hour;
> > +
> > +		status1 |=3D S35390A_FLAG_24H;
> > +
> > +		err =3D s35390a_get_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(tim=
e));
> > +		if (err < 0)
> > +			return dev_err_probe(dev, err, "reading 12-hour time failed\n");
> > +
> > +		/* converting to 24-hour time */
> > +		time[S35390A_BYTE_HOURS] =3D bitrev8(time[S35390A_BYTE_HOURS]);
> > +		hour =3D bcd2bin(time[S35390A_BYTE_HOURS] & 0x3f);
> > +		if (time[S35390A_BYTE_HOURS] & 0x40)
> > +			hour +=3D 12;
> > +
> > +		time[S35390A_BYTE_HOURS] =3D bitrev8(bin2bcd(hour));
> > +
> > +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &status1, size=
of(status1));
> > +		if (err < 0)
> > +			return dev_err_probe(dev, err, "setting 24-hour mode failed\n");
> > +
> > +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(tim=
e));
> > +		if (err < 0)
> > +			return dev_err_probe(dev, err, "setting 24-hour time failed\n");
>=20
> No, don't do this, this will break existing users as your conversion may
> happen after a minute rollover. The only function in which you are
> allowed to change the time registers is set_time. You definitively need
> to be able to read 12H mode time but you are allowed to only support
> writing 24h time.
>=20
> Also, this is super verbose, adding strings to the kernel makes it
> bloated.
>=20
> To avoid any desync, simply test for the S35390A_FLAG_24H bit in status
> in s35390a_rtc_read_time as the register is already read anyway.
>=20
I think that would defeat the whole point of the patch, that the rtc is
always in 24-hour mode. If this driver was always used with the rtc, it
already should be in 24-hour mode, as thats the mode this driver does
initialize the rtc.

Your idea would work for the time, but not in combination with alarms.
If the rtc could be in 12-hour mode, then this would need to be
considered in setting and reading alarm. Also setting 24-hour mode
inside set_time would then also require to convert the alarm time.
Effectively making it less maintainable than before.

Currently s35390a_init does initialize the rtc in 24-hour mode, while
not updating s35390a->twentyfourhour. So some change needs to be made.
Just setting s35390a->twentyfourhour inside s35390a_init might now be
the simplest solution here.

Thanks
- Markus Probst


--=-+m6o0kZ90Z5oSoDP9C6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqGNMcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSwWQP/1H0JfUVKMKNAvbONPU9
YHttL3PSOx76DK0KlUnmyfS3oNQX9O6B65uSNWS2sLi3Au2kY5m1hhXMouyzqpi7
SAm/ubM2aj4LeUZDjn/HBztXYNGdYNMAADf1y+tM7m+ixuS02dLGXYO1WUm2sAop
rgr555O1g/HDUuXWAcfia4QSSHGUZXVmLTzn4PQIKdcD2AdtyUki8sucDNWTGUSm
csZhTEb8mrjg2Dg3uQZXKu02vkehAVx2TfctepMkwo4kWK+oBz8nV/KnAcl1doas
6xASHjjqv3tD8CBTVgO9Ga/0bz08PXQ2MLMEbwKcFACRmBaJLQinKbvRTSTdKirJ
iVsAuK4dhgHm13u0B1O6dvFvKO4Fm2wS+lK6Wk+oj60nhOg4+VJ4qH1FcydiA/2p
47FT/hcsD9vMtp5RSwqzcp/dFVZsabrWln/QMDz2Qn/S1CeMOo7MYjezEUTp/EMB
n4mQcp7k8o5sZeM6MZZVt8JglrgzgCn1Vda8SSCu+TEyc++TR7kdUAPInnVKjKAI
BkCs6HWbPnosTCRO5xfbTdn3KwMu3+Ty8XqWngQHzzXe+I5xs7w43438pkp202R5
Xm1jeOiVCtCuHesDfIyCIEZ1wL+HZZjtMPRhTr8e3sucMIwkEOmfeiyjEs5D5Gsj
+6M075JfnhslxZ/9xcQydqaU
=fSXF
-----END PGP SIGNATURE-----

--=-+m6o0kZ90Z5oSoDP9C6X--
