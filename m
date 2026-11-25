Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619679;
	b=q6TJz56jiDMTLCaRmIFaIjz1jwAX6ZF6um3Sy1yoZSpKRQ/BBp9Tu4bQdQLaqby8LHQh
	 qxHkPhVozO4YGzpkUhHppsVvp723tLVGk4gjYGW+8Wr4rwxwYS2adOJgymNm29O+YWnRh
	 H68JPU+06PeK+qNG1WU6TtagxVX9oxSz/KagIxIHdblxwJdFyqwc03q6Hu5y71wTRayux
	 DVLp/npE8ta499sd0LlDAmRj1M6feTYe38cPmSQY46aPEQfTmdYGSuvAX09D71I9l6hto
	 GJwhj5rm2tb7LLDcC6DrzSFgOFx7JGpKUrRsRQ3k8GcLzL+O5ELUz0i05qfzSnKPCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5g8t+he/3yoCFDKUfvcowJtxpAX9gz7XfhHB0NBIjcE=;
	b=WDnGsiQI2rZ125OW9WNJWl4O8fxKCqW7DK+Piw7xm+zSW41KxJKfbAu1p3q2xFTwPQEM
	 NVb424OXHAEKg5klxgpxekBkNu/kmb6pG2gOKBHyFmOFbTs86e5EB/bhj9RoKQoQpdOwO
	 TrzcPXoPE0I9HvR+5Q04NiKDVRdJxmMJQc58/TC2nv6GabNNOzMtAjTy/nbOAvLZvXTEh
	 D7SVVnzOnJckbSR5QFDL9+ImyavqCfl7VnRS5Gu8EXkCaKFUdieh51rnCH9B/f+1jRMCm
	 jwaDxT/oVtMW9LQInG3ueD2v84sYwX1JZAkoQgFHM8PEaYnZ8UUdHY3XV0s5kPekJIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BMp/4WwQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF3606A685
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMp/4WwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F65C1F000F2;
	Wed, 25 Nov 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619679;
	bh=5g8t+he/3yoCFDKUfvcowJtxpAX9gz7XfhHB0NBIjcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMp/4WwQsFXNtzv9cBV+goNtQkyHK2OoG+pLw8N52z+/FUTPbUWlap9/FzRlmD4jN
	 3BoYMsHXY4/RhHuE8XV0Fw/s80bnuz0DPMMpQnTKQUhIQYn0KCeTaBx6c1gjU55Mie
	 QwtBavdFOnK3Vu5PCHD9aPOWwCUlQGMn/HeDe03YeX65Kzf5ToGClbocmXQekiAxbA
	 4+vrBrtohhV+hFVxp2QBI7YYWbX2P8Q895x0mVi989J1V0MnB1Wg5SILe9FjWtfVju
	 +7tPvX4PaP+v19PLn/Y+AZExmmRSVYh8P3e46SvWUd0McX28Kxg95v5KLmnyOktJb7
	 pAzkJOTgB3BPg==
Message-ID: <sashiko-outbox-233638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: pcf2127: fix regmap_config corruption across
 probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshat Rawat" <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125151108.423-1-akshatrawat095@gmail.com>
References: <20261125151108.423-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:14:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Both pcf2127_i2c_probe() and pcf2127_spi_probe() declare config as a
> static struct regmap_config and update it in place based on the chip
> variant.
>=20
> In pcf2127_spi_probe(), if a PCF2131 probes first, read_flag_mask and
> write_flag_mask are overwritten to 0 and never restored. Any PCF2127 or
> PCF2129 probed later reuses those zeroed masks instead of 0xa0/0x20,
> breaking SPI register access. Modifying static max_register and flag
> masks also races if multiple instances probe concurrently.
>=20
> Remove the static qualifier from config in both probe functions so each
> device gets its own initialized copy on the stack.
>=20
> Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration st=
ructure")
> Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125151108.423-=
1-akshatrawat095@gmail.com?part=3D1
