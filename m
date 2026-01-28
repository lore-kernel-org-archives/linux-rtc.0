Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59F34EF18;
	Wed, 28 Jan 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599734; cv=none; b=BrTPHk3+jzgF8xtobKv5o9Fo4mj+OZAazzczTbfYwGM9U4VakVDTZXDMTMFSI3n3mX6pU4OvVz7JMCfkx6WFFdbFBTtxA5CgCbfPKKhCnwN1ACwKIcrISSRTLutaU97DZDmHQTiUHxGkGgGW8KeTpKXFmzTZH6Os1uGrGR2IgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599734; c=relaxed/simple;
	bh=T07LlMy27vafgH7EsyMqUnD2T2urcjuFvAvW/6qJzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOpiko4Q7VcL2IRbWm/ZfejIA5AtUPn7jEWV8VIGS/f7jVn+AE3EVtUY/80s1D4STwGHBDnOrpX3NTONnXR6kwHTAOvoPS42/Yd4wUQ6wa09PGUPv0eR08cdyCNzvLkIXin4pCQwDEobEqBQsCkCdSxDY6rePIW+LBzVd77AHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OhT+vNxl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OhT+vNxl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B13111A2ABC;
	Wed, 28 Jan 2026 11:28:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 859D66071F;
	Wed, 28 Jan 2026 11:28:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64D2A119A880C;
	Wed, 28 Jan 2026 12:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769599729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QBBuyhtDVUcmCyPFukQunvBh3yCxAEkSKtkTkXjGZDw=;
	b=OhT+vNxleDjxcYy5pINjuLDxSiBlo02MNUX0svbs548k0VM0tD2K6OAmgmW1zhMwvupuCW
	KnvtaopyJet9O1vQ2PQA/d4uNeq3ew6YhyUfOOdjRj/jOAac6/9ZyyBzOK90NIMCH+C9YU
	KI9+jNPKxN9EIC+wSsIZ8xNf3uqCzRG5XOHZfM8nW/hTtftqiF4jCYrkLSUxoGpZTVD8iX
	ve7l3UZEI13j9DkF8acv1J/UZR9qbBBh9KUq+b5d4D0BdxLJQv9j8mQNQ8u9yirC7yoqnr
	uC69DbO7+9WhAS3xgCq4TDG/CeZonb9ilCB7nLnX3W50VZr2TjBLGILTdpdM4w==
Date: Wed, 28 Jan 2026 12:28:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Yiting Deng <yiting.deng@amlogic.com>,
	linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH v2 12/20] rtc: amlogic-a4: Remove IRQF_ONESHOT
Message-ID: <176959971728.1166553.14340155586831654418.b4-ty@bootlin.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
 <20260128095540.863589-13-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128095540.863589-13-bigeasy@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 28 Jan 2026 10:55:32 +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> [...]

Applied, thanks!

[12/20] rtc: amlogic-a4: Remove IRQF_ONESHOT
        https://git.kernel.org/abelloni/c/1932db202c93

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
