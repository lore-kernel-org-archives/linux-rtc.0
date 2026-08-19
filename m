Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE73563CD;
	Wed, 19 Aug 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157080; cv=none; b=U6SiVLn6b0BZ0Mcwmia0jDcAKcZb2VbVXDXeeY+1FHegmxQi/V4w6MXh96dw5CENF7Xyx3B/BvwpMoq0AcuKmBXwE8vEBuuDE8sYgEGWEWI1MVBc3gjC3hQqx6Gz+SdUgvgIW1jx2MXY7vQ1WZ2IqHvdqwj+4xNdFqxIoq8kH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157080; c=relaxed/simple;
	bh=wiQmGrA/IqT8Qf+OKXdxG0h0qHbYJFxBK3sEDpj/orM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOQjHwmHlwDaLQ0wKZdcL/iK9PXv7SupnRH3Z37Uwm3TevfQX9jVhAYyEKZj0NBLsFDmEt2vbU9VZEmSUAbspRR604Ykdp57AHpMTP//L9i5TR8HuqW14GqPJmKudDVvtxr0yXj73BJWLM3EoNjr26Ygo5/Nq1wR9oghuN9Sa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LUJx+C47; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LUJx+C47"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DDA394E412D3;
	Wed, 19 Aug 2026 16:31:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A990A5FF42;
	Wed, 19 Aug 2026 16:31:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E34011C7590F;
	Wed, 19 Aug 2026 18:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6O/ENWAeI0ggqLJnnrqub6Mo13IAWCe6rYEcWK4qdzE=;
	b=LUJx+C47nbcPFdIyMNFVJ0AHbhn4SbhMjx2UIJSnCVts5yzzKTtEku3sZODhLmhKHgcslk
	Gmi1t+V6xP8DveYElL8lbbFrREuOa+U938bNVL4hLWgOJJcfDAfBqUX4uVsmEZecIsVX7v
	L1wfH43AV2QNsgmn5USe5XB3JP/rEb0vzqr69pHRJr1VV+DauqSn7IWYUOxss64U/Xng5F
	v0LwCZ5HJFR+HZc30i80PCZOcA1P3ZsoJV3M71KDJEO9NiewLX03j5JTKV3kiaOFI1MQPx
	jgNuR9RMtIedbuDB6QuUr0Lvnm/Pd4qxbv2HpnDUVsGW8EJv2cJX+gjBEccNFA==
Date: Wed, 19 Aug 2026 18:31:11 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH] rtc: st-lpc: get IRQ via platform_get_irq()
Message-ID: <178715693847.130787.13227961965648988698.b4-ty@b4>
References: <20260714002259.1392655-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714002259.1392655-1-rosenp@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 13 Jul 2026 17:22:59 -0700, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with platform_get_irq(), which resolves
> the interrupt from pdev->dev.of_node directly and returns a positive IRQ
> or a negative errno (it never returns 0). Propagate the error on failure
> instead of the previous open-coded "IRQ missing or invalid" / -EINVAL
> message, so -EPROBE_DEFER is handled correctly. The rtc->irq field is a
> signed short, so the negative error code is preserved.
> 
> [...]

Applied, thanks!

[1/1] rtc: st-lpc: get IRQ via platform_get_irq()
      https://git.kernel.org/abelloni/c/da5e8713aee5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
