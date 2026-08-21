Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E98352008;
	Fri, 21 Aug 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347233; cv=none; b=Dl+wRkYYqnQA4G5Et1C4gzxm+1uXyDFJSgCMMiC++ZDkWnHz+O3sLTtkMYKTJpUtRSDdNhO0qKYQGCPAujPUa2LyzpvqbBmUMfmKEFvP82zFyBJ+p1oxUrVywJ4ArXc4ksni/KQ/0SM+a8yeVVIz5NqmwFSG8+rc76hOVQG6v8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347233; c=relaxed/simple;
	bh=WyfAXLKGhNP0oO28M9uaACIhFr4IZbLYdPqPhY8bDZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uenshAYnfJqovtLm5cXkDviTqNqyXMT9gnEBn/rkEnI+vQQFA7e+kI+Df//ZATLk/P/wIf6rSZVarf0dMrJ8sPDdVSC1rPilfafyfRaYjXWQ8R0kJ50YjD1lFUOSpSi2j+jGLsgYYzQkv7Bw3aO93vofJ0HgHyHvt/jrw7Y2HRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORKVOOfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORKVOOfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003E01F000E9;
	Fri, 21 Aug 2026 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347232;
	bh=WyfAXLKGhNP0oO28M9uaACIhFr4IZbLYdPqPhY8bDZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORKVOOfNJKcoXtcM7/xo5CTw99le7x5Bxa6xNm90mUqayrLQZdzkhJWTRH8Uzb6GH
	 uVBT6mb2hoY2DxQKtYUfUZYiqRC7g+N9mFopkv3+sKzx2u1msJ3hSz1uhErEMWmjzR
	 YYdnwsCLYHABCPg2ifiyDyHYWa3gLzVUq6ToljTJAg6nej01K136RZLMZQZazTyxPn
	 U6cSXflhfKL0HZLkEu9vqI0sXTjdoJCoI+Y9EdYHgVN3npVzLCg/+tBYjF0DN/S/q8
	 HhgK+CU21NBQCJcKA4yqsAZv95cFt/ZOPUUnF5RP0uT8Zt+A+O2oM13gYYIV+Wk01m
	 xwDy579tQh6+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/17] rtc: rzn1: Handle EPROBE_DEFER for optional
 pps interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821211032.13554-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:20:31 +0000
Message-Id: <20260821212032.003E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
> the deferred probe request properly.
>=20
> Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
> indicates that the interrupt subsystem is not yet ready. Intercept this
> specific error condition, assign it to the return value, and jump to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

