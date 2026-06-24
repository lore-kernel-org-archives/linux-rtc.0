Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3803E5A34;
	Wed, 24 Jun 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335755; cv=none; b=eQ8fKxHEWfULeA0MgLYH6T0nKKmNn8naoC+KmHGw52J5ZHjFY0dts/jaTk7ZnQTYvxF3GKLneh9Wl2iRacrM+aNKr0sI4JXFAaY6rJMZxmRXdV8+1aeGvBHx9LYljmaPqmgetJsNyV8ghtaGLkgTDd0c5yTFBzRjZvw+I6UfiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335755; c=relaxed/simple;
	bh=z72s8fIxCDisst4GzRRp+ispJwc9yaF19tGtV/DZqn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0ZodjiE903RpkiiEev+rUeQwan7Jji5ZjEcpDKuwo8Jg6sjHHuciufCdwvpu5H0PpTILUMkwLfJWR60O8R9gJTAa7EnIl8XCgiXF2d6zmwmR7UMMGPjIpn9uAAXBtCqho5k73M3UOwugPmP5lBi7qbPLfEYXxg5997nApeef0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1IqN3vJu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1IqN3vJu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3C93DC6B3B8;
	Wed, 24 Jun 2026 21:16:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22AE2601C5;
	Wed, 24 Jun 2026 21:15:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FD5B106C85A3;
	Wed, 24 Jun 2026 23:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fzEyUAkdtwsDGWDcus0Rb/IDW3je9WE2eQGLEcegO3Y=;
	b=1IqN3vJuyb0vKPDjR6RvttBzaJHyuUdItXuVk6MTrKEkqdYKb4IDWCH730jgPu66k2vCJM
	7WnZLUEHmWvXUm68RwV52L2dkTGHlTX/5UN0JdppUalyjkeJxQvLnY2ueTkRNyG1wch0Ne
	LrqA1NflR8Vg89yEXp9GVHYF2zSoPHiwuMGuP/ThMURWKcD7OurpXawK1SkMsPrgkLdLcy
	IZrguBaj34xdDRW3l1mffKUgNd0RGbzlerLVjV2oDcsewlf5wcKnGeKQHDVjvSuH7qU4X2
	WKKObQOw74wir9Ydm0rrO35atzWEcnlMGJWHihhn+ZEMO7OtytdjkEO4wizk3A==
Date: Wed, 24 Jun 2026 23:15:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: ryan@bluewatersys.com, akpm@linux-foundation.org,
	m.grzeschik@pengutronix.de, Denis.Osterland@diehl.com,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	biju.das.jz@bp.renesas.com, john.madieu@gmail.com
Subject: Re: (subset) [PATCH 2/2] rtc: isl1208: Balance enable_irq_wake()
 with disable_irq_wake() on cleanup
Message-ID: <178233558810.1517260.13463842390127591656.b4-ty@b4>
References: <20260425154959.2796261-3-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425154959.2796261-3-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 25 Apr 2026 15:49:59 +0000, John Madieu wrote:
> isl1208_setup_irq() calls enable_irq_wake() after a successful
> IRQ request, but the driver has no remove path that balances it.
> The driver is devm-only, so on unbind devm releases the IRQ -
> but enable_irq_wake() is not undone by IRQ release, so the wake
> count for that IRQ stays incremented.
> 
> Each rebind therefore leaks one wake reference; the leak doubles
> for the chip variant that has a separate evdet IRQ, since
> isl1208_setup_irq() is then called twice during probe.
> 
> [...]

Applied, thanks!

[2/2] rtc: isl1208: Balance enable_irq_wake() with disable_irq_wake() on cleanup
      https://git.kernel.org/abelloni/c/1afe4f19d6ad

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
