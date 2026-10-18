Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E43D8103
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295903; cv=none; b=IvL+rz+BFqtW94qptK5SnKnq7GcJBsVeRu3NOfPmWOEmH+dAJmJuiO2wsil/V/P4u//hw3GK/a8yOgNV7vC7wGbE+GiT72vRYi6E21c76JyCbWVzPH/eOFuDDpqZN/mxxTvJMfdoDmeEry89UavBWQR2fc82WUV2yhMVh6QpuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295903; c=relaxed/simple;
	bh=GM+XiDOwJPZdj+FGQqQAeabioh9lH6r8987v0spWB+I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X989wbULWosAp5flBHphhEmcsQmHibOIL4aRp7ttHm/NcmTFr4zdkw59oyiwItw3NS3E6c4Zx8KVWk4jR8YgnGaMG0Kts9oPM4rkmfo4pqVcsPU9UjP+P6ooMwWBtW3h9BS17WeZ2HR0a9Eeh67nOVz3xWh7qlG3qEbtm/VHV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L74GQZWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L74GQZWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B821F000C4;
	Sun, 18 Oct 2026 03:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792295899;
	bh=Y0Njjj8laW760r60BZYUGDDvUluzXejtmasv46TjdO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L74GQZWVu5hkIS2ktmSxJsdsh9DvJ3tu4LR/fmk0M20vz2LTZjYhDcAsNvr/aOlsR
	 pzg/pcwVxtXMLyQILCpdkLW5SRUFf1+z4csmCnjRHo70xR0UKf4awxbogfCbXMPtsO
	 Fvry6GOhKaTHkAN4HK6U4nWH2e8YVBR+ddnGjlTir4ii0BRgWwOF5iHTr3aidnpKf7
	 SC7d8shRJ4T2fSpJWj9lBXJr8MitJJZTpaHToRXecavr+7pe/+NSY8YzSBjkVl3V/p
	 ePciiVry/qJ4SrwJ9tixo3U+8mMeuBlMZ9OhMB3bjnAO+fh8iaSTsU40VHraK3Rf/x
	 1k9l/z6y6kuiQ==
Message-ID: <sashiko-outbox-175914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mt7622: allocate the RTC before requesting its IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <179229507333.3965554.17726204422948048488.rtc-mt7622-irq-init-order@gmail.com>
References: <179229507333.3965554.17726204422948048488.rtc-mt7622-irq-init-order@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 03:58:18 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: mt7622: clk disabled in mtk_rtc_remove() before devres tear=
down
--

commit aaf543ae0f6d2f3fb8f602ad5f4977facde6059e
Author: Myeonghun Pak <mhun512@gmail.com>

rtc: mt7622: allocate the RTC before requesting its IRQ

This patch reorders RTC allocation, hardware initialization, IRQ request,
and RTC registration in mtk_rtc_probe() so that devres unregisters the
RTC and frees its IRQ before dropping the final RTC device reference.

> diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
> index 9e17dd09d5673..c86c8cf3f2d77 100644
> --- a/drivers/rtc/rtc-mt7622.c
> +++ b/drivers/rtc/rtc-mt7622.c
> @@ -324,12 +324,21 @@ static int mtk_rtc_probe(struct platform_device *pd=
ev)
>  	if (ret)
>  		return ret;
> =20
> +	hw->rtc =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(hw->rtc)) {
> +		ret =3D PTR_ERR(hw->rtc);
> +		goto err;
> +	}
> +
>  	hw->irq =3D platform_get_irq(pdev, 0);
>  	if (hw->irq < 0) {
>  		ret =3D hw->irq;
>  		goto err;
>  	}
> =20
> +	mtk_rtc_hw_init(hw);
> +	hw->rtc->ops =3D &mtk_rtc_ops;
> +
>  	ret =3D devm_request_irq(&pdev->dev, hw->irq, mtk_rtc_alarmirq,
>  			       0, dev_name(&pdev->dev), hw);
>  	if (ret) {
> @@ -337,14 +346,10 @@ static int mtk_rtc_probe(struct platform_device *pd=
ev)
>  		goto err;
>  	}
> =20
> -	mtk_rtc_hw_init(hw);
> -
>  	device_init_wakeup(&pdev->dev, true);
> =20
> -	hw->rtc =3D devm_rtc_device_register(&pdev->dev, pdev->name,
> -					   &mtk_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(hw->rtc)) {
> -		ret =3D PTR_ERR(hw->rtc);
> +	ret =3D devm_rtc_register_device(hw->rtc);
> +	if (ret) {
>  		dev_err(&pdev->dev, "Unable to register device\n");
>  		goto err;
>  	}

[Severity: Medium]
While this fixes the devres ordering between hw->rtc and hw->irq, what
about hw->clk during detach?

In mtk_rtc_probe(), hw->clk is enabled manually before the devm calls:

drivers/rtc/rtc-mt7622.c:mtk_rtc_probe() {
	...
	ret =3D clk_prepare_enable(hw->clk);
	if (ret)
		return ret;

	hw->rtc =3D devm_rtc_allocate_device(&pdev->dev);
	...
}

And it is disabled in mtk_rtc_remove():

drivers/rtc/rtc-mt7622.c:mtk_rtc_remove() {
	struct mtk_rtc *hw =3D platform_get_drvdata(pdev);

	clk_disable_unprepare(hw->clk);
}

During driver unbind or module unload, __device_release_driver() calls
device_remove() -> mtk_rtc_remove() before device_unbind_cleanup() calls
devres_release_all().

Because hw->rtc and hw->irq are cleaned up by devres,
clk_disable_unprepare(hw->clk) runs while hw->rtc is still registered and
mtk_rtc_alarmirq() is still active. If an alarm interrupt fires or an
mtk_rtc_ops callback runs in that window, mtk_rtc_alarmirq() or the RTC
operations will access hw->base MMIO registers after hw->clk has already
been disabled:

drivers/rtc/rtc-mt7622.c:mtk_rtc_alarmirq() {
	struct mtk_rtc *hw =3D (struct mtk_rtc *)id;
	u32 irq_sta;

	irq_sta =3D mtk_r32(hw, MTK_RTC_INT);
	...
}

Should mtk_rtc_probe() use devm_clk_get_enabled() (and drop
mtk_rtc_remove()) so that hw->clk stays enabled until after devres
unregisters hw->rtc and frees hw->irq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179229507333.396555=
4.17726204422948048488.rtc-mt7622-irq-init-order@gmail.com?part=3D1
