Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EE4503EB
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023627; cv=none; b=kavZ7mr/2KhXLxJ3ItZPBEOzX9u7pZeelzI86GTXathzdyQURTjQQs/V6aGxrORWA70eQSNWfF9DUPffjn4ic6SQ6S9l/VeYM1Jh8OPA+/1peDo+pwyC7D5gysegvI8HgryHdejxhvxJ/AhdW70PaZ2073Bsy1Gtefcxh0xeEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023627; c=relaxed/simple;
	bh=dPFt1uyiwaF4RND+NxKp9/9IOXEzMHtdmcpyf6hVMMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHT08WwWIiVHHsFKf3qVohz/w7XzIdHMGT4xCafcIzYZj6F8Rrb8L9gJbdawdhjz0WOcMjGFlzUtkpVEVMaRKNdVuaJkViUAIu7qwCYCqfF7wh/PLVmdY3lQ1GwI0oYJ97mHy1mEt7Jbf52XcPLsrBA6KyhIQBDpihjnPM1ID/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gt2/U1E4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gt2/U1E4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BDE981A0F61;
	Mon, 21 Sep 2026 20:47:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B40E5FFB2;
	Mon, 21 Sep 2026 20:47:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EEDA10329207;
	Mon, 21 Sep 2026 22:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790023618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pqEsQzHfIMMK9wMxPMCOeE8LGX1/NFmL9DTS5Jgu/vM=;
	b=gt2/U1E4qkrptCXy1CafTtgPtwyUZMteSUBWpOnzY/DovZu4E4xP6dC1585WCGQN8QeBFJ
	rOnAiyAXvGPUKWTdrSP6gMZAuxdwZsyAS7vNorZap4chhwLfda1rkffEz0AZClgf+yGcwN
	WDrN3v2AESmEuMequxxVq8uOcxfpvRrz9CTmEsXAebXrlLy63EB+HhQBGVdpeGrB9UY+6B
	LISQG3K5NDFMgtgwE0SEmo6LhfL8qQFxNRSGKvJLvpI+bQqkauFTrxUEdogWULWnHMTR2z
	EEnB5YZP/fiHcqxnLffRQhNtZhpOog5iQuSYilGOeEKXu3At8vOnoppDFiqZMQ==
Date: Mon, 21 Sep 2026 22:46:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] rtc: spear: initialize IRQ state before requesting alarm
 IRQ
Message-ID: <179002360735.255596.9129646206960462050.b4-ty@b4>
References: <20260902080318.3498434-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902080318.3498434-1-runyu.xiao@seu.edu.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 02 Sep 2026 16:03:18 +0800, Runyu Xiao wrote:
> devm_request_irq() enables the interrupt before it returns, so the handler
> may run while probe is still initializing the device. Initialize the MMIO
> address and spinlock before requesting the alarm IRQ.

Applied, thanks!

[1/1] rtc: spear: initialize IRQ state before requesting alarm IRQ
      https://git.kernel.org/abelloni/c/055ef5ce9f67

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
