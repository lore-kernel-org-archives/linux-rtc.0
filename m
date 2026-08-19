Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E84381AEF;
	Wed, 19 Aug 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136701; cv=none; b=iVZK6l4YwQoirik5Yuk1BOLDeiBuxsmmT843tbqY/hnGRm1rp1bYGWGO5pdYZECkjKFMqQNYSrArPNoxTBOvhKynpiIi6UBDKUW4ju2eZl8p4um6IdAY4RGb7VfCzd+sTPlkQEpWFy1k0+04Y4b1/KqkeQEadpcZ2WEb7YmNAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136701; c=relaxed/simple;
	bh=ZIL932loLN/w6iyyy3wKDm8oZ9drBl/Y30G8aK+0Wiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KLhpSvLPcWhbp+ScbyfBIi6yH9TwV48Ef7lMSb0Itx+b6ktAWNrxsEawxrnlMHRn9d24DVj7vmpefy6IbbYsu+ntZ4os+FdQUvT5VXiMN0SB0pgaGfg3Q7jN2kaMe9ruQ+gcvNYWX6i0PVeeKdnXHR8qT2a2o799FM/oyOSkrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmqGTVwr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmqGTVwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB9F1F000E9;
	Wed, 19 Aug 2026 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136699;
	bh=jC49HbEUiPw84pT2BRy0aPnBq31YZx/M+kWurIq5omI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RmqGTVwr4n0+2cubVfxPFBfvhUhcwOVoZWergTwV9Z+sCAAmGCM+ZMq3f68RyJnvs
	 1dLU1WTweZcqXILPdzQXaaKR6OgBqHSG12hSTL4NjOKzsQvgRaMIlLYPGKOfa55m7a
	 1pBDJZSigBqOj4Iag2wYl6A7+/6amcqGbInIIdyfGFRcfMyjiuCPx0MaUCIXNSSyZi
	 6qqYsW0NBA7JMmWBwP8H3JAWvcj45JoyhRqOcxOzkFQn09RuQXzp4YRf4SfRisMPgE
	 fpGQ1h26lRJNq5qTQcCeIiCJdBf/X1m0Ex5BcyDTDvxQANrpK4cYRHEUyZzlKXvFrk
	 aNmE5/0c1Wp2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/15] rtc: rzn1: Use pm_runtime_put_sync() in
 rzn1_rtc_disable_hardware()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20260819103926.2136712-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:51:38 +0000
Message-Id: <20260819105139.4AB9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Race condition in rzn1_rtc_set_alarm() leading to spurious hardw=
are interrupts and lockless torn reads of rtc->tm_alarm.
--

--- Patch [8]: [PATCH v4 08/15] rtc: rzn1: Use pm_runtime_put_sync() in rzn=
1_rtc_disable_hardware() ---
commit dff0f7a5386396694cffd2ad789f85740e53b9b9
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Use pm_runtime_put_sync() in rzn1_rtc_disable_hardware()
   =20
pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index da7d13337c0da..425d9590c55b9 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -379,7 +379,7 @@ static void rzn1_rtc_disable_hardware(void *data)
>  	/* Disable all interrupts */
>  	writel(0, rtc->base + RZN1_RTC_CTL1);
> =20
> -	pm_runtime_put(dev);
> +	pm_runtime_put_sync(dev);
>  }

[Severity: Medium]
This is a pre-existing issue, but while reviewing this file I noticed a
potential race condition in rzn1_rtc_set_alarm() that could lead to
spurious hardware interrupts and lockless torn reads of rtc->tm_alarm.

If rtc_timer_enqueue() calls __rtc_set_alarm() to replace an existing
alarm with an earlier one without disabling the hardware alarm first, ALME
might still be 1. During this time, rzn1_rtc_set_alarm() sequentially writes
to the registers:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_set_alarm() {
    ...
	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);

	rtc->tm_alarm =3D alrm->time;
    ...
}

If the intermediate hybrid state of these registers matches the current
hardware time, would the RTC immediately fire an alarm interrupt?

Concurrently, if the interrupt fires, the IRQ handler reads the potentially
stale or partially updated rtc->tm_alarm structure without locks:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_alarm_irq() {
    ...
	if (rtc->tm_alarm.tm_sec =3D=3D 0)
		rtc_update_irq(rtc->rtcdev, 1, RTC_AF | RTC_IRQF);
	else
		/* Switch to 1s interrupts */
		set_irq_bits =3D RZN1_RTC_CTL1_1SE;
    ...
}

Could this result in spurious RTC_AF events sent to userspace or incorrect
toggling of the 1-second interrupt mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
