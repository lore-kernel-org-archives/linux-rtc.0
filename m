Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639126;
	b=EdybyG9dysXimYbbXnG8sb7q6zzOYZ30h8f0P2xRhoDFBxs6tXl//m3edvdS3Hzc25rb
	 Of7Y7cpK2nJoMZ+Bw9fHRyEivJADqbHjomf5XhRXyufhdfbwQnw16QcJNIQ46j4kyL4+6
	 ZnkiZx1ub6Fw4GTLacdusC0U4vZ1xS9LPlNeTsu2mcbpFElhKX9HC7oOagFY42VM7Grxv
	 zIQxMmKoNVXLfYEzfCrk2QTTAy9+ngusyYlth5yokyL0HS8L5GbSzb+VlFmWeJ6/cIMMX
	 HzlTrO6Wn8pwSPQw8IZcP4rB3TDAFlB7VkOI4dJA7rIuQzs8MSwv2mngVjJ/0LHGz5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EVBdiXBvrUuBkfkVcn+e69xb0XKOS9YBC+A+wJafZU8=;
	b=M7J8F/zDhsd+dm7GaplnWJko+ZyVxAiUXdTbTfNC13QoZH+71Bv7ZtC+Qb+Y4fxjdXQr
	 6CO69IJxFB0HEZlDooiYRNx1nmSBO3fSGqfw9RbWQO8PMhzfaTz6A4FDjW7iO2xKsZ0Hr
	 /K8UnHnV8Epilwm+19p8Jjtbt0JRQpryp5NiecxSIIVG5Vg3Tr/+PeskOGCAizA0aa+JY
	 +/rBX7BdwTd4jrjcB6nRHwqjIwp3JzLg5cE/Om/Z82sSH7PSQdHr7pTQfl1FjsMvrrSe6
	 ptxnEoHEQ+opFBISY/u6DtN7660XwMtGHxLg4vF+kHVgjnmfq21mdbMp8Auu82XoZdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DFsEM8/g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4897606A909;
	Mon,  2 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFsEM8/g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C61F00A16;
	Mon,  2 Nov 2026 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793639125;
	bh=EVBdiXBvrUuBkfkVcn+e69xb0XKOS9YBC+A+wJafZU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFsEM8/ghn6Cv/rZ9P/aeKKt8P7zs2BfUegqlRmI6Xb6jsN0bYwVQRPj+IfqV1066
	 RDlsBytLDSkWD4BQURF6ZG5FV3nNU+eu4kxM3Ws3VqWrxKMPq7Lk2BRJPgSkF1sh25
	 QFLYoe8h5X6NDr0nE0sJpf/VdU5LgpZ3frfE7VN0GAHwBOFAA0oJQvm5D+ERtBuoLb
	 3cGahD03YOguAbHgjBlU5OIzYYZ0g+hVAj2Fa1KkH5AHkfS9NgBl6SrOq0QO5mTeE2
	 MBJbpC3HgBmPabEcOlysEGy4+sYvGHz7VyzsOT+h2c+j4bJWNYmH8/2tp7WYDSjSgc
	 9CHeAijcwYFNg==
Message-ID: <sashiko-outbox-193796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rtc: mt6397: provide the 32 kHz output as a
 clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-2-19ca72815374@gmail.com>
References: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
 <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-2-19ca72815374@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:05:24 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The RTC's 32 kHz output is gated by RTC_CON.F32KOB, which the vendor
> kernel clears before it powers the Wi-Fi/Bluetooth combo chip. Mainline
> never touches it, so on a board whose bootloader leaves it set, such a
> chip has no sleep clock and does not come up.
>=20
> Register the output as a clock when the RTC node has #clock-cells, so
> the chip's power sequence can enable it.
>=20
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com?part=3D2

