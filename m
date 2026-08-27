Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61616175A6D
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813594; cv=none; b=tUklD3DcLrD+z0/M8dpEzePYMG5uwlSHnKiXpBngU0x0DpLWIxdMWeRhd5y2pawNPHCyboNv7yvp3AW6jw07R50pDFZ2KTcf0UE/Zw5tfQLxrS9hyxY/dYeJTOzwYoQMZ7lTZdL9mTBjKSim95jM6hzlM7leVH1PNegcyufZOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813594; c=relaxed/simple;
	bh=z7gm/hdonrz8Q/HX0dNnFVtfLywwuoLjS2co3B5ym90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eli4D+Ryg0H5myV0vmPKJG7RfFyDp4ZiyzfIm58a2Mt/Z7pSDmHpABEALDzNuIvd0dmLr+nvMWoGwG5IzNgtTw5hgsEkPiZX5katHJBKshwc39EWmEcAvOkBdbOQYaIU43fEo3JkZJAjICr5T6p2MEFD88Bm3qshVZcxJuKuPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEQH42rO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEQH42rO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC11F000E9;
	Thu, 27 Aug 2026 06:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813593;
	bh=/3nGkTdIXXdNTrWCvLObG8Q217SHLwevtAIH5pf1+J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEQH42rOnbZIYf/FkuCCIH9XT1aayrv98mJTnTEXfeEVEQgmw5AmMCCdPOkZRuj/4
	 GcvbU0s4Y0ResUAUciE3fVtJT9WbpZwj2DTvjiUhQO2VZfD/0s0iG3D7oxMCr9ksmG
	 03rdkOkX5hed2Dq8jLTcXjxstj6YEEzhb4qSWo2r0CP/Ge0SJJArSZjE6aJVnS0p+H
	 Wjj1w6r2/2kFRCgRKX+eqNq6ozl64Tfgq3RjI814gqmOJEiiyMjhDCgiw+CvGY9b/G
	 dexIsc+qs9T2M1JPXE7FQnAiFnyOIff2t2Aef7o8cKPEUcpsFKptDNd0j2riS6v45Y
	 wa0/1ZZ23+A0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] rtc: ftrtc010: fix integer overflow in time
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <B06A3E7BF268E081+20260827063019.3342085-4-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <B06A3E7BF268E081+20260827063019.3342085-4-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:53:12 +0000
Message-Id: <20260827065312.CECC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Transition to 64-bit arithmetic zero-extends negative time offsets=
, causing the clock to erroneously jump ~136 years into the future.

Pre-existing issues:
- [High] Unsynchronized, non-atomic reads of consecutive RTC time registers=
 can produce severely corrupted timestamps if a hardware tick and rollover =
occurs during the read sequence.
--

commit 0451b19111beae8b1f5abde3e58d176d4ad642f2
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix integer overflow in time calculation

This commit addresses an integer overflow in ftrtc010_rtc_read_time and
ftrtc010_rtc_set_time. It casts the 32-bit time variables to timeu64_t befo=
re
multiplication to ensure 64-bit arithmetic, preventing overflow for dates
beyond year 2106.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 2f610a0fc6e9b..6fff537cad27e 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -73,7 +73,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)
>  	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset =3D readl(rtc->rtc_base + FTRTC010_RTC_RECORD);

[Severity: High]
This isn't a bug introduced by this patch, but can these unsynchronized,
non-atomic reads of consecutive RTC time registers produce corrupted
timestamps?

If a hardware tick and rollover occurs during the read sequence:

ftrtc010_rtc_read_time()
    sec  =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
    min  =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
    ...

It appears possible to read desynchronized values, which could result in
permanent time corruption up to 1 day.

> -	time =3D offset + days * 86400 + hour * 3600 + min * 60 + sec;
> +	time =3D (timeu64_t)offset + (timeu64_t)days * 86400 +
> +	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + sec;

[Severity: High]
Does this transition to 64-bit arithmetic zero-extend negative time offsets?

If the offset is negative, casting it directly to timeu64_t breaks the two's
complement modulo arithmetic required to correctly decode negative time
differences, which could cause the clock to erroneously jump about 136 years
into the future.

> @@ -93,7 +94,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
>  	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	day =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);

[Severity: High]
This isn't a bug introduced by this patch, but can this sequential read
result in computing an improperly desynchronized offset?

If a tick occurs between reads:

ftrtc010_rtc_set_time()
    sec =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
    min =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
    ...

It seems this could permanently corrupt the stored RTC offset and skew the
time until it is reset.

> -	offset =3D time - (day * 86400 + hour * 3600 + min * 60 + sec);
> +	offset =3D time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> +			 (timeu64_t)min * 60 + sec);

[Severity: High]
Does this calculation incorrectly wrap offset into a large 32-bit integer?

If the target Unix time is numerically smaller than the hardware's internal
uptime counters, the difference becomes negative. This can happen on offline
embedded devices where the initial OS time defaults to 1970-01-01.

Casting this negative 32-bit offset to timeu64_t zero-extends it instead of
allowing the required 32-bit modulo arithmetic. This could lead to a massive
forward jump when ftrtc010_rtc_read_time is subsequently called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827063019.3342=
085-1-liudalin@kylinsec.com.cn?part=3D3
