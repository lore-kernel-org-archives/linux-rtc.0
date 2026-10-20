Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491468;
	b=O7iFydEwBEaF7BYa+khdESi01OMNDvw3cpgVdZyvsoJTUPJdNZloJr2PTocDfvnnTGYG
	 rL9wGtwcv0B5E3KlDWh3m4vjQvJ/HCWsT+llG1TEd+LQ5CkNef0PFWym7syxJg0BaURmR
	 MJJLEV7wT1PB5eoWzPCPoh8c1kGnhtLpBz54udKmlr9ocZk2oOwYGJnjgvatOu17Resh4
	 nlYlUXVqeqG/QwyCx0DT/X115y2VXUnmFsPPw1fo5MldNkqfCRGzIiDiU8nhIi86B10nw
	 pMFlHslGnhm7H3uNSPnukRJl4WeQwWzBv6Y8P5t1rm1Wt7eYpgKaGtra1foGIt86BzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491468;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UKzrd54OMkG5fM6Hq82N9GAY/LO634g6mtsK7/1Cxe8=;
	b=QtXEWvSfCbw+oppjkUioqhtkawpUFU2Zz/fs3tQnTTozPJx7Sz+eClbdHECo8XvFR0Bu
	 nuesjckmAQGi3WhRjFb/8pajfo2lddSuTBEGwFHDS4iaYBJl11jAmUqZ/Ni9bvhLa56/X
	 V+KBdIpqDQJ1HUhdPLvPnOPhlP24OKEKs/+y7mv4w1y/62YroTkYWUiOA319HLrVQiE8V
	 ztlWcmpvsD1r4xXOkYNPeMJOGAYKzw9MeEZh1okXBNKv3gcZSi84tz57nfMOmgjSw8NpY
	 h+djA9x5+pM+mtRi8br+4cmZy1sR41W84WKTLcMR9/AeAKZVu2diaVD3w+lrm7RX2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPfmQr1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB6606A31A;
	Tue, 20 Oct 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPfmQr1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD311F000C5;
	Tue, 20 Oct 2026 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491467;
	bh=UKzrd54OMkG5fM6Hq82N9GAY/LO634g6mtsK7/1Cxe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DPfmQr1XpGn1F7zlc60wK5nEJ91BJpuKAKsF8lExqKfooOyIiWGPlLylSgVIB3Poo
	 W1aUFP8Vh9YIT3WRyrmvTfHlzmC40HX5Ur+NoyQ7gtyNPGtRQGFB68UsJZUwXDoVDv
	 aRwBsDD0kCvXANW+L6bDQ3/5Mh2c5/sAkAeOYYMd2g62dwEHvMDtFX3HOkcj8BMIgN
	 JhlnxtSw2xd1ansNwlmtGpH+CrpEHCV1TdbILuKeIbCDJOV4kA1mRecsyaV8Wpzycr
	 Po631d/fNggmeIVEF2+H+R11g2hC4DsFPPl6Y+I3jEqUa5E+ZaGb8/tgnPuu63BBgZ
	 Gizma9CCv5Ouw==
Date: Tue, 20 Oct 2026 11:17:43 +0100
From: Conor Dooley <conor@kernel.org>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: Fix alarm register word order
Message-ID: <20261020-frequency-gloating-f9fd455d4fd2@spud>
References: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3X8iI98+7hL0ZN1"
Content-Disposition: inline
In-Reply-To: <20261019151024.2232338-1-pocj8ur4in@gmail.com>

--o3X8iI98+7hL0ZN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:10:24AM +0900, Baek Kyu, Kim wrote:
> mpfs_rtc_readalarm() swaps the low and high words of the alarm time.
> The RTC core reads this value during device registration to initialize
> its alarm timer. This can populate the cached alarm and timer queue
> with an incorrect expiry time, or leave an enabled hardware alarm out
> of the timer queue if the decoded time appears to be in the past.
>=20
> Read the low 32 bits from ALARM_LOWER_REG and place the masked high
> 11 bits from ALARM_UPPER_REG in bits 42:32. This matches the layout
> used by mpfs_rtc_setalarm() and the low/high assembly in
> mpfs_rtc_readtime(), so the RTC core imports the programmed alarm
> time correctly during device registration.
>=20
> Fixes: 0b31d703598d ("rtc: Add driver for Microchip PolarFire SoC")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

That's very odd, wonder how that happened. Definitely a blindspot when
it came to testing. This should look the same as reading the time.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
CC: stable@vger.kernel.org

Cheers,
Conor.

> ---
> Tested with KUnit under ARM64 QEMU using RAM-backed MMIO and the actual
> MPFS RTC callbacks and RTC core registration. All ten tests pass with the
> fix, including importing a preloaded alarm and checking its timer queue
> entry. Four additional tests covering current-date alarms also pass.
> No physical MPFS hardware or suspend/wakeup was tested.
>=20
>  drivers/rtc/rtc-mpfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
> index 60596b0ea9d8..6616ca1f02c7 100644
> --- a/drivers/rtc/rtc-mpfs.c
> +++ b/drivers/rtc/rtc-mpfs.c
> @@ -131,8 +131,8 @@ static int mpfs_rtc_readalarm(struct device *dev, str=
uct rtc_wkalrm *alrm)
> =20
>  	alrm->enabled =3D mode & MODE_WAKE_EN;
> =20
> -	time =3D (u64)readl(rtcdev->base + ALARM_LOWER_REG) << 32;
> -	time |=3D (readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MASK);
> +	time =3D readl(rtcdev->base + ALARM_LOWER_REG);
> +	time |=3D ((u64)readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MAS=
K) << 32;
>  	rtc_time64_to_tm(time, &alrm->time);
> =20
>  	return 0;
>=20
> base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> --=20
> 2.55.0
>=20

--o3X8iI98+7hL0ZN1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatc/xwAKCRB4tDGHoIJi
0mnfAP9WHLFsH9RNlptmvuRa3tCyL3gcyFP1D4ouXo0XLigQXQEAiSt75Wu3OUbv
ThkSkMDr/yWEXfi5RfyATq3bW78TkAI=
=vBRu
-----END PGP SIGNATURE-----

--o3X8iI98+7hL0ZN1--
