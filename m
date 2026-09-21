Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1359397E9E
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018866; cv=none; b=XAd+qtcGhWTrux7eTCNk/15qB2kFjz8jKylcHJgg0Us2fuqrWYepYJC20M1IIYgQ3nQ+vL4h7xyNnPp+rjncfbYM2PaNQjzY2/2pB++oi+mEue+knTSeiW0fcTanvTLK+AUsHJMiLhu4HHldG3viMZdBrFl/dUts99CoBYYfbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018866; c=relaxed/simple;
	bh=CwYBVxhx32JRli1+4leSz6Ldgf3gbn6vsYGQnoYWnXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbD5ZABSn1/4dFL/5OHt7IKyZgga0lADYJBoZYUyTxZa9Sppk0PaMfYgmqNVxONbzAgm0osKZCCwzLa6vUU6sZ7SQ2DiS3DEJDxmQPOaPkGpX/9swZR7BNE0wPZoqZp2WGNUR8nuPaAQP7Mdem66isdewT/jcWkl7YFc9IT38rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJCiogmY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJCiogmY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3852D4E40769;
	Mon, 21 Sep 2026 19:27:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1C255FFB2;
	Mon, 21 Sep 2026 19:27:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7C3A103291F3;
	Mon, 21 Sep 2026 21:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790018858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CnzUMIxTE+jlOJW/ewUyMPQRcDqilqcBWXrytbWfhLM=;
	b=EJCiogmYQ/uqLMMsuySmluulfW7D8Y9QmTNZ2DuK96f+tGgZTELuWBtkc2U8eage8cZc7f
	3OBKsWklmtuopq5L3ctR604jRb85kfTugdir7Zcao2bUPBIzpRFfA0UQuI2X5t7PJft3Zn
	IBJjoX2MVue3kiij1shbVWGexl+peo886eeew+SIex/IVhltfjvh57qv4kmBqiaBWQ5Lq9
	IJwiFAdvjB8vAWwa1MxrNhkYKytuJAHjZZoVpIv/WQ9yg5H1/PVuour/2IAdGoVY89VnB+
	rWkvY69UsMC/XK44eQDkwu9PudN2vajlwYu6VWd+wjVF0PV6JGx+eLYgiVwJ0Q==
Date: Mon, 21 Sep 2026 21:27:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@lists.linux.dev,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH] rtc: ac100: Fix clock provider use-after-free on probe
 failure
Message-ID: <179001885068.248450.5112683279968066338.b4-ty@b4>
References: <AS8P251MB0001A489CC45A591ABBB9BDCC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001A489CC45A591ABBB9BDCC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 05 Sep 2026 21:41:52 +0100, Aamir Ahmed wrote:
> ac100_rtc_register_clks() registers the RTC-32k clock with
> clk_hw_register_fixed_rate() and the clock provider with
> of_clk_add_hw_provider(). Neither is device managed, and both are
> released only from ac100_rtc_remove(). The driver core does not call
> remove() when probe() fails: really_probe() reaches probe_failed below
> the device_remove() call and goes straight to releasing the device's
> managed resources.
> 
> [...]

Applied, thanks!

[1/1] rtc: ac100: Fix clock provider use-after-free on probe failure
      https://git.kernel.org/abelloni/c/fcf0b58e976e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
