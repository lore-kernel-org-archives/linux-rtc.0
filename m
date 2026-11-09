Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238857;
	b=eLkE0Ptb4eRcS8S5L0PLkn5DOEQagZ1/jclin8HQ0rmAWfq8EAvuiJKyImD93NHDmuAC
	 l/ThyJS3mwDMEKca4Z6TDCw12fwHd10EVf4TBRhxJQxbRQJdV399wMOL7VzjF9AO0nZxP
	 wfyyx+A2Z1loMn32GRQ+SwOutebPX/lHykCHSiGvNHkqyViAGGha/nI4Z0CSryoSz8LGK
	 tEb09YA71qHsRpgM4045i7LjrIE3xLljsyXJxpXLLKSB4sFkjW3pi67rR3BgpujJKiUxV
	 KCUey2tqZJPf5Sl2g7AkXfh4tkG3Slt4vFjoAVXbZaKHILocKzw3KPZJlhmVD5jZFVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vVF3ubqf5E+OXvIP0/wHjwFLXkvTdoq8FtxBpNAeetc=;
	b=TbmwSnrvG6H2VEPbDIQBhdz2UEIxmr0LQieBSqCk8cAHdbBgoMiWwgZOS/0tkJwR4hoJ
	 YhrTecQ2IYnxMGh9xVv385UiQCDDW/UbMn/1LevQQacNScYU2Y0hacMo+fdvOb0ENl1/O
	 hCVexIR5O7I3vQmmsyQc+Z7RfsBV6XD2Sp4MoiSM4YGOfjMcsvXw0Krg0zSY2T3AaaNY/
	 fgr+zsGSyP6R0cJ8n++qW0HxEqBJnaSd2N4GO4c6hQMrWLttOcG5m97zZC2ZiYp8/x5XN
	 lJIAq+sLyFCj8i5gHu9K6zIR2lUetXvEyVJLe2Pr1RKovME3y+3fz35nO+iKf9UNCVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUKWUnWL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61744606A325
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUKWUnWL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B185F1F0089F;
	Mon,  9 Nov 2026 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238856;
	bh=vVF3ubqf5E+OXvIP0/wHjwFLXkvTdoq8FtxBpNAeetc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUKWUnWLfo9uqXQtAwgydUIdlia2ApM4Hb+Fzrgjzg2GJOn19pSNGtHdndPiJcZCp
	 EGF877I6/f8LJDaR6DyGvbs3Y585Qx0XL84iKNzPXZOPEPMSKp8Z1hcHcRowqxWDqh
	 j2hScXiFdHU/ecddWvjB1dYvmOEcExei5zXEv+r6E2nOK1Shymzy3icKcnqtrHZcNs
	 7ZR0KtGkdtfJkdVGkrffs7WyBhNhHEX1OHRLYf3hQG2JrrssoSXKtkzuI0qLAkq4xP
	 T3gnuNPTPywuZvreZMVB3mjr7m0sZzld/mIv9qq/upjcLb7AlCoUC0TFq0zki4+GMr
	 64lVyKzUzxhHg==
Message-ID: <sashiko-outbox-205167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rodrigo Rea" <rodrigo.rea@marsrover.mx>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109152352.6335-1-rodrigo.rea@marsrover.mx>
References: <20261109152352.6335-1-rodrigo.rea@marsrover.mx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:40:56 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Rodrigo Rea <rodrigo.rea@nxp.com>
>=20
> Document the NXP PCA85074A real-time clock with nxp,pca85073a as a
> fallback compatible. Both devices have the same register layout for
> clock, calendar, alarm, offset, RAM and timer functions, allowing the
> existing PCA85073A driver support to be used without a new match entry.
>=20
> Link: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf
> Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109152352.6335=
-1-rodrigo.rea@marsrover.mx?part=3D1

