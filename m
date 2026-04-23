Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C533D6E1;
	Thu, 23 Apr 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976223; cv=none; b=qA2zJyDoU3zDaTZ1hsoBuVOlmdcInzwPViyDn1I8PIt2SxIdc0oaDefyyub+X3zAhfHRoj3sTnDwX9g+GJOnWN0ao/FxqKQGjl+O/6ZijF1+WeVRdKigUMPeu2+qGRuwW1sWR4R5S5nvlVX8c8bjjFam3YxgbpD80tBM2456YZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976223; c=relaxed/simple;
	bh=aOPZRoaDFMyw7xMYGt//8RvLBOMjN18KzZftyAuEx2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKfihqERptGokzXiVRJLxxwqXleAtli9D/oDyT+Qvxd5pOtBPBfp4EnoG1qq1iOyhe/kEUfac43Wz/iKHhXCYtjsqi7xQ9ZPhyhf2iMANxm6Q+szD97cS0w/xucx+sFbpKXhDXAbuCimC40RuihiG+K49BstT+DF4U4T9A4LGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ow64udvD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ow64udvD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 688F7C5EF15;
	Thu, 23 Apr 2026 20:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0286F600DD;
	Thu, 23 Apr 2026 20:30:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2A7810720636;
	Thu, 23 Apr 2026 22:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776976218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Qk4iIJsTRqwNAecFhUCmL54kBm8GhkDY+d+oOXae5Dc=;
	b=Ow64udvD70hGHYnvXqJWHf9WaFjPR1ZQrIuUMlVXzarGyAXpUjBn8viDHdZVmPJxp/s3AE
	IPD0pajaf5CumjJ4xoR/88c9YyaUX7ZKL6JVmrjxuBp4rNBPr9FQawImsMNT+40mVOJAoD
	lw4oWj3HFKkS+w3WMz3ia/JAIT/MydgMbX2VZ4pV+IPIkRNKoSCbwZrNIkQgu2JKRCo1r5
	ig3QNyxhSPBKQ51+JAQ1+BBKPDyB8GTEFjHwPIwpd39YCZjGORc87muIipzymeMAghZaLS
	QcP8xa7vy/BDdDq1gtffxllNn3UzcFxUdvJYkLF886q4IPhFDFmta75LDdcoog==
Date: Thu, 23 Apr 2026 22:30:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, linux-rtc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] ACPI: TAD: RTC: Refine timer value computations
 and checks
Message-ID: <20260423203017d25ac200@mail.local>
References: <2415066.ElGaqSPkdT@rafael.j.wysocki>
 <3414608.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3414608.aeNJFYEL58@rafael.j.wysocki>
X-Last-TLS-Session-Version: TLSv1.3

On 22/04/2026 17:26:49+0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since rtc_tm_to_ktime() may overflow for large RTC time values and
> full second granularity is sufficient in timer value computations
> in acpi_tad_rtc_set_alarm() and acpi_tad_rtc_read_alarm(), use
> rtc_tm_to_time64() instead of that function, which also allows the
> computations to be simplified.
> 
> Moreover, U32_MAX is a special "timer disabled" value, so make
> acpi_tad_rtc_set_alarm() reject it when attempting to program the
> alarm timers.
> 
> Fixes: 7572dcabe38d ("ACPI: TAD: Add alarm support to the RTC class device interface")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/acpi/acpi_tad.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -680,9 +680,8 @@ static int acpi_tad_rtc_set_alarm(struct
>  
>  		acpi_tad_rt_to_tm(&rt, &tm_now);
>  
> -		value = ktime_divns(ktime_sub(rtc_tm_to_ktime(t->time),
> -					      rtc_tm_to_ktime(tm_now)), NSEC_PER_SEC);
> -		if (value <= 0 || value > U32_MAX)
> +		value = rtc_tm_to_time64(&t->time) - rtc_tm_to_time64(&tm_now);
> +		if (value <= 0 || value >= U32_MAX)
>  			return -EINVAL;
>  	}
>  
> @@ -745,8 +744,7 @@ static int acpi_tad_rtc_read_alarm(struc
>  
>  	if (retval != ACPI_TAD_WAKE_DISABLED) {
>  		t->enabled = 1;
> -		t->time = rtc_ktime_to_tm(ktime_add_ns(rtc_tm_to_ktime(tm_now),
> -						       (u64)retval * NSEC_PER_SEC));
> +		rtc_time64_to_tm(rtc_tm_to_time64(&tm_now) + retval, &t->time);
>  	} else {
>  		t->enabled = 0;
>  		t->time = tm_now;
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
