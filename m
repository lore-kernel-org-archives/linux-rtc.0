Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49D3515F6;
	Wed, 19 Aug 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157099; cv=none; b=fMQ1w4KwCyXMsqmF2nI1GRfmxRLAaTXrpqlEyQA/qTZlsfkxe6sGiZQSZ0X5TpTN306Yx7h77c5Krnq6DMNFXSPnoYX4PuoOIq5iU/DjgduCF03f9l07GsJpbkE4AwRYwg6lvSKmwUuEx5EkD41l8E1HWgkrrVOmQglZjkBSTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157099; c=relaxed/simple;
	bh=YDq5A3i2lxezJJLHk+irT35RxZLz5Qp02pkXZaXBmow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCjPxVajQ2RzYV5qTV/UMKi7QiSMpr9hyeMjVeJKNTqqdd7+ePNCc7Q13V2EoE/7sLHJSKkNbU2jAKNn/OZfWtIGVtOz5y5sGeEMv00YvQ0YzS49dCmVwo2A0SxWNnK8J3qo31d3Hhwy36lGx1nJP9F7ZR7+D++NdlxUkXnitDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nhutmENd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nhutmENd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5475C1A173C;
	Wed, 19 Aug 2026 16:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 288995FF42;
	Wed, 19 Aug 2026 16:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E38111C7590E;
	Wed, 19 Aug 2026 18:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157095; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PFtgi7hd1RncKkblm+fDNHYDQJbrPl9rcgocxe2cKLc=;
	b=nhutmENdTdZ6KWY5JVfDK94eF8ZZfZs6hNGP8Qn6a/eWs0nK5SYl7+BcjqWoSSzTkIQByY
	UYwm0RS4cRWD4cXo61AM6PZYtiqnu77UOrHsb+q2dyrxgm6DhO2OaBAt6fUMPZ6ntd9HpS
	8xQxGrCWwheiKJQb439ZYPh9ZK7KuASf+L09+zS2//4MW18DwfMX0JxP/qxnsubUTrQRJw
	xmiwqPraGo/60jqx5e17ErlxknNj5ngEMDJeEZs63FohEJOf/bnw299tacv+PWJbkgjAWT
	r4Tw3HXFWFZi3VLtMPOFAKoRkSq7Jg7pIOts/7kTjpSOQULnOf6w1sGJjflyTQ==
Date: Wed, 19 Aug 2026 18:31:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Yi Ding <yi.s.ding@gmail.com>
Cc: Heiko Schocher <hs@denx.de>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8563: fix clock provider leak on unbind
Message-ID: <178715693826.130787.13032869938030567300.b4-ty@b4>
References: <20260602035135.62264-1-yi.s.ding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602035135.62264-1-yi.s.ding@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 01 Jun 2026 20:51:35 -0700, Yi Ding wrote:
> pcf8563_clkout_register_clk() registers the CLKOUT clock provider with
> of_clk_add_provider(), but nothing ever unwinds it: there is no
> of_clk_del_provider() call and the driver has no remove callback. Each
> of_clk_add_provider() allocates a struct of_clk_provider, takes a
> reference on the OF node and adds an entry to the global of_clk_providers
> list, none of which is released when the device is unbound. Every
> bind/unbind (or module reload) therefore leaks a provider structure and
> an of_node reference.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8563: fix clock provider leak on unbind
      https://git.kernel.org/abelloni/c/9c48a5368504

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
