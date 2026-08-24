Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D598408636;
	Mon, 24 Aug 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570108; cv=none; b=fa6DLkEhCbz5da93kDu/KTpMXDLMhwK0tEAqfRzwd1VAct+mfPhrlWflppuUeOCsV9GQKZfQFxNbTrnX7bS7QQAP3M5lsH3CJCy25WwzBMhaNxEo9h3KohgYO1yTCbCADfB3Cn92kVkuuBMa1mrrkWIUPZjkTcsm29ZBli/nQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570108; c=relaxed/simple;
	bh=andUaj+Bh5utO2ISSwUy4oL4OZsdcOwKGN1vOBzV+tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFfl9QMExeUb6hkYr7fAKFgpPvjq2GvEaw+/Wi5mn/2Pi6H67YWXNk2+0THUCb6DjyTv7N8Mnur6D/JeHKjVWBcntgucVmU5zWJvbLKyehFkr7ASZyWLHvZ09Q0kB5HVG9x1qzW9/dgoOtrliHjBa/V72wuyqk8yJBwS+YkZXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT4d2OV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT4d2OV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8540F1F000E9;
	Mon, 24 Aug 2026 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570106;
	bh=M0lMk8uCw2fVtvD9ka1aZzEGaJjFFb/M45aWtFfLtqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cT4d2OV5YVuFo3lA7prwZVuLw7uU1PjyphwXA/VgI2TfEYCUXEEJaN8ffEVOmlweY
	 bMvhB6fdCpwPVJH/JrzHfBsf+iRHtAO2OZXjCTnGgCeiClLawJET1wwJpbbAyucaFR
	 soEBdj3tHybvIn91x02BgzDeaWFq3R6u4utwUO1p/LGe5JXBaIhK4UU8b4OUu4I1WG
	 nydhBhHzp+nj0ViTotm9AtPM9I5o2OGSfMjIbwLVonyHPopW9rVLK0aEVgCy+dvROV
	 EhOIBJmVkLpbTXovh/Zr+21lC0r1+Si/+bMvFCS0kxheEnNWqo5NZYJVVlZmw8ttBM
	 PWpsNYja9KIBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] rtc: rs5c372: support eco mode on R2223x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260824110452.4038870-4-hs@nabladev.com>
References: <20260824110452.4038870-1-hs@nabladev.com>
 <20260824110452.4038870-4-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:15:06 +0000
Message-Id: <20260824111506.8540F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `rtc_r2223x` device is unhandled in the `RTC_VL_READ` and `R=
TC_VL_CLR` ioctls, causing incorrect voltage reporting and an inability to =
clear voltage warnings.
--

--- Patch [3]: [PATCH v1 3/3] rtc: rs5c372: support eco mode on R2223x ---
commit 03356cfada315a3baf4a319faaa5eba9b7ccba15
Author: Heiko Schocher <hs@nabladev.com>

rtc: rs5c372: support eco mode on R2223x
   =20
The R2223x can run in an eco mode that lowers its current consumption
from the backup supply. Enable it when ricoh,eco-mode property is
set in the device tree.

> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index 30e272d650219..41d391bf07f7c 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c

[ ... ]

> @@ -898,6 +917,13 @@ static int rs5c372_probe(struct i2c_client *client)
>  			rs5c372->time24 ? "24hr" : "am/pm"
>  			);
> =20
> +	if (rs5c372->type =3D=3D rtc_r2223x &&
> +	    device_property_read_bool(&client->dev, "ricoh,eco-mode")) {
> +		err =3D rs5c372_set_eco_mode(rs5c372, true);
> +		if (err < 0)
> +			return err;
> +	}
> +

[Severity: Medium]
Are we missing rtc_r2223x support in rs5c372_ioctl() for RTC_VL_READ and
RTC_VL_CLR?

For RTC_VL_READ, without rtc_r2223x in the switch statement, it falls throu=
gh
to the default handler which misinterprets the PON bit (bit 4) as the
oscillator stopped (XSTP) bit, and ignores the voltage low (VDET) bit:

drivers/rtc/rtc-rs5c372.c:rs5c372_ioctl() {
    ...
		switch (rs5c->type) {
		case rtc_r2025sd:
		case rtc_r2221tl:
			// ... checks R2x2x_CTRL2_XSTP and R2x2x_CTRL2_VDET ...
			break;
		default:
			if (ctrl2 & RS5C_CTRL2_XSTP)
				flags |=3D RTC_VL_DATA_INVALID;
			break;
		}
    ...
}

Similarly, for RTC_VL_CLR, userspace cannot clear the voltage warning bit
because rtc_r2223x is omitted from the check:

drivers/rtc/rtc-rs5c372.c:rs5c372_ioctl() {
    ...
	case RTC_VL_CLR:
		/* clear VDET bit */
		if (rs5c->type =3D=3D rtc_r2025sd || rs5c->type =3D=3D rtc_r2221tl) {
			ctrl2 &=3D ~R2x2x_CTRL2_VDET;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824110452.4038=
870-1-hs@nabladev.com?part=3D3
