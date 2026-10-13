Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703C4FD78F
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893739; cv=none; b=txggx3S+kG6s6TKqLG9X4yFmiVUXFfo6K4IuszzCkKwRaoOqBQ+8dfZBi7U7WK5t9/MuVqsg/0RNT28gViKmAY3aXharoFPrE0uSbbDDtjuztJHw8/9gK9/GtPm36iyWDBqXKcQg4jyrvzfDu2nE0oM4eJsaXoyzpKrSa2qC7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893739; c=relaxed/simple;
	bh=cPN/VbP8iupPV9zblhslcdoIaCFcJH6dqalYJpQeGtc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a+80J+UFNirLBJfmpILGIkq+16cYPn6S47g04oM3CfP/ckypTfGFqLw72P3wODDVcLWY1bk718hwBtU2ha4t4LCRzoBXVDBQoU29Lx7mHbCTh13Bhv0AfE9X7sEf4lexnTH7OvUl67Nt9Cu2/7sJ3eUMV2v1yNX+QUD0tNF1w1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOmhyA+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOmhyA+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727CF1F000FF;
	Tue, 13 Oct 2026 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791893738;
	bh=NU5utGNucUi5LWxYxQj4PEg27qzGGT3Kkoy9qCkxzy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOmhyA+3cFLPi7UE53iawFQW/tAVZW6e4Sg78ucLcpow433PRvPrRP525ubX7qfLj
	 1DvCgbEROfCTWFMNU4MZmoudJk+49qPlOgINtNrVcOtTfqOYJNswWW/2iKUJnfGu6T
	 fw1/tADrKjK46zQT3KOytezVjt6IT/TsMYHKx3xsz9Up/rHhDd+xPv9PqextpNIlF1
	 BTkJw0O/fHuxZLYyM2+g2efAM+H7AzaePLsKeOPm/CziPbuoUFuSxUkPtZknZRf2Sv
	 rUrGUVMsAs/LZK0+OKO5TPchSv8mEou6oLgB3KzRgWchzjg0nuYRT6OJ0bCIhrM9UU
	 fI80cAot7sN8Q==
Message-ID: <sashiko-outbox-169684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] rtc: ds1685: arm the wake-up alarm at power-off
 only if an alarm is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261013120208.11268-2-kaloz@kernel.org>
References: <20261013120208.11268-1-kaloz@kernel.org>
 <20261013120208.11268-2-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:15:37 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: ds1685: NULL pointer deref in poweroff handler if unbound
--

commit e81b71e9197dea1b3b5991740fdeeb891e509522
Author: Imre Kaloz <kaloz@kernel.org>

rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set

This commit modifies the DS1685 RTC driver to only arm the wake-up alarm
during power-off if an alarm is actually set. It prevents stale alarm
registers from inadvertently powering the machine back on.

> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 5fc8e36b1abf8..94c89333c5d5c 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -1367,7 +1367,7 @@ module_platform_driver(ds1685_rtc_driver);
>  void __noreturn
>  ds1685_rtc_poweroff(struct platform_device *pdev)
>  {
> -	u8 ctrla, ctrl4a, ctrl4b;
> +	u8 ctrla, ctrlb, ctrl4a, ctrl4b;
>  	struct ds1685_priv *rtc;
> =20
>  	/* Check for valid RTC data, else, spin forever. */

[ ... ]

> @@ -1394,6 +1394,8 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>  		ctrla &=3D ~(RTC_CTRL_A_DV2);
>  		rtc->write(rtc, RTC_CTRL_A, ctrla);
> =20
> +		ctrlb =3D rtc->read(rtc, RTC_CTRL_B);

[Severity: High]
Can this lead to a NULL pointer dereference during the system poweroff
sequence?

If the driver failed to probe or was explicitly unbound via sysfs,
platform_get_drvdata(pdev) will return NULL. When the global shutdown handl=
er
calls ds1685_rtc_poweroff(), we fetch the driver data and dereference it
without checking:

        /* Get the rtc data. */
        rtc =3D platform_get_drvdata(pdev);

        /* ... */
        if (rtc->irq_num)
                disable_irq_nosync(rtc->irq_num);

        ctrla =3D rtc->read(rtc, RTC_CTRL_A);

Could this hang the system instead of powering off by causing a panic when =
rtc
is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120208.1126=
8-1-kaloz@kernel.org?part=3D1
