Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A649365A;
	Sun, 23 Aug 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523882; cv=none; b=D6QvfqmuOuYwKluHfD+C7CyIJ2bZwjoxF/f3iU5DDUTW2pX6i/7CX9z6ACCVJjK43WhNoo44+SPUggHns/Qw3S3t0OJY95G7E98EdRvx2vBi38UpTgVLWq47oop2M/o8VYgSgkBKXFQIy6U4DoIfAp+DT2aR46psvoQSeiudhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523882; c=relaxed/simple;
	bh=Ic67LUXNCeBsl4gruyjfmmqoecx3tV5LfZzO7op09Vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+U6Q3hqhhf9SHA+esZbqmo+VyHhqSz/MaW80w82NSg/BbzORltvwDheLaNF77LsnDeIp0lIDLuQzoIdhPAhlH98y4vRyJn3cjFyWKCu7bbOQ8VxczH0JLGdsYClKumRpN8m6DWviSrE58MNJmJz+hBl+76ippsvnB/PM1TlgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEA5gsm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEA5gsm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1541F000E9;
	Sun, 23 Aug 2026 22:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523881;
	bh=H7tMTnH3aIdx9u4OJX7+nhgbm1pnW2xh4P0FZ+t37Qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEA5gsm/kPv3pDAoKEQlKO258E47aY4zg/fhfnOj1MYix/PERaRzwerFwyVMKmEq/
	 JRxZ0fzKRqb7DrsPLSVe8rgI+DpiM6UjT/tA5lJpewpPAaFUO8zTXlG3X4/WnTNwR6
	 v43/VLmytiCkHU8l8wCuUbqQBTxx+okCWiDnBZxsuowWuIbzprGtIuNZ11bwCkhh5V
	 kfYanvi3whuyQyTXaBP5ltJpmjJWqvXVAB1+z6J+e3zLh9k16on5U1VPJik9mBCFFH
	 9WO+EZnjJ2Losc01unXFs1e6v61Kbcwqez9T/dq2xDGn6J5BdLXpGz7n7/Cs6dBvtR
	 oS0nUPnB2ElKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] rtc: s35390a: Read 24-hour mode on access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260824-rtc_s35390a_int1-v6-4-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-4-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:24:40 +0000
Message-Id: <20260823222440.BF1541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized stack variable usage due to missing error check for =
negative return values from s35390a_read_status.
--

--- Patch [4]: [PATCH v6 4/6] rtc: s35390a: Read 24-hour mode on access ---
commit d45935347291ea27eb3558322c8f56d965fd15e6
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Read 24-hour mode on access

This commit reads the 24-hour mode on access instead of only on probe. It
fixes time corruption when resetting the chip in 12-hour mode, as
s35390a_init did not update the cached value.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..8e3616c65d2c0 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -256,7 +258,7 @@ static int s35390a_rtc_read_time(struct device *dev, =
struct rtc_time *tm)
> =20
>  	tm->tm_sec =3D bcd2bin(buf[S35390A_BYTE_SECS]);
>  	tm->tm_min =3D bcd2bin(buf[S35390A_BYTE_MINS]);
> -	tm->tm_hour =3D s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
> +	tm->tm_hour =3D s35390a_reg2hr(buf[S35390A_BYTE_HOURS], status & S35390=
A_FLAG_24H);

[Severity: High]
Earlier in s35390a_rtc_read_time(), the code calls
s35390a_read_status(s35390a, &status).

If this call fails with a negative error code (e.g. -EIO due to a transient
I2C error), the check if (s35390a_read_status(s35390a, &status) =3D=3D 1) e=
valuates
to false, and the function proceeds without returning an error.

Will this cause the uninitialized status stack variable to be evaluated her=
e,
potentially corrupting the time calculation?

[ ... ]
> @@ -345,14 +347,17 @@ static int s35390a_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *alm)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct s35390a *s35390a =3D i2c_get_clientdata(client);
> -	u8 buf[3], sts;
> +	u8 buf[3], status1, status2;
>  	int i, err;
> =20
> -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
> +	if (s35390a_read_status(s35390a, &status1) =3D=3D 1)
> +		return -EINVAL;
> +
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(=
status2));
>  	if (err < 0)
>  		return err;

[ ... ]

> @@ -381,8 +386,8 @@ static int s35390a_rtc_read_alarm(struct device *dev,=
 struct rtc_wkalrm *alm)
> =20
>  	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
>  		alm->time.tm_hour =3D
> -			s35390a_reg2hr(s35390a,
> -				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
> +			s35390a_reg2hr(buf[S35390A_ALRM_BYTE_HOURS] & ~0x80,
> +				       status1 & S35390A_FLAG_24H);

[Severity: High]
Similarly to s35390a_rtc_read_time(), if s35390a_read_status() returns a
negative error code, the check above will pass and the status1 stack variab=
le
will remain uninitialized.

Could this allow the uninitialized status1 variable to be used here to dete=
rmine
the alarm hour calculations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D4
