Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC11A3029;
	Wed,  5 Aug 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961839; cv=none; b=bOTujuRZaYZ2K2di7ox7wqMR868KCJkq3UnAfjc/YPCfrW2aorFQcYVJmf1sOUXO8iCrg4Q0wB9qWulNCPpJ85lwUxmBkjn4SBHgDi3Rv5Dbhno5CvU6bH7U6PSiZ23gY+xtGPhHSQgWacgWpHAEQhC2Hh5FGybolZpQF6k55lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961839; c=relaxed/simple;
	bh=Xbc68cfImZl/4NblwVRTa47yNH9AQXbyn5hyxImL3TA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NAa2qUu4eV5CRtZmZSfPF2i4qf0HdmkL9/iuVkCUpeDaYHDfxrOSSedklViLGm/0fXySS3bPCSRWx1V/IE3XSNB4lFC3kJ94zdHR1DF+/ZO/w+B2vMNkQiijdihp6jdcuLNJLDPkjM7+YJmC7DLR11oK+iuKdP3LMTUWZC9Uox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anHMJVh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anHMJVh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A341F000E9;
	Wed,  5 Aug 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785961838;
	bh=4X5OwJdLRukN3BT2JpFVFjJGNi57fZ0TlzlXhjrSGSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anHMJVh4cKCZDrsihtXrR9tCVAcHtaxZNBxY6Q2KWLRoUsWetSCALWpw2ln41Euqc
	 bCBUMiVKkmXPecOkgr5j5HMwmHXYREWSKmz4WBlt6M3V854glDNUiWWjV0pME2cwPl
	 uOeyZjVYbAYW4vlrTZUbg+2wie2JQs2tWhXJIHa+p4rniQH6YTjkO0/NFEaLcwOiuA
	 OS4AqczKl4F9aen4z1UiRrEpszpOftYSzuN1RN45ixqoRg0PBUFf7x2Zv9We0DUfyT
	 JHBVgUkZDq7t2yunIBU9GdyrhLlofOTVWwo2glsPMW2n0sZhLPLs3BZbq9UvdUi2Iz
	 PdvWHguviYJug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260805-rtc_s35390a_int1-v3-2-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-2-e836faba3e25@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:30:37 +0000
Message-Id: <20260805203037.E9A341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Desynchronization between software state and hardware 24-hour mode=
 after initialization causes time corruption.
- [High] Alarm hour formatting erroneously adds PM bit in 24-hour mode, cau=
sing PM alarms to permanently fail.
--

--- Patch [2]: [PATCH v3 2/5] rtc: s35390a: Add missing newline to dev_err =
---
commit 60df926a63720bd3dbdd3b4991c3149af682d4b0
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add missing newline to dev_err

This commit fixes a missing newline character in the dev_err call
within s35390a_probe() when alarm disabling fails.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index b72eef4fb0997..4cfe7034c5165 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -494,7 +494,7 @@ static int s35390a_probe(struct i2c_client *client)
>  		buf =3D 0;
>  		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
>  		if (err < 0) {
> -			dev_err(dev, "error disabling alarm");
> +			dev_err(dev, "error disabling alarm\n");
>  			return err;
>  		}
>  	} else {

While reviewing this driver, I noticed a couple of pre-existing issues.

[Severity: High]
This isn't a bug introduced by this patch, but looking at s35390a_init(),
is it possible for the software state to become desynchronized from the
hardware 24-hour mode?

drivers/rtc/rtc-s35390a.c:s35390a_init() {
    ...
    initialize:
	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
    ...
}

When this reset is triggered (for instance, via the RTC_VL_CLR ioctl or when
a brownout is detected), the hardware is explicitly switched to 24-hour mode
by setting S35390A_FLAG_24H.

However, s35390a->twentyfourhour is not updated to 1.

Does this mean subsequent calls to rtc_set_time() will incorrectly use the
12-hour formatting rules if twentyfourhour was previously 0, sending invalid
BCD formats to the chip and corrupting the timekeeping for PM hours?


[Severity: High]
This is a pre-existing issue, but I have a question about how the alarm hour
is formatted when the chip is operating in 24-hour mode:

drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm() {
    ...
	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
			alm->time.tm_hour) | 0x80;
	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;

	if (alm->time.tm_hour >=3D 12)
		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;
    ...
}

If the chip is in 24-hour mode, s35390a_hr2reg() will already return the
standard 24-hour BCD value (e.g., 0x15 for 15:00).

Could the unconditional bitwise-OR with 0x40 (the PM bit) corrupt the alarm
time value in 24-hour mode, causing PM alarms to permanently fail because t=
he
hardware comparator expects a standard 24-hour BCD value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rtc_s35390=
a_int1-v3-0-e836faba3e25@posteo.de?part=3D2
