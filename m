Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101382DF128
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891064; cv=none; b=NVk8BeDNLUicH4UaJ7gTUB+kS+hEG2TLL+U3VQjXDU+XOwPtrPmNcbASUEmzEl/Wz3tWiHNuhDrZToxvgUSeP7q6rR3TBqWKDyLK9OOjT/+X+6gq2PmMpL1HFqPQ+9Zk2XaT4hI6mwB16GjnqLxSsyVwFx/IPZY2lgHLARNGL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891064; c=relaxed/simple;
	bh=9BXr/n4/ZySZqMqLaZ5551csECR9du4tOg4WTu3M5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAtXcpJuKLyKMKMxnwckcvEbl9olGapALZjsEg68gQqFdpkZ0qstv1kPJsN9Kc5QVy7IpBd99VVEOGkY2cCSjhi69M1G+o9K4RHo5nLKMIh/9JdJL6XkZKKGaE8wiASmHViEkwch7ZHcrZWaP3Q8ogVI6OB+01VkYRrKcRwbX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R3tViBMn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R3tViBMn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E3CE4E41AE6
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 21:44:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD8E56035C;
	Thu,  1 Oct 2026 21:44:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91148103281F9;
	Thu,  1 Oct 2026 23:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790891054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6A4roYCJqLgyAdT2Le0ZQud4Oae8ijT0P6KR6Kzq30k=;
	b=R3tViBMnrJuNTfgpIHJ1OOBh9i9gAx5hYqOXP99smMbbccvIj1feRb67+84o8ovILCksVe
	/ha/HI25U+gyXSSpTGZ36yp964RHYKkTlNVNAJl4E8UrGwVW3j5U7fZNm/QI7Vl1aRh7mW
	gAvycYm+B4rQrNosQHiRKteKyuM4tYPNrgME0Zn93NJHoiGTkyaB+Fvr2a9c94Npji+liX
	+dE0a2E6k39iF1/hKxs8k0uRC09Tff9Cpik+VJVGc8unHZYPHUYyfae0reC4gctGVzfYbB
	+TeLo2PVqjTKG9+lQJquvL0NZcIm/cgIN2squO8B7O4I650vitt2ZwiL2EoYFQ==
Date: Thu, 1 Oct 2026 23:44:12 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Walle <mwalle@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8563: add SMBus support
Message-ID: <2026100121441258ccde92@mail.local>
References: <20260930113126.720555-1-mwalle@kernel.org>
 <20260930114005.2C6661F000FF@smtp.kernel.org>
 <20260930152513dd617b74@mail.local>
 <DLTJ9BRUJFAO.XKH3SG306MBJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLTJ9BRUJFAO.XKH3SG306MBJ@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 01/10/2026 15:24:07+0200, Michael Walle wrote:
> On Wed Sep 30, 2026 at 5:25 PM CEST, Alexandre Belloni wrote:
> >> Because of this fallback, when pcf8563_rtc_read_time() reads the time:
> >> 
> >> drivers/rtc/rtc-pcf8563.c:pcf8563_rtc_read_time() {
> >>     ...
> >>     err = regmap_bulk_read(pcf8563->regmap, PCF8563_REG_ST1, buf,
> >>                            sizeof(buf));
> >>     ...
> >> }
> >> 
> >> The bulk read executes as a loop of separate single-byte SMBus reads instead
> >> of an atomic transaction. Since each SMBus byte transaction issues its own
> >> STOP condition, the RTC's internal register latch is released between reads.
> >> 
> >> Does this allow the hardware time to roll over mid-read and result in
> >> corrupt time data?
> >
> > This is a valid concern, did you test?
> 
> Yes, did you read my first reply? I'm not sure how this is handled
> in the RTC subsystem. Most regmap converted RTC should fall into
> this case. How do you propose to handle that? Instead of removing
> the check, we could just test for either I2C or SMBus block read.

For some reason, I didn't get you reply in my inbox. For the RTCs that
are not latching, we do read the sec register twice. I guess testing for
I2C or SMBus block read would make more sense here.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
