Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCD351C3F
	for <linux-rtc@vger.kernel.org>; Fri,  3 Apr 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232561; cv=none; b=heepi3TTyo0vlwevtOlDowTES5AMNEnWktYVcJoF14ruDURP+w748hMaVvdvsFLxcMr1zTNp7X3Q58/xCYD7Wo9BVVKqmZyd5DAfHOZN+kJAC+Zy6j2ArgDW6O/CbWPa0abOdShNTdZEjV/NRORABjGYaiQMQDvMEPmGq3M2rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232561; c=relaxed/simple;
	bh=Mozm54e3kj3ylhz+hlP2Ai7Qimo66RJX8Q/qoWOZKQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUL+NzwswSOfLwWYWUgK0UgfeFIR1C1wnVJIaPwJOmr8hpucR58Ad3caiSvf2oWf8JiNfWTjRxU0pFQl1fEYVe7cU746GDK9bMhqTmBcGDsIJpmvMFW700NAizMC/jwFfgur59rKM3lx7CW/suAy29dOzRd0ZEh0iQCT3jx9ZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wnLEoN5I; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wnLEoN5I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56BCA1A312B;
	Fri,  3 Apr 2026 16:09:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E530603C1;
	Fri,  3 Apr 2026 16:09:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B503104500F6;
	Fri,  3 Apr 2026 18:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775232558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/t44091BTuiGA/3IotE5ahSTrak5+O9l8783U0Gxdo4=;
	b=wnLEoN5I/fgGR+GFWNYkKR30wuVXzVo4sFfBtEQKpoQA9acxFit/ThAnhnepGj/YFS0GsC
	vmABI7GC2xDDyduKZ41xp99UCjNTHslZX3iRCXxRyfIlZU8ufAL5l1661OoppAVqcssp3q
	9T4/h0LpT1PGH6hpdAOCelUcWyhhCVf55e8wL45AaKoSebj+WYvucCUFHSy9MIdV9OaI06
	wIMuBWR87gsFNzfN2hEl9Y0Q+9Is347FRrIDoRN0TrpIa79F5NbDHFHHbGFUPr7DwgPv28
	IEc+zdQglYr/NDa4hBdTmi1LU2A9AKRUK91wFOrEbbjpIphR3GBMxm5o/SLsSw==
Date: Fri, 3 Apr 2026 18:09:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in
 cmos_platform_probe()
Message-ID: <177523251876.1559844.3350200076617485072.b4-ty@b4>
References: <12857714.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12857714.O9o76ZdvQC@rafael.j.wysocki>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 04 Mar 2026 13:55:43 +0100, Rafael J. Wysocki wrote:
> The rtc-cmos driver can live without an IRQ and returning an error
> code from platform_get_irq() is not a problem for it in general, so
> make it call platform_get_irq_optional() in cmos_platform_probe()
> instead of platform_get_irq() to avoid a confusing error message
> printed by the latter if an IRQ cannot be found for index 0, which
> is possible on x86 platforms.
> 
> [...]

Applied, thanks!

[1/1] rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()
      https://git.kernel.org/abelloni/c/92bad323175e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
