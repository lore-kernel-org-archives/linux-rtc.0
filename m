Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0B359A6D;
	Thu,  1 Oct 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861053; cv=none; b=BW/Y+CzTQw6TOm9nV+bgJd4mkm6WsUgV/vuFK6xVAG0cngVFgksoAK2dsohL+OkfBY6XjYm5cjEGY4JouviAm+In5p264xzf4mWTfUgR29KADM8bb9L7kngsVhnQJY8Mr1Npc4VTaA6Hg1FZGtIJds86Khff7iy53HffkdAls6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861053; c=relaxed/simple;
	bh=X3bEkhlf2gZZ3OnkEQK0X6+xXjV2dWqggmj0Oiskz8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=IbwiZVFRkYBeCRnZ6+g0tPtvp0zd6UrKYDZigNRkRsPWNbiihJBvPAy3FD0xdTulWd2CCInVwnFX1Z5t3qJ1QkSp9FarCSwbpNcOYhQ5BMQmV4B44RHSsXHaLQIoVqZvhd0cXJoiv+/rP6AYHjsfAnlF9QqGLT6I/hiJU5ikapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdrnTc7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdrnTc7V"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AFBEB1F000FF;
	Thu,  1 Oct 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861052;
	bh=TxmM7g86vqWg38a4SdLtH6GLKKWCA2S+rsHqVLNPnzs=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=UdrnTc7VhjcqmAPuMMCl8UmdyGGXQjb9ksYiIoYyXk60Nsxy9YjPk1ByDAlNdbTwM
	 ld3Dq1HKt/QwlcfrJfb+nvw/mzmpgJN/tVqH9WAV7FCpYK4EOPW8LzdPAcs3neQblU
	 d8OfwsUKHJFxZAHsNswzMqJUTeeUDTVXVpUCevdMJX1j7luoCajWllVsJvwoBuJr6D
	 b+ROI88GROPfuG3FejnHNkrHskvNjX3fT89HCVvcR2Weev1AYdtPatP4iWLPHDUZis
	 TXwM1pRnc6TEuxHkvwsWP+UiUnDzBMTEq+1Zg41URe3XcHmvWu61TVJNWS/geZteO3
	 eTddDZEOmBrRw==
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=77375552f6370145b30eb1ccdc2150a0059ef6924f39b36562e21db53e52;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 01 Oct 2026 15:24:07 +0200
Message-Id: <DLTJ9BRUJFAO.XKH3SG306MBJ@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] rtc: pcf8563: add SMBus support
Cc: <linux-rtc@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260930113126.720555-1-mwalle@kernel.org>
 <20260930114005.2C6661F000FF@smtp.kernel.org>
 <20260930152513dd617b74@mail.local>
In-Reply-To: <20260930152513dd617b74@mail.local>

--77375552f6370145b30eb1ccdc2150a0059ef6924f39b36562e21db53e52
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 30, 2026 at 5:25 PM CEST, Alexandre Belloni wrote:
>> Because of this fallback, when pcf8563_rtc_read_time() reads the time:
>>=20
>> drivers/rtc/rtc-pcf8563.c:pcf8563_rtc_read_time() {
>>     ...
>>     err =3D regmap_bulk_read(pcf8563->regmap, PCF8563_REG_ST1, buf,
>>                            sizeof(buf));
>>     ...
>> }
>>=20
>> The bulk read executes as a loop of separate single-byte SMBus reads ins=
tead
>> of an atomic transaction. Since each SMBus byte transaction issues its o=
wn
>> STOP condition, the RTC's internal register latch is released between re=
ads.
>>=20
>> Does this allow the hardware time to roll over mid-read and result in
>> corrupt time data?
>
> This is a valid concern, did you test?

Yes, did you read my first reply? I'm not sure how this is handled
in the RTC subsystem. Most regmap converted RTC should fall into
this case. How do you propose to handle that? Instead of removing
the check, we could just test for either I2C or SMBus block read.

Anyway, I have an SMBus host controller which supports the block
read, thus it doesn't fall into the single byte read case.

-michael

--77375552f6370145b30eb1ccdc2150a0059ef6924f39b36562e21db53e52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCar5e+BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jhlgF/Y8IyyaBQcyjnDWyIDp+bbHMRunlhL/Xr
Q7ggknk+4hfiJyNkQODvbDVIJubun0OHAX9ArRo7FRsEblq6m05JtDlnrtmWPsq/
yrgL9SUkZgCt/+yIGpDtvsZkzTRvOM5Oa4M=
=beSV
-----END PGP SIGNATURE-----

--77375552f6370145b30eb1ccdc2150a0059ef6924f39b36562e21db53e52--
