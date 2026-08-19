Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC60371897;
	Wed, 19 Aug 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136629; cv=none; b=IQxKMYU18urylpJ3+8Y1RlTNVSyKg9sNK6lhozAsfLhVBGMMwMQg5C0eULlv/hHLkrphCI+Z+KZAbwX9Jn6sugxkPwd57gKwQp8kacUfav6d5lNJ5J28UT8CMj08qU0hUQ9gZYFcH5HDKnTSLcYtfPGL1m6dpMDuLNjH7BqtQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136629; c=relaxed/simple;
	bh=QfEDMPAEGPg280ZQobmmprdOLxgbKFzRqK9qI3NSpew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oo+Jwie6MTfMLjWAc3gfj4P5AyGik6Gqyh7VzaOcmEGPhgseSFEra9SsHVmwwv7XWNjY9vC1UdI8FqWDOAVvxdsjIGTXEHqIxje7snmE0yb/6DCH/NDKLcq2zzVobs+SV12qne/6mywzCzklU2sCvabA1HPz45McDtmdyEyMGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i30Mpjgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i30Mpjgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A121F000E9;
	Wed, 19 Aug 2026 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136628;
	bh=OefMrw2SPE33ss8WyReqmX1rIpOzCKfsdkOlrQVhdKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i30Mpjgx6oCNGeE+LyyU1xhYP0L7ENvcF0/v1jh9MTTD53/Vl/FfUVtH3eFRSuexV
	 lFT6XeDLBYBgr64FylJOK8Rox8/AN3UU8iHb2qFT7/TTKovYxShtUnYIri8D9yp+ZU
	 D9sbhWXpOQP1pZtwGha3X0DDfpPyU9mlWZuYJmkdTLwZiqIzHUrURsDX+uMup3qSs9
	 +bUX8WVF87Rw4mRqLbiX9jTe3iDHI8UJ67WFlRIPenQFhI8LqorJP5kpqXzaXtRHop
	 UFWandam9zfDFAvrkQkT2YJeOmy+2I1Jo+gEulA85n51qqsZSBk+XBFGinWL9SIIn9
	 NWa1ERwpYsFmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/15] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260819103926.2136712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:50:27 +0000
Message-Id: <20260819105027.B7A121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() in managed teardown action races wit=
h pm_runtime_disable(), leaving hardware powered on.
--

--- Patch [7]: [PATCH v4 07/15] rtc: rzn1: Replace remove callback with dev=
m_add_action_or_reset() ---
commit c31bf08fd16c6f4ea71e35f49bac8367fb7f3cce
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Replace remove callback with devm_add_action_or_reset()

This commit simplifies driver teardown by registering a managed cleanup act=
ion.
It uses devm_add_action_or_reset() to disable hardware and drop the runtime=
 PM
usage count, eliminating the explicit remove callback and probe error paths.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 94d592e88a044..da7d13337c0da 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -371,6 +371,17 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp =
=3D {
>  	.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable,
>  };
> =20
> +static void rzn1_rtc_disable_hardware(void *data)
> +{
> +	struct device *dev =3D data;
> +	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
> +
> +	/* Disable all interrupts */
> +	writel(0, rtc->base + RZN1_RTC_CTL1);
> +
> +	pm_runtime_put(dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this asynchronous
pm_runtime_put() risk leaving the hardware powered on?

Because rzn1_rtc_disable_hardware() is registered as a devres action, it wi=
ll
execute during driver unbind just before the automatic cleanup of
pm_runtime_enable().=20

When the devres cleanup calls pm_runtime_disable(), any pending asynchronous
suspend work queued by pm_runtime_put() may be cancelled, leaving the hardw=
are
clocks and power domains permanently active.=20

Would it be safer to use pm_runtime_put_sync() here to ensure the device=20
reaches a suspended state before the teardown continues?

> +}
> +
>  static int rzn1_rtc_probe(struct platform_device *pdev)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7
