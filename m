Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609F352003
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336926; cv=none; b=u+EavSSjXOK1IbI7SdCqTFPRDbKU0TbK3935qouLqq5RHO7MWRQqgBPMRncWAdqUptew4Arm6QYfmxw6GAQV+CgWQTglePV8O55wc7pr2MG8Egj8GSYZwtpb8hKyFNv4kQ407azui9HFPs3JMv7EWyJQs8tNpCClBYguQR5D3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336926; c=relaxed/simple;
	bh=36qPjISO5WeswNAanrvrIHPPoAoTnsyqc7+22GyuUFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnVrdcVsMGgq8XT3rvapwTMt03wEX3+Crzaaxx4bhvxShaxmPSxv7UFz+L0wpGSHsOXWIYkC30mmRwsbnep54Y3JXTp78Ro4UQ63AX2+Q/qQ144APBWGQdkA+g0/F9cYwOzMsMmCziOPOCERVLdfJkSjAME3I1T4QujbkSuv6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MABekBlu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MABekBlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC41F000E9;
	Wed,  2 Sep 2026 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336924;
	bh=zb2Pf3nxs5kNiKJ6F3BYdCuSgTq0LmZenp2FdFt4R0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MABekBlupvG/rGRCWBCdrvQWQXVUImYBMesJFkNmdOfYjrDJXbQINVw5P3gK3OPG+
	 rrTGReRkzGKHrc9iw1HBR+mJhNtdfPGxZUFdS5QDnMA8XC1SbLNAqNcSf7wEKe02al
	 spsmPDvp+h0bw2FDv+4gFkbeNLJgofEAKLWOEWcty/fFjgoo5yHluQRuQyYhBdAbma
	 M6rOwz1fvd6AghTb49MK2TwdcvmmU9mmJBEEJwnoPJAF6VPmczR8en/iC6tkIkV4YH
	 QVnqX5bqz6mMKr8f7e7njWiUCS0N6U6PZ5mEcZe9E8zRdllS5WBt/VDEkTa4SJY2x1
	 KB8QB05sE+RVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: spear: initialize IRQ state before requesting
 alarm IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260902080318.3498434-1-runyu.xiao@seu.edu.cn>
References: <20260902080318.3498434-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:15:24 +0000
Message-Id: <20260902081524.B5AC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware Access Before Initialization / Missing Clock / System Cra=
sh
- [High] Logic Error / Potential Denial of Service
- [High] Data Corruption in RTC Year
--

commit 4751499f6595bf942675b476a237ee52aa8c59e1
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

rtc: spear: initialize IRQ state before requesting alarm IRQ

devm_request_irq() enables the interrupt before it returns, so the handler
may run while probe is still initializing the device. Initialize the MMIO
address and spinlock before requesting the alarm IRQ.

Cc: stable@vger.kernel.org

> diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
> index 959acff8faff0..d12bccb3cf5ec 100644
> --- a/drivers/rtc/rtc-spear.c
> +++ b/drivers/rtc/rtc-spear.c
> @@ -363,6 +363,12 @@ static int spear_rtc_probe(struct platform_device *p=
dev)
[ ... ]
> +	config->ioaddr =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(config->ioaddr))
> +		return PTR_ERR(config->ioaddr);
> +
> +	spin_lock_init(&config->lock);
> +
>  	status =3D devm_request_irq(&pdev->dev, irq, spear_rtc_irq, 0, pdev->na=
me,
>  			config);
>  	if (status) {

[Severity: High]
This is a pre-existing issue, but by requesting the IRQ here before the clo=
ck
is prepared and enabled later in spear_rtc_probe(), is there a risk of a
system crash?

If a pending or spurious interrupt fires immediately after devm_request_irq=
()
returns, spear_rtc_irq() will execute and perform:

    irq_data =3D readl(config->ioaddr + STATUS_REG);

Since clk_prepare_enable() has not been called yet, the clock is disabled.
Accessing an unclocked peripheral register typically causes a synchronous
external abort.

Additionally, clk_disable_unprepare() is called manually on probe failure or
during spear_rtc_remove() before devres cleans up the IRQ and unregisters
the device. Could this create a similar window where an interrupt fires or a
userspace ioctl triggers a clock-dependent MMIO read on a gated clock?

> @@ -371,10 +377,6 @@ static int spear_rtc_probe(struct platform_device *p=
dev)
>  		return status;
>  	}
> =20
> -	config->ioaddr =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(config->ioaddr))
> -		return PTR_ERR(config->ioaddr);
> -
>  	config->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(config->clk))
>  		return PTR_ERR(config->clk);
> @@ -383,7 +385,6 @@ static int spear_rtc_probe(struct platform_device *pd=
ev)
>  	if (status < 0)
>  		return status;

While reviewing the RTC implementation, I noticed a couple of other
pre-existing issues that might be worth addressing.

In drivers/rtc/rtc-spear.c:spear_rtc_read_time():

    do {
        time =3D readl(config->ioaddr + TIME_REG);
        days =3D readl(config->ioaddr + DATE_REG);
    } while (time =3D=3D readl(config->ioaddr + TIME_REG));

[Severity: High]
This is a pre-existing issue, but does this inverted condition cause a=20
busy-wait loop?

Because the TIME_REG only updates once per second, the loop will spin
continuously as long as the time has not changed, occupying a CPU core
entirely for up to 1 second. Unprivileged local users repeatedly reading
the RTC time could potentially cause a denial of service. Should this be a
!=3D condition to only catch rollovers?

Also in drivers/rtc/rtc-spear.c:tm2bcd():

    tm->tm_year =3D bin2bcd(tm->tm_year);

[Severity: High]
This is a pre-existing issue, but does this corrupt the year value?

The driver advertises support for years up to 9999 in spear_rtc_probe():

    config->rtc->range_max =3D RTC_TIMESTAMP_END_9999;

However, tm_year is the number of years since 1900. If userspace sets the=20
time to a year like 2026, tm_year is 126. Passing 126 to bin2bcd() produces=
=20
an invalid BCD value (0xC6), which is written directly into the lower 8 bit=
s=20
of the 16-bit hardware year field.=20

Furthermore, because bin2bcd() returns an 8-bit u8, years >=3D 2156=20
(tm_year >=3D 256) will be silently truncated to 0. When reading back the
value in bcd2tm(), the year will be misinterpreted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902080318.3498=
434-1-runyu.xiao@seu.edu.cn?part=3D1
