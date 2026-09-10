Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB803D6478
	for <linux-rtc@vger.kernel.org>; Thu, 10 Sep 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032934; cv=none; b=nP0IS9tSixoHfeMomUij604yO0EvBskIQqi7iiRQgPWUZKHVDpRKrKnVFVWYLv39Q5lhLH2KMNZU8hy+HpUcLW4Gf3AIsaIOtjIAIGGUh8XUUHt/Zift8YbbteGUp1momWMY2bIAQunEXDvGKv1Ck35sJ2kOAbc7jbx0/T/+56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032934; c=relaxed/simple;
	bh=BumFbiQVX3CSsxqgqFPn6ARHBL9QqovQi8zHUy8Gk2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfXrT67Tdn3dHJSszwqJhFbKQwP1OUFHCG96lbLqy+MLC7Fe43uZI2NbNAhQaID24iX7TO5s15zaKZRwvdIqYu48j1sEIheLBEaCEJptat4hJdRWIuC56mONXGy27zNg7+8kLFwrGSHRfne8+gGCq0NLnktTVqQO4JaaOcwzCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSUGim98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSUGim98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D681F000FF;
	Thu, 10 Sep 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032933;
	bh=MhYt92CcIUnQM6BhB/xrdIPmtvgmyoCTZHCvaOxjShE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSUGim986OtkbimNpIgagDq5reYhG2dHA2Ui+0/Wl006CkRH167Wpat3ZnrB92sg4
	 9Ln6PUjXfsvQMn+1qHtaJm4RP05vqPvs3cvMXUuasHe+DgHuVypZPh5rsbZ7pWNqlN
	 rvFZ0qIuANUK70QLvUqNC8+rYaxm8wZscZr8poPa7gX4YgcPm6Pt58jzFqkjyWp+qe
	 P3/0CsMRz1wpsxKoW2KkkQMj0p27RR9U3wAqT4TfiRYt+oUNJ52GYkYvh4+MfDDE7V
	 cBAJsxtcLF7NuZLSJQWVkpdCJ2DuMb7IVRYp+lOdvm9J4aOpuVPeqSiIXq0bjBECTW
	 fEqjb/lnVttOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: bd70528: properly enable wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260910092558.1008998-1-andreas@kemnade.info>
References: <20260910092558.1008998-1-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:35:32 +0000
Message-Id: <20260910093533.34D681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The return value of devm_pm_set_wake_irq() is ignored, which can=
 result in a silent failure to enable wakeup.
--

commit 145fe15d42adcccef8370937c9cb325de30fe4ff
Author: Andreas Kemnade <andreas@kemnade.info>

rtc: bd70528: properly enable wakeup

This commit specifies the wakeup irq for the RTC alarm to ensure wakeup
works reliably, rather than relying on the power button's wakeup
configuration.

> diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
> index 482810b61495d..dc86882562abd 100644
> --- a/drivers/rtc/rtc-bd70528.c
> +++ b/drivers/rtc/rtc-bd70528.c
[ ... ]
> @@ -320,6 +321,7 @@ static int bd70528_probe(struct platform_device *pdev)
> =20
>  	device_set_wakeup_capable(&pdev->dev, true);
>  	device_wakeup_enable(&pdev->dev);
> +	devm_pm_set_wake_irq(&pdev->dev, irq);

[Severity: Medium]
Is it safe to ignore the return value of devm_pm_set_wake_irq() here?

If this fails (for instance, due to -ENOMEM during the internal kzalloc() or
devm_add_action_or_reset() calls), the wakeup IRQ configuration will be
silently aborted.

The probe function would then continue and succeed, leaving the device
without wakeup capabilities. Should this return value be checked and
propagated to prevent a silent failure?

> =20
>  	rtc =3D devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(rtc)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910092558.1008=
998-1-andreas@kemnade.info?part=3D1
