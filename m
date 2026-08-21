Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573A309F08;
	Fri, 21 Aug 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347056; cv=none; b=cJPi8T5vjjNGH6PIBIzy0OxDyESoDp6qXB70oxEli4RslKLJSeS6sxWTb+JnzupLamMIxoS9AARg29ajZ3EDQEF6tqa2eCMzd1b8eZOTVr1Z7bzzMJl3iZRlRSStHpz230oh8RlqGm0f1Ez0EyxchnWE/p+Ih/lKED0kjoHtMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347056; c=relaxed/simple;
	bh=bC0FbHWWShb2M+hCJoXznjXn2YPtHt6Zc0Z/Z1qQb1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=osoKW/lbmBnsKqxF91L6I/dWZYLYBUJka4DhvLyHIQcVUfAXG6Z6oMn4fbEGlfPRSVjcwL4fJWKghjC3kUUwxgjn7drOkUuD9/9r7H5qXTEVsFKjwDerkLKCsznxTq76q9GR9c6hbszkZZxy9eBoqoxe/EPupjZdFGCTMYI25rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRB8OPAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRB8OPAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103801F000E9;
	Fri, 21 Aug 2026 21:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347055;
	bh=bC0FbHWWShb2M+hCJoXznjXn2YPtHt6Zc0Z/Z1qQb1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRB8OPAmX5oPJq+bfG2Rj2yoTPs9t62Yts6rs5xh0rShG41BtoMwG8GTDSMjQBipO
	 HKG5OwBL+OB2711xHAv3m/RXy4pzXOsWjDgk2mZMPayVXIA7qYvRgpxpN/RKe3OPFQ
	 OMWdiUtWec4VsI3ox4LISrXjU/aEBxUvBOptSppyAIo+mj+FelCkf+sXpbATa4/GmK
	 1dvHSf/2lqbELQVmPJ92QeR4huEeLXEKqFhD4CbOP9RlIDI5fQxRgLW+Nqy7Gm7ZFC
	 GolVQ/Zw8mI/thMKWw/xUIWUrPoQlgUD1p2JFHGFTV1obdpgSJRhM5C9PKhPx1BM0O
	 skvm7nO3gXSaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/17] rtc: rzn1: Consistently use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821211032.13554-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:17:34 +0000
Message-Id: <20260821211735.103801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Use dev_err_probe() in the IRQ request error path to make error handling
> consistent with the rest of rzn1_rtc_probe().
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D13

