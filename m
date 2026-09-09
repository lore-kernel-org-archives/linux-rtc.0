Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6705540AE
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968257; cv=none; b=PQbPDw5jo/vPyzGO/790rhZPGCYHck3Ms3On/nmZ8sN8/VF8fSoIz+S3VH41Neigv7jsXFqV6eUJ4ciAyZ6kcLzJvqH6K39OLEGZXAiodhWdHEnKMyGPbtO7qFNX1zVzUVsdjr091LtyGOP1VqkJkInIV++gTJAsgUb97b+lcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968257; c=relaxed/simple;
	bh=SLl2etl7vOwFDFB6JF6O7Ujsn6kZIHsMbPF1okbApmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRDfc6BTIzzQmnsYz2Utf2KFqGCblYAZC2YID80WVgDBgYA31Ns9TJ0fA93eHtdc/3GGqReGp9AlbFDLYFcMgSFAzmUieFrXympsbjknLPOGzO9De3oZ2XNj6zKvDTj7D0uJrks19PRaFi1Pjktuu06sjmdlkRnbrriiqgegNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjUOQWX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjUOQWX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554F71F00A3A;
	Wed,  9 Sep 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788968255;
	bh=IQBD3h3uOX05x7h3ABTq6ghPbvH92CNkqmKsqwjzQ1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjUOQWX41xYSW9ntbN8XlBHI12qJHkzJ2rvHxsITGhXTMxZEQtpbWa57noguZcUfx
	 PjKN28oLp+GlJxVhVSrnyJZ7s4o+6W5FjyEL+f9jQamR8IBWgnQ+Yh+kzOzCOba4NF
	 EhS0gcdNDEUJ3nJUN9vyc3K7esVb098xHiZHlc1xLThnN3PQrvOvjKp/Wd0zb59EF4
	 ef45gK3fvYCOCr0ZWJb1JjbhOHBDiD8GJf+rchMxecWmOq9F1tug+5w81Z697KJwjT
	 JzXvUlP9zrwihtNT90Q6CV0dJ1l+jL8S/cvG5/ZWlra5nCAGmhlIgGzswtlq3/3y/A
	 8+tKI1c8/nFJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: atcrtc100: cancel alarm work on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260909152651.712614-1-fanwu01@zju.edu.cn>
References: <20260909152651.712614-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:37:34 +0000
Message-Id: <20260909153735.554F71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CRASH: NULL pointer dereference and uninitialized memory execution=
. The alarm IRQ is requested prematurely in probe before the required struc=
tures are initialized.
- [High] LEAK AND UAF: The probe function's error path for devm_rtc_registe=
r_device() fails to clean up newly configured wake capabilities and the wor=
kqueue.
--

commit 913e1e349945d1e573a4b95047a974a86f29a566
Author: Fan Wu <fanwu01@zju.edu.cn>

rtc: atcrtc100: cancel alarm work on remove

This commit adds a remove callback to the atcrtc100 RTC driver to properly
clean up resources. It clears the wake IRQ, disables wakeup, frees the
interrupt, and cancels the alarm work to prevent use-after-free and -EEXIST
issues on rebinding.

> diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
> index 9808fc2c5a492..3c7313218da51 100644
> --- a/drivers/rtc/rtc-atcrtc100.c
> +++ b/drivers/rtc/rtc-atcrtc100.c
> @@ -337,6 +337,16 @@ static int atcrtc_probe(struct platform_device *pdev)
>  	return devm_rtc_register_device(atcrtc_dev->rtc_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
resources or risk a use-after-free?

If devm_rtc_register_device() fails in atcrtc_probe(), it returns the error
immediately:

atcrtc_probe() {
    ...
    return devm_rtc_register_device(atcrtc_dev->rtc_dev);
}

However, earlier in atcrtc_probe(), device_init_wakeup() and
dev_pm_set_wake_irq() are called, which are not devres-managed. Do these wa=
ke
configurations leak on this error path?

Also, if the alarm IRQ fired and scheduled rtc_work, wouldn't returning wit=
hout
cancel_work_sync() leave the work pending? Once devres frees atcrtc_dev,
couldn't this lead to a use-after-free when the system workqueue eventually
executes the uncancelled work?

[Severity: High]
This is also a pre-existing issue, but is there a race condition when the a=
larm
IRQ is requested earlier in atcrtc_probe()?

The IRQ is requested via devm_request_irq() before atcrtc_dev->rtc_dev is
allocated and before INIT_WORK() initializes rtc_work:

atcrtc_probe() {
    ...
    ret =3D devm_request_irq(&pdev->dev, atcrtc_dev->alarm_irq, ...);
    ...
    atcrtc_dev->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
    ...
    INIT_WORK(&atcrtc_dev->rtc_work, atcrtc_alarm_clear);
}

If the hardware interrupt fires immediately after devm_request_irq(), the
handler atcrtc_alarm_isr() will execute:

atcrtc_alarm_isr() {
    ...
    schedule_work(&rtc->rtc_work);
    rtc_update_irq(rtc->rtc_dev, 1, RTC_AF | RTC_IRQF);
    ...
}

Will this cause schedule_work() to operate on uninitialized memory and
rtc_update_irq() to dereference a NULL pointer? Should the IRQ request be m=
oved
until after these structures are fully initialized?

>  }
> =20
> +static void atcrtc_remove(struct platform_device *pdev)
> +{
> +	struct atcrtc_dev *atcrtc_dev =3D platform_get_drvdata(pdev);
> +
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +	devm_free_irq(&pdev->dev, atcrtc_dev->alarm_irq, atcrtc_dev);
> +	cancel_work_sync(&atcrtc_dev->rtc_work);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909152651.7126=
14-1-fanwu01@zju.edu.cn?part=3D1
