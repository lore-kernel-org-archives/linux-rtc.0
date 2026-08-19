Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EA371897;
	Wed, 19 Aug 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136568; cv=none; b=DixsT5gm2tg6/XHfIKDD/UzUXmvm3hVa/XMxeechl9N/0rouUbtrdsexEF2Djc1OJcqfOMtYKPAmJX1bf7Spl1nSAif5VexwNdF5FVJ3frD4O9fFG/kkTTgrPWNNzMON271KKCpceCpLQ6/qEAMsAuC5RHcIdnzqBcGk3fXv+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136568; c=relaxed/simple;
	bh=QiDPsrIFJBsNdnnwQNrjtARWLJIeiE4FpqB2uScnWOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSYShLO4ymkEjeRkj1n0w8+M0VsmrGEUrrgDmS/EXZ00JVx6N10Zj+ZkNzp8CIUpzi0yDa0BdOwR6cd3+3aS6vB5D9O8YtniMtDiCIw7sJeGyOJ5GP0Qby3MQqoc23oeCqD5Eyx/NI0FeE3s2VtVqIuqtLfTO/9RrEQ5OzCHSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBZ09NaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBZ09NaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC21F000E9;
	Wed, 19 Aug 2026 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136567;
	bh=7rTrOFrCf6hLxs0rDVfDdPJDb7bJsBBJP6UuzalyL3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KBZ09NaJ6M1c6yIUhX85BHLTK++ZdhXR8nNhIOf4s2IfzBT6sj3KFqyj2XvPt3WzK
	 kTyqcPTlNzHoHbmKMMKLOezDPSXfRz28L8mSm7u5xejd1MmkdlEjBKJ6HAjGrSJmfF
	 NbQRAva5rWKwxArdVnH3J7kvEuXdE5XQjoss6fx2X4EvBF/TefIS4bRd+gXlnR5f+l
	 oxx4GLAX46xCKXTPUZGa8Da8XZvXtptz+jGfC+FpVV6IYhooueHf8R1yBp+VzYgRdg
	 iQiXXJI/t+fyFaZeJGkaUGZzGyvcYdmzY68j66dkfTcHld58SXczfAFTDK6wERnp+s
	 CxG7yLCdPCcwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] rtc: rzn1: use FIELD_PREP/FIELD_GET and
 GENMASK for register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260819103926.2136712-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:49:26 +0000
Message-Id: <20260819104926.DBFC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Open-coded masking is still used in `rzn1_rtc_set_offset`, violatin=
g the commit's stated intent to replace them with the bitfield API.
--

--- Patch [12]: [PATCH v4 12/15] rtc: rzn1: use FIELD_PREP/FIELD_GET and GE=
NMASK for register access ---
commit ad6005d5cfeb80b3add21bb7f02da5fd44f8a3bd
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access

This commit replaces open-coded shift and mask operations with the bitfield
API. It also updates the weekday field to an 8-bit definition to match the
hardware manual expectations.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

> @@ -341,7 +347,7 @@ static int rzn1_rtc_set_offset(struct device *dev, lo=
ng offset)
>  		subu |=3D steps + 1;
>  	} else {
>  		subu |=3D RZN1_RTC_SUBU_DECR;
> -		subu |=3D (~(-steps - 1)) & 0x3F;
> +		subu |=3D (~(-steps - 1)) & RZN1_RTC_SUBU_RTCA0FX;

[Severity: Low]
The commit message mentions replacing open-coded shift and mask operations
with the bitfield API.

In rzn1_rtc_set_offset(), this assignment uses the new macro but leaves the
masking operation open-coded.

Would it make sense to wrap this value with FIELD_PREP() to enforce the
compile-time checks and stay consistent with the rest of the patch?

>  	}
> =20
>  	ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, ctl2,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D12
