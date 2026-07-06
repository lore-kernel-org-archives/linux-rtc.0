Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4A42088C;
	Mon,  6 Jul 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360617; cv=none; b=I4tFKFuo5o3uttNzL7DMT4bI/EysMbfPsrs0NkY23cwVunPZaM+eLQujo2kf3RIMfSdytHUQE8fZaVh6wYx19u9V+8cOow0s4+LR8jIrzrMxXPi3+X384GEFKTaQ+7lkjFdjm6T0tQ8Rl9ObNJkRHmUtxSTh7I0RKff8Yi/ku10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360617; c=relaxed/simple;
	bh=Q1p089HhHWgvI8PGe8Ku81Bu61YGbYxPL0q7T7fdOyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siUy83gQ8eTnhIpBNztDSDtv/mmz6aGztwJmB3UEMjU3vxAUmflTrfBpw5Mwe46tDIFCG5FpKoTVsoIdrHiuk3gmwImJt4zCrZo0Fx7yuxTiolCOgwhD3xsk/qnuiZ8iWFTwI379gyeSMLkGd/Lf0fmvpUNt11mAAoPROzJgEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1q29NJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1q29NJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6202E1F00A3D;
	Mon,  6 Jul 2026 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360616;
	bh=Q1p089HhHWgvI8PGe8Ku81Bu61YGbYxPL0q7T7fdOyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1q29NJED5H2I2jncyWQemhRNZ0Pq3cbP4GGhYq7k7sLdUSMiVjGo2hW+LR3uXD3W
	 XBtmE89fp0If6iP+x7md/DIUy/BUZHDf/tuof47HcecV4zK9v/2PfDaNmdeLGu8HnM
	 bc6e9z9Lam32gg6+tnGd2XmhiCmGGDZ8xNQZ4zkndcdURIBsh44XkULN8DNCG7Po1I
	 TAgWsv3ROMEEyxmloJ3p+78dEd0q091uwDPACLn4O1LWIyL+NCn2tTQSj9L6whS3SI
	 krJFBnmdk9M/TbDM6pAYgmil5+lEB6vEpmIICgFlcoFOkJwIEs48uA3gy8lA5MPlQX
	 9eI0WxqLGSqvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] rtc: rzn1: Handle EPROBE_DEFER for optional
 pps interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260706175138.12587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:56:55 +0000
Message-Id: <20260706175656.6202E1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

