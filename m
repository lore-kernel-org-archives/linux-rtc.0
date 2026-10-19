Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442870;
	b=3L3RWlQMMVUF8VNWNmqJbQB2vqsD8/ISdQaK6CxZ9Uvk+EJGTcHMHJfxTJM0n5cfjDOy
	 ORvLSixfTnzawyiwi9sVppL5dqb6AlfWFr5LXoXTi4gJZnbQ8zYaaotz3wFxbX60PCCeB
	 tpZhDJhS6J0UBCAVwIIJmFw4fFw3sisQ0+jKPHu3TmqR0HKWlRLSzz/2tuk9wpGgieVgh
	 qb7cxM9UeJiavlccvAV2nP3h2zvqJhUT8rRjjGeRdGRF790hAcK1TaKiiRmi5kNh1tgJJ
	 vI1n216XUy97kIQsZVeYtu6bi8cbhMRFhNlWkynzJiWXkY7zItiaykxkqcvY60PCguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442870;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=KnhFauQRQMdP/HvCz8tr9YCb6Rhc9i5YKUinTTqwk7s=;
	b=iKNjO4NJpKbhVHmRdWcAnwTKu5eiFtNLyA5HUMSrxuUQqKL9g0u9/KvosV9Q2/Uq2s+T
	 wOUVMri/9k0goZRPYA6nvSAjkWROUD/qx4VOS/Pi5TUaIRwl5/qZpxsbXbVdyouxhjHrj
	 bqGiWuvwTswJl5ov5nqVlP+xb5+eaNtzUfDxddCuPnugAhF8vGjymZ86LpigyWdSFJu8P
	 IzPTnzB7cKcTWiL4MJE9Zi67tu1OS0tSUpBucfDfDuxkxnBV7MKLNc9kSprv1XyRZIptJ
	 nXAtqCIT7AYUzBif33K+8ftdaVGdcnX9J10/OXIhmXOSczzeZ7aJn9AjOPvTDnL2WjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qOjdJqR3;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E26A606A31B;
	Mon, 19 Oct 2026 20:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E26A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qOjdJqR3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8EDA44E4127B;
	Mon, 19 Oct 2026 20:47:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4225F60582;
	Mon, 19 Oct 2026 20:47:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0751310328C52;
	Mon, 19 Oct 2026 22:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792442866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KnhFauQRQMdP/HvCz8tr9YCb6Rhc9i5YKUinTTqwk7s=;
	b=qOjdJqR3k95ePaXqLDsXj58BeX4o7gJ2DJ0aMsiDBuQR+ZfmEspsHZB2snqQkbGMqc1Gr2
	rSClNf+7XDf5/yT0i6D2xo3OJ+Q26jBeTvXGJMOv0IwnOuSKx/BfZMx/j3OreZNAMgZH4w
	rUaiErFutFhSrZc410WOBsHkenIk0HhDxQzstqduil/d2xFk71wa/5U0ge24YhhAjheKwA
	snfst7Tyj4modqa7nfnbP18pfZ9hO6hseH/SrNsJRE8XBk9z13P67wjsuy50BivnF/orzS
	+aAVVJUIGvSCX5YpJo4UKP4TV4EFp2+hYSz9DAK2kj7TNx0DOfN4ft/YN3r4Rw==
Date: Mon, 19 Oct 2026 22:47:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] rtc: rs5c372: add Ricoh R2223x support
Message-ID: <179244285492.113856.13160350426783860313.b4-ty@b4>
References: <20260825071927.4090460-1-hs@nabladev.com>
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
In-Reply-To: <20260825071927.4090460-1-hs@nabladev.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 25 Aug 2026 09:19:15 +0200, Heiko Schocher wrote:
> The Ricoh R2223x is an I2C RTC from the same family as the r2025sd and
> r2221tl which the rtc-rs5c372 already supports. It shares the R2x2x
> control register layout, so only the new type must be added to the driver.
> 
> The ricoh R2223x drives a clock output and offers an eco mode that
> lowers its current consumption while running from the backup supply.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: add ricoh,r2223x binding
      https://git.kernel.org/abelloni/c/026f8b1d515b
[2/3] rtc: rs5c372: add support for Ricoh R2223x
      https://git.kernel.org/abelloni/c/df8a0f6db214
[3/3] rtc: rs5c372: support eco mode on R2223x
      https://git.kernel.org/abelloni/c/95e83d98e104

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
