Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264093;
	b=VvFw3Rqll55+XWJHCBBOgn9csrZjkM43Vn4wOAkcRoP1HxBVwMur/cRyUlUMhS3R7Nib
	 HOwlcHU0Cvr+TF230L7NWffYEAaE9v+k4BpnVl3ccrfJIBq2ert9atpFUm6P6UxWp2nGO
	 hBFwpzy1bLY7t2hZoyiOhMAWfrplTJWeZvjVga0cAKucUVH2vBwvni508EiorGl6vDk2o
	 AnGci2kdxgzRENPISDkVC3geSXLXnPGri78MYaFBDRkml1Vk7Ht3KdRmoO/u+BpwKOP86
	 1eRLSotxO84yN6FEtRwN0Q97T7wcTAvv4PgYdifBoA6UzclcJrwA/w5He3rxdYMFzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CA8gMvG76+FYl2Ely/+3lZ6ZC30twNsroiuDE5kBjkk=;
	b=EwtcZZ6FXImO7ScGaU+e7cnoexkDm+xqNOl3xa7PVltCX09/qsQFHBHurpxodQRG441y
	 ObM93Eh9lq0BMNP1g3liCxknM4nwtFezl9E88LmIJRrUFJF4IZm8Eo+hc6srLOIGij4fq
	 o/ALiqdKEIHX5CZKZ4vDSDIejBPp4Tde0IjudH0XI0StqROROpwFgDQNWxh6QGrtnYK86
	 DiLtXgwTsDhk+B22CfMwHsitaHpJgMc7OjLGjWOnCR34fecRQuI1bcdIfoSOkUUYZuxq7
	 MN4aDxufHoKDIcpKLf5VvQJYr2HcL5JykZfyYu8LRSWjnyeKXp9pP8ZFOT9++wxCG5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz5OCDyN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EB606A32A
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz5OCDyN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4CC1F008A1;
	Mon,  9 Nov 2026 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264093;
	bh=CA8gMvG76+FYl2Ely/+3lZ6ZC30twNsroiuDE5kBjkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yz5OCDyNb2I/AuP/KRixh/dQRXxJrsML0pFD2c4EQYs9/kMiUai2dTKWQcKMnH2am
	 xEDdKVt2CqYUyoN+xtM2qk50l0E5K9cLcWVB/Nmk0weUUW/fb1ltmsBooDpCtLRCuE
	 EYJNnhQpklRp+x93+MNSPCIDZqEiYZeNdP/FuRgCF/aQZcEfe+zb6D4u9bBsj0QKMN
	 +vwLeFQJss0PH52NgZw3dixPPVxXaTDd12RADZ1M35FvVC3wfgyRzSkMGk0BH8D02A
	 Vv+qiUEcqfmArqsZQZtiiwGR237bwnLYUi9K1RGmoXXfAZDnHxkTLR0lu80CfzSzgh
	 hv6x8Y5Tcjhpw==
Message-ID: <sashiko-outbox-205762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] rtc: gamecube: Use register definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109223902.84918-10-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
 <20261109223902.84918-10-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:41:32 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Use the register definitions to replace the hard-coded addresses to
> improve readability. Add RTC_SRAM_LAST for the SRAM range end.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109223902.8491=
8-6-blum@kernel.org?part=3D5

