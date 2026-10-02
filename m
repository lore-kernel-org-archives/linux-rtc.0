Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE44734EB;
	Fri,  2 Oct 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937424; cv=none; b=eApBD1UH0YyOCmv4FTrfpfgS19cKN4Lg0npM0Qb347p/gULMGsRqLTtUMlV2WhougCW4FDLVrzcrO42zZD6dTgwXIvSAmm3qQiCs9UJFLIID9jliIxfupLmu+nNrG+O+bHL+6o8GXnLz590lUAik0W3nKEtIZ9aALVJFwxn7eXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937424; c=relaxed/simple;
	bh=t9HUS8dgRngcPnHSlHaiT9nMgFjuRyJyM+/B0JP9MGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CcngfLm5V0vzVJSJxs79ERo15HHccQKsHPmZDSbpNvZnDI6tgNu/7DkZbKfBEPonUy5XTJ8Ud0fuT/FZaBO9Pq1tSUdwl14VUbZQiUtC8sxm7gqsV4EDzHxY10MCfOwk4BjWgo432OJ61XAhex5btETWMimTp+COJ8doHBqWw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX22rPqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX22rPqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D251F000FF;
	Fri,  2 Oct 2026 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937422;
	bh=QB6AKeRsJJZhDZ0vSyfhKmV0pdhzr2GIn40B1PbnYHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VX22rPqJd8A0XwAn6c/ab45hIvUG/ddf6ya89qNGiD5sNqC2OyR/DjcDv6ujaf0xv
	 TjKy3mJrBHtV53d3D8Oy46Zxc9ugrnZiHrwgLAwC59ubaxIlg/Sgs7dPTxLFdEpQRO
	 a7Ydd62VH6WIKOcjc563sD3L2twXqNobWyL7Y3MBBfglUva6ECSO50IfEwRAyqISqF
	 haP/aHKIhMaSq/fyQF9FuzPQ+M1/sw5njBzEw6dP9IXwq1sUuRF2LKtvdZacOzxRx+
	 In6Q74exOaJNkSW8LnRfTAtNAWkVwr6aLtxUY0OhXpAbGB9FeGlfP1GXUAT9n0+kBk
	 e+rC2VzPK9gCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20261002102419.830595-4-sander.speetjens@gmail.com>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
 <20261002102419.830595-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:37:02 +0000
Message-Id: <20261002103702.78D251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kernel panic due to passing ERR_PTR to platform_device_unregister
--

commit 871d9696731b8e115094c715d59226e0d29be3d2
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit adds support for the Raspberry Pi 5 RTC by registering a new
platform device through the existing BCM2835 firmware driver.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -231,6 +232,26 @@ static void rpi_register_clk_driver(struct device *d=
ev)
[ ... ]
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model of Raspberry Pi board is from the 5th gen
> +	// as the RTC is only present on that model.
> +	if (!of_machine_is_compatible("brcm,bcm2712"))
> +		return;
> +
> +	firmware =3D of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-rtc");
> +	if (firmware) {
> +		of_node_put(firmware);
> +		return;
> +	}
> +
> +	rpi_rtc =3D platform_device_register_data(dev, "raspberrypi-rtc",
> +						-1, NULL, 0);
> +}

[Severity: High]
If platform_device_register_data() fails (for example, due to an out of
memory condition), it returns an ERR_PTR. Is it safe to store this error
pointer directly in the global rpi_rtc variable without an IS_ERR() check?

[ ... ]

> @@ -327,6 +349,8 @@ static void rpi_firmware_remove(struct platform_devic=
e *pdev)
>  	rpi_hwmon =3D NULL;
>  	platform_device_unregister(rpi_clk);
>  	rpi_clk =3D NULL;
> +	platform_device_unregister(rpi_rtc);
> +	rpi_rtc =3D NULL;

[Severity: High]
Can this cause a kernel panic during unbind or module removal?

If platform_device_register_data() previously failed and returned an
ERR_PTR, rpi_firmware_probe() still returns 0 (success) so the firmware
driver binds successfully. Later, when rpi_firmware_remove() is called,
platform_device_unregister() is invoked on rpi_rtc.

While platform_device_unregister() safely ignores NULL pointers, it
attempts to dereference ERR_PTRs, which would lead to an invalid memory
access. Does this path need a check to ensure rpi_rtc is valid before
unregistering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102419.8305=
95-1-sander.speetjens@gmail.com?part=3D3
