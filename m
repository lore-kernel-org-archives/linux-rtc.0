Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025296;
	b=2wWun32pmcnWhko3Rddk/1mFCxICGm+xsomCnZJ1Kl4mHg5STUkxtBKRhzhzCWofp0Tu
	 GLFFH7+2tZ/PG4eBLyXf4Fu+r5JUQu81iYcp0xtiDJLAKbi7mJOvjahvG00d5+P682m/o
	 Euk4dGSGmj0DOKCWkaCsQBnaHKKGd3nQah7khfw9lpIGK7TgzxfvmooRE6Wl6Mt46zz+s
	 ORqKR3xzVak0nWZp7GoZowpM+nuAPb+3fJ7uYtMTEEXU2KfGemduF7rfvDehkhsERBuo3
	 fal985mTUE+5H9fy96/sdtOMG2xXkfslVQOEkUNre3opRwQgHOiJkTMFuHaFeCyjyPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025296;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Z3enWDQudpSNbKvA16GqEe3rRa33DMzA4M8NFFeCVw8=;
	b=lgLsQmaanJHMHYcRh6cUuC1dtU9Nkv9GDn29Wpul3lrM9wVH3Q7M7J4Kbq+lPjTtWsJD
	 p43p5G7hEMmZiD9YBC01HYPVkkLr277vd8gEjXhmEzNARO9opp/nAC4N1vDK2Kq7Kvm90
	 X24UewZ3zS1lNstavAaAvmrWlohd8Pi7dyefd4ASayls0kdc3dfuaTfvl/FCyhntSIjBa
	 sf0w+frvLV13RB4Yrec5Y9yiX2yuhGaN04lHTc3WYr229AS1v6S1N6MEbu9Z4bmL8K/5E
	 Za1DfK0I2H05V02oUI00fHBl/1nB5QCg87+dAEo7NO67Zk8Lpel9JLAuBFOrsuMjcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OeLsKJR0;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD0606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2DD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OeLsKJR0
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4A3B920B7166; Mon, 26 Oct 2026 07:34:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A3B920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793025285;
	bh=Z3enWDQudpSNbKvA16GqEe3rRa33DMzA4M8NFFeCVw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeLsKJR08xUqkZJOlGTgmbCQd5bJE3TWpl5r6iYJsqIMN3IM5unwEJsseRnA1UDA0
	 C7++WQ6geo46BPU2pkbogRW949JMaotxck/zFHRlVwvAJ1c9btD6D4Gk7TS5RZ3n07
	 +usalLKIma65dM4pW33tI7KNFp7XAXfADegKRNbY=
Date: Mon, 26 Oct 2026 10:34:45 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
Message-ID: <at9lBfs9Ll0jImUP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
 <20261023212218.2568858-2-hamzamahfooz@linux.microsoft.com>
 <sashiko-outbox-183260@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-183260@kernel.org>

On Fri, Oct 23, 2026 at 09:30:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] rtc: efi: ACPI_TAD dependency disables RTC_DRV_EFI in arm64 defconfig
> --
> 
> commit 43949693bace16600c49e8c7dd525850e1286516
> Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> rtc: efi: defer to the ACPI TAD if it can drive the RTC
> 
> This commit updates efi_rtc_probe() in drivers/rtc/rtc-efi.c to return
> -ENODEV when acpi_has_rtc() is true, and makes RTC_DRV_EFI depend on
> !ACPI || ACPI_TAD.
> 
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 1e863f1d36fd5..26f057f52ce59 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1262,10 +1262,14 @@ config RTC_DRV_DA9063
> >  config RTC_DRV_EFI
> >  	tristate "EFI RTC"
> >  	depends on EFI && !X86
> > +	depends on !ACPI || ACPI_TAD
> 
> [Severity: High]
> Does adding "depends on !ACPI || ACPI_TAD" here cause CONFIG_RTC_DRV_EFI=y
> to be silently dropped in arch/arm64/configs/defconfig (and existing
> configurations with CONFIG_ACPI=y and CONFIG_ACPI_TAD=n)?
> 
> In drivers/acpi/Kconfig, ACPI_TAD has no default and depends on SYSFS and
> PM_SLEEP:
> 
> config ACPI_TAD
> 	tristate "ACPI Time and Alarm (TAD) Device Support"
> 	depends on SYSFS && PM_SLEEP
> 
> In arch/arm64/configs/defconfig, CONFIG_ACPI=y and CONFIG_RTC_DRV_EFI=y are
> enabled without setting CONFIG_ACPI_TAD, so this dependency causes Kconfig
> to drop CONFIG_RTC_DRV_EFI while leaving CONFIG_ACPI_TAD disabled,
> resulting in neither rtc-efi nor acpi-tad being built. It also prevents
> enabling CONFIG_RTC_DRV_EFI when CONFIG_ACPI=y and CONFIG_PM_SLEEP=n (or
> CONFIG_SYSFS=n).
> 
> Since include/linux/acpi.h already provides an inline stub for
> acpi_has_rtc() when !IS_REACHABLE(CONFIG_ACPI_TAD):
> 
> #if IS_REACHABLE(CONFIG_ACPI_TAD)
> bool acpi_has_rtc(void);
> #else
> static inline bool acpi_has_rtc(void) { return false; }
> #endif
> 
> should this use "depends on ACPI_TAD || !ACPI_TAD" instead to avoid the

Ya this seems like a better fit since it deals with the reachablity issue
while not making acpi-tad a hard requirement for rtc-efi.

> CONFIG_RTC_DRV_EFI=y and CONFIG_ACPI_TAD=m reachability mismatch, or if
> ACPI_TAD is meant to be required whenever ACPI is enabled, should ACPI_TAD
> and defconfig be updated accordingly?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com?part=2
