Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791013;
	b=kGcjH9HHj2WKHZ4pnwPbhfEgt/jJcGoIZarD1hLBBkLKOmzE26KkYI1WzRSJmr5viRBk
	 LmKeZZ8NR7WyGIm5XK7OqpSM6PpAPh1/ax+Nyad760nlN2jLoz2CfnwDHlwOVe4Mv+i5L
	 Hl0OebMXDtNEPT4Bj4rgZeE1/y7klxdMpMx2JjJnDQGdlxTFwdMtNVX+eMzEHkV6itLdk
	 K0uTraamOqqMZMkhqyIS59VsrxuZ8dzWUHkUqDoWLbVmwJ5iwMykbNJglFt5um1NVhwD/
	 Gt/I2+PVawGJwLFfcOvvnbKwNoESYRpEb9zvPj/LITIeEbxOJU9Ldr+GPOqNp9iWd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y/5octX+n/8CgN+e6Sxo3qcS02L5T0v/vVxNRBKC7MY=;
	b=S0vYdv2UdqX+tHBV764K6JioYy7uoLdVO0oRcvhhFspNOizTz6MLs20uxf+zowWMF+Z4
	 LD5QbnYJ/UBNPQmjHvlJU/O5OR/wZsa1yMkYGHPdWunhMe3wXZWh4Zbb71ZftaC4u4DOz
	 wMqD5o2nNadk0vMTZ28wD58yEbKNNn++BrkDuu/STFziRL7rKmVM2McIh+D3HEYzocpzK
	 1kOWLuLuEdEL75JvfyvTFuQhMbfRVKsSHFFHYWpcsTszNoFTawdlnuRmeocKWo2cvH2RE
	 d5w/vZrVHA4Fxz27VmccQ8KxH72XhdHpKgcUy+KDmyymS+hMmDqPjdWl4HOiKSrCp2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABfRYrAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9F606A31B
	for <linux-rtc@vger.kernel.org>; Fri, 23 Oct 2026 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABfRYrAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4683F1F01829;
	Fri, 23 Oct 2026 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791012;
	bh=Y/5octX+n/8CgN+e6Sxo3qcS02L5T0v/vVxNRBKC7MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABfRYrAyNjmEYY8bwGE8ImWrmbeZT6v9TTy872wYgv17CvEY9FCa6W2kjxbZm03Ip
	 pisoOLL0OXdjCWFmUb9FhK9f8f9MCFBXIpzMxyhoUxYmrOKlF2mySn1sKVDaNSWmnu
	 HM8tQQfOrDCBiv2phx0xaYKu9LriP4olM0oq+XCXA9w0NUn0RTN4Uy9f9VQm31p0OJ
	 Rp4T7JzQ5e8EEfA9KZEjD+LrTLxLtDv63XPT9zbiIyEsXHbnvJ1H5xCxfQCzxG/b1p
	 Wz9fCxC65ukGC+FGaM9VlTXm+FlBwR5WwSYYKgFy0ZFmSk0BVY0ID7hYgoWbU/GvGq
	 fzZlkrWsbqfBQ==
Message-ID: <sashiko-outbox-183260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261023212218.2568858-2-hamzamahfooz@linux.microsoft.com>
References: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
 <20261023212218.2568858-2-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 21:30:11 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: efi: ACPI_TAD dependency disables RTC_DRV_EFI in arm64 defcon=
fig
--

commit 43949693bace16600c49e8c7dd525850e1286516
Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

rtc: efi: defer to the ACPI TAD if it can drive the RTC

This commit updates efi_rtc_probe() in drivers/rtc/rtc-efi.c to return
-ENODEV when acpi_has_rtc() is true, and makes RTC_DRV_EFI depend on
!ACPI || ACPI_TAD.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 1e863f1d36fd5..26f057f52ce59 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1262,10 +1262,14 @@ config RTC_DRV_DA9063
>  config RTC_DRV_EFI
>  	tristate "EFI RTC"
>  	depends on EFI && !X86
> +	depends on !ACPI || ACPI_TAD

[Severity: High]
Does adding "depends on !ACPI || ACPI_TAD" here cause CONFIG_RTC_DRV_EFI=3Dy
to be silently dropped in arch/arm64/configs/defconfig (and existing
configurations with CONFIG_ACPI=3Dy and CONFIG_ACPI_TAD=3Dn)?

In drivers/acpi/Kconfig, ACPI_TAD has no default and depends on SYSFS and
PM_SLEEP:

config ACPI_TAD
	tristate "ACPI Time and Alarm (TAD) Device Support"
	depends on SYSFS && PM_SLEEP

In arch/arm64/configs/defconfig, CONFIG_ACPI=3Dy and CONFIG_RTC_DRV_EFI=3Dy=
 are
enabled without setting CONFIG_ACPI_TAD, so this dependency causes Kconfig
to drop CONFIG_RTC_DRV_EFI while leaving CONFIG_ACPI_TAD disabled,
resulting in neither rtc-efi nor acpi-tad being built. It also prevents
enabling CONFIG_RTC_DRV_EFI when CONFIG_ACPI=3Dy and CONFIG_PM_SLEEP=3Dn (or
CONFIG_SYSFS=3Dn).

Since include/linux/acpi.h already provides an inline stub for
acpi_has_rtc() when !IS_REACHABLE(CONFIG_ACPI_TAD):

#if IS_REACHABLE(CONFIG_ACPI_TAD)
bool acpi_has_rtc(void);
#else
static inline bool acpi_has_rtc(void) { return false; }
#endif

should this use "depends on ACPI_TAD || !ACPI_TAD" instead to avoid the
CONFIG_RTC_DRV_EFI=3Dy and CONFIG_ACPI_TAD=3Dm reachability mismatch, or if
ACPI_TAD is meant to be required whenever ACPI is enabled, should ACPI_TAD
and defconfig be updated accordingly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023212218.2568=
858-1-hamzamahfooz@linux.microsoft.com?part=3D2
