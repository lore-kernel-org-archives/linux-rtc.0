Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109A38239F;
	Fri, 14 Aug 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748775; cv=none; b=Ga+Ew1c9t+hr+PzzSpCQl4scadiuGq68KBGLf6B7V0CdxcJL8wGQTCGDXtUBxftfCCSXrQKwnypkmxZexXWnchIACb99v8B3IYwSBF0VwjLHfmvSFn0tDj5LSeAK9b/vlxMeg3wcNy0WPnbRxjBVghAdZ2NstxkIkdnN43ChkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748775; c=relaxed/simple;
	bh=wfl5e7jQ5lQUc9xPRm+/ZzQYfLmyynYg+hLBzC6RzJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nd202v51JgcYJAJ4pfKc7/RIp4Sb/2R2b8xV3GK+FRdrEBLv8eMjZmPbVJ/qj+M1O5tzC9WsqxeX5uNd/Jw/xdPi0M5E47q0t88tOy6B4APyPC9M78VLiy1okHNAhV+Jgq3eO0DNbQXwgvRnp3M3/8nWLrhUS8wTDL0/57KH41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBFtaaje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBFtaaje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC81F000E9;
	Fri, 14 Aug 2026 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748774;
	bh=9BFWwwuYUUMAYMyAxcpPzubyF9KSgGkhR2l8/L/YaV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBFtaajeOZnTdUxVk56oNCF4uhkq1yg0bQYWpTS15P3cs/sva4oeplyCMUPlP1+rO
	 1iwv0fgUTKoaCS+l/U86TQGdnonbYl4gGLypHtI/n/yhben4xtJLYv7j10+pu1m2mR
	 gJlDQ9Gj6EQnB0DgPWg/OLHKjLgJairpHDdxM7AVcF2Uh/kuo5JWYkWdxf0F17IGDS
	 1U8zEoB7ZHhK0179Nffew0Pm5llkFr5llCIAVAJxEygeVXT2cKSAm//GGUkhxVzXkT
	 LKOw6lac+mzj7wL8JD+heGj1VOHV6izchOL4qKBaanvf7zug/YCBbXCYZvsofdu72m
	 dlscD6tHrpunA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] rtc: s35390a: force 24-hour mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260815-rtc_s35390a_int1-v4-4-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-4-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:06:13 +0000
Message-Id: <20260814230614.46BC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Forcing the RTC into 24-hour mode without converting existing BCD =
time registers corrupts system time.

Pre-existing issues:
- [High] Unconditional setting of the 12-hour mode PM bit (0x40) breaks ala=
rms for PM hours in 24-hour mode.
- [High] Destructive read of hardware status during probe permanently loses=
 power-failure state, causing corrupted time reads.
--

--- Patch [4]: [PATCH v4 4/6] rtc: s35390a: force 24-hour mode ---
commit 5dfeb8634985eb7940c40692a8b6802f70166610
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: force 24-hour mode
   =20
Instead of trying to remember the current 12/24-hour mode, which could
result in time corruption if out of sync, we force the use of the 24-hour
mode. Set to 24-hour mode if in 12-hour mode on startup and assume
24-hour mode.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..4d7fecfbe38e8 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
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
This is a pre-existing issue, but does this unconditional bitwise OR break
alarms for PM hours in 24-hour mode?

In drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm(), the code
unconditionally sets bit 6 (|=3D 0x40) for PM hours. Since the driver now
forces the RTC into 24-hour mode, the current time is stored in purely
24-hour BCD format without bit 6 set.

Because the alarm register is written with bit 6 set for PM hours, the
hardware time and alarm registers will never match, causing PM alarms to
silently fail.

> [ ... ]
> @@ -503,10 +475,13 @@ static int s35390a_probe(struct i2c_client *client)
>  		return err_read;
>  	}

[Severity: High]
This is a pre-existing issue, but does reading the status during probe
permanently lose the power-failure state?

Earlier in drivers/rtc/rtc-s35390a.c:s35390a_probe(), the driver calls
s35390a_read_status() to check the chip state. This hardware read
automatically clears the Power-On Clear (POC) and Battery Low Voltage
(BLD) flags.

If these flags were set (returning 1), the probe function seems to ignore
the return value and proceed without resetting the time. Because the flags
are irrevocably cleared, subsequent calls to s35390a_rtc_read_time() will
see a clean status and return invalid time data instead of reporting an
error.

> -	if (status1 & S35390A_FLAG_24H)
> -		s35390a->twentyfourhour =3D 1;
> -	else
> -		s35390a->twentyfourhour =3D 0;
> +	if (!(status1 & S35390A_FLAG_24H)) {
> +		status1 |=3D S35390A_FLAG_24H;
> +
> +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &status1, sizeof=
(status1));
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "setting 24-hour mode failed\n");
> +	}

[Severity: High]
Could forcing the hardware into 24-hour mode without converting the
existing BCD time registers corrupt system time?

If the RTC was previously running in 12-hour mode, PM times will have
bit 6 set (e.g., 2:00 PM is 0x42). When the mode is flipped to 24-hour
mode on boot in drivers/rtc/rtc-s35390a.c:s35390a_probe(), the driver
masks bit 6 during read.

This would incorrectly interpret the PM time as AM (e.g., 2:00 AM) instead
of properly converting the time registers during the transition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D4
