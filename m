Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7444064F
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199459; cv=none; b=qQUZrNWWPngTwdi1jY2m6x5Gbg6kGK8YwZJ6SCJctvP/eY+Kw0MY0Y4GA6sKyn+RVwAP6azPYilI+APWgpBmzVJiwrtwLBYgjZgtraLXKv8IhRdtiyxhdp7x3jwZ5HkjtuSho5C4ueVu8MzOu0lAcXFKMSWZsYvxvnyBPevCyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199459; c=relaxed/simple;
	bh=61w4A/sp75PG+s0hui2b2dzKm57IRMV/7wRvIucBWzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fvo30o3znpZCuEQGi77KJOY2rWfdTUCetJKqT8KGlxJXTjWFjvbV8uLPQ8rx//s84vaW7/w7J3Gg0vGNJPyYFwWEXCAOIhTUvl2QS/iJythtWjRO8sCjXvAJOBGC2z3LwIdWpj5/oU3Zu044pb3hMi7FuVHLjam1+U42sYuzZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dng0ekPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dng0ekPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42BE1F000FF;
	Mon,  5 Oct 2026 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791199457;
	bh=TV/0c1CGlxoNqX8xBN2IJr73+PF/uwAXYUP1gZR/1F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dng0ekPtPVZrBgYQJrwF9sl74kFb3xG3evNZZARVvEhrbFSJkofIz0D29r6nMIN0A
	 lJAAND4jNXu1dxUCrkcTgnFNJzI2cuDn1u9FwsUft4D5VyLVDkQ7V2rQoeOPP5aatr
	 a4s5gJMTYvWDlj5sZFYfH1Gh3YmuQXkriFEGbTrvFgVr9QJqMHpdzlwEEvLz07tfwa
	 qXliQ2vrb0qgWtEjPjHgGGQjpYzMTbu99ggWlCtOKW2EPUjOiJmSqY6ik1ToceO3tA
	 JvqaqvXfcCVFVdU13YQ5SITVGoRGD60FLWL7oRrscdPGN4Q2Fp5v66zsvtfyCdWBKR
	 EG3poUBLyejzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: ftrtc010: fix cast
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
References: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:24:17 +0000
Message-Id: <20261005112417.A42BE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: ftrtc010: 64-bit promotion breaks negative offset wraparound
--

commit 2ccc1a04cd44cfcc28a0e0150aa880f011201f5c
Author: Alexandre Belloni <alexandre.belloni@bootlin.com>

rtc: ftrtc010: fix cast

The hour and minute registers will rollover before the multiplication to
convert to a number of seconds can exceed an 32bit integer, there is no
need to cast them.

Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRo=
Xi2kgq8FTSaDPA@z/

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index b29c96be40f4a..c66d4a85f23c1 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)
>  	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset =3D readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
> =20
> -	time =3D (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + s=
ec);
> +	time =3D offset + (timeu64_t)days * 86400 + hour * 3600 + min * 60 + se=
c;

[Severity: High]
Does this 64-bit promotion break the negative offset wraparound?

In ftrtc010_rtc_set_time(), if the target time is set backwards to a value
smaller than the elapsed hardware counter (time < hw_counter), the 64-bit
subtraction yields a negative offset that is truncated and stored in the
32-bit offset register as a two's complement value (e.g., 0xFFFFFC18).

The previous implementation explicitly performed offset + hw_counter in
32-bit arithmetic, allowing the negative offset to correctly wrap around
modulo 2^32 and yield the correct time.

By removing the outer grouping parentheses and casting days to timeu64_t,
the entire addition is promoted to 64-bit arithmetic. Because offset is an
unsigned 32-bit integer, it is zero-extended to 64-bit rather than
sign-extended, which prevents the necessary 32-bit wraparound.

As a result, the negative offset is added as a massive positive value
(e.g., 4,294,967,295), causing the RTC read time to leap about 136 years
into the future. Setting the clock backwards triggers this logic error,
resulting in corrupted time reading.

[ ... ]
> @@ -92,8 +92,7 @@ static int ftrtc010_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
>  	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	day =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> =20
> -	offset =3D time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> -			 (timeu64_t)min * 60 + (timeu64_t)sec);
> +	offset =3D time - ((timeu64_t)day * 86400 + hour * 3600 + min * 60 + se=
c);

[Severity: High]
Does setting the time to a value smaller than the elapsed hardware counter
generate a two's complement negative offset in this 32-bit unsigned registe=
r?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005111502.1598=
55-1-alexandre.belloni@bootlin.com?part=3D1
