Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471695;
	b=Fimbc3E0GMMiTKfoYJNFVOdnQww0CN+oz0ErhhcMsv8c04CHf7QIwHw5JvktbnuFQJRs
	 6lRWWka4U38UWCKCmFaHzrj0TzMqmTtfQUhf1+5NuCY8MyokgFmQnZGoV56f22DCFuel8
	 5nTpKNypUMt7sVKdoOeCugUt5dNtNSZANtqo+2VZYdHfM6fnCdBlB3ZOvMpLPfue5M39M
	 /A//zBxnXSFELL/s1z+btzylHo0nfMlcpg/jJ7EAZ5Hxzomw3A1Lela1rMeGZHJRUGRX4
	 D1GWtdvG3y6AqBz3UQI5qkLUfnC0ZW78UfWVY9EYkfc6pePHW1/x25fN+jTT+QU5HGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471695;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=8d9e+YMOidi5LL2xCdgLdHHyKqQI1BilnlId8h90LJM=;
	b=RYyIph9Sy0Ppz+7fG9zsK5o6Ys+kPX610TmBGARJ1KjIWVTa81krXA8mHOOS1cxD/i7H
	 srEWWncwmABw8MewZo9IDwEa8gCF61Glw+fe33FgIjZxlTkYvTlwl5Or9ztZ/XeVn17rr
	 4sFHq30tFJgm0PrPIq88SlIuxJuZxn2nluoYuqxqj2Pt7L+bjUBNesvx0JyPVNTXwwrg/
	 r0ZvMRDeeruEL6+IBVyY63ArU6s6nGsJf1ORkpwKV7G6xhnqc0ZiRrgNxTuiO7staPmXM
	 yR5evQeN4IJtuTrhlh0V3IZT2j/D/imODbapF80bJcp2ecycZyowteNet9fIno8+cfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gPwZ6LVs;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30877606A31E;
	Mon, 23 Nov 2026 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30877606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gPwZ6LVs
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 904D21A16E3;
	Mon, 23 Nov 2026 22:08:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 55E7C604E9;
	Mon, 23 Nov 2026 22:08:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C324411E6AA51;
	Mon, 23 Nov 2026 23:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795471687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8d9e+YMOidi5LL2xCdgLdHHyKqQI1BilnlId8h90LJM=;
	b=gPwZ6LVsEXxNep/JPL+zIVG3xBj9ljumiCBc3iK3Exa5TwW0IT6uCSkaEQaT/fPUz8if/o
	va8LGpot2hbC6Z9zVrRaE3qG81yGiHNUYXQo+5Nhq3mccRPYc6Ya4vPu1+qM/DGJ8rNqoM
	luwTI1yrAgHoL3pOqqLhlI6zMyelOdpi6fvtS12rQERX7SlXnpnJHfPZjVC7vU3SqBuqlN
	mHmKLEtH0jcBiLbajAGjijg54L08qrRZMVTciAl8bTHDBPjDxF8YI64vUdJROJIGAIp2ZZ
	DTwUMk/FGx1C0tXturzJY3r8I0rReizsoCHpmh/JEqRl472Zm+PZVUzzxGXTVg==
Date: Mon, 23 Nov 2026 23:08:04 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rtc: Add Cortina Systems CS7542 RTC driver
Message-ID: <20261123220804bcab0f99@mail.local>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
 <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
 <202611232056209fabb078@mail.local>
 <179547125963.75567.6386430167092445665@gmail.com>
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
In-Reply-To: <179547125963.75567.6386430167092445665@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/11/2026 01:00:59+0300, Fil Dunsky wrote:
> Thanks for the review. I have sent v3:
> 
> https://lore.kernel.org/all/20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com/
> 
> Probe now leaves the enable/reset state alone. read_time returns EINVAL
> when RTCEN is clear or CLKRST is set, and only set_time enables the clock
> and clears its reset state after programming a known time. I removed
> the redundant rtc_valid_tm call, the two probe messages and the ALARM
> feature clearing.
> 
> I also checked the year field and the calendar on Almond+. The vendor
> register definition gives BCDYEAR bits 15:0 to year data, with bits 31:16
> reserved. Using a separate RAM-only range fixture, the hardware passed
> 2099 to 2100, February 28 to March 1 in both 2100 and 2200, and February
> 28 to February 29 in 2400. Century carries into 2200 and 2400 passed too.
> The 1970 and 2038 first-second/boundary checks, year 2000 leap day, and
> 9999-12-31 23:59:58 to 23:59:59 also passed. I therefore changed the
> advertised range to 1970-9999. These are specific boundary tests, not a
> hardware sweep of every year.

So why not 0 to 9999?

> 
> An exact-driver RAM run separately checked reprobe with RTCEN disabled
> and CLKRST set: probe preserved control, reads returned EINVAL, and
> setting current UTC enabled the RTC and resumed counting. Each run
> restored current UTC before returning to installed OpenWrt, then I
> verified restoration again from fresh host UTC. Firmware was not flashed.
> Full independent ARM built-in/module builds and source tests passed.
> 
> Thanks,
> Fil

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
