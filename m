Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0531E821;
	Fri, 21 Aug 2026 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346918; cv=none; b=oZPW0roolh61Ybi5mjZiaGtNtYRs5uRhiZHPfKFoZbG3c6kv50ylKsXt6snRLiikQAJibiVSo/nUDFeiltz58OyxuFvzHMPqfsZy1paQS++xfGNG3CbKMD8TbrCcPT7jF28loO8XuVCoGZfEGaXf9Td/JebEkQPlJFd6ar/Np3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346918; c=relaxed/simple;
	bh=rY6XXybY4ovfsLNHNg1bMd7pSh2ZjfeNYboZ3NL3YRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0PbqccJD4LM+NOM5JqpCylhDMwE/CTpAxpZwV1N7YnLkbxn+j6CwzXCpsIy2JYhLXWVnvXD8rtcWJaGHSJYAUfPafVuGc6FvBYs0F0Fy2xCCZGCa7Jg8TsJxLyuO1P9CodF9RT/AvoWOqUOmBGJq87tzSoWJPGY2gD8wpl+S0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR4+sRAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR4+sRAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2172D1F000E9;
	Fri, 21 Aug 2026 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787346917;
	bh=rY6XXybY4ovfsLNHNg1bMd7pSh2ZjfeNYboZ3NL3YRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SR4+sRANSlKqDr1dUM4d5Ow/Fy6zc1QE3RpchPKKwK/z8XSTYAx6+a1sfKlWhluoB
	 C3Ld8bxkYNaryXx5KtlzhCVswU8iXpD2/Cc2WyM1p8Mq4KGCqFBR0ObUkqYfRyck4p
	 qhUUtoFntTasNcJ1uzliNcxcI7TC2xd324X5MjJUSCEufemJ5/v2zg53APXq7x3i9Z
	 YmA67+IF8te/X/D8Upcco8lu3ukwQrN7uh5vNqmOBFBzDN1eI2/xYgN+T5GYtJNuNJ
	 GXdovtjZuc0O5qqja9bfGz1blOswjkWDoF2ERfhhQNDyLYB6IQxFd2PI63MBf72ri+
	 oJNit6SGs695g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/17] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency
 to ARCH_RENESAS
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821211032.13554-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:15:16 +0000
Message-Id: <20260821211517.2172D1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8

