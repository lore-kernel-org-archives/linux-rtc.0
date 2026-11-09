Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239495;
	b=XHWHyMzaja84txUvbLu1MsWmS9+6ZqvCNftT6CyG/JpofAyu2wwEqwH9TfzGgMOPQJoq
	 K2tEGO2jDoduM9P74ZGdSn/JE0BDUZCjoSow9fZqoy1ufrgsdbV4mUtpKaOHxzfPAwCXr
	 jXPO7OxQzUEXfVJq951mSGr+MBMGTXSTxSmJkKb/FYwG8x6u0AEsYrvgR1cFnfHIA72j3
	 ishLV7N8OXwUmZAnoFLuD+6v/Z4H1w9kn4WrLdmUNbRlUKCI7aXAoZ7eEN+594dUpTPzx
	 Sla4kkKYpwcV6V9S4uN2I4mqLR7jSgcbi2PKnjZWA+/bfULrZhDCpG67FK6Aw1bcWCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bAGl24g4jZtcyVI9+pcWLhPu4GtIheswWj/sZ1XWiUI=;
	b=GJAnzTdtFDxFTry2k+sB7mCvZGXyFdYDsa5om9iUGE3CZWfCBjDYtOcdgcoqmQ/fYD6z
	 ws++XEi3JuPZT1qiu6tMv7MbHljmYiLIYV/mpjFJ/dPcnOLfrU4MkAshek5KvYINahPkf
	 2tdzcQEqxVUUqWskZdwip0XpY8ZcRzFGHHwTkCBdOv+DhZQRCSYSfPNqCMNIHeD3OaYXi
	 SQYrs0oZyzqwsLT5zUshR1PD1ou81t6/Mw+fRzWuqeh591HHZXprhmPZjvAooQ3xTgKN6
	 eE/f+AgqISppX+Q2t95LlPv/2RJ+qCCAUV26Q5uuqQjo3qoasmrs6apebQLWB15bV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hUJG/KBH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940F606A321
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUJG/KBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0E41F0089F;
	Mon,  9 Nov 2026 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239495;
	bh=bAGl24g4jZtcyVI9+pcWLhPu4GtIheswWj/sZ1XWiUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUJG/KBH+8NgQ26Qorm3NhoXSLeatjSxQpBx0zijN9hdBMWRUSdgET2bPH/mbmh76
	 3X7sXzVJdE7Wshkx6i15fQs1s86Cxsg6jLx0EycEIaPz97OS9Fx97VQedEtVOeZSiV
	 LoeIpPskK/tOWDWeA4vqIxH5gz1oYpRrJCu9eJYqNuo/X1nT/Yb9TsFPZY5jpoHHp0
	 xqX3+ULiNR2Hj0To+PIxoW5zbP8/aKBhkCTxefJHLwFIGcA8kLEqjHMHtNV95vMdP8
	 pk6e3VHkefSC1MZgRnuzanBd2pNPHWS1iDiQ7Y9bd10AJImEf+3xKlGl6GEw9aQsx0
	 vjQCMjoH/G9AQ==
Message-ID: <sashiko-outbox-205188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] rtc: Add StarFive JH7110 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109154501.63762-3-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
 <20261109154501.63762-3-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:51:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: "ziv.xu" <ziv.xu@starfivetech.com>
>=20
> Add a driver for the RTC in the always-on domain of the StarFive JH7110
> SoC. It supports time, alarm with wakeup, and the frequency offset.
>=20
> Signed-off-by: ziv.xu <ziv.xu@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> [Owen: rework of the StarFive vendor driver for mainline: drop hardware
>  calibration & the default time set in probe, use the generic wake IRQ
>  helpers, wait for the update bit in set_time, re-read a time that rolls
>  over during the read, round the offset to the nearest step & follow the
>  sysfs offset sign, enable the 32k counter clock]
> Co-developed-by: Owen O'Hehir <oo.hehir@gmail.com>
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109154501.6376=
2-1-oo.hehir@gmail.com?part=3D2

