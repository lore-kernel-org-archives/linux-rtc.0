Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CF2D0C82;
	Mon,  7 Sep 2026 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814365; cv=none; b=g/1wGynpNyVE99h1JKNbYuCCTZVGP7rvhJtSZdjk/fyF/CAXkDYEicILiKUnHwoKXKovLYzOHtMFdhPL3Jkl3tZ4Q8qjxozJi1kZ9HtJI5nqSs6jtYDneRaqqkyc5jhN5uw1aQmzTCICYZw0FDwJiWkaeGBZbGC0pna9Hmve47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814365; c=relaxed/simple;
	bh=OS5yHKjCG0V0UqBMJ63C4+kg84/5UefDRLfHjPEirdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J4SUbnyWaEEVEA7JS7/ukUNUpv9yWtXfA1HqRWHovsfs48GIYVe4X29pd5ATyB4ADYIaKJSYi/OVg/DZS9Eaq01wSwkv3EgmCW/t92zIFOoTpn7XeKcb2ps19UVULcodbo2lNbwMujXJ/sHVwplNpOp9T2XV1MnVyLuuLyMR3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2x8Miqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2x8Miqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FC71F00A3A;
	Mon,  7 Sep 2026 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814363;
	bh=jIbMDVOqLnfDMhWufnBKCnSwtt3dR6rdkehGnnxqf0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2x8MiqjpRsEp6FomBvcaGKm6yajPRBjeuajO0xRVScP/hoKIp7NYVKYiO3HsHeNw
	 9qE33PyCXLxwvumgrCQt1qxCH5ogZGOOM4b92AWlkOS20/rJXEGN0v5OTlxrpNem9J
	 jNduK5jgzsvGRHHuCxG2ts2GLwfaQBucjDvZyJO5dj1Lv56Vp3KNm8eJilflznPcjE
	 I+BGg/Vqozq5xo6lSXPuKtTSx2UvnO4oCR14xSfxhFZkGNUxpOxUuKDRS/xfkiAyij
	 OyLSHRcgxbRu9fhYSUYzybkjn6Rfc0vun7E83tywMgZuuss0xcN2Uxqr0BB4xkQYDj
	 F8mx8u8/RZCeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260907203216.53192-10-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-10-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:52:42 +0000
Message-Id: <20260907205243.58FC71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `regmap_bulk_read` return value check in `abx80x_read_alarm` c=
auses the function to unconditionally fail with `-EIO` on success.
--

commit 7f9a5b9080b676338469e285a0ce05b36660c82c
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add support for ABX81X

This patch adds support for the Abracon ABX81X family of RTCs, which feature
a SPI interface. It updates the Kconfig to support both I2C and SPI, and ad=
ds
the necessary SPI device IDs, device tree bindings, and probe functions.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index c90407a023fe8..c3bf6f0ae48b9 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * A driver for the I2C members of the Abracon AB x8xx RTC family,
> - * and compatible: AB 1805 and AB 0805
> + * A driver for the I2C and SPI members of the Abracon AB x8xx RTC famil=
y,
> + * and compatible: AB 1805, AB 0805, AB 1815 and AB 0815
>   *
>   * Copyright 2014-2015 Macq S.A.
>   *

[Severity: High]
Will the regmap_bulk_read return value check in abx80x_read_alarm() cause t=
he
function to unconditionally fail?

drivers/rtc/rtc-abx80x.c:abx80x_read_alarm() {
...
	err =3D regmap_bulk_read(priv->regmap, ABX8XX_REG_ASC, buf, sizeof(buf));
	if (err)
		return err;
	if (err < ARRAY_SIZE(buf))
		return -EIO;
...
}

When the RTC core calls abx80x_read_alarm(), regmap_bulk_read() will return=
 0
on a successful read. The subsequent check evaluates
if (err < ARRAY_SIZE(buf)), which is 0 < 7. This evaluates to true, resulti=
ng
in an unconditional return of -EIO and breaking the alarm read functionality
for any unprivileged userspace application reading the RTC alarm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D9
