Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738D3D2FE1;
	Tue, 25 Aug 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643414; cv=none; b=DH759u0oEmxdJ6XNj6m7WWNb6JMkO5ceuvbJmMSFkDqbP0IeU3JReyA5XiWzEJlNBs6N47oIIC+B2MG6aEAiKUzZqbczuZMyFtncUaRxj5Pfct6YFIjAlzRoCX8MzTB2CW3/epZsnVpUxKoMvF+Ryig1DJKWMHxDr/Yfomlu2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643414; c=relaxed/simple;
	bh=uTzKeawx7r+b2nuywDjPTcQZa4UkzoGULUbhXdN5voo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2bB8u4wwr7QZN5ZMY1Ct4XUowdf1htNKb9+5VUObpwEB5H6s976+NBRQJjXYI5tUozyeuhDFGLqdeD/W72OnuCz4XCCK063mOSJGdIBLe4yVAVaOi8EXBBCQ/ryvIesbhTEkodKqfZ63ngsbVgxqSD4RvqhhrmT02oE0zWdzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmrjS6+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmrjS6+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CAD1F000E9;
	Tue, 25 Aug 2026 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643413;
	bh=TSB0qg2zCLROQv9iOKefILSomx9/Th+Ia6Y7lKiVkAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmrjS6+/eHOKlZGzIlaLm0aa2QQP58h51eXBTL1yhzMhFQY0oM70PGM+77tigAVfx
	 hLJwL1g1ZwQUFLCuZggJUQwpV0yvvHpD53CjqImcrXD1jVKoD2jJzTClC5bu/jC+sS
	 P8nhEDCdvjwG3zKjhtUkl141sDD4YqZYBWZorQgq9AVLMBWCHnfYI6d2e611qK6AeR
	 5XpZBhLYl0bdBu6fETiqS9XIPRcNVwYbkDd2CULYxvKGxR0ZrTt0PO7e/4VrAdEwsB
	 qPcQ6NFnsarnNL9S1VtZV/5cij0EBOWspCmoKnz5rPLMlLcpEi4VsrOE9lLPMZsAA5
	 lg40lfcW/HrRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] rtc: rs5c372: support eco mode on R2223x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260825071927.4090460-4-hs@nabladev.com>
References: <20260825071927.4090460-1-hs@nabladev.com>
 <20260825071927.4090460-4-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:36:52 +0000
Message-Id: <20260825073653.19CAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing RTC rang=
e_min and range_max constraints allow user-space to inject dates prior to y=
ear 2000, causing an integer underflow in bin2bcd() and silent RTC corrupti=
on.
--

--- Patch [3]: [PATCH v2 3/3] rtc: rs5c372: support eco mode on R2223x ---
commit dde76823d322a057d0dc319ae14408d7646ff056
Author: Heiko Schocher <hs@nabladev.com>

rtc: rs5c372: support eco mode on R2223x

The R2223x can run in an eco mode that lowers its current consumption from =
the
backup supply. This patch adds support for configuring this mode via the
ricoh,eco-mode device tree property.

> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index c65b76cc0dc66..9ab6f2c28f7b1 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c

[ ... ]

> @@ -903,6 +922,15 @@ static int rs5c372_probe(struct i2c_client *client)
>  			rs5c372->time24 ? "24hr" : "am/pm"
>  			);
> =20
> +	if (rs5c372->type =3D=3D rtc_r2223x) {
> +		bool eco =3D device_property_read_bool(&client->dev,
> +						     "ricoh,eco-mode");
> +
> +		err =3D rs5c372_set_eco_mode(rs5c372, eco);
> +		if (err < 0)
> +			goto exit;
> +	}
> +
>  	/* REVISIT use client->irq to register alarm irq ... */
>  	rs5c372->rtc =3D devm_rtc_device_register(&client->dev,
>  					rs5c372_driver.driver.name,

[Severity: High]
This isn't a bug introduced by this patch, but should the RTC range_min and
range_max constraints be explicitly initialized here before registration?

The core RTC subsystem defaults range_min to 1970 if not set by the driver,
allowing user-space to set tm_year between 70 and 99. Inside
rs5c372_rtc_set_time(), the driver computes tm->tm_year - 100, which
underflows to a negative number when tm_year < 100:

drivers/rtc/rtc-rs5c372.c:rs5c372_rtc_set_time() {
    ...
    buf[6] =3D bin2bcd(tm->tm_year - 100);
    ...
}

This results in an incorrectly shifted BCD value being written to the I2C R=
TC
register, silently corrupting the RTC time with garbage future dates when a
valid standard date is requested.

>  					&rs5c372_rtc_ops, THIS_MODULE);
> =20
>  	if (IS_ERR(rs5c372->rtc)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825071927.4090=
460-1-hs@nabladev.com?part=3D3
