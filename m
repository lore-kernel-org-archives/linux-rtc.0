Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD537AA65;
	Mon, 31 Aug 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210035; cv=none; b=dBCr1oX4HGEPVTC8tJ5/Hp12ahSpYwjRtYQ6bzsxdSeQQeKdFyvOYeig+WnP3d7uBNza1fvo9nLxv+r0hCtDCPG1VCv9RBq55m0kPLPZy07bBOE7GJ480vHFXKUefeuSf4qROmzRzlXEawpO7Q9KX5QQf++l+P2+u5RhUgeJ9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210035; c=relaxed/simple;
	bh=H/YDNa8Z5IAj0VF3CpcnXR+HMJcHvMB8TW8eZGhFPyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPfUVlmN/2jKSkKcvXyy5lxvFkWS3CYUqVjRPv8Dx1z2PBxjnvytXon8zDFhOHThxHTPlV+0RnhLujkBglf/ltDbEJo81VP750zn0Viospgl/MeLLA8eaInpqvmyYRZjQ8R+GXIRBjPwS2uwwtkTQM1zeels78Ml+Y++xVDtnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrLmclB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrLmclB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F51F000E9;
	Mon, 31 Aug 2026 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210034;
	bh=a3UXW1LIeg94PAxTEF/lwNtMOsILS1EwmIeg0oVUdso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrLmclB/iW+xB6dCqLH0y1Ak1ZhKduCINRqYeaRwkzpl3VpIjE+JTwJAXwclDE8Ci
	 EP4SmF0a/I3iGovVddqCkkCo86mQhS/MMiJJigzSQxCId8Wgmr/j4c+rQkhrXm1doW
	 Wdtfb7kp3UvarAe7GVL9+JoeoYTHAXt9x7zbnD/mOe4A9zwWwapnSRbnlAWCKTzPM/
	 FfI461cco3LMQCuSq7p7s1dZpqnWq0Z8J/YBXL06Aih6d38C06NUTUJykZ15yFtJ/Z
	 h2okSHYP9pemCf2J5RXIwtwSZHwr3iFo6xC0uurMjYB4pQpsX8px06sAKF02tRKmQ2
	 kdE2unuEimxaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831-rtc_s35390a_int1-v8-5-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-5-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:00:33 +0000
Message-Id: <20260831210033.CD5F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware reset clears persistent pinctrl pin configurations withou=
t restoring them, breaking clock outputs.
- [Medium] Lockless read of `s35390a->pinfunction` introduces a TOCTOU race=
 with concurrent pinctrl consumers, potentially overwriting valid pinmux co=
nfigurations with fallbacks.
--

commit b6394d0bf7b85783daa05f6575f0b6579cf01843
Author: Markus Probst <markus.probst@posteo.de>
Subject: rtc: s35390a: Add pinctrl

This commit adds pinctrl support to the s35390a RTC driver, allowing
the configuration of pin functions like wake-up, minute periodic interrupt,
or disabling the output. It falls back to previous behavior if no function
is configured.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> @@ -64,6 +89,10 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
> =20
>  struct s35390a {
>  	struct i2c_client *client[8];
> +	struct rtc_device *rtc;
> +
> +	struct mutex pinfunction_lock; /* lock preventing concurrent access of =
pin function */
> +	int pinfunction[2];
>  };

[Severity: High]
If a user triggers a hardware reset at runtime via the RTC_VL_CLR ioctl,
it calls s35390a_init() which completely clears the STATUS2 register:

drivers/rtc/rtc-s35390a.c:s35390a_rtc_ioctl() {
	...
	case RTC_VL_CLR:
		/* update flag and clear register */
		err =3D s35390a_init(s35390a, &sts);
	...
}

drivers/rtc/rtc-s35390a.c:s35390a_init() {
	...
	*sts =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, sts, 1);
	...
}

Because s35390a->pinfunction retains the previously configured pinctrl
state but the hardware has been reset, will this permanently break the
pinctrl outputs (such as PMIN clock outputs) since the software and
hardware are now out of sync?

[ ... ]

> @@ -539,9 +762,33 @@ static int s35390a_probe(struct i2c_client *client)

[ ... ]

> +	err =3D pinctrl_enable(pctl);
> +	if (err)
> +		return dev_err_probe(dev, err, "pinctrl enable failed\n");
> +
> +	/* If no pinmux function is defined in DT, fallback to previous behavio=
ur */
> +	fallback[0] =3D S35390A_FUNC_IGNORE;
> +	fallback[1] =3D S35390A_FUNC_WAKEUP;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
> +		if (s35390a->pinfunction[i] =3D=3D -1) {
> +			err =3D s35390a_pinctrl_set_mux(pctl, fallback[i], i);

[Severity: Medium]
Since pinctrl_enable() makes the pinctrl device globally visible before
this loop runs, is there a TOCTOU race condition if a consumer driver
requests a pin state concurrently?

If a consumer (e.g., probing asynchronously) sets the hardware state and
updates pinfunction right before the lockless s35390a->pinfunction[i] =3D=
=3D -1
check evaluates to true, could this probe thread subsequently acquire the
lock and overwrite the explicitly requested configuration with the fallback
state?

> +			if (err)
> +				return err;
> +		}
> +	}
> +
>  	nvmem_cfg.priv =3D s35390a;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D5
