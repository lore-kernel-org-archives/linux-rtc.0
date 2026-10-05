Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC402D6E58
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198675; cv=none; b=LPuNrevlcM+IpYr4Z9v2xZLIkQ0ViEGdm9rTs3Db2EOblohLIKNHTCxR21T0fADDGxkIclJA68ZUpf9awEKFLxwFR1qnLuOeTgCEMN7RbngEUVCkWm8SuBMD8HoAHlvb0h5qtbmTctEs4j4HBcxVfn3U5DkyIC3bjNcmPZR7GPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198675; c=relaxed/simple;
	bh=fDDcvXB1um9OBWqIR69fI5q2jQeRaxFdgRcN5fPxuOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dVXXxQGLqzk4Bya6NiXzhZwWkH8Gzqyd/0CDooOtx+k0o7erK4yLQQKvtKRXavD1hNRT5Gz0ypb5x2XOH/fYZX1DVdQWP/SynBnHeqfSNYmAjTT4XfbuaA56qOshFOXHfBQ5p7xCSjDFO/vD8kU+lxoNxN+G8a4G0zT5jsi1eN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzY5Tt0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzY5Tt0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E2A1F00893;
	Mon,  5 Oct 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791198674;
	bh=lGbd6ideZZRjrOgD4w9xKO0BHgq7rV8ES6bZWwH5lEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzY5Tt0pO+2DTXTShdImtOl8NDc+J5iZTpEEA8wYme7dSCtg7b48eAHk/v3foeN1n
	 ImHKwXEa8K7WEva40i6b2H8hycD4jO45rcD9PUvylOSA3k0G0HfaoCXbqd5mpijqCx
	 4Eo038paEMrJdubQTMQjMXJjetJUhGBN3igjF1jUIVdicl3i0qTgXgrFWVfy/wAnMS
	 Z6AQgbwnAHZYN5ZFpOjSLuVfsTwmDohtNuUhSaCTanPfVfmRQKUWlPZwEaK6R+Sus/
	 jHA2S7fRrCYukqwxjdOor4ZVYJNj7/H3MpuWvTEsWMeOBzcK2+gtEUIr4rGcNXELjc
	 gzXuUSrq9SpCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ftrtc010: fix cast
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261005110638.156559-1-alexandre.belloni@bootlin.com>
References: <20261005110638.156559-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:11:13 +0000
Message-Id: <20261005111114.34E2A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: ftrtc010: broken operator precedence in offset calculation
--

commit d205fb0cae60ed15e7685f77950862e58120dd5a
Author: Alexandre Belloni <alexandre.belloni@bootlin.com>

rtc: ftrtc010: fix cast

This commit removes unnecessary casts to timeu64_t from the hour, min, and =
sec
registers during the calculation of time and offset, as they will rollover
before exceeding a 32-bit integer.

Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRo=
Xi2kgq8FTSaDPA@z/

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index b29c96be40f4a..5332451bdaa05 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c

[ ... ]

> @@ -92,8 +92,7 @@ static int ftrtc010_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
>  	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	day =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> =20
> -	offset =3D time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> -			 (timeu64_t)min * 60 + (timeu64_t)sec);
> +	offset =3D time - (timeu64_t)day * 86400 + hour * 3600 + min * 60 + sec;

[Severity: High]
Could this change introduce an operator precedence issue?

Because the grouping parentheses around the time components were removed,
the expression evaluates strictly from left to right. This subtracts only
the days from the system time, and erroneously adds the hour, min, and sec
components instead of subtracting them.

When user-space programs or system time synchronizations invoke
ftrtc010_rtc_set_time(), this will predictably corrupt the stored hardware
time offset written to the FTRTC010_RTC_RECORD register.

> =20
>  	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
>  	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005110638.1565=
59-1-alexandre.belloni@bootlin.com?part=3D1
