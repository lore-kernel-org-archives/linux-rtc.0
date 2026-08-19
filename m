Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BC440631;
	Wed, 19 Aug 2026 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177879; cv=none; b=Fe6QvnWv9Aklrr80ZN29a5brBXLv/2lC9+aaFa3pE792bsWmcrdgl/1oyIzZlcKOi0E37OzD9xp50TU1xHHHtg3QWOBmXls3tgawZbrDNxi5t15ymCxt+TDBYIc5p48ZUIZeeDspA/B+6L0wgT1qpmhXCqvy22F/wyTzzQ8xqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177879; c=relaxed/simple;
	bh=YEov3zh96aUO4Zpv5AiVeBOhngujo6NooC8PwFiAz3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljTpE0bVDWUfphN2wTlkfKxCKz5IBqolJQ/T/LJuWd9++EJiEAU2Rlb/+Fos2vIo2AYP3UpJQkmowEkhLrDKFif3wi4pOUChR95mZjfuhjN9iFDxZuwo7OjYdc89YCnrk7I111hp9+RktKZpGDUdBJ2vZfhIhqIOUZ9P7ZvJuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhu1vW+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhu1vW+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B67F1F000E9;
	Wed, 19 Aug 2026 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177877;
	bh=PpxlzXZ72c8HIObuy4V/8PDmaMa5Q0BInkOM1OBpH40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xhu1vW+jTP8R86WffEpGigRVh6IiiXrwdg58SVGreeAM4LwKau5fftuIfZNqLIupv
	 RqQWiA7zQnH1kPLQyr/Xy0xNvc6N297veaJX5rvKLR2DjLcvH7kvabLrUyQxVY1GBF
	 if8zaQaViofnylZnLGlaFVDJC+eqEfKYMbnhdjtyjRhEgmORWxz3SfYKv700vQsfvL
	 8CRjLhj3gWR4kilFmDTYYmEyWDQUfWdIUkJmZ8bk2xQetHnodqYrUw8PRjQogxZe15
	 VV5FJsN8lMvDeBOiFDilxgDpzrMIjZ0EGxhwi3gTR7VF7P+e0YVmB8NqhhewS5yTHj
	 e/2Tu6zw5RJrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] rtc: s35390a: force 24-hour mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:17:57 +0000
Message-Id: <20260819221757.8B67F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete migration from 12-hour to 24-hour mode silently break=
s existing hardware wake alarms.

Pre-existing issues:
- [High] Forcing 24-hour mode permanently breaks all alarms for PM hours du=
e to legacy AM/PM bit manipulation.
--

--- Patch [4]: [PATCH v5 4/6] rtc: s35390a: force 24-hour mode ---
commit 8f484adee5ad67584475e4c03516c2ee9307afc4
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: force 24-hour mode
   =20
Instead of trying to remember the current 12/24-hour mode, which could
result in time corruption if out of sync, we force the use of the 24-hour
mode. Set to 24-hour mode if in 12-hour mode on startup and assume
24-hour mode.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..b34a3f7e8476c 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -325,8 +299,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alm)
>  	else
>  		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
> =20
> -	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> -			alm->time.tm_hour) | 0x80;
> +	buf[S35390A_ALRM_BYTE_HOURS] =3D bin2bcd(alm->time.tm_hour) | 0x80;
>  	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
> =20
>  	if (alm->time.tm_hour >=3D 12)
>  		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;

[Severity: High]
This is a pre-existing issue, but does forcing 24-hour mode permanently bre=
ak=20
all alarms for PM hours here?

In s35390a_rtc_set_alarm(), the code unconditionally sets bit 6 (|=3D 0x40)=
 of=20
the hours register when tm_hour >=3D 12. While this was correct for 12-hour=
=20
mode to indicate PM, in 24-hour mode the time register uses raw 24-hour BCD=
=20
without a PM bit (e.g., 13:00 is 0x13).=20

Writing 0x13 | 0x40 yields 0x53. The hardware comparator will attempt to ma=
tch
the current time (0x13) with the alarm (0x53) and fail, meaning hardware wa=
ke=20
alarms for PM hours will never trigger. Since 24-hour mode is now forced=20
universally, will this affect all users?

[ ... ]
> @@ -503,10 +475,31 @@ static int s35390a_probe(struct i2c_client *client)
>  		return err_read;
>  	}
> =20
> -	if (status1 & S35390A_FLAG_24H)
> -		s35390a->twentyfourhour =3D 1;
> -	else
> -		s35390a->twentyfourhour =3D 0;
> +	if (!(status1 & S35390A_FLAG_24H) && err_read !=3D 1) {
> +		unsigned int hour;
> +
> +		status1 |=3D S35390A_FLAG_24H;
> +
> +		err =3D s35390a_get_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(time)=
);
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "reading 12-hour time failed\n");
> +
> +		/* converting to 24-hour time */
> +		time[S35390A_BYTE_HOURS] =3D bitrev8(time[S35390A_BYTE_HOURS]);

[Severity: Medium]
Does this migration from 12-hour to 24-hour mode miss the hardware alarm=20
registers?

During s35390a_probe(), the driver successfully converts the main time regi=
ster
(S35390A_CMD_TIME1) to 24-hour format. However, it seems to omit reading,=20
converting, and writing back the alarm registers (S35390A_CMD_INT1_REG1 and=
=20
S35390A_CMD_INT2_REG1).

If a system reboots with an active PM wake alarm set by an older kernel (in=
=20
12-hour format), won't the alarm register remain in 12-hour format while th=
e=20
RTC switches to 24-hour mode? This could cause the hardware comparator to=20
silently fail to match the time and wake the system.

> +		hour =3D bcd2bin(time[S35390A_BYTE_HOURS] & 0x3f);
> +		if (time[S35390A_BYTE_HOURS] & 0x40)
> +			hour +=3D 12;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D4
