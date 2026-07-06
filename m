Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDE3F65EF;
	Mon,  6 Jul 2026 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360617; cv=none; b=NWfnTI7uD3Ztr2ite2irY+k1SOuafQl/BFEWMEYDpSesb2MGwPWblCW/DE6akf6xkIeWVK+0fAb6WXHV4226ujmhadhRmN4m82FV8qTs1vexlFj4Oe/+2WCwJ42gvepPD22L9BR8FMVKIajDl8Lr7INf0wL1FQxn3AhR1yT9N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360617; c=relaxed/simple;
	bh=Wj1UnNP+3shlIoYmWxJc8i+61hFpfMJlcSDuUgMpYGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c4mOihS8UCSieNlUpiYrRBNqZ5STMnQYotejJyOnDr1w3g7vO5o+Ojo+pckn6s4uSAoPvZXiCk7XLGDiP0ksXRI4xNWCh6fHdSBZmdvKKR5QGMJA2HN0T72DF3YURtrW15u2/lNNnPymRuJ3q/UqoBckMeRCOdZlV9q0JRKsE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJtTv4KD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJtTv4KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A31D1F000E9;
	Mon,  6 Jul 2026 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360615;
	bh=RShWaVdZQYREA8MuUaVgLWHi2qGDwLh/hCyMYbDcCJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJtTv4KDgw6FrlTobjmHijGegOfNQqJvOys4aqZKWsBtwe/5HlPjv5gKkru/GWyDM
	 ISrHocKBUysXtyiLm8WzXbEkjV/2+GvnQUkIc+GDVwVQmG8umtOqGZFjq008Ar1zl4
	 HTUA4/rBSwUBFjtFFFPXE+57M0sSanjdwEJZAwEp089q/ga/jwlQ47EyYynqTgo1re
	 TMdsP8Cm1SZzqZ/CI/mLHJ1g4NZl0s0PgzIQlrs/G+b6GiVRcloe3AWsA3uObTpKYz
	 6F3oRi7lFGu1YvP5An18vmLSHqejQaPC9cAUNDcYSM5q2Qs44E3GNIJjB0yfvoXKbx
	 gOzalWOW3T3bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/12] rtc: rzn1: Use temporary variable for struct
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20260706175138.12587-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:56:54 +0000
Message-Id: <20260706175655.6A31D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() is used immediately before pm_runtim=
e_disable() during devres cleanup, creating a race condition that leaves th=
e device active.
--

commit 5ee7d58e34962ad10d6a886e40f4b4757bc5611e
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Use temporary variable for struct device

This commit introduces a temporary variable to store the device pointer in
the probe function. This replaces multiple occurrences to avoid repeated
dereferencing.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 12bbbc18f7eab..4917bd223efd7 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

> @@ -421,19 +422,19 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>  	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;
>  	rtc->rtcdev->alarm_offset_max =3D 7 * 86400;
> =20
> -	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_pm_runtime_enable(dev);
>  	if (ret < 0)
>  		return ret;
> -	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware,=
 &pdev->dev);
> +	ret =3D devm_add_action_or_reset(dev, rzn1_rtc_disable_hardware, dev);

[Severity: High]
This is a pre-existing issue, but does the async suspend queued by
rzn1_rtc_disable_hardware() race with the subsequent runtime PM disable?

During devres cleanup (such as probe failure or driver removal), the cleanup
actions execute in reverse order (LIFO). First, the custom hardware disable
action runs:

static void rzn1_rtc_disable_hardware(void *data)
{
        ...
        pm_runtime_put(dev);
}

Because this is an asynchronous put, the suspend work is only queued.

Immediately after, devres unwinds devm_pm_runtime_enable() which calls
pm_runtime_disable(). This cleanup triggers __pm_runtime_barrier(), canceli=
ng
any pending async idle or suspend work and leaving the hardware powered on.

Should rzn1_rtc_disable_hardware() use pm_runtime_put_sync() instead to
ensure the suspend completes before runtime PM is disabled?

>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9
