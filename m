Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55F49365A;
	Sun, 23 Aug 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523721; cv=none; b=Idp/1pjdnry3ZnYeWAOU+fX5o4aEHILnOHcdEEJ6OyfKTkdrD6NigMU2xteKQ75V6USOmMs9c49/ABXa/oTe4Dbu+qpnmSWf+EqUWYSXu+advW7u0B2VSgB3r4148CGjtUO1ENjy/ZBD/qUeyd51eJSIt03jKg3WZGgNznVjTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523721; c=relaxed/simple;
	bh=uuPGaHYov7+PkPtInXDEjee/W7KmjVQCjf6Ih66IufI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N9TY8QocD25UdERbRRr6WNqcqRBUSBHVKfxD3rD6i8d692DY55zrX6ibEBa1KCZGH9kccCJCdLculJf9KmvdOG8e6RhAHhqOGqqfwHdro2RjG6Nma+CZT5rIUr42lEcspQpTzRydkVkB6EnTJ+MMsndJkdMkpNJXRWA4WUpjc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA7bI3Lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA7bI3Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7671F000E9;
	Sun, 23 Aug 2026 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523720;
	bh=sAKgo+kc8fgXH+phEHJsbUgm+0NTkbxe/iECeJEt1Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IA7bI3LcurCe4FvwTHSP8dhi/TvxVZxOlwqiQJS7qp4IkaILVgxKjLlIMB8I+bfAB
	 J1ZMObNEvK3eJzwjPnUKzzyTI5iGYm6BafqhXrAsESgw+TsUfmgk70v9LbxxD0dm6c
	 F/wxFxbwFG3/reo73e1kco5EQFG6AQ9lOWtqQL/7j3Yp1sQukdmSNMNXS/qEiyMtMr
	 LnbQeice/OeucWo7gp8PSmucXThuqY1aCH/gIyLbzyIQX5SdG6AGo0tAZDQmLC3ILL
	 KpvRfVqHRaY+n4GJCLY01wV6V8j3YWRax4WPmrI8xuoTKILa16vMsis8hIbumAANd2
	 pyFguwg9+6yIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260824-rtc_s35390a_int1-v6-2-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-2-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:21:59 +0000
Message-Id: <20260823222159.BC7671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe clears power-on clear (POC) and battery low (BLD) flags with=
out acting on them, causing silent data corruption.
- [High] RTC_VL_CLR ioctl performs a full hardware reset, destructively era=
sing the RTC time.
--

--- Patch [2]: [PATCH v6 2/6] rtc: s35390a: Add missing newline to dev_err =
---
commit f317b10535ad5028ddd5cbe785ad735c87f43819
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add missing newline to dev_err

This commit adds a missing newline character to a dev_err() message in the
probe function. It fixes the log output format when disabling the alarm fai=
ls.

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

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
in how the probe function handles power-loss flags:

drivers/rtc/rtc-s35390a.c:s35390a_probe() {
[ ... ]
	err_read =3D s35390a_read_status(s35390a, &status1);
	if (err_read < 0) {
		dev_err(dev, "error resetting chip\n");
		return err_read;
	}
[ ... ]
}

Does the driver silently discard the power-loss or battery-low indicators?

When the RTC loses power, reading STATUS1 clears the hardware flags, but
s35390a_read_status() returns 1 to indicate the invalid state. Since this c=
ode
doesn't check if err_read =3D=3D 1, won't it just continue and serve garbag=
e time
data to userspace as if it were valid?

[Severity: High]
This is a pre-existing issue, but there is also a destructive behavior in t=
he
ioctl handler:

drivers/rtc/rtc-s35390a.c:s35390a_rtc_ioctl() {
[ ... ]
	case RTC_VL_CLR:
		/* update flag and clear register */
		err =3D s35390a_init(s35390a);
		if (err < 0)
			return err;
		break;
[ ... ]
}

Could this ioctl destructively erase the configured RTC time?

Calling s35390a_init() writes S35390A_FLAG_RESET, which resets the chip and
erases the currently programmed time. Since RTC_VL_CLR is only meant to cle=
ar
low-voltage warnings, is it safe to let this UAPI call wipe the main time d=
ata?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D2
