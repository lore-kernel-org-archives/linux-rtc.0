Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A24B44AB
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016726; cv=none; b=XDpTSspjS25wuav8XLnx6CkwF65Oew4xM5qT8cBI3N6Rno/thksGlsEXFnoSocp2SDjG6d5/kdGsKvcU5MugtMMhigFVG+zXbXhD5zcg9rGalgoA/bm58BsxyzA3spLWgLXc09XJ5t2zcPgTfJSCtaezjJWEj3p2PMd26ibKXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016726; c=relaxed/simple;
	bh=UJUqXeG/P9u5Yvv8sV22VIHKqdnIxK57penxmpwywjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cId7Phmco5A8A/vTcWBDk1RT4e3b/7qgcbDfYLP+8pnfFWb+CL/O04HEh0tV3vvQ925+xEp3kQE2jxA3S1l/GXjlmE04YBQrUhN1sHfMsxx3U9NRGtfxRd4U8qSBNJipOnTwMKnRhXI7mRtT4RcrRdjcdAyOqAraVA71ksI+bHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EQ+P/mLV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EQ+P/mLV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B3FBFC5CD60;
	Mon, 21 Sep 2026 18:52:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4AFB25FFB2;
	Mon, 21 Sep 2026 18:52:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 025ED10328D5D;
	Mon, 21 Sep 2026 20:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790016716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ynllzazNvLa6sdXptheLKncoSIIa92ngh94S7ablR5Q=;
	b=EQ+P/mLVE8/BKXKD/OxABygryvUhWzVKUliyIZQZ9zBKQIsd5cEGBgNogarz+dTxnt0cvQ
	n5z151+B1RU62F5ely8avEytG+VufUox8Z81DuxyAmBGTyinkg2dcidf+hAdL9MOhMg0UH
	l2YFQN51bAf3uxcjxHDvpzm9iqTco5GTSb8dDVU1CPc5LIeiI6AsKkRuJvSL18PHSXVvF8
	HWA6LC0Z49eD3Nz9qESVkQyas9qtld+oxB7cyIf4+Hj50jkF9VTIw6NjUhRM8gMn0hp9Ii
	rDQ+MH+nEwDK1vcgyg+ZV4ZMW+3PEI9lPDMMl3BmvR/5Tmwdjxx7cR26AXsdow==
Date: Mon, 21 Sep 2026 20:51:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sander Speetjens <sander.speetjens@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <202609211851510a4eec42@mail.local>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-2-sander.speetjens@gmail.com>
 <20260918-steadfast-unselfish-loris-996d7d@quoll>
 <f5c04c5a-20c3-4f4c-bd1f-045516d24140@gmx.net>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c04c5a-20c3-4f4c-bd1f-045516d24140@gmx.net>
X-Last-TLS-Session-Version: TLSv1.3

On 18/09/2026 15:27:55+0200, Stefan Wahren wrote:
> Am 18.09.26 um 13:44 schrieb Krzysztof Kozlowski:
> > On Thu, Sep 17, 2026 at 03:58:40PM +0200, Sander Speetjens wrote:
> > > Add trickle-voltage-millivolt property for the Raspberry Pi 5 RTC.
> > Why? Describe the hardware, the need, not the diff.
> Is this something we can avoid by making this configurable via userspace /
> hw_clock --param-set=parameter=value ?

I don't think so, the battery, once select is unlikely to change and so
having it is the device tree is describing the HW properly.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
