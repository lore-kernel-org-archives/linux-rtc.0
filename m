Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776403;
	b=SKIGeab8fJFrtUmlVAx0xw0q7i4M90+NAUs0EdoUojsSmi1HKRZTbUHJdOEPmxcnUA0t
	 dyyGPzPOmv9Ef9HwaPm4Lhm8rzl0DmaZ3FNwnatS87TtvZ+YAyon9f57xLNvC0HqP50R8
	 8pwodUkwgmiyEAorhIS3qGxWx2VPt0eN5BfZQGzh5TRwjUtMDbn5AyoKd4OnWevO1CiLD
	 sD6v7TQW79SKdsCoFSIRdrYjdZtVlnLjvDPJuYlK6BQV2VipG8RB0zW2QjJ5Ch1BPzdxb
	 ay7r6hpO/8qg9afFxSRhmPcyhnpYLUyqMhGcadu8UJqBWDVpiPVo5ejqPgC6r6S1ABw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C0TzHQVierNFxfbysRrMWhI+1YWkm8i4uRFXjJUT9jE=;
	b=LOhKq25EIoRVOqOI69AabL7WgJHpPKVBDVzKCYYIFTnOjXTVfFP2tKlstp/DyX8VMvDX
	 pWuAZ6daUPzSpWaUAW735pcLiMykbh1eQBSQorHm+MPHspbZRZSFjSdNQpD9ht1k51W4t
	 15RfzHj2xVKeOArDfBipCH4cOvqY01JHYfi8+plrCaiyh9Haib7j53OLZf9bkcLJ19FQb
	 ZpU31S54OQLP++aarpNg/fvEHd1AH7VXjmgqgUrAn/GllvJTPULZcGS+/WJMtS2Wn+v/E
	 IJ9oQJO2X6Hg8LbZG+Nn/Si6CreuNRPer/V/suVwLeU8cfi6PuIWWTe1fvU5Hu7cEfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVX2YnTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF8606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVX2YnTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6251F000C1;
	Wed,  4 Nov 2026 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776402;
	bh=C0TzHQVierNFxfbysRrMWhI+1YWkm8i4uRFXjJUT9jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVX2YnTV3Siy0nmZshkBoeQ8reNZbFy6lCXVd5LhlQ0uMwiBN+L6cE4hB8Q+exx0N
	 vwC4G2zeiOeC861tL5jkvVsjM+HiEslISYMVhRoCbcFdIxlAhYN9iCY9rHdL1iIqBz
	 qPEaujg5zHdp19Kr4u0OjfbijrR+5wSSxmn9X08CwcAQB2L+20XNYeafTg11s/SspS
	 9AVf714/KFHRy0clR41P8nejwQCeIj9v7j2r3YfU3x4rfJXKgeC5EOraYc4cYN4IAe
	 O6VwQWWRuzZ4k03H+ZB5/4Qp9vIZ3FPo6Gc/8PC/nPQFqHLiMPO3DtTNp4nFQ216QP
	 3ZtBpP6HO85ZQ==
Message-ID: <sashiko-outbox-196781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] rtc: Add basic support for RTC via Surface System
 Aggregator Module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104070441.74127-5-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-5-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:13:21 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Maximilian Luz <luzmaximilian@gmail.com>
>=20
> The Surface Pro X uses an RTC provided by the SSAM. Add a driver for it.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104070441.7412=
7-1-val@packett.cool?part=3D4

