Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1723955E7
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018918; cv=none; b=Zord8RJtUNa3TUtdcj2t3CjE4FTn+t2bIapkmBUjnJKuupWlE16moZ6Sc8XLiWKZqnTLFBkyMF1EbD3/nn1fYwN14f4lRKYLiMzbFGvePOLb40Z21hr6ghG3/t7Ia05DOHnPiv96KztMevBFMlVoRVVoDcyJF8Vo0jF520SLF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018918; c=relaxed/simple;
	bh=mKcF77i+3uB4CtphUQ7sbspWe7lmNav9hgR8+R+Cqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNCr0l9pozYLghQMnLb/1ibeuDkNlb4vbh7/7OqVS7P6VdQW0EGoB0L0dqhCwpDVgB7dFNs2Jm3zj23ddHfPIUnfa48QD1ZsLuFqhyr6mVRl0W3CODD0JaYQtuJkz0A2T05lTlQzDmHkrjKMSaDP1o7Ff9nU/r0jNzmFlrAOzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tx63j8gt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tx63j8gt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5FA04E40769;
	Mon, 21 Sep 2026 19:28:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9F1E5FFB2;
	Mon, 21 Sep 2026 19:28:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6433C103291F6;
	Mon, 21 Sep 2026 21:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790018910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2CJ7icff8JEtr2MIIttHYeL6xAW9xMU6iW5VZ8o8b1Y=;
	b=tx63j8gtO2LTknEcJl2VsugMfHDV7JkN140eNtrYk1J+a7OmNqx7hOWnSycxNKn6WxA3rI
	67IcochnkJqxkqTq9SmqcT3wVG2ztoIxlaNJrHsu+Jhut64wQu8jzet6X93DYSbtwIBgv1
	AD/k/7vLqexg9YfgMWGfFOPwCZzrYxI0jGE0DYTe1iXzYUW4zmsaVRJN1XFRKGAc1Bc0BI
	AYQ6I84cp+Tz5HM1tyM1/oiVahThYqQPhySlXEAPkj8HMlacfm719AU1bASL8ZrHNtgQ10
	PnaYqYYaFCMb/xm5DKd4MMBsH0IjHQqw1rFjM6JM1CSxI1Y87QHpC6Cc/7j/4w==
Date: Mon, 21 Sep 2026 21:28:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	Manush Prajwal <manushprajwal555@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: fix unchecked devm_clk_get() error pointer in
 probe()
Message-ID: <179001890274.248925.9854410688320328698.b4-ty@b4>
References: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 06 Sep 2026 16:44:09 +0530, Manush Prajwal wrote:
> devm_clk_get(&pdev->dev, "rtcref")'s return value was passed straight
> into clk_get_rate() without checking it for an error first, unlike the
> "rtc" clock a few lines above which is correctly checked with
> IS_ERR(). clk_get_rate() only guards against a NULL clk, not an error
> pointer:
> 
> 	if (!clk)
> 		return 0;
> 	...
> 	rate = clk_core_get_rate_recalc(clk->core);
> 
> [...]

Applied, thanks!

[1/1] rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()
      https://git.kernel.org/abelloni/c/ac41b05d15db

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
