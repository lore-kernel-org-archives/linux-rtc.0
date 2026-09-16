Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D394A64FD;
	Wed, 16 Sep 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575024; cv=none; b=Yct5stQvCqJtga4Wg0s2YcPFQECZ0UkYoc5LGDIgtDaAG1ey8oTitQCDmo610/SJBFhZZ7XOhTYY4ZA73hBJ0QlHzVo8MLQ3RtQPeTHrTtLYGBxGDz6f4O3zHPOL6/RemuhFWcBgOAS4OSY1HU/PT+dY2j+xcTCKlG5sWcbGtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575024; c=relaxed/simple;
	bh=9C03tr5HlKFL7WQRGrV/NyjexuAhFWr4l25Fb3O+pUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYts0ywf2RpKILhFA7EMQt5HSQiR8ltQPFMVuoFs/Y2wdQAwgJdmL2WCt7hYyGqcr7FV4EnHhgjf7kWEzzJDXmVuJOHFLT+tbRusMCEd5MJ8hIi1DK7tvkk+ZOwnVkIXcOnAxkvCefQUC/QoKP2aJGSfu5hbiA0vmfRSmtcr9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euENMWAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euENMWAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C4E1F00899;
	Wed, 16 Sep 2026 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575022;
	bh=OpPgCuAnd7XFLGWSnxUe7rt5rjbsvv2b1Rx7/nrx/80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euENMWAVS0zeQO9t/LGUDWFjkkZXRKWhcbmqsUJxET945V7ptns0/4ISdS9SVTcwj
	 jRamcMIq9Hv9+hbS1epjd09s7AJGgz9H2wzpXdvxL6DXpaEL/LBPcJcoXXrndLakbb
	 GGkxwX6rbm/3F7KtzR2sxDkt3bDf9PG1n4AZyaLVpyt5C1ktaRtvjz6qGxpl9q3mGQ
	 +ZPbgMTiMb+kE47QfxwRhHt37RUN6tWhF7eUQRr2Mjo51w579nnrE3dBDdX4L/6z53
	 rBOLl/cOhMxNlzVOww42dwhmWB3uKwCHtmgbqY8tWAUP0zbVZk1c+YCQhwTx54BJ2+
	 rhExvyHxBLFvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] rtc: s35390a: Read 24-hour mode on access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916-rtc_s35390a_int1-v9-4-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-4-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:10:21 +0000
Message-Id: <20260916161021.D9C4E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: s35390a: read_alarm destructively clears pending interrupts a=
nd power-loss flags
--

commit ca86574fc774e3c6f6f2d2629b0a0ab8635be21f
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Read 24-hour mode on access

This patch modifies the s35390a driver to read the 24-hour mode flag
dynamically on access rather than caching it during probe. It aims to preve=
nt
out-of-sync issues when the chip is reset while in 12-hour mode.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..12ed504db94d8 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -345,14 +350,20 @@ static int s35390a_rtc_read_alarm(struct device *de=
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
> +	err =3D s35390a_read_status(s35390a, &status1);

[Severity: High]
Does this new s35390a_read_status() call destructively clear pending interr=
upts
and power-loss flags?

When s35390a_read_status() executes, it issues an I2C read against the
S35390A_CMD_STATUS1 register. According to the S-35390A hardware behavior,
reading STATUS1 automatically clears the POC (Power-On Clear), BLD (Battery=
 Low
Detection), INT1, and INT2 flags.

Because s35390a_rtc_read_alarm() does not handle these flags after reading
STATUS1, it appears this would inadvertently erase any pending alarm wake-up
events and silently discard power-loss faults.=20

Since reading an alarm can be triggered by unprivileged user-space applicat=
ions
via sysfs or RTC ioctls, could this allow a trivial denial of service for R=
TC
alarms and power-loss detection?

> +	if (err =3D=3D 1)
> +		return -EINVAL;
> +	if (err < 0)
> +		return err;
> +
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(=
status2));
>  	if (err < 0)
>  		return err;
> =20
> -	if ((sts & S35390A_INT2_MODE_MASK) !=3D S35390A_INT2_MODE_ALARM) {
> +	if ((status2 & S35390A_INT2_MODE_MASK) !=3D S35390A_INT2_MODE_ALARM) {
>  		/*
>  		 * When the alarm isn't enabled, the register to configure
>  		 * the alarm time isn't accessible.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D4
