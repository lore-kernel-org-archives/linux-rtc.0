Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E93468C05
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390485; cv=none; b=B8BcjOZ2p1VWjqCdRelo9QfcrEthebLIYAG1qzo99NdCyrAiGNWVTIrsAj96KBp16YzeRql1RcKHpI3eERBgQ7QjE2+xmFNeBW/jp+0CggT0BkOrqLFRfu+DdJRSrx0YznkZ5ipzsxHs31jMXGv66Zo4h+Ak1AJgare7dAI/3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390485; c=relaxed/simple;
	bh=Dcx7+McgjgbFgj1+VIPThs15YE0NaB4/rvjdXOLSRt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AR5zEVRQBSqdOdmKAhbplfFg+eaTiRVAhbAf2IuiSTpgdcw1Eq3vZdP9S3lzRQ/6EJraIHr14UBG/76Tkl/gdvTtj8Q8mOCjd8hl7KaEnk/27lY3kEvu2vel8jXR//IddPQpP4Q3LnxBqf3N2TxUrgwqkO4Gf0wUR98TxGonDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ9Vn0FD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ9Vn0FD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F981F000FF;
	Mon, 14 Sep 2026 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390483;
	bh=yzM7RMd7B2o0W9CTBE7BpdLXJVO6aCZeOrS+X8NdOYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJ9Vn0FDRait1DZG4vOdupBIzl0EjjJzeXJp+dFqeW4lH6hnhg7Fbtz6rbOEJ7ofv
	 IqyVkJ6aY90sY2UfdaDWPJNDV5sfh0dUjCLFZ/SM+qeHvoUM70r8XlrmsmT8fGQ9EL
	 Y082vfpwXDhctvss8WnNpuwZn4G7dJ68QiOC4QlBK9m8EZjiltL55MNBpj7bqtWoyg
	 0BCjivvru1VKrAxyuDuodnChv6/1B9Mafx+YB6qXDqxgZZI5vinWwp5TAZ1fvPgjeX
	 iXPjRHOqSp/h8TEcILYn8RISk6rfmWOITAcUSSAZLs/wf46S8YWC8Dd5QG1zazIelO
	 vBrWVEZoeaedA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pxa: fix IRQ leak on probe failure after
 pxa_rtc_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260914124037.2204337-1-congnt264@gmail.com>
References: <20260914124037.2204337-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:54:43 +0000
Message-Id: <20260914125443.73F981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver incorrectly registers two separate RTC class devices fo=
r the same hardware, leading to uncoordinated concurrent access and registe=
r corruption.
--

commit 0b0a0ee3975e585ff222c5362ed76732cdee7bd2
Author: Cong Nguyen <congnt264@gmail.com>

rtc: pxa: fix IRQ leak on probe failure after pxa_rtc_open()

This commit addresses an IRQ leak in pxa_rtc_probe() where the 1Hz and alarm
IRQs requested by pxa_rtc_open() are not released if sa1100_rtc_init() or
devm_rtc_device_register() fail later in the probe sequence. It routes
failures through a new err_release label to properly call pxa_rtc_release().

> diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
> index 62ee6b8f9bcd6..e01e683c2f615 100644
> --- a/drivers/rtc/rtc-pxa.c
> +++ b/drivers/rtc/rtc-pxa.c
[ ... ]
> @@ -347,7 +349,7 @@ static int __init pxa_rtc_probe(struct platform_devic=
e *pdev)
>  	ret =3D sa1100_rtc_init(pdev, sa1100_rtc);
>  	if (ret) {
>  		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
> -		return ret;
> +		goto err_release;
>  	}
> =20
>  	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
> @@ -357,12 +359,16 @@ static int __init pxa_rtc_probe(struct platform_dev=
ice *pdev)
>  	if (IS_ERR(pxa_rtc->rtc)) {

[Severity: High]
This is a pre-existing issue, but does this lead to uncoordinated concurrent
access and register corruption?

Looking at drivers/rtc/rtc-pxa.c:pxa_rtc_probe(), the code first delegates
to sa1100_rtc_init(), which registers a primary RTC class device and
initializes its own spinlock (info->lock).

Then pxa_rtc_probe() registers a second concurrent RTC class device
(pxa_rtc->rtc) with a completely independent spinlock (pxa_rtc->lock) for
the exact same hardware registers.

Concurrent userspace interactions (via ioctls on /dev/rtc0 and /dev/rtc1)
will race during read-modify-write operations on the hardware. Could this
cause data corruption of shared RTC hardware registers (like RTSR),
inconsistent state, and incorrect interrupt routing since events only
update one of the devices?

>  		ret =3D PTR_ERR(pxa_rtc->rtc);
>  		dev_err(dev, "Failed to register RTC device -> %d\n", ret);
> -		return ret;
> +		goto err_release;
>  	}
> =20
>  	device_init_wakeup(dev, true);
> =20
>  	return 0;
> +
> +err_release:
> +	pxa_rtc_release(dev);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914124037.2204=
337-1-congnt264@gmail.com?part=3D1
