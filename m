Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD202569F0E
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967330; cv=none; b=jNt3zcj2kb7xiqWtGvnxtAdIpQd3aeqgl7F0UMhhBZt10v2D3yK+tRphrZwa1S91nilzcI65qRxgKLLZo1v09RpIF402tkN+gUH97MAf6WLTwmPWnPETz8+MTuYpxIJu7XnWPlcz0wrwPyR1JA0BGLst7djM6XuJnBafq4O6wEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967330; c=relaxed/simple;
	bh=MamDNejFka8GDdgyd/uhGAj2+TJpZqaBqtkwD9Sp1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJkj1dxZmEn3z4mQfSDk4oI/YEG2Ykue+50kMxFOMCcVNAUfseeCanCQpaRen+hH0IVKKuPiNGv9wjiAj6M0ndgVjRABWFqWhXZ2k8CLzXdg8sl5xA/gjDTp/FdNUVL0KCY09cSsD2LLUrn/Ut9BLUXounG5tOht8EpmKs16dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uwk4BS0i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uwk4BS0i"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 42A0B1A1A7C;
	Wed,  9 Sep 2026 15:22:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E02760448;
	Wed,  9 Sep 2026 15:22:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BDBD11C7AF57;
	Wed,  9 Sep 2026 17:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788967326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KzaNhATIdhxpC6JVerVZ3GOKWv6+RID4GsaT9j1TEpU=;
	b=uwk4BS0i6nO//nIHM9d9pBWfJA4DW3hmwZfzs8dOgKLxSJvWM7pYyOS37njsl+/QpKoOac
	fgzc5gEx2cg1gpfM4DAqMXv/RnYAIVwROK5ZOCP4S7LcbeSPYtTzUtN6wGlN4LlcVF0HT4
	HHTFj4aUACU0gSXhgXX1lu1ZGCPpAbfQe4522I/jx0626Mlj9QVY+s0KpyXyuFvsx3R3ie
	KEuv19ZbKxlaJnVJXCNnwPs6J55/O4ESdnQfEAdSX8jyMxbyCppmnwR0xto2ZLLtvzEDbx
	ItG//eYk5panHRVOFA2v+Uw9hjgGp0twtDVqP0/dis90eX4/YjT2jQFCfGp85g==
Date: Wed, 9 Sep 2026 17:22:03 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH 2/3] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <202609091522031352f96b@mail.local>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909141300.1368790-3-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 16:12:59+0200, Sander Speetjens wrote:
> From: Jonathan Bell <jonathan@raspberrypi.com>
> 
> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091, which is accessed through the firmware mailbox.
> 
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

This is missing the SoB from Jonathan Bell


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
