Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE3434E45;
	Mon,  6 Jul 2026 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361056; cv=none; b=TfjfFR9c+LfGcyNa4PT4DSLIiGL9WKl9HAfyjWcPgepCGuxYiH99Zty8XY41FDOdEG6UlCjooqj+9h6BrVAa5lpGhsUU/wLGB6VpHkWTngdMHGVeCVH9UVK1BGI9X8tWp/DK2CtxzoECyQkCf+2T0Er3wnQGLzsemq3pLSXxa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361056; c=relaxed/simple;
	bh=bQcuLJK4yCkNFwd1z5zInSjavV4dl3KrI22tLu4ylSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlwTWG9aQ2NRelLEXBAvd40BD85rmP2JVVyh2TlxJEZxcNm2fksoBO3+sHLNrEkp03X1bZYKSBjQ5TFj6jNTSJYMcZViOsdtQra2swahpJQss3jek5rOpLDeXPketo1dMxAyp8jbKvxfuVbQlwmbCh83ZEYLK8PcgvEebDeque0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqG9ujhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqG9ujhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177F61F000E9;
	Mon,  6 Jul 2026 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361055;
	bh=bQcuLJK4yCkNFwd1z5zInSjavV4dl3KrI22tLu4ylSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZqG9ujhiQnXlew7wNf7p5C94iEXumk7NalNGe+pEYgRj1K5MKnovOP2Wztxp1Hd4U
	 lSab/ytp35voavWjQMufqw6wgVBnafSEq2FZdX8af3Q8LAEqAFcYFGBZSQ6A8eSrzr
	 1oyB5EQK60aOX59d41oU9mFC5ZnR9a/B/KFU8HwJe2VX29K6cnM+WO7tp/FtLAC5gW
	 VKCP+Gyo0Lcqf7fZnrffuVmTxJs9tVqrXekzzTjn7ac3k+7+pWhuGNMiX5qn1a+ZUT
	 QU8o8cmLaMeaAu8cZU4OiflewMEvW4rA2slYmlhRDPC09mCyukMBAmrHjt1zmQv2Kk
	 gdUGOryxs2QAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/12] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260706175138.12587-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:04:13 +0000
Message-Id: <20260706180414.177F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
>=20
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6

