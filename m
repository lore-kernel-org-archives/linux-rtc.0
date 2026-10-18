Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008B4746AC;
	Sun, 18 Oct 2026 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335984; cv=none; b=YLOs5F2E3q/dkwY3/A6Ohga7i4h1a2f2tWpDfTe/ntCGJJivYV79j2aRbD9DPq3IF5lVlsT11f4ENP+A6ymyRb1fqTmRRiQ8DA3tYx5rrMgTBcUxIsWNbQ2XOGwZ0qh66wmR3SSzLXO/Am4rFCyyLisk1bL1iJOBntjfoRHMxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335984; c=relaxed/simple;
	bh=e980C/IZej1RK/Yze4TuOqCtgrkM2JOP9JmPbJjpprc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qMSpTuoINWs0fwcd6iboyzsO7u+0GZNMc19kSGIGjUbTTkaAgIWo5rDIUzPbsNWSlOS5sDzcVEq0DKSEanwopnCA/P3gzpREInMKUBmURCTK60n4HVVxNn/6+oDkPJlmvLPeakekpPYrIjk6ZAObVOeGySVPhqsLgdVW2QahfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjGJdy86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjGJdy86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999931F000C5;
	Sun, 18 Oct 2026 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792335982;
	bh=pqYNmdw7orki98zxgCy5n3pePd2kAylkGZsp9Uv4pUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjGJdy86D486trAJuD9GMtnBqUcOVUX++ky6qGiJULcEjT69HHnboOyoBt6gFkkwa
	 gf1KTy/zRpQ3J2RqIbi0603iZNDqSoSFED1E7sjC4njYUU6ZpP7RxpmEFAM2NZ32s3
	 B63fCsfqW/lTPajZRTune2J+cLWHBbBmC3p2MSa82Jkb01QxUnxipss809h7Q2Zt4H
	 acLPudpkN3CL288MJE14pKLUXETX9X5I6M9eK64aVGaWY2fO+NZ2BpcutZSnGtYxjo
	 8Mu+CLzsrPoaKLkoe/dIp5xtyYhTM7g/yN8j4YLJSHDlXeX4rJfiBJ84gMhnYTHQ0s
	 Y6goIbQQbWNog==
Message-ID: <sashiko-outbox-176229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018150028.1047172-4-sander.speetjens@gmail.com>
References: <20261018150028.1047172-1-sander.speetjens@gmail.com>
 <20261018150028.1047172-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:06:22 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: Kconfig RTC_DRV_RPI depends on non-existent ARCH_BRCM2835 sym=
bol
--

commit a6bed19cc6f6abde9685896060e26f766fe6119a
Author: Sander Speetjens <sander.speetjens@gmail.com>

rtc: Add Raspberry Pi 5 RTC driver

This commit adds an RTC driver for the Raspberry Pi 5 custom DA9091 RTC,
accessed via the Raspberry Pi firmware mailbox interface.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b94189..b4ed5ebea11a1 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
> =20
> +config RTC_DRV_RPI
> +	tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWA=
RE)
> +	depends on ARCH_BRCM2835 || COMPILE_TEST
> +	default ARCH_BRCM2835

[Severity: High]
Should ARCH_BRCM2835 be ARCH_BCM2835 here?

No Kconfig symbol named ARCH_BRCM2835 exists in the tree; the platform
symbol defined in arch/arm64/Kconfig.platforms and used by
config RASPBERRYPI_FIRMWARE in drivers/firmware/Kconfig is ARCH_BCM2835:

	depends on ARCH_BCM2835 || COMPILE_TEST
	depends on BCM2835_MBOX
	default ARCH_BCM2835

Because ARCH_BRCM2835 is undefined, Kconfig evaluates it as n, preventing
RTC_DRV_RPI from being selected or defaulted on Raspberry Pi builds unless
COMPILE_TEST is enabled.

> +	help
> +	  If you say yes here you get support for the RTC found on
> +	  Raspberry Pi 5th gen devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-raspberrypi.
> +
>  config RTC_DRV_STM32
>  	tristate "STM32 RTC"
>  	select REGMAP_MMIO

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018150028.1047=
172-1-sander.speetjens@gmail.com?part=3D3
