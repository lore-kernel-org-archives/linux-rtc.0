Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78D3B47C6;
	Thu,  1 Oct 2026 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833703; cv=none; b=dhWdyDtHS6AX7CxgWxM+TlxV3C+acIRIG70u8iJ4YqaE8ugzms9n9/a0oYPYvMR9mPSLExFr15UEvZucZiei1O55z64sBB0tpYgN/CqymMf/bzKUcY6ppaLyB7wvtzgVV6ezxRHrhnq59kOO+/ryyXkY+rj98T+IiIqcFB8nRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833703; c=relaxed/simple;
	bh=rCdG5DHSnO2Igvy3TlIU6t13ncLAdoccjYhQmYQMMww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EM4M7iAf8KgbUDed1PJT8uT2lnZatQatocYNbFi0X/+KPdqcTuskmNiAOBYUc9LOp+v8vcH7uGfLNnJW2SXSYtwX/qSW1Hf34dpZ2vHyCOlgCTEkQ+/5Tng5K7GeoRTnMhQLWfUiK75PlehO3PG9D7oEpFxZSbsEAm3Gc43HGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1EXxwJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1EXxwJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF6E1F000FF;
	Thu,  1 Oct 2026 05:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833701;
	bh=lativQ/72fe6PQe6GyRVAuUCAsONqwA8ieMocuJMYX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1EXxwJ6wxjWa+Y/ITcjbaJ0axFOEu3sUKVT2Y6ke/av3KHfEo/Twr1j/GRsNsh0c
	 ISxcZyVH++tCl3iLn3Xj+l5n9uifB3PDV4lhGw3g2uRGQpJFiRm8N6eanvbolgwaqh
	 SNnzFq+8o+W9+8Ubw13dgzAlHqrhbAlRQA4MCaVz18J1KGZepcUs2HOamCKEP8sbiL
	 KAKgYMcqlGhLganGnMF1Xun+Y3WiA8uznMdGQMyG/xHsuwzaVDlSWV+3qXn312ZrzQ
	 XwqySgACbAnh6pkt9DsHjlrgEau+/T7j/1vHmHxERFVifwVvJULAUCrtIAnwkW3abp
	 vbdrwfz0um8lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: nct3018y: report chassis intrusion through hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Liu" <liuer@nvidia.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org
In-Reply-To: <20261001054108.3346426-1-liuer@nvidia.com>
References: <20261001054108.3346426-1-liuer@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 05:48:21 +0000
Message-Id: <20261001054821.AEF6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: nct3018y: hwmon device registration violates layering guide=
lines
--

commit 12bf4b0b27866f7565ebcc7b10db8faf4943fb10
Author: Eric Liu <liuer@nvidia.com>

rtc: nct3018y: report chassis intrusion through hwmon

This patch adds an hwmon intrusion alarm for the chip's chassis intrusion
latch. Reading it says whether the chassis has been opened since the latch =
was
last cleared; writing 0 clears it and re-arms.

> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> index 2f7ad57057a4b..194ba077363aa 100644
> --- a/drivers/rtc/rtc-nct3018y.c
> +++ b/drivers/rtc/rtc-nct3018y.c

[ ... ]

> @@ -491,6 +494,95 @@ static const struct rtc_class_ops nct3018y_rtc_ops =
=3D {
>  	.ioctl		=3D nct3018y_ioctl,
>  };
> =20
> +#if IS_REACHABLE(CONFIG_HWMON)

[ ... ]

> +static void nct3018y_hwmon_register(struct nct3018y *nct3018y)
> +{
> +	struct device *dev;
> +
> +	dev =3D devm_hwmon_device_register_with_info(&nct3018y->client->dev,
> +						   "nct3018y", nct3018y,
> +						   &nct3018y_hwmon_chip_info,
> +						   NULL);
[Severity: Medium]
Does this violate the hardware monitoring subsystem architecture rules?

Registering a hardware monitoring device directly from within
nct3018y_hwmon_register() in drivers/rtc/rtc-nct3018y.c bypasses hwmon
maintainer review and pollutes the RTC driver with secondary hardware
monitoring code.

Could this hwmon functionality be decoupled via an auxiliary device driver
located in the hwmon subsystem directory instead?

> +	if (IS_ERR(dev))
> +		dev_warn(&nct3018y->client->dev,
> +			 "unable to register hwmon device %ld\n", PTR_ERR(dev));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001054108.3346=
426-1-liuer@nvidia.com?part=3D1
