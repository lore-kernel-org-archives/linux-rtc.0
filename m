Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BD4A2E3F;
	Fri, 21 Aug 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320979; cv=none; b=nzVfzUibhcUaUtyZgTzS/JKYpFIjDUhGnvNhH+fmFuZOj9N59i6CEfyKp3PN3weePRn5DtYVA6Z4oEre/HatDK1RJTOE4JWoNcLFgg+BQcQV4yc3Pzsst4y//iE/4xL97oWFTPeMtUvIMGXHUXdDGu4dzHNy18FA2HNb8PWtuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320979; c=relaxed/simple;
	bh=HgwWVH+rslkBpr5EaBCzn1iOlv1FvBr9ChGWENNhIHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UGjdMbXVODBVFyh3gm2/Knb8+YD/JLDyHz/0sUetY9WECUfuBBF7kRrz3cBTS8pLMTtbZG7RjYrDWEfuvktorMPkFpK9u6jYKFx+JV+6bM+I74VfMX00c7nF4Z87ntkYR2hGgzUU+DgYAAEX/3o51wkFlRXgcNOcThyzGHNbJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI8FrNFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI8FrNFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46FD1F00A3A;
	Fri, 21 Aug 2026 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787320977;
	bh=HgwWVH+rslkBpr5EaBCzn1iOlv1FvBr9ChGWENNhIHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gI8FrNFo66w7U5Y+GIpntMbJk9Abt+/80KY78dCHj4JvjQEZ1ssCWIohOLBXyqRGz
	 dAbiiYtqZ6Wpd6QrCZubEvTH0ejq4kuF49Hx9LCDEsPsUHLUf3MvDQoZ/Z8vjjhYRk
	 FSnFD8zy0kClCTG3qLVxU4SeRdjOxNoxFgEUkrbi567iLTgh3OFDPflZUiZxJCTUFD
	 l2gfc2vx5hJxuZQSFVB0O1YFpQEQFg8RLFZKHcp8MsdzKK6zPkCYiebzCz5wsNEtp2
	 m7nDuB/ItdxpkoGlbGjpzl2JTXUx+y4xcS8Lf8KhF7uh2yqEepsMlUXQhaHk2LE3oc
	 5mGwOXWW8XIGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency
 to ARCH_RENESAS
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260821135608.275233-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:02:56 +0000
Message-Id: <20260821140256.E46FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
> config option to make the driver available across both ARM32 and ARM64
> Renesas architectures.
>=20
> The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
> of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
> and expand the Kconfig help text to allow this driver to be selected for
> these additional platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8

