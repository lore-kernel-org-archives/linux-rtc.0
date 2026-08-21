Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE9347BA9;
	Fri, 21 Aug 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347196; cv=none; b=ZcKNggecJKBfPgNEZUxQYvGaYa20H5T77kQGGSI2Hn8O1zx+QzUqjTgWy0AmoYMV8t9Q+/9CUx7qok+maE00zPoMSONRdpNmKPJiVOuVjwLJOqDtPsOW89kRRURhHCa9rq8spqAkMpsDK6KZGBNMojrtXP0XYUOkZHzk69hPO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347196; c=relaxed/simple;
	bh=ZorIicxW9jS4gvUqLq0ebv/WJXkXUjYQUEedCYrr/n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pkGc04HjVH33CZh3hHhpyoVOXyEjwoTdSZrvVzG54td63qhyMriU1QZuZHMbqPk/3z9b41WI9gLYufEwq0lSYYovO7MdZoVu9kDPdH8I/L2JZ0uAlSwde8Rf3Zvb5dOFKPC6wSC5O5MO6JuvsZcyrqT6EhBb3p/lNF/CuYAMtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR2fzfJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR2fzfJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FDF1F000E9;
	Fri, 21 Aug 2026 21:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347195;
	bh=ZorIicxW9jS4gvUqLq0ebv/WJXkXUjYQUEedCYrr/n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XR2fzfJfewq57G8PvIGCNORz+RwTyZwKVUIzokZ+NsjvmKv9xTtgHpTt1uZ7DDdfw
	 PgpYYpDUQX6PYJclEcAXf5ebs9PuK0oXC0ZhdVcgc0RPVJ7Av6i+t/Q/rIhEZjuq16
	 YPUYxBcZApMs08HzNmllciIlVvrE7j/bnRW9FE3EPdtayl7l0OiDm6Rqf2VdW2Ojfd
	 AEj6wJp8IB+h9b1dXJMKh0RMFCzPTEtWs0iMLxhumGo16SSGjCF/TKBBXB1mZemgUa
	 39Js7vmnJscws3mLuyY75cKZatsNiCDRxXiO/RiSOqONxth1fOnyzxH5mZMAhK/4+G
	 csIuqkoBZUd0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/17] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260821211032.13554-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:19:54 +0000
Message-Id: <20260821211955.22FDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add compatible strings for the RTC block found on the Renesas RZ/T2H
> (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP.
> Unlike RZ/N1, they do not implement the RTCA0SUBU register. This is
> not a limitation for Linux support, as these registers are not used
> when the RTC operates in "scmp" clock mode, which is required on
> RZ/T2H and RZ/N2H due to their 195.3 kHz input clock.
>=20
> The RZ/T2H RTC variant also supports a 1Hz output signal on the
> RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> marked as reserved in the RZ/N1 hardware manual.
>=20
> Update the binding schema to require the additional clock inputs used by
> these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1

