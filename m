Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233407;
	b=mOhQFB3X4vyXrbXjwNGS8qs0K86NCd3oGkF7I4z8am/Ltng7Gr2CSVQK3MHB9a+TWrAi
	 WIxMk1RUgT6HpBqUYy2edVljz6WY2Oa5tONcgMOk0WRPTtDCFPsGv4Zr3eGLm4M/F/0A5
	 pOUdGtKRZDLF04EwfhDALKFsf7tFJcWFSj+vprKiPsJ+PMonm38fN+tRQCWbD6H8bXSYi
	 VzaJy+7RrjIeAMKyrMnYUBInJWSRjMHWN0KipOAKV1M3TAc6fgQrIsre7ykf6cIJu+6aj
	 Szg5vJmfX3yAjwX5A9v57GrDKjDdD1LQqSvOEAjdhOu05petMABSujIfhRqDzmj9deA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233407;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/r36U/YZbO3NFa17bnpPbQOWChW1in8WcBpC5j5CceI=;
	b=zhNuReXozpaW0x4Mv++bZT12VDS/hgsg9Q+b5MZSZ5K3ZqThS3YLDhVEBo6obKzYeso1
	 47RSCVWy9VXlFC8KlP4pd4hjuwS9c6akc3NwM6tjGOUQiCtup9CYEmpH+EpdnoAjzNe17
	 kNGlbo/gQXvo4CtTkzg9wWQJoOlOTo6TbJ5OK+9uS7x36thzWU8GUYM4sxsmeAIp2U0S7
	 OKubmjiGua0YQoTPhs6NT0WfdtsNEqrTHbmODOp6amlp7FX3B5N0uEKpDV3jeJLe1LmnN
	 q95ara7Neq6g/DZAz/PfAm8zgD1Hvx3HscXY89hllQ0LATKW3KezlHiZLR7j4CJA3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=LUTzsTCp;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2B606D83A;
	Mon,  9 Nov 2026 14:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D2B606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=LUTzsTCp
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 701C920B7168; Mon,  9 Nov 2026 06:09:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 701C920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794233398;
	bh=/r36U/YZbO3NFa17bnpPbQOWChW1in8WcBpC5j5CceI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUTzsTCpZLUWKfh0RXA4zyK6kypRKutk8i7c7EI8s7UDIzGaiv89NRHPiPVSmRo1b
	 xyxjdvpfZZv9wd7oBxGGznU6oM/05Sr2aRt//9ag4O7IT3brrbNPvAa5oK/PtBCvpi
	 qyS+MpqzTa1Ib58tXQgkWOHPtfVB7epFHgDwrqT8=
Date: Mon, 9 Nov 2026 09:09:58 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 0/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
Message-ID: <avHUNhepm/Qowd1E@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>

On Tue, Oct 27, 2026 at 06:05:34PM -0400, Hamza Mahfooz wrote:
> On Microsoft C2141 and C4143 systems, the EFI GetTime() runtime service
> faults when called by rtc-efi, which causes all EFI runtime services to
> be disabled, even though the RTC can be driven via the ACPI Time and
> Alarm Device (TAD) instead, which acpi-tad registers an RTC class device
> for since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
> interface").
> 
> As suggested by Ard, add acpi_has_rtc() to the TAD driver (patch 1),
> and make rtc-efi decline to probe if it returns true (patch 2).
> 

Ping?

> v2:
> - Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
>   acpi-tad (which allows us to simplify it quite a bit) and declare it
>   in linux/acpi.h. (Ard)
> - Add acpi_disabled check. (Ard)
> - Make rtc-efi decline to probe instead of not registering the device in
>   efisubsys_init(). (Ard)
> - Make RTC_DRV_EFI depend on !ACPI || ACPI_TAD. (Ard)
> v3:
> - Make RTC_DRV_EFI depend on ACPI_TAD || !ACPI_TAD. (Sashiko)
> v4:
> - Move acpi-tad code to existing CONFIG_RTC_CLASS #ifdef. (Rafael)
> - Add IS_ENABLED(CONFIG_RTC_CLASS) case to linux/acpi.h.
> 
> Hamza Mahfooz (2):
>   ACPI: TAD: introduce acpi_has_rtc()
>   rtc: efi: defer to the ACPI TAD if it can drive the RTC
> 
>  drivers/acpi/acpi_tad.c | 48 ++++++++++++++++++++++++++++++++++++-----
>  drivers/rtc/Kconfig     |  5 +++++
>  drivers/rtc/rtc-efi.c   |  4 ++++
>  include/linux/acpi.h    |  6 ++++++
>  4 files changed, 58 insertions(+), 5 deletions(-)
> 
> -- 
> 2.56.0
