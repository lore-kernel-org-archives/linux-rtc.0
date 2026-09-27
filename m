Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686C3909A8;
	Sun, 27 Sep 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522281; cv=none; b=P0krPnKA/Fg01Fu6Dahb+uUVjKZDYnufCPlMaR2QypSW5e3ofTqjijt86Uxva52V923MFj9nTeWKAvif31trpfXCINc90KpoNB2Mf6F7luDYb3fTywaA4ViuV3P4MPCwEMwBm1o3ct1p6UdD6u2Twp7Qqdjq4LPaNvtVWbIDc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522281; c=relaxed/simple;
	bh=0z47+ZtHaVhknMIBcyYP6ZxDTM7cAc5O0YL6wl+j/dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OfH3zPn2obc6ZqLjehfPDIOEVR1c6IokTcXUIl3sW4Axcw0NAYYPIZbdr8/UwlYchRSmsC8GZ8RA7ENlYeBltNDixjzS8256Nv1pVkZOemV/m3DfAI0AJIw4TMIHFXnMRx/Xrzh/NjX7082T41TSYR2Q3g/CjjUJxLkg/BUeWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8pdhJE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8pdhJE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B9F1F000FF;
	Sun, 27 Sep 2026 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790522279;
	bh=lc2zBsj8ty1DRwiBVnT8cwOo1g9wgLVyjSy8hpLu5NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8pdhJE9aakirbXz53kPALg0R8TPqu7ff8E9Ijst4Xww7sxCmCgaM2DqupCpZBtua
	 ekSAzVL6WY2QZCnNGQCS1FOqHlqZFs03XPXWfqWhMbHRz0v92UTS9Wiy0VYuSg8x2f
	 sFmKEAMKxEkUF3YJqX2H0jGDNC3pBZdvOqXuNf2QPM3M4bWv/jyDWf0vRXr7Nj7OvL
	 rSv70e7w0l06FM0f3oZvh9GTRELKjDwDqZxGuy7oEl7jbWQTTu2QxVmX42TtILJ1gF
	 UMzy36TtBaoXFxOqPHdJ2rid2BUfMqJ3ExxFmcgSDk0l4AL9i7bPh9KDQ6OTJos+mr
	 2d/1cW5cj2l1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner
 B288
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260927151016.186493-6-pmazzini@gmail.com>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-6-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:17:57 +0000
Message-Id: <20260927151759.35B9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: rtc: missing clock-output-names constraints for sun8i-=
b288-rtc
--

commit dc864843d6f807d8dbbd6c391ac70a1992bc2e0f
Author: Pablo Mazzini <pmazzini@gmail.com>

dt-bindings: rtc: sun6i-a31: add Allwinner B288

The B288 RTC wires one alarm interrupt, not two.

> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rt=
c.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> index f2b91186ed377..1699e3576b915 100644
> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml

[ ... ]

> @@ -162,6 +163,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - allwinner,sun8i-b288-rtc
>                - allwinner,sun8i-r40-rtc
>                - allwinner,sun50i-h616-rtc
>                - allwinner,sun50i-r329-rtc

[Severity: Low]
Does the new allwinner,sun8i-b288-rtc compatible string need to be added to
one of the clock-output-names conditional blocks as well?

Because it is omitted from the earlier conditional blocks in the allOf
section that strictly enforce clock-output-names constraints for all other
compatibles, it falls back to the default allowing 1 to 3 items.

This could allow an incorrect number of clock-output-names in a device tree
configuration to silently pass dtbs_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927151016.1864=
93-1-pmazzini@gmail.com?part=3D5
