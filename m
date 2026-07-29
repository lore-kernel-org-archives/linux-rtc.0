Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B3381EA3
	for <linux-rtc@vger.kernel.org>; Wed, 29 Jul 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366016; cv=none; b=sT9z20RqI/R6T0UpKEjc2xgESPlAUD7kj7zTwjBTUUAqxbtjfHnCpK2y/aAh017dZbDZ1Jq2/7O0p76ijyJDCQLAd9RXiGl4otmBh0gWD9LFnhlfU6VvhQKbRjFRx2SAtOY/rwD/4FCuzyLUgOXpWBHzPYlzq+rcyF9xFu/u0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366016; c=relaxed/simple;
	bh=Q0bSGh94Pwsws5TBctw5LL/bAsIqiCdVGNy8+NgoqIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQM69/Isz9HzzHI5N3OlzI0KVECZ/5sCFPZTC1n/uFuo2PQPYxLtmX5rZUVBm8PPcbECnuDBxqIk9MHwtPuzS+N7TF7OcnBTb6aqg7lXv0Xc+3Iu3sRsyfgexAqS2u0YAgUuPNlIJXpN3DI4mACAGhBDmkBU7+hXm8xpnP9zomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD8YClx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD8YClx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B01F000E9;
	Wed, 29 Jul 2026 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366013;
	bh=Th+/KNBmyymov1ZYsSaK5ctL6+0yc3ieCdkEeStVrIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GD8YClx98dIwhsCRxDgdQIzcgb139OIB2yUkENzRd0z18PwAd/IYW2wcecfNl4MBR
	 dqH9dAy4lUaOu9NRCkHZE3on8MQg+YQ5w8Z2Cl6mC4wiwTWQ8eWWgfIPkARgMjWwOh
	 0W1iCCG2aCOU3CjCMQh/FNW1y69PiKA6uaVC17ZEHYokiTkUQ4T3E0DMZ8jchfpCMd
	 4d9MJGW/fhWEX4gO+QWyb3R00zj+JdVI0tqGZ6KcYshuyIwRhuQNqpPkfvrgCDmtC2
	 32vNdqa8vGJHOSFT28WviA9MzgFuQpL4nB62bt9ZF68ewy+foxIpl/ZAIP702EUFOU
	 9czKf/5D2KXzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260729225159.775183-1-rosenp@gmail.com>
References: <20260729225159.775183-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 23:00:12 +0000
Message-Id: <20260729230013.562B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the child watchd=
og platform device is not unregistered when the RTC driver is unbound, lead=
ing to a resource leak, sysfs name collision, and a deterministic Use-After=
-Free or NULL pointer dereference.
--

--- Patch [1]: [PATCHv3] rtc: stmp3xxx: use devm_platform_ioremap_resource(=
) ---
commit 901eb0948c2584d64b7584f8b8da4d7f0a425840
Author: Rosen Penev <rosenp@gmail.com>

rtc: stmp3xxx: use devm_platform_ioremap_resource()

This commit replaces the open-coded platform_get_resource() and
devm_ioremap() sequence with a single devm_platform_ioremap_resource() call.
It also moves the mapping ahead of devm_kzalloc() to handle errors earlier
and removes irq_alarm from the private struct.

> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index 7afcd14aeee56..a8ca681b574f5 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c

[ ... ]

> @@ -354,13 +350,10 @@ static int stmp3xxx_rtc_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(rtc_data->rtc))
>  		return PTR_ERR(rtc_data->rtc);
> =20
> -	err =3D devm_request_irq(&pdev->dev, rtc_data->irq_alarm,
> +	err =3D devm_request_irq(&pdev->dev, irq_alarm,
>  			stmp3xxx_rtc_interrupt, 0, "RTC alarm", &pdev->dev);
> -	if (err) {
> -		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
> -			rtc_data->irq_alarm);
> +	if (err)
>  		return err;
> -	}
> =20
>  	rtc_data->rtc->ops =3D &stmp3xxx_rtc_ops;
>  	rtc_data->rtc->range_max =3D U32_MAX;

[Severity: High]
This is a pre-existing issue, but does the child watchdog device registered
further down in stmp3xxx_rtc_probe() outlive the RTC device if the driver
is unbound?

Looking at stmp3xxx_rtc_remove(), the child watchdog device is never
unregistered:

static void stmp3xxx_rtc_remove(struct platform_device *pdev)
{
	struct stmp3xxx_rtc_data *rtc_data =3D platform_get_drvdata(pdev);

	if (!rtc_data)
		return;

	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
}

Since devres will free all devm_ managed resources (including rtc_data) when
the RTC driver is unbound, but the watchdog driver remains active, could
this cause a use-after-free or NULL pointer dereference?

For example, if the system shuts down after unbinding the RTC driver, the
reboot notifier in the orphaned watchdog driver could trigger:

drivers/watchdog/stmp3xxx_rtc_wdt.c:wdt_notify_sys() {
	switch (code) {
	...
	case SYS_POWER_OFF:
		wdt_stop(&stmp3xxx_wdd);
		break;
	}
}

Could this attempt to access the freed parent data when it dereferences
rtc_data->io?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729225159.7751=
83-1-rosenp@gmail.com?part=3D1
