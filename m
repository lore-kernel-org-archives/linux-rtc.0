Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA937255F52
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460252; cv=none; b=q1XreXLzMfgAtv6gW1tqjjyWxaQAzkliwDJ48SV6qkbUT+s9v8diWmyrBTuqL2HxfYIFtvDdyBPhiKlv1eTFRcPR0dBYirZwUPjp5Nbpo0CQMC2TZRGoYxPTtkJRU8WidorLmdJ+Bm2eJXBi0D9bPR8MqksCOIuQa3mRcb6ecPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460252; c=relaxed/simple;
	bh=avO/8E48eirjkFd/FgBo3FoHOY5AM10GnpFZOwP0jDY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m95USbpxn2CrwedfEWkcfSt/jBThAj/tdS0AdHgQQwuZaz9RWPTrxuRKK/AyUEe6svRNJBOg+D4X86fnq4pldSRYuw+CWfXDG4DrxmKA/gPBUiJInUHs4lSUsLP7IAxNiBK0A3LPxpdkYZeifiz6a/rV3Xqn3GHFsztoXCFXHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhEM4Lhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhEM4Lhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D91F00893;
	Thu,  8 Oct 2026 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791460251;
	bh=l7+XSdw74eo9K09ooxnq0YO7Vm4geC8VrFob9/+VIYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhEM4LhdCB86iRnjAbEByrfc/eqG7M9UAPACAeuMBijb/T//MUZTgupZL9hqkX/ko
	 5UEaSlpxVWWl/55BTjv6vsqV5N3f7gwagHhIZ8edjKO3Y0ZPMmQ0AdiCNUGBz4+r5Z
	 OdDuz/9AH68FsoSzT3uI1BmWvKkrUrtf0GtviBTeF0T8+bBJejpIjOCtlawZ7g5/5E
	 WLSpz1C/klDqVC1FQ+jC+Pg75BIh7pRC/DH1DSlklKRDg2qno8wmp+gPbQOazvTsbC
	 xlBzNGTS6z9aDHpP9+OCEUe7Ta4WCMUiea5v7lry1JPcC6v9hscpgB/Tl4Tg2dKlb7
	 xuRB4qhG9o7wA==
Message-ID: <sashiko-outbox-164108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ftrtc010: fix negative offset handling and smatch
 warning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
References: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:50:50 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rtc: rtc-ftrtc010: s32 cast limits positive offset to 68 years but=
 range_max allows 136 years
- [Medium] rtc: ftrtc010: unprotected sequential hardware counter reads cau=
se time skew
- [Medium] rtc: ftrtc010: range_min blocks setting negative offsets
--

commit 36a9e88aad02944c1e1579ef1c2b0dd3b5ceff14
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix negative offset handling and smatch warning

This commit addresses negative offset sign-extension and 32-bit arithmetic
overflows by explicitly casting the offset to an s32 before computing the
time in 64-bit space.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index b29c96be40f4a..65fe1e872239e 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -72,7 +72,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)
>  	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset =3D readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
> =20

[Severity: Medium]
This problem wasn't introduced by this patch, but does computing the time
from these sequential MMIO reads risk corrupting the result if the hardware
rolls over a counter during the reads?

For example, if sec is read as 59, and then a hardware tick rolls it to 0
before min is read, min will be incremented. The combined calculation from:

	sec  =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
	min  =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);

will yield a time skewed by a full minute. Does this sequence need a retry
loop or explicit latching to prevent skew in ftrtc010_rtc_read_time() and
ftrtc010_rtc_set_time()?

> -	time =3D (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + s=
ec);
> +	time =3D (timeu64_t)(s32)offset + (timeu64_t)days * 86400 +
> +	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + (timeu64_t)sec;

[Severity: High]
Does this explicit s32 cast limit the maximum positive offset to roughly
68 years while the driver continues to advertise a range of 136 years?

Looking at ftrtc010_rtc_probe(), rtc_dev->range_max is set to U32_MAX:

	rtc_dev->range_max =3D U32_MAX + rtc_dev->range_min;

If a time is set more than 68 years into the future, ftrtc010_rtc_set_time()
will compute a 32-bit offset with the most significant bit set.

When read back here in ftrtc010_rtc_read_time(), the new (s32) cast will
incorrectly interpret that large positive offset as a negative offset,
causing the time to jump backwards. Should range_max be updated to use
S32_MAX?

[Severity: Medium]
Does the current rtc_dev->range_min configuration prevent setting the
negative offsets that this patch intends to handle?

In ftrtc010_rtc_probe(), range_min is statically initialized to the exact
hardware time at the moment of driver probe:

	rtc_dev->range_min =3D (u64)days * 86400 + hour * 3600 + min * 60 + sec;

Because the RTC core's rtc_valid_range() checks this bound, it will return
-ERANGE for any attempt to set a time older than the hardware counters at
probe.

This blocks configuring valid negative offsets. Does range_min need to be
decreased by S32_MAX to allow setting times in the past?

>  	rtc_time64_to_tm(time, tm);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0C8AEB5636132B0C+20=
261008113732.581825-1-liudalin@kylinsec.com.cn?part=3D1
