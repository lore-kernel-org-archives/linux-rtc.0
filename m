Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB23E5EC0
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335788; cv=none; b=kMk0LeUYIcksvZGfZD+QYkGfJcx8JNfh8UQfewKXBiuRyTRatTVwKY7bRoDoKFzuw8M1ozrIOkMnGaa+PehH1DL3fFeTl0+SpjBJgemYOlEJ+rDRPfCnTNPMcjHcwpWaZ4C8+UE1nBPymJt6KNzy3JpOai1nGgcRjmXwVu7c0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335788; c=relaxed/simple;
	bh=AgwBp4EJ2OJTLxSY2GuCLwHEATVqJ0yxgOOUWKgjO1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzqJKAQPyjSYbumnRH13VPWcMjWKoyFeLVm/rioOQGG6P/SieIDFF7REa6XtVBSYR6BrGaj24x6d8RtTHYXwDPzLbw7DJzc55euFvUzu3p/zDy2uAgP2uV7Xy9DXw0chfwNL7R7YZWqOK2mXG/hYrO+WcedFp78Ry71SYTGrDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ihyhfUrD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ihyhfUrD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7616F4E4082F
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:16:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43E18601C5;
	Wed, 24 Jun 2026 21:16:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94B0F106C84E1;
	Wed, 24 Jun 2026 23:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vBH6xv7ZkxkHBWgfUR9uRW7RIajxlyL6Gwv9+5lzgWI=;
	b=ihyhfUrDPedUI5FP4ZV7tXSy0iuXl9nIPQP3HRjPaPi1uGIbPPtPYJSJ99R8KUDg4iTSjC
	9JXIOT+SGTF00BT7Hd7I65PkacTLr26gb7mqsMltGB/GkwlliTXYveFpfN+cd/FuJykCv5
	kVgs5c9YTAgbiErgWFIUJXF1lNDBzVe6Qs9sE5guaRkpxhnRFuo+fREx7g1IOXwuYI3pfg
	aeCkZWm6tm89HXjbhuz39OzH2ibsYDQPUnt61ok7rQzZsj20gZiAfg/gd1Kzcjz+vJ3K1L
	2DP40okNevtwFaM3biXSW2o4Q1cNRdK0UHZ3uQg2gLXtlWStXAFlZb7gMV+OBg==
Date: Wed, 24 Jun 2026 23:16:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: daniel@thingy.jp, romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: msc313: fix NULL deref in shared IRQ handler at
 probe
Message-ID: <178233558818.1517260.12796768179217211710.b4-ty@b4>
References: <20260511032703.48262-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511032703.48262-1-sozdayvek@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 11 May 2026 08:27:03 +0500, Stepan Ionichev wrote:
> msc313_rtc_probe() calls devm_request_irq() with IRQF_SHARED and
> &pdev->dev as the cookie, but platform_set_drvdata() is only called
> later after the clock setup. With a shared IRQ line, another device
> on the same line can trigger the handler in that window. The
> handler does dev_get_drvdata() on the cookie, gets NULL, and
> dereferences priv->rtc_base in interrupt context.
> 
> [...]

Applied, thanks!

[1/1] rtc: msc313: fix NULL deref in shared IRQ handler at probe
      https://git.kernel.org/abelloni/c/a369f48be8de

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
