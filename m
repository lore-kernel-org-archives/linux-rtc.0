Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BC431A33;
	Wed, 15 Jul 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138649; cv=none; b=Mf33xn6dvakCUDQONrBO42j3fCrnoGRMUCXRdViw9x9tuAaDAVHcxPAtse53qr11NMl/DWYyhih6NgQhZck999Vd69qW3ZcxWJ38UinewGZCdf/fml/nN2eGYO90DDC6B9HMvmrIAMHdINZ1cYqK5GVWvpgpDjVqMCJFIlniEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138649; c=relaxed/simple;
	bh=AxvVICqh9sKD9vJ4mnVOagf+69/KaAL/ID1Y7fKL9MU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SkvN5bVCx27M32zGTqiC+wLCxwieUlfXFMTyQqwAsJUKL3sYsJzclD+xDee2uJ+5nGmTJ5lcgj0VQrONpSYhHXLZCPqPjXHb+f6v2LIiLshLyFiJV0AxZ3TuD+9QENsDHEY4S0ZNyjRvCstAiIEifcGLHt1n5OlvkRIsSPRHyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKuHNa/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKuHNa/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC1F1F000E9;
	Wed, 15 Jul 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138632;
	bh=+hLdvm5bi4I2pqi5e5o8weLMk1N1xO7kttAv7fJ38vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKuHNa/2hlrkqgW4gS/thhfVqTVLy80WzuC8MPPxLC/E2kl0bPlcJtGeLSbvQD3No
	 QTat5XKZQGKmzmFX3OHAMOq1zpTiHGHIWeom+MXrmdWKyWrdYLPuN8jr/YOVqsy7jG
	 E/BOsE4J4KnKjUE785UpU1xSQAagbhfAAnNG0uz6uzYfPE9LXnuYUTDoZdikeakdJu
	 nGi0HEQLP+diJuVmiHLdj4Bm0B8VWtuSpZ7IrKf2LMLDiMwnD4jl1nYJ+rz73RNg3/
	 lCkAGKWwIqAA7pz1ukvwX5oYjHMRTWUSXBI6HoX2v2RTglHF8gI/96sPZTqk3KyjZT
	 aUlVPYpzkVdGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] iio: pressure: bmp280: make reg_write callback take
 const void *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: mfd@lists.linux.dev, linux-amlogic@lists.infradead.org, imx@lists.linux.dev, ojeda@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, lee@kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260715175229.24672-6-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-6-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:03:51 +0000
Message-Id: <20260715180352.3EC1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Syntax error due to 'void void *_val' parameter in qfprom_reg_write.

Pre-existing issues:
- [Critical] m48t59_nvram_read and m48t59_nvram_write completely ignore the=
 requested offset.
--

--- Patch [5]: [PATCH 5/8] iio: pressure: bmp280: make reg_write callback t=
ake const void * ---
commit bd8404c8c6d692d9a700578455111f78fd0eaf2a
Author: Link Mauve <linkmauve@linkmauve.fr>

iio: pressure: bmp280: make reg_write callback take const void *

The previous commit switched from a pointer to mutable data to a pointer
to immutable data, so let=E2=80=99s fix all users of the nvmem_config API.

> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index a872c640b8c5a..bacdcb5610bae 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -253,13 +253,13 @@ static int qfprom_enable_fuse_blowing(const struct =
qfprom_priv *priv,
>   *
>   * Return: 0 or -err.
>   */
> -static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
> +static int qfprom_reg_write(void *context, unsigned int reg, void void *=
_val,
>  			    size_t bytes)
>  {

[Severity: Low]
Does this syntax error in qfprom_reg_write() prevent the qfprom driver from
compiling?

It looks like "void void *_val" was introduced during a find-and-replace
to make the callback take a const void pointer.

>  	struct qfprom_priv *priv =3D context;
>  	struct qfprom_touched_values old;
>  	int words =3D bytes / 4;
> -	u32 *value =3D _val;
> +	const u32 *value =3D _val;
>  	u32 blow_status;

[ ... ]

> diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
> index 4e608bc8bbd36..ad407faecf1f8 100644
> --- a/drivers/rtc/rtc-m48t59.c
> +++ b/drivers/rtc/rtc-m48t59.c
> @@ -325,7 +325,7 @@ static int m48t59_nvram_write(void *priv, unsigned in=
t offset, void *val,
>  	struct m48t59_private *m48t59 =3D platform_get_drvdata(pdev);
>  	ssize_t cnt =3D 0;
>  	unsigned long flags;
> -	u8 *buf =3D val;
> +	const u8 *buf =3D val;
> =20
>  	spin_lock_irqsave(&m48t59->lock, flags);
> =20

[Severity: Critical]
This is a pre-existing issue, but does the loop in m48t59_nvram_write()
completely ignore the requested offset?

It appears that cnt starts at 0 and is used as the hardware address instead
of adding the requested offset:

drivers/rtc/rtc-m48t59.c:m48t59_nvram_write() {
    ...
	for (; cnt < size; cnt++)
		M48T59_WRITE(*buf++, cnt);
    ...
}

Any subsystem or user-space application performing an NVMEM write at an
offset greater than 0 will silently overwrite data at the very beginning
of the NVRAM.

The same issue seems to be present in m48t59_nvram_read(), which could
lead to incorrect data disclosure:

drivers/rtc/rtc-m48t59.c:m48t59_nvram_read() {
    ...
	for (; cnt < size; cnt++)
		*buf++ =3D M48T59_READ(cnt);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D5
