Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4864AE8D5
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644330; cv=none; b=OYgXYMZaZGwDjijsx5+P3wp+z62WecBhegWp2dunCOxu5IFFWwIm+dgwALKtcdFy7vfR51yBpR38VQTM0FnMHDlgM3l0oL+RV+GhpA2APVjAozUfj+8ixtL8M2V1vYiz+sYQ4dof9ZbJAKQpeZbnrsYTUzCu4HKpG6Z4Az59bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644330; c=relaxed/simple;
	bh=TdCU+qyGIcGjOTKzjn28bOxnJkDRu78a5OjtWenKHVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWXeMZpe6lMSiWaFtP52SVe7N6ZjRNwJrrqgKTqk2JgsGZGS2tciF143ThPmFF9p9Rf1iz8t6bjREvI+JenDKU7SmR2COvlcta5xPLkQLh9rlDCGj6UjoJ2YH4YW7ik+jY0/BmtqbgS0x+ona/D1yPe4zw1Z+LNzGbIyGGgdRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYV8jABP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYV8jABP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB51F00899;
	Thu, 17 Sep 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644328;
	bh=TeKZbpWGkEDgIEI6CgT0vPkc77FDrjhOONHQi9MoJZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYV8jABP/DTmYIRuoESyGIo7phfMQ3O5dAa+ulrudzGWTGac9rxQeLhXXlV6M7LQC
	 3HqtrOY/687i/SYcrEDdx0Ad3+zaPSEkZxjlxGNNPM7EqwkbzabwdPzULZgJgEKseF
	 bC8poXvKf8tPQPKoVZHrNhFHgZxgE8Y3doEdH1jPWqYYyhsJ3wsthHSGHtIpIbPdxh
	 z/NVWObxK1hG6dxNZUkYAmm0MQ5bWaLGz2nMwGUUztNP8hAImElBEH1xy00rRNMGQR
	 UgczO2tOthd9xbqxCQLoiQDoe5LytxggpFofP2ouy5NqLVGHd2ByfUqu/BXMBECKs1
	 nex55T7RFi9iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260917111349.52250-5-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 11:25:27 +0000
Message-Id: <20260917112528.36BB51F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: rzn1: falsely advertising RTC_FEATURE_UPDATE_INTERRUPT for =
broken_irqs
--

commit 526064073abaf5e11d2cc3b65e8bf7e6092cd549
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>

rtc: rzn1: add R-Car X5H support

The RTC on R-Car X5H is a bit special because interrupts are not wired.
This creates a dedicated entry for X5H without interrupts.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

> @@ -504,25 +506,39 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
> =20
>  	spin_lock_init(&rtc->ctl1_access_lock);
> =20
> -	ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Ala=
rm", rtc);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
> -
> -	irq =3D platform_get_irq_byname_optional(pdev, "pps");
> -	if (irq =3D=3D -EPROBE_DEFER)
> -		return irq;
> -	if (irq >=3D 0)
> -		ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", =
rtc);
> -
> -	if (irq < 0 || ret) {
> -		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> -		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> -		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute =
accuracy\n");
> +	if (data->broken_irqs) {
> +		/* All known broken irqs are on SCMP only variants */
> +		rtc->rtcdev->ops =3D &rzn1_rtc_ops_scmp_no_alarm;
> +	} else {

[Severity: Medium]
Does this branch need to clear the RTC_FEATURE_UPDATE_INTERRUPT bit from
rtc->rtcdev->features?

Since devm_rtc_allocate_device() allocates the RTC device and
unconditionally sets RTC_FEATURE_UPDATE_INTERRUPT, drivers that do not
support hardware update interrupts are expected to clear this bit.

The original code cleared this bit when PPS interrupts were missing, but
this new branch for broken_irqs skips that clearing logic.

Could this expose false hardware capabilities to userspace when queried
via RTC_PARAM_FEATURES?

> +		irq =3D platform_get_irq_byname(pdev, "alarm");
> +		if (irq < 0)
> +			return irq;
> +
> +		ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Al=
arm", rtc);
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
>  	}
> =20
>  	return devm_rtc_register_device(rtc->rtcdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917111349.5225=
0-1-wsa+renesas@sang-engineering.com?part=3D4
