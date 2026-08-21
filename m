Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F23515DB;
	Fri, 21 Aug 2026 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347166; cv=none; b=FrCekPcHxE0VEbi3MnLNdQel18AzTE340SzmY2xuKGESUCxd2kTv0HVL+ZPZ2QLB049uDoakOgThNlEWcjH5RGDLzP9ZQgtf7ZBmh89lE6ACtAvKU72apvKY9HS33sjImrvQOzyIkhDMKivimZkjVxiG1n+eKomd3mskR2KFFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347166; c=relaxed/simple;
	bh=T0KZ8jPl+KoBFK+2KtoKQfF/GtkW2tlXeQ/d5UgwgO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R00gRnY8RwJLZ37rEOEB/R1bvlC4sbL2Tbk1I1JFsMBBk14UroP+ygsXNiBWQefXYaOS0htGBW1nkW4kb5Cq5HtbFw4q4QQuD1MimClazp9GB+gk5k0UqKfAXEOL4thd6G7sH7A5irJfscbZrPQhOp+Lh8eOf5e/ERESASi+R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSg3K5bg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSg3K5bg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1811F000E9;
	Fri, 21 Aug 2026 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347164;
	bh=T0KZ8jPl+KoBFK+2KtoKQfF/GtkW2tlXeQ/d5UgwgO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSg3K5bgfjn3Q3EEQOiq2U33zZy38r9dZGcY1M1Q4bMbq5g3wDO6kfOFeoDww42H4
	 shkwUI9GZDqU10by+Cm0DcJPDh6Jwug5P69W2ElbJ2iIIBSCPxHD4lMUyRaZr3b7t7
	 uCg88cDUYZcmApemDpUPcnjGDj0/Bx7oqBVr7Fb8oIp+7nL2SHo7clBaxr0i3URJuO
	 GbPC21ejyHmY66rF072VMB7O2qXgUfn8P+H2az4odCwGrh68UU15uvugKBrBwemLpS
	 oD1Z11kxDWZKKRFYzgro4DLFIlmx9zqZD/8QPan2kewveN+H5J6/gW0nJgryq43Vr1
	 ar7OoV42Nayxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/17] rtc: rzn1: Use pm_runtime_put_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821211032.13554-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:19:23 +0000
Message-Id: <20260821211924.1D1811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> pm_runtime_put() may trigger the idle check after pm_runtime_disable()
> is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
> runtime PM active.
>=20
> Use pm_runtime_put_sync() to ensure the idle check runs synchronously.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9

