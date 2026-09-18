Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264B515965
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748899; cv=none; b=LUGDxqp1I6sxc55ON9m/+F3dWbSWGK19Priu64io8jPlls1Dz5NjjrgrP7z23/vC/6GRlFOzQ+9X2ZPH+W0Dk4TFAuB+LYQOWbTAqyDftycL1zCj3jP3udyStgipvDwSYutdoFHNj7gS012GqonGhC5aAK44QbkSKHjRTCblwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748899; c=relaxed/simple;
	bh=NByz2twd9ccBMO8W8HX7eOaf2uxUOENjKt8JE5OjI8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8/5bt3LLRnw33iFNBK1KXrIpxlZIz1bg0y4AQvp6CVQUsoFmkQGO2Q9yfnivcHblwNxPrfa5HjE9talEoW2O7V1jcURs+/rtqZ9ikmvVE2KyQk9URVR8rlyDWmcUYzlzU1lM3Qa3Sz7e5jYS6QqH7Btv8GYaBnygD3vHJj1jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRQ11QB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRQ11QB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A119E1F00898;
	Fri, 18 Sep 2026 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748890;
	bh=OjQH/yfykXCLQ4qpxe2HPpWvhEMaQClEbvuj6nKl4cQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRQ11QB379FktgfBtaOLuIxUvGxdpkM/8zJFEcbItpTlo2Scy6ycrSvvuth7o7H/L
	 pH++yR3mm6fqmClmcD+3geNk6KwjucidxTpmi9bZ+vnlMxAcAUBp+sILI1xAWpBJ6q
	 AX2GStKLta0hxT8xB9EWk7+O8H6Ul7rFWPsiY7q2KhIwnwYujWupEB5SWiEJXAwg90
	 tlXsX2SG8fNAKqLWxf3MMkZCfkDMl4vTF5kwQTI2cBUMNJqyrdzTcxtSOKrHJ2OojN
	 cIuHdoPjcdqb8ozZg/2oxIwWciOrSXPf8qavtmBkQdnAMk1e3sWdZUXhttx5luOxFC
	 U8cWCqUkCZJtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ma35d1: fix unchecked IRQ error and
 IRQ-before-rtcdev ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260918161925.2639130-1-congnt264@gmail.com>
References: <20260918161925.2639130-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:28:10 +0000
Message-Id: <20260918162810.A119E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rtc: devm_request_irq() called after devm_rtc_register_device()
- [Low] rtc: redundant dev_err_probe() on platform_get_irq() failure
--

commit 65db24f320f8394c839e4022831930f15fb56e95
Author: Cong Nguyen <congnt264@gmail.com>
rtc: ma35d1: fix unchecked IRQ error and IRQ-before-rtcdev ordering

This commit checks the return value of platform_get_irq() to prevent passing
a negative error code to devm_request_irq(). It also moves the IRQ
request to after the RTC device is registered, intending to fix the teardown
order.

Link: https://lore.kernel.org/r/20260914133532.CBFAA1F000FF@smtp.kernel.org

> diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
> --- a/drivers/rtc/rtc-ma35d1.c
> +++ b/drivers/rtc/rtc-ma35d1.c
> @@ -236,11 +236,8 @@ static int ma35d1_rtc_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	rtc->irq_num =3D platform_get_irq(pdev, 0);
> -
> -	ret =3D devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
> -			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
> +	if (rtc->irq_num < 0)
> +		return dev_err_probe(&pdev->dev, rtc->irq_num, "failed to get rtc irq\=
n");

[Severity: Low]
Does this cause a redundant error message to be printed? platform_get_irq()
already calls dev_err_probe() internally when it fails. Returning the error
code directly without another dev_err_probe() might be preferred.

[ ... ]

> @@ -258,6 +255,11 @@ static int ma35d1_rtc_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n=
");
> =20
> +	ret =3D devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
> +			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
> +
>  	return 0;
>  }

[Severity: High]
Does placing devm_request_irq() after devm_rtc_register_device() introduce a
race condition?

Since devres teardown is last-in, first-out, during an unbind or a probe
failure, the IRQ would be freed before the RTC device is unregistered.
This leaves the device exposed to userspace without an active interrupt
handler, potentially leading to missed alarms or unhandled interrupt storms.

Would it be better to place devm_request_irq() between
devm_rtc_allocate_device() and devm_rtc_register_device() in
ma35d1_rtc_probe()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918161925.2639=
130-1-congnt264@gmail.com?part=3D1
