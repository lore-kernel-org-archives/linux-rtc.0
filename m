Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A6410D15
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421390; cv=none; b=cOX+KswuWUTLmMxcUFeDEGVX0+5N+ycm16eIxe84B94WoSwoEzqcHNWUQ7hD1bKqGMpy8yUw1fyCwMlZWhkhhDPj8h6DS060BFhfHXZiURBmjBqtKE+HfZtY61P7RagjlVFyhWujHa0oRpCvsFYJjFcdGo7Nv+zcJssswtV6C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421390; c=relaxed/simple;
	bh=CfojKEg8rc+b1wLJgPohtX0BpvUaZXpAtUmWm1fgQKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDNZnXSj3fYOTYOVbyf24KCW5XEFShk6VVhFdYFBz79EWZiB3l7hpU6Lhp1ZBGPz41HFJRLKJsSuVUKnkif+Tcgz2/P22v9T9hBbvOM6i39U2d5kLyc86v0z4G2pls0f6XqpLI6BsqlJxJTV3PDveG8GNxrZ6GvJrfOke2+gcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQWPH9N1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQWPH9N1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133AD1F000FF;
	Mon, 14 Sep 2026 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421388;
	bh=haZ2SRwODCGUlThEEaVG/Io6cuStS6sQ0Hqankq6cmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQWPH9N1S0UIgKNy0c24cpQzYmLk9BJqhwjulfsE11kk1Tgol9uZaDdbp76ieVgs2
	 d+Gb8e8RYNK7T/s1fZYLpRI6W+nxpOAIFJ9IzJWjdAnmgK7QfS5suE9sbVgYdI/OEy
	 dbqT+QaLeYeKLjbKX2QyvzRxpvkzvGXBfOR3wHBezrXKNa1MZJwRFZ8ryTAQ9fD6/0
	 rjZB5IIqRTL2YSifgCUZn2qSPOw6LEmW79+FOM8rWKs34fKiCWAjtNX75GHayqZxQO
	 bm3ABONgjTfNuBqc6D2Ucpwz0zseDlITJNwyGQaPlwSdXSF+rlFZUtWKhbvhE7ny8Y
	 P7OkTfUvSJqiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] rtc: rzn1: make interrupts optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260914211826.73727-12-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-12-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:29:47 +0000
Message-Id: <20260914212948.133AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch replaces immutable `const struct rtc_class_ops` structur=
es with a single mutable global `struct rtc_class_ops rzn1_rtc_ops`. The dr=
iver then dynamically modifies this shared global struct during `probe()`. =
This introduces two severe issues: 1) A security regression by placing func=
tion pointers in writable `.data` memory instead of read-only `.rodata`, ma=
king them an easy target for control-flow hijacking exploits. 2) Driver mod=
el isolation breakage. If a device is unbound and rebound with different ha=
rdware capabilities (e.g., via a DT overlay lacking the alarm IRQ), or if m=
ultiple RTC instances exist, the global struct retains stale function point=
ers from previous probes. For example, a device without an alarm interrupt =
will inherit `set_alarm` from a prior successful probe, causing the RTC cor=
e to mistakenly advertise unsupported features and attempt to program unsup=
ported hardware.
- [Medium] `RTC_FEATURE_UPDATE_INTERRUPT` is erroneously left enabled when =
the device lacks an alarm interrupt, causing the RTC core to advertise non-=
existent capabilities. Before this patch, the driver explicitly cleared `RT=
C_FEATURE_UPDATE_INTERRUPT` if it couldn't acquire the 'pps' interrupt. In =
this patch, the check for the 'pps' interrupt and the subsequent feature fl=
ag clearing logic are nested inside an `else if (irq >=3D 0)` block that ch=
ecks for a valid 'alarm' interrupt. If a device has no 'alarm' interrupt, t=
his entire block is bypassed. Consequently, the driver neither requests the=
 'pps' interrupt nor clears the `RTC_FEATURE_UPDATE_INTERRUPT` flag (which =
is enabled by default by the RTC core), leaving the device in an inconsiste=
nt state.
--

