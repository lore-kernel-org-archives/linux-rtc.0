Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D23254AE;
	Fri, 21 Aug 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321443; cv=none; b=LxFvwsz24Ab81DRiOE5/vOzdwCuDX79/aGByYEuXwHnPvFU5WxDgpql+jb8aKBagOqYsH9ee0TiO3kV9eDIxhOgKz2Vk3alX7A16j/v9rt0FrUZoubz6DdPtQ1mT2ZxfBsqQESWtXetbH2cHuO/IhE/KPfae3rE/C+RZWnc167M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321443; c=relaxed/simple;
	bh=hofLw2x6F8EOYhtoS3gZM7upWG85KV3BxKmdHhbkVLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ilZMp95b19E9ooOELDJ5SBHBpy78LJpmV5xSyi2+BEO3jGN8BvE6wUEzqB02DKNZdChMOiODKbOerUTiUOi00pNwFMaraKVBQ0ORk/Z+TwIe30VWTTYhLxinclejUpsgsay/0VUbHfUSuJH2AxRm2plvZ6fdf8/sd3HGh1QDK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ojpd15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ojpd15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A191F000E9;
	Fri, 21 Aug 2026 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321441;
	bh=MzhgVVZX9i9qT4UOJCGe1rI1bGZSTsjv5P/rX4JoZU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8ojpd15+6EDONRUSn4jUVEscrQQZ79VRlvkG3mv57EvD16AV7LoV2teR5U4YVfTP
	 YFllLPK4iGkUCqEqDCXwDlP8zGLbfIa9UWqfH3A0g4YVMHnpGhy4x1M94vn5yV6TGp
	 47fcmlH+6BkW9E08odaFddO/enJxPwT20c13hgbrgRaArPxfjucPu17X4TkmzTiMsQ
	 N2jAANaeaApzTCsrtJ4t0P+W9N5IKLeLXFCeypHF4wiQ9Kya/KBGV0/OSc7JgcoX/p
	 I+M0sO2Q/WYvT3cuZpZpv1SnFyayNxouV5NJpqg3G2Ro6Tc0gari+EYm+A5J1JPREk
	 4tx8gBrAaYvjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before
 reprogramming alarm registers
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:10:40 +0000
Message-Id: <20260821141041.57A191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent lockless read and write of `rtc->tm_alarm` and a race w=
ith delayed IRQ handlers can cause a newly configured alarm to be silently =
disabled.
--

--- Patch [6]: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before r=
eprogramming alarm registers ---
commit 6227942d78d91abfb1648a64bce64f0011716b61
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers

This commit updates rzn1_rtc_set_alarm() to disable the alarm interrupt
before reprogramming the alarm registers. This prevents the interrupt from
firing while the alarm registers contain a mixture of old and newly written
values.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 44e8db466cb78..09631a3a51345 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -280,6 +280,11 @@ static int rzn1_rtc_set_alarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
>  	if (alarm > farest)
>  		return -ERANGE;
> =20
> +	/* Disable alarm interrupts before reprogramming the alarm. */
> +	ret =3D rzn1_rtc_alarm_irq_enable(dev, 0);
> +	if (ret)
> +		return ret;
> +
>  	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
>  	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
>  	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);

[Severity: High]
This is a pre-existing issue, but does this fully protect against a race
with a delayed IRQ handler?

If a previous alarm fires and the IRQ handler rzn1_rtc_alarm_irq() is
delayed on CPU1, and concurrently CPU0 runs rzn1_rtc_set_alarm():

CPU0 completes rzn1_rtc_set_alarm(), updating the lockless rtc->tm_alarm
and re-enabling the alarm by setting ALME in CTL1.

CPU1 then resumes in rzn1_rtc_alarm_irq():

	if (rtc->tm_alarm.tm_sec =3D=3D 0)
		...
	else
		set_irq_bits =3D RZN1_RTC_CTL1_1SE;

	guard(spinlock)(&rtc->ctl1_access_lock);

	ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
	ctl1 &=3D ~RZN1_RTC_CTL1_ALME;
	ctl1 |=3D set_irq_bits;
	writel(ctl1, rtc->base + RZN1_RTC_CTL1);

Could CPU1 read the newly updated rtc->tm_alarm locklessly, and then
unconditionally clear ALME in CTL1? This sequence appears to silently
disable the newly configured alarm, which could result in missed wakeups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
