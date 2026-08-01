Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CC2E1722;
	Sat,  1 Aug 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610379; cv=none; b=kSGogxeThb6n5tR628kxE9DPIGro3h/6flt1/8B5X96gDJ5W4n4EOH7AjPM035+1IGSKgF9/NXT9jSszZSOETM0vINnAIBmfT1n6LwHO6l+mZU02jm3ps/b9R+cVqp/2YMOCA8cmW/eeHiYExPZKQoTX+9TzNVux7fmQODrVhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610379; c=relaxed/simple;
	bh=aAjAP2DU9VVct4R40GZuQ6xaTRyTPNMbZy/rzaLNKyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iC2qv48O6d3ljCeEupdIoE0kvHsT7UZhmJ5mmwwMtuU/0xPC5+9rt3CXcXBY9SZISpl9Jx6vZog2k6kt4hLPsNAhzrBxFA9wQFPTxiRnXUCjWyThIjj1PDWRzKhZVCXWqeB05e7BRCUByllpVRza6Wo4P3kEYXOdFv9mwjI6Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8b/J6Ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8b/J6Ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCCD1F00AC4;
	Sat,  1 Aug 2026 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610377;
	bh=4civryNVrod0/2kUenZzVz0Q+AeBOiAyREVzqcEaQxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8b/J6UlGXHFw7jPrxRivrj3PlycOH2Yj8CqA+M32kigAzXb8sLaZfzIBsfTxI1lU
	 V6c4nmuFXHvJ1FjcFSnuClFz6XGIQbV8I2w7rXxw1/sZGF7cpWtvf7FlG65xHrHQjm
	 Uf1dKhKnTo2xlGvmBPp39qbnFANrZF7JmbZoMVx1hLc6AD1QaCN/KeKzg7Q+2ubcd7
	 YwjxZaIO2W+WJs0eaaBJb+b4MGJGZOj7DG4T9vpuIY/5bEyUScioSCt5HANTDVN0mT
	 nhcU/PmOI1u4ozqwkyF6fePK+j9sKSTEUcrGQTZH0j1743LveJordVImiiyPh0PUen
	 BsB+fQ864Lf4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260801-rtc_s35390a_int1-v2-5-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-5-f10c99ad1d6c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:52:57 +0000
Message-Id: <20260801185257.8CCCD1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The return value of s35390a_update_mode() is ignored when disablin=
g INT2 for Synology devices.

Pre-existing issues:
- [High] Software mode cache is eagerly updated before hardware is successf=
ully modified in s35390a_update_mode().
--

--- Patch [5]: [PATCH v2 5/5] rtc: s35390a: Add synology quirk ---
commit 707121acedc466ad23fc787561fac16b4efa8e1f
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add synology quirk
   =20
Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
it is not possible to configure pinctrl. Use interrupt signal 1 for
wakeup if no pinctrl state has been configured in devicetree and dmi
sys vendor matches "Synology Inc.".

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index fc0dbce0e8f4a..f20b8a5a72dea 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> @@ -806,7 +807,16 @@ static int s35390a_probe(struct i2c_client *client)
> =20
>  	/* If no pinctrl config is defined in DT, fallback to previous behaviou=
r */
>  	if (!s35390a->mode_init) {
> -		err =3D s35390a_update_mode(s35390a, 1, S35390A_MODE_WAKEUP, 0);
> +		i =3D 1;
> +		/*
> +		 * Synology uses interrupt signal 1 for wakeup. Since pinctrl cannot be
> +		 * configured on ACPI, we check against the dmi sys vendor.
> +		 */
> +		if (dmi_match(DMI_SYS_VENDOR, "Synology Inc.")) {
> +			i =3D 0;
> +			s35390a_update_mode(s35390a, 1, S35390A_MODE_DISABLE, 0);

[Severity: High]
Does this code ignore the return value of s35390a_update_mode() when
disabling INT2 for Synology devices?

If the I2C transaction fails during driver probe, such as due to a bus
error, the hardware configuration failure is silently ignored. This could
leave INT2 active when it should be disabled.

This is a pre-existing issue, but updating the software mode cache before
the hardware is successfully modified in s35390a_update_mode() makes
ignoring the return value more problematic:

drivers/rtc/rtc-s35390a.c:s35390a_update_mode() {
    ...
	if (mode =3D=3D s35390a->mode[pin] && freq =3D=3D s35390a->freq[pin])
		return 0;

	s35390a->mode[pin] =3D mode;
	s35390a->freq[pin] =3D freq;

	if (mode =3D=3D S35390A_MODE_IGNORE)
		return 0;

	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
    ...
}

Because the internal software cache retains the new target mode even if the
I2C communication fails later in the function, subsequent requests to set
the same mode will silently return success without communicating with the
hardware.

Since the error is ignored in s35390a_probe(), if the initial disable
fails, the software cache becomes permanently out of sync with the
hardware, making any subsequent attempt to disable INT2 silently fail.

> +		}
> +		err =3D s35390a_update_mode(s35390a, i, S35390A_MODE_WAKEUP, 0);
>  		if (err)
>  			return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801-rtc_s35390=
a_int1-v2-0-f10c99ad1d6c@posteo.de?part=3D5
