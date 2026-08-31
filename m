Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FF3D567F;
	Mon, 31 Aug 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207845; cv=none; b=HUL95EaBaMQapUkYwJbeJQo4HAYsJ29cLzklM3TuhxdZQp7ZElwFpuxv9yxBC6crmSPoNh64U2bBEHdiA7rmdInzdP9Mti4QLYRliyT26+ZN+0gwtEuZ+VaaBZrLrxKEKRGEBS19iBN2nl7EWu8fBc8N8RDm6S1gU0sbiYpvUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207845; c=relaxed/simple;
	bh=Px93pEqXxcv2hFKIgOuJCdQfEAqnHWVFotwUQGyFlME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jD3X8BZHXAZMroeDCJNz5q7gqYSB/LkXFlmQLk15P9xFIQlQaKU5V6exjWX2qnYTSERrWA0wHUrwFEIxBQ28pZujQtUwfmZTSWXcm57m4KzhqwRrYfU3JIXUtsMLrJGK+fUgfTN/XsjUR2LtRpkiXczY0mzGfF7Io/SAmcxzm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCX4A4K/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCX4A4K/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AC61F01558;
	Mon, 31 Aug 2026 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207841;
	bh=m0ht2Jh/Z0elTqL0rLrW+hpx7XQGEgsAv/mHcxf5D2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCX4A4K/ZBy9TjJE5I9nDw1Ryxos61qIbeL7RS/UhUsfe7SFRLwa8Qh73rSdMqjzY
	 /axSZPs5cKFmU84M6zXxrppw48DmWkF+tr0uFoxdQiw7tE5VBjJDx7pYnm5x0kyOfR
	 E9sp/yZvLRKqQQQM+1dEzq566bauf1tOPbjuuEdotQUujxI4+2DY3o2z/78vhlF2Kh
	 babbWy3NsMxblFBlRY6uV1VUprPvko+NSk7Lqczj5iKH+hdSf7JRisub3yK1SExllK
	 DTJFjeF5IDN2YFughIKO3ovDW+Bi9vaodnsysYtwb/3trSgfuYZ8mqqpz6mn48WkUS
	 kVPDrJCCxIOAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] rtc: s35390a: Read 24-hour mode on access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260831-rtc_s35390a_int1-v8-4-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-4-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:24:00 +0000
Message-Id: <20260831202401.43AC61F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Alarm PM bit is unconditionally set for PM hours, breaking alarms =
in 24-hour mode.
- [High] Multiple functions read the STATUS1 register but fail to handle th=
e POC (Power-On Clear) and BLD (Battery Low Detect) flags correctly, perman=
ently masking power-loss events.
--

commit b899282922e9e75f3f9690275fbd3d093dfa12e5
Author: Markus Probst <markus.probst@posteo.de>
Subject: rtc: s35390a: Read 24-hour mode on access

This commit modifies the driver to dynamically read the 24-hour mode status
from the chip on access, rather than caching it during probe. This prevents
the mode from going out of sync if the chip is reset while in 12-hour mode.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..12ed504db94d8 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> @@ -292,7 +297,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alm)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct s35390a *s35390a =3D i2c_get_clientdata(client);
> -	u8 buf[3], sts =3D 0;
> +	u8 buf[3], status1, status2 =3D 0;
>  	int err, i;

[ ... ]

>  	/* clear pending interrupt (in STATUS1 only), if any */
> -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &sts, sizeof(sts)=
);
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &status1, sizeof(=
status1));
>  	if (err < 0)
>  		return err;

[Severity: High]
This is a pre-existing issue, but does reading S35390A_CMD_STATUS1 here
silently clear the POC (Power-On Clear) and BLD (Battery Low Detect) flags
in the hardware without handling them?

Since these flags are automatically cleared by the hardware upon reading
STATUS1, it appears that s35390a_probe(), s35390a_rtc_set_alarm(), and
s35390a_rtc_ioctl() all inadvertently erase the power-loss state. By bypass=
ing
the proper power-loss handling, will subsequent reads of the time unknowing=
ly
trust and present an invalid or garbage RTC time to the system after a batt=
ery
failure?

>  	if (alm->enabled)
> -		sts =3D S35390A_INT2_MODE_ALARM;
> +		status2 =3D S35390A_INT2_MODE_ALARM;
>  	else
> -		sts =3D S35390A_INT2_MODE_NOINTR;
> +		status2 =3D S35390A_INT2_MODE_NOINTR;
> =20
>  	/* set interrupt mode*/
> -	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
> +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(=
status2));
>  	if (err < 0)
>  		return err;
> =20
> @@ -325,8 +330,8 @@ static int s35390a_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alm)
>  	else
>  		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
> =20
> -	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> -			alm->time.tm_hour) | 0x80;
> +	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(alm->time.tm_hour,
> +						      status1 & S35390A_FLAG_24H) | 0x80;
>  	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
> =20
>  	if (alm->time.tm_hour >=3D 12)
>  		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;

[Severity: High]
This isn't a bug introduced by this patch, but does unconditionally setting
the 0x40 bit for PM hours here break alarms in 24-hour mode?

In 24-hour mode, bit 6 is not used for PM, so setting it writes an invalid
BCD value that the time register will never match. Will this prevent the
alarm from ever firing for times >=3D 12:00 when the RTC is configured in
24-hour mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D4
