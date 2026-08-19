Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044E5474F;
	Wed, 19 Aug 2026 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136838; cv=none; b=sKnU0EnBjCg0mvjIgKI8wlnImSYcGn2fZdJRpkeAWQXMbUN2m7VKI8CrY/9PnhVwQFY7qC8BjLm/Q/vSXIb0ry6llOTXanK+UhNcg6Ul7QX0uFHnpkvGAhgkyZ7tr1svWdBLHctVrvyWRSwvUXiHERFsLfuInHiw7ynOf6eGUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136838; c=relaxed/simple;
	bh=2H7Qvtx7rwaTsS4PPFimRnpBEsluuNdNpqK8YExqXUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDHvleAH56aGoJWbkx/1G+i5ZHQBQqTzSJmRaRrKyNw2RKy/KUrGmCxMsYmRfNedubHrSG+q7zMXzH+U+6DMEKfKGenx+hXR/MECtV40qF2s3kRQLArhdOVBElVnxkPJi6Efn8llkULGiKR+ZiNueUUcXcUuEEMKwVL7pqbUy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCZ6VLt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCZ6VLt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7731F000E9;
	Wed, 19 Aug 2026 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136837;
	bh=AiLFttw/7yjqzaijIR+efjYyPzPLdWyXzRVb7WAvHPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCZ6VLt0qmwY3HzcPH7P7EGC9l8cTeQj92CfsURrAc3F+lwTrSuFme3Bw7exROizg
	 BdJOV0QKSe1aCfliYyNsb2VdhyAWOQ8v2G/25NY/axomxIAn/GnFawSeUHZtzFrsvE
	 hL4/HzVq2aF1I0slF1DvW4nIHQy9vKEWP2DpcaUByYVCDefmkcaVjRek18GUAt4qSj
	 WqLVrkPBzRYAO/FypnkfBYZ5u+gy2u1JYIWsBvQj09IiNBVbWDagCHgk3oaCglTmgZ
	 aNevDI4jxyJgFY/L4WrlXh+c1oNX4cMHmyPt3bF15MlkDFnyabbxjpqKpij54Z7IFd
	 pMnvxChyslwJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:53:56 +0000
Message-Id: <20260819105356.BD7731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Truncation of 64-bit `time64_t` alarm timestamps to 32-bit `unsign=
ed long` and misuse of `time_after()` allows users to bypass the 1-week har=
dware alarm limit on 32-bit systems for alarms requested > 68 years in the =
future.
- [Medium] Missing validation for an uninitialized `wday` hardware register=
 in `rzn1_rtc_read_alarm` produces bogus alarm dates.
--

--- Patch [3]: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm=
 crosses month boundary ---
commit d19190c56b59d2960781807a89bdaa97caa58aa4
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Fix weekday underflow when alarm crosses month boundary

This patch fixes an underflow issue in rzn1_rtc_set_alarm() when
calculating the alarm weekday across month boundaries. It directly uses
the tm_wday field from the pre-populated rtc_time struct instead of
recalculating it from the days ahead.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index aa27ad7f5941a..8c70dbf8c7ecd 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

> @@ -273,13 +272,9 @@ static int rzn1_rtc_set_alarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
>  	if (time_after(alarm, farest))
>  		return -ERANGE;

[Severity: High]
This is a pre-existing issue, but does this time_after() comparison
allow bypassing the 1-week hardware limit on 32-bit systems?

Since rtc_tm_to_time64() returns a 64-bit value that gets truncated
into the 32-bit unsigned long alarm and farest variables on 32-bit
architectures, requesting an alarm > 68 years in the future (e.g. 2099)
could cause the difference farest - alarm to exceed INT_MAX.

This subtraction would overflow in two's complement and evaluate as a
positive integer, causing time_after(alarm, farest) to evaluate to
false, bypassing the -ERANGE check and configuring an alarm that fires at
the wrong time.


While reviewing this file, I also noticed another pre-existing issue in
rzn1_rtc_read_alarm() that might need attention:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_read_alarm() {
    ...
    wday =3D readl(rtc->base + RZN1_RTC_ALW);
    ...
    delta_days =3D ((fls(wday) - 1) - tm->tm_wday + 7) % 7;
    tm->tm_wday =3D fls(wday) - 1;
    ...
}

[Severity: Medium]
This is a pre-existing issue, but what happens if the RZN1_RTC_ALW register
is uninitialized and wday is 0?

Calling fls(0) - 1 would evaluate to -1. If the current time is a Saturday
(tm_now.tm_wday =3D=3D 6), delta_days evaluates to 0, which bypasses
the if (delta_days) block and leaves tm->tm_wday =3D -1.

Since the core function rtc_valid_tm() does not check tm_wday, would this
propagate a bogus alarm date to the caller?


> -	/* Convert alarm day into week day */
> -	days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> -	wday =3D (tm_now.tm_wday + days_ahead) % 7;
> -
>  	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
>  	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
> -	writel(BIT(wday), rtc->base + RZN1_RTC_ALW);
> +	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
