Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE9352008;
	Fri, 21 Aug 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347259; cv=none; b=RVkpg3rmiPpERD9jvvMly0Krl8pUJF8GB9GNE60PS/X5yhBL4EDUEwIKGqvyE+WGE3kxsqR/IRlO8vtzZ7Lw8Cjrzo2XJkq64xR+GwYa21+qYHp+GE3Iuj684J2ZSyw2Jw9XqS1sEEu7KaxrA3JFDw5mO0tGajJtWZC/PxF4IrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347259; c=relaxed/simple;
	bh=IjMfXBrf16NuDMDO7gzxuvHbUdH7Trg9b4LJBB07ic8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4Rqx91i8DV+BQbubxOdvq3YdwK/rwdVXOxPWJizqfBHrDVhSIcc7KkKpTuZTglp5k9uFr5t23hGLhFBcIzPXDFcz1yqUazIZ5oOnYkthtQuRs68iYqy/gg75Rdht2nY7LjOyhsOMb3K6x/28P79wFia54cnd8To1ugDpu9ob6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+3F4h3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+3F4h3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3C1F000E9;
	Fri, 21 Aug 2026 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347258;
	bh=IjMfXBrf16NuDMDO7gzxuvHbUdH7Trg9b4LJBB07ic8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+3F4h3tAnLpbesw8jmCIEoyntSUQ6+3i4QmXxsumUB0InTJMIrCrVlNyJKNOJSDB
	 NVH0A1hrbLRVeWF2+J3xa6iTwprD5gdvkxoa3hLyWz5YhPNmdSl993hvhCiLt8U7Gr
	 bP7VGnGRtT29e3+ZLQ/RqxALxcGcL7DGdYN9AP7ylytTs5Se+OjTLQxoCtrxng9Aii
	 Dv567jLg65FlEVwiSJSuAEx5parMlXWUjHO4GxUZ0ejsd9MY5F5tJhAVgU1AA1bhRA
	 19UhXRbo9Orwr9X2Wsl+AEQAoFr0t9MyHbATPvS9SITM/8VIMC/dPUXC6l1p4hpBdW
	 Yfgx+nAPW584Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821211032.13554-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:20:57 +0000
Message-Id: <20260821212057.F0C3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> or when it runs at 32768 Hz, the driver uses SUBU mode.
>=20
> However, the RTCA0SUBU register used by SUBU mode is not present on all
> SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> mode on those variants would expose RTC offset operations that access a
> non-existent register.
>=20
> Add OF match data to describe whether the RTC supports the SUBU register.
> Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> variant without SUBU support.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D15

