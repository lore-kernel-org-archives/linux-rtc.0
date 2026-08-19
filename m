Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972B38AC6A;
	Wed, 19 Aug 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156987; cv=none; b=guAXyG5hIriEaxOX1piNfYyyuQtQWHxyvkyu4XfUHUO44Zew1tpDOsEotjey5tQanIGiKZEUTZtGnxfuZI1LPhrX9UpwJ+seAXtSpryRlv1S0lV/yFiVlJpEjQbIC7IcGsPvtuNa4LlQsLAwAP93hjIIoUadtisizco6vGaUfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156987; c=relaxed/simple;
	bh=+1p+o657DbMrOo+1VVifwb+QN0i/DFJdH73LCKBy9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB9agy73pVsKanaGXGTeOZWO5XaIprr5NduRflQp9plTuQJ8pc/0oAu4Qi4Qsw1bGYpbb2O4XAOTJQC6G2HGVodk4qNfRvZlayAIoRJt2IlzGkyyICBLXEuRUMZumTbLnHMy47LQgF4NHTVxMroPHp+kZ6AMjvVDbSrKEKwD7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yERopX7p; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yERopX7p"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C6BBB4E412D3;
	Wed, 19 Aug 2026 16:29:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94D2E5FF42;
	Wed, 19 Aug 2026 16:29:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFACD11C75909;
	Wed, 19 Aug 2026 18:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787156980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6L/9g58H8H0kZnM7deRRTD7WwrW/fRJjZYFA3ZmqyTU=;
	b=yERopX7pGx0SkQF71ngWW9pG97BWiQ/Ydpl5U40RbFqDjbAAPs3kpEJZS3YgG3/MjwmAaO
	6u+UtxTNEIwmC0MELBXV4MEncq7J4lz3FjBavJx/V2lQl0WsR/421st4PTs4kOSCZVA/PC
	fD5ly4wQjrXXX2vgvHu8qp1pEDKrcwMyLkImwKXGJdQ3aylnSN0+Df56FwHxGB/YN9NyzX
	vzd9RuDTEpQB4Nu/2iSEFKMg9gC9gh/zvbm8vuv41aNicyF/D89QaaS6RMep/vNf2RFMJN
	jEZW1mZim91CgeoFiaCVCfQtIEpHWwcfizhfdjEqnw61H7BAiKCss6awr6WQnA==
Date: Wed, 19 Aug 2026 18:29:38 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
Message-ID: <178715693843.130787.3365587914156428309.b4-ty@b4>
References: <20260704152528.53258-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704152528.53258-1-pengpeng@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 04 Jul 2026 23:25:28 +0800, Pengpeng Hou wrote:
> The driver has a match table for the i2c bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> [...]

Applied, thanks!

[1/1] rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
      https://git.kernel.org/abelloni/c/7490b8356e52

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