commit 2099c0ea773de6a8c400669f6b3316540360644e
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

rtc: rzn1: make interrupts optional

This patch makes interrupts optional in the rzn1 rtc driver, disabling
alarm handling if they are absent. It replaces the multiple static rtc_ops
structures with a single non-static one that is adapted during probe().

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 1e1676a7f3cc9..583ce12b052d9 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -379,22 +379,9 @@ static int rzn1_rtc_set_offset(struct device *dev, l=
ong offset)
>  	return 0;
>  }
> =20
> -static const struct rtc_class_ops rzn1_rtc_ops_subu =3D {
> +static struct rtc_class_ops rzn1_rtc_ops =3D {

[Severity: High]
Does removing const from this global operations structure introduce a
security regression? Placing function pointers into writable memory makes
them a potential target for control-flow hijacking exploits.

[ ... ]

> @@ -491,9 +475,9 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
> =20
>  	if (scmp_val) {
>  		writel(rate - 1, rtc->base + RZN1_RTC_SCMP);
> -		rtc->rtcdev->ops =3D &rzn1_rtc_ops_scmp;
>  	} else {
> -		rtc->rtcdev->ops =3D &rzn1_rtc_ops_subu;
> +		rzn1_rtc_ops.read_offset =3D rzn1_rtc_read_offset;
> +		rzn1_rtc_ops.set_offset =3D rzn1_rtc_set_offset;

[Severity: High]
Can mutating this shared global structure in rzn1_rtc_probe() lead to state
corruption across unbind/rebind cycles or if multiple instances of the RTC
exist?

If a device is unbound and then rebound with different hardware capabilitie=
s,
or if a device lacking an alarm interrupt inherits the set_alarm operations
from a previous probe, the RTC core could mistakenly advertise unsupported
features and attempt to program unsupported hardware.

[ ... ]

> @@ -504,20 +488,30 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
> =20
>  	spin_lock_init(&rtc->ctl1_access_lock);
> =20
> -	ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Ala=
rm", rtc);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
> =20
> -	irq =3D platform_get_irq_byname_optional(pdev, "pps");
> -	if (irq =3D=3D -EPROBE_DEFER)
> +	irq =3D platform_get_irq_byname_optional(pdev, "alarm");
> +	if (irq =3D=3D -EPROBE_DEFER) {
>  		return irq;
> -	if (irq >=3D 0)
> -		ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", =
rtc);
> -
> -	if (irq < 0 || ret) {
> -		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> -		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> -		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute =
accuracy\n");
> +	} else if (irq >=3D 0) {
> +		ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Al=
arm", rtc);

[Severity: Medium]
Will RTC_FEATURE_UPDATE_INTERRUPT mistakenly remain enabled if there is no
alarm interrupt present on the device?

Because the feature flag cleanup and the pps interrupt probing are now nest=
ed
inside this else if (irq >=3D 0) block, a missing alarm interrupt bypasses =
this
entire logic.

Since the RTC core enables RTC_FEATURE_UPDATE_INTERRUPT by default, failing
to clear it here could leave the device in an inconsistent state and cause
incorrect capabilities to be advertised.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
> +
> +		irq =3D platform_get_irq_byname_optional(pdev, "pps");
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return irq;
> +		if (irq >=3D 0)
> +			ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s",=
 rtc);
> +
> +		if (irq < 0 || ret) {
> +			set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> +			clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> +			dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute=
 accuracy\n");
> +		}
> +
> +		rzn1_rtc_ops.read_alarm =3D rzn1_rtc_read_alarm;
> +		rzn1_rtc_ops.set_alarm =3D rzn1_rtc_set_alarm;
> +		rzn1_rtc_ops.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D4
