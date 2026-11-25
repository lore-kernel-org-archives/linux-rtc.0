Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591510;
	b=wYWzw1bfCQJ8AMJ/DhfKR7IVrvPZVEu5Tzdwvl0TFuGOrN9W8L0QGT+gZz9aOxTb8Apk
	 p3V10ahY0L1XL7/jksU7trNpGWjCpcpHqkCPcknMggMOpo/uqTk5LTT5iDTjjdOtscE8F
	 tcU3PAsbrgwl3Jqqs+JwI664CMKcgC7wPINyMsH6mh0yqNDbPjpgygN0f3qd4CQMjDy6Q
	 emn9raO57zBlbBK677yfra1u3Iuywhf6WzncKsyHCvJqfCDBi9KLSw4ev/XPPcI/z/Vip
	 IwWxIqwguIKjH4nBDCwjFwdbRj9LlHitSne8SfB/dMeba2bu8hclrC8r8PjkVxTfE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JI4Qym6cD0gnhU9vLY1J21V/Ym2HT/rP/tSxSRmWjgE=;
	b=ASrtQ72HDLNbPN62h575c/hIKiqWm+bNJOiNPJq4pXrVJo0S7VEeSjwZp+hcMjLUXiEJ
	 7VNDsplraOKI8oiH/3fwcOjNoWSS4bxcUCMrLVPLpskp3Gt6OxDqgqO2YZ1tS3O+tn63B
	 IODHA9wVPgmwu8D2QpkotCtF3/1w2dQjdjxnsASnMEaEqJ5X+ZACGgq+UORLMDEjsossg
	 NyvKBIjQ2rZlExQiO7uFtglYFs0Ol5Zl+n0ncBHCQawdWHXff7hzxVbG3Um/zMgOSjiFG
	 YGFzNjNsq4MO2DqFMKVeOz14f9YA6JkKAK9wQmL9QKUnVWjzsUnzFL8TPQUUlyhlW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bzT/idmb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA9606A31E;
	Wed, 25 Nov 2026 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzT/idmb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200BC1F000C0;
	Wed, 25 Nov 2026 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591510;
	bh=JI4Qym6cD0gnhU9vLY1J21V/Ym2HT/rP/tSxSRmWjgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzT/idmb0kudE/FXoeMwTUidd52pnO+1yOPKAzC/naxT2EiGFugZfCmXSs0LCCgaa
	 G7oFoegMLzSdRofe2cJORAWtHDe0aXdvu1lwxLwOMGcY9QSnYkDPN5kuN4GOWIdkXT
	 ZmVeql+ZdhdgtSJD0HRhGmmXFlSkBmhwA/c2gRLmR/fE7yfFC0gIouJWtESR5PDP+o
	 uHi1AuIsDJmZdq3E6SP02Q+WxXen1K0y/7IxNNNE3flQqAaYPRkVlpG+/vvM/H4k3q
	 uuhkx/9++jw28TA+f/6mtG+cpOejy2CEQZThxK+cKNw9ncxjJobi2fIijsvVty35W1
	 t++3sQ19+PKoA==
Message-ID: <sashiko-outbox-232779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] rtc: mxc_v2: clear the wake IRQ on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prasanth R" <ragaprasanth@gmail.com>, linux-rtc@vger.kernel.org
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125072026.2997493-5-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-5-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:25:09 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] rtc: mxc_v2: unhandled interrupt storm in mxc_rtc_remove() [1]
--

commit f8f7168b7242f3f7ce38e7545b8decc669f9b81a
Author: Prasanth R <ragaprasanth@gmail.com>

rtc: mxc_v2: clear the wake IRQ on unbind

This commit replaces device_init_wakeup() and dev_pm_set_wake_irq() with
their device-managed variants in mxc_rtc_probe() so the wakeup source and
wake IRQ are released on unbind.

> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
> index 35a18b75c1098..fe3a55b00418b 100644
> --- a/drivers/rtc/rtc-mxc_v2.c
> +++ b/drivers/rtc/rtc-mxc_v2.c
> @@ -301,8 +301,8 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	if (pdata->irq < 0)
>  		return pdata->irq;
> =20
> -	device_init_wakeup(&pdev->dev, true);
> -	ret =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	devm_device_init_wakeup(&pdev->dev);
> +	ret =3D devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to enable irq wake\n");
> =20

[Severity: High]
This problem wasn't introduced by this patch, but can unbinding the driver
while a hardware alarm is armed trigger an unhandled interrupt storm
[1]?

drivers/rtc/rtc-mxc_v2.c:mxc_rtc_remove() {
	struct mxc_rtc_data *pdata =3D platform_get_drvdata(pdev);

	clk_unprepare(pdata->clk);
}

mxc_rtc_remove() does not clear SRTC_LPCR_ALP or SRTC_LPCR_WAE before
devres unregisters the IRQ handler.  If a pending alarm fires afterward,
no handler is left to acknowledge it and the IRQ core disables the line
with "nobody cared".

[1] https://sashiko.dev/#/bug/linux-4a7ad9ff-00aa-4c3f-aa57-966cdc8a71a1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125072026.2997=
493-1-prasanth.r@lineo.co.jp?part=3D4
