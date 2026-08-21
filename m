Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E04C6F1C;
	Fri, 21 Aug 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321294; cv=none; b=KoAuhcB9sG0vLmrnV76AaTvkZJssyNoPv1ygDpBJrTVe9hEbiTVSQ2lWY68EdBNSCPooj0scXsgUMaEquiAK3H5xOAInDsaD6FKFOUauHjdfEu4m2Hvb0EJBXrrMlpMyR8pZaACZyxLytGnJBo8qPUyut/dbrMEIMrrxNMdR8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321294; c=relaxed/simple;
	bh=yDuHNXBQOixTmobS+vs1dQcpeljXdUgbUBacS5Iwi/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tR2qWKhpZ4nIDxSMWfUNPA0wYeTFtTaLO6V5z70kR7cRPAzpgKWXDKZjDVQ17DAoVzthzaKuNNESjmF4QUEsYICGYcUdM4HKAQGfnbzO2hI+IpZNXal3hkYJ3a1KFmQIQ8RESM0TVHpntC/rZXFTQPdNcubxCjzJza4yvv9kjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRgK31kC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRgK31kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B710A1F000E9;
	Fri, 21 Aug 2026 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321293;
	bh=yDuHNXBQOixTmobS+vs1dQcpeljXdUgbUBacS5Iwi/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRgK31kCZ9T28vw3VO0WvUqbNp5b7us8GKCgAYWvlfvx+8zrskTThnHwmC5uZwh0o
	 xMtRGYhgJpuBQMUc5wQja4moQBveDdgkgyFgyWtnieh9/JGsv4bcegfFGE0GWsrZaR
	 rXXSYVeR9EeXs2Df1JRcOBL8MHWJ9M1YYKTdcydjonTckQx94HjX8BoawfgX8GuG0q
	 ZtVBqUE1M/lRNGRZcxfyx8Miy2RJveD6T8u+girfkdnVIJTp63qINau6TO2J8G54dY
	 l4eriyMxTEemIcwCjTyYmuIe0quZL64KgvZIHDLKKd4qenoWAmTrYnqRNUxwHuoKgg
	 yzpMy+oJHPjPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:08:12 +0000
Message-Id: <20260821140812.B710A1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D15

