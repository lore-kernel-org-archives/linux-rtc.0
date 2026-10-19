Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440880;
	b=3grloSQUvBXgOrkFBLNkKmI0KIj846xcyrqgpgEayf5FqiKRKuyYuZ+2SkMIXueRhdTe
	 YQIwcZ8h9V5HsUimmfqq2aXBIc7ERQqHLF0Iy1RFknPFh6qifpvFyYQlT2YdFgggojn+O
	 cRaD5rt8Zu7B0coQBJLZePEtYvvc5JHYcMTIghR6UdxQ7lPtzHjMByNg/kJAyx+fK7Goa
	 4tiMN6wvokNvO9t7QFqoGJAm3i81Mvb/hsQxErNaP77V8M94IvfyyJhZHsrttT+9l/6v/
	 yNjX5YVWMMpbaHp8pkZiRX6Kk41iM4G3UUljL2fN736Xb+O4azTLXrynxxaRWxxYBIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440880;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=/5hKNHxFeOAm4qbVmRotbF0ev/GwLapj1bf9lcHGii8=;
	b=Sd2Kq6LZcN0Rq6+/pv+yQNiKxhqxY2AryWfDn0AvDBZ4YXBRWc2LlFhRgLpyzjmsHD4c
	 IVTY8E3V+2ZgiNKjNY7p/YGTC1bxd8mcKFP5+Mao0teKEGDxsLKpxT11LLOGEd9WFq9ES
	 E9rDReZsKWlapiOG7goIj3sX367WpPReJj1VhFoJmG/uvWiK+Xnr0MV9puYCd5qxqokMA
	 0Stj44ONgNL87X+wZPQj478ztvy2HhgB0IcldfFulpGkZesHmiZspBRJPQhIO5nRXYFCz
	 uS8isbdSLNXVY8W2uy/sU535sGdcIFplZ5XV29NS1AtLmvknn5pUXBVHdjAZvNSqIsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2kW1CJRE;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56958606A31E;
	Mon, 19 Oct 2026 20:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56958606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2kW1CJRE
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E18331A09ED;
	Mon, 19 Oct 2026 20:14:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5FBF60582;
	Mon, 19 Oct 2026 20:14:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F55610328D55;
	Mon, 19 Oct 2026 22:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/5hKNHxFeOAm4qbVmRotbF0ev/GwLapj1bf9lcHGii8=;
	b=2kW1CJREHzfvucOPyMIXsdTH16PE6sWlaJFwqxWxy412Pdm+6GNc8qnu3aE89P1rcswmyO
	4a9p1fwEZhab95bnMapFk8abPHjyTzkaXq6AsUBwJKNfzZP7hrw0YkYXO6Gdj+ykEA3DSz
	w9vRtBBhoZNEVkUaeyIz2pCSaf0PAdHrQWgOhF3hLCn7CC4knVkSyn2VGHqNyhBY86o9L6
	GeLy0QWWjC/xQnB5TC9CIL1sHvUlWcKjqmymeFbDqm8mg6lm4ArdSMPeR6vJHZu8lOFgeD
	zc1a6Zah9Yx1VPx+stg4tLBr0YJMFitp/N8BF34H60Y0hjQJH4ZKgIRjxaIE7w==
Date: Mon, 19 Oct 2026 22:14:32 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
Message-ID: <179244056628.104236.2147410035571083724.b4-ty@b4>
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
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
In-Reply-To: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 08 Oct 2026 22:16:53 +0200, Wolfram Sang wrote:
> The RTC on R-Car X5H does have a reset unlike the other versions.

Applied, thanks!

[1/1] dt-bindings: rtc: rzn1: add resets property
      https://git.kernel.org/abelloni/c/9e25de5490fb

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
