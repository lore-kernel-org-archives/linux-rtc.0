Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442097;
	b=tDRy6ZTrRJfdVvsfFX874oMYMK7m2S6VknHh39G+52KPTqfNuuzaaMF3Z0JvII7eVuUk
	 4A9H9uZMP5MAk4tnW34/ujEB/vaLy+KMj15jT3ixnYtDKTrikMQaJZy8eQ7TO9iuWtnGQ
	 /BRZazBwAC4xqYj/HhrhnZd6MZqRjy21glXCGL4SOrta3pz9VFBlMRJ9H8lxRul/XIcxG
	 fi3xmnFQf/LWT05ybFhjM8oTh18HE2sYYp06OxzzUcVE7Xo4O494/16vHWnRux6Gw/LaN
	 hVh8e4sNhuioIQsiTwB6yC58/dUv4eY6F3zpYXbt9X79Zh9mo9mujXBMIyaP0+9Ielw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442097;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=aolHtKyHViu0zwbE45UYogroG29+h0ZC1Ve4vIwtrPI=;
	b=uTJAkx5UheVNYQkaefSnK34gyDB/uxz1KjgWOAL3rUDNIevUKglqbCsy8bVuos5IcB+d
	 1kz4XpqJ/Hzu26fE7vITEmAJ9U6ZGaaoJ3paR7P1LlX2o0kh6sNI+cD6muTN3KeoUAkcT
	 MZJFI4445+N4dPJbTaor2xq/uq/rrQdgpC0dsCLrrdeslay4sHq4+3ohFgkqpx9IUeKx2
	 bju5da+uUre8bUG96VPigd1cMRRQOCCk65hYWYfaR32kg+Vd1MHqcSjDwMiKVBocXun78
	 9bsLMVobPwFUoP0HWQlq5IoVwDoODqU+L95Mg0CBc8cjAUUJ+DNMUGulDUai1unIusA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GOuzsqdm;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F6606A319
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1F6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GOuzsqdm
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E2174E4127B;
	Mon, 19 Oct 2026 20:34:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDC0B60582;
	Mon, 19 Oct 2026 20:34:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F34C10328C22;
	Mon, 19 Oct 2026 22:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792442093; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aolHtKyHViu0zwbE45UYogroG29+h0ZC1Ve4vIwtrPI=;
	b=GOuzsqdmMYeYWjsBZJqgR6mZVUlRjbeM13GG9uTKJBi2GgxJdvbvqhmhSemI8IbzyoLpCw
	feBkfQeic/lh/DngNATUaHLv2N+GwvG4wKCL7JLQ12hCezG/z0l1SeLs2oNDnUtv5G3ezF
	hMgMYmfNbdSs6QSYQ8zpm22/z4tpbw8o6LOWFH7VDbCFkUjBRne8wSvr2tUoIln3gDtB4s
	yB4v+MJxLFPqKdDAngQJD6PfoJUcoFLe0hHwmxho87uSD3YNrAQ4TKRlprn6sTtRc90MfJ
	rbFt9gp97cZczPRMaz8eJLHY4MCKEQZU9+cBIzjhNAuwvN6GqwjIGQGKWAvDOQ==
Date: Mon, 19 Oct 2026 22:34:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Fredrik M Olsson <fredriol@axis.com>
Cc: Fredrik M Olsson <fredrik.m.olsson@axis.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3] rtc: ds1307: Add driver for Epson RX8901CE
Message-ID: <202610192034497aeb0da5@mail.local>
References: <20260629-ds1307-rx8901-add-v3-1-302dc3cbb71e@axis.com>
 <f3fd611b-920f-4539-8edb-ecb173f715b0@axis.com>
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
In-Reply-To: <f3fd611b-920f-4539-8edb-ecb173f715b0@axis.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 16/10/2026 09:41:14+0200, Fredrik M Olsson wrote:
> On 6/29/26 17:13, Fredrik M Olsson wrote:
> > Adds support for:
> > - Reading and writing time to/from the RTC.
> > - Changing Backup Switch Mode (BSM) to DISABLED/DIRECT/LEVEL using the
> >    RTC_PARAM_SET ioctl.
> > - Optionally enabling battery charging.
> > - Reading the battery voltage low status using the RTC_VL_READ ioctl
> >    (only supported in LEVEL BSM), which also reports invalid time
> >    information if the VLF flag is set.
> > 
> > Signed-off-by: Fredrik M Olsson<fredrik.m.olsson@axis.com>
> > ---
> > Add basic support for the Epson RX8901CE RTC.
> > Datasheet:https://download.epsondevice.com/td/pdf/app/RX8901CE_en.pdf
> > 
> > Also includes a bug fix for an issue with reading the weekday from the
> > RTC which affects both the existing rx8130 and this rx8901 driver.
> > ---
> > Changes in v3:
> > - Clear CHGEN when trickle battery charging is disabled.
> > - Link to v2:https://lore.kernel.org/r/20260520-ds1307-rx8901-add-v2-0-
> > e069ea32e1db@axis.com
> > 
> > Changes in v2:
> > - Squashed the Voltage Low status patch into the driver patch
> > - Switch from dev_err to dev_dbg
> > - Implement Backup Switch Mode (BSM) ioctl instead of hard coding
> >    switching mode.
> > - Change the prototype for the do_trickle_setup function pointer in
> >    order to make it possible to propagate error codes from the added
> >    PWSW_CFG register read operation. This read operation is added so not
> >    to override previously set register fields.
> > - Link to v1:https://lore.kernel.org/r/20251219-ds1307-rx8901-add-v1-0-
> > b13f346ebe93@axis.com
> 
> [...]
> 
> Friendly ping.

This was dropped from the queue because kbuild reported warnings and
smatch issues on the patch.

Also, I feel like this should actually be a separate driver instead of
growing ds1307 larger than it already is.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
