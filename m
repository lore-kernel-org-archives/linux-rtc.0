Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97532486629;
	Thu, 20 Aug 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261366; cv=none; b=J2qRyRd6BoHDL7aFt5+02qbm3j/5KLKrttVI0tunh9K0WaB3Tldj3PxIbYNbOUWYe1LXcXXjMItC+G+MQVxeXB1HZE+WXY5zJSDeftzN+8um5oNdkZGrGFRd1jL0eIKh+jRZO2VxtRcAfRVDK+Y88f03OPLybEBaikfwFhON2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261366; c=relaxed/simple;
	bh=ZD5ehMjdulQ+jMYga38IHhpkuLsHW82c3o84ONfGcTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgdjJsAgaLTT5Bb1Wr3UfLOevzquOV1vfjGhyaCawJHveXcw4F8gk2au522gghpmwWJGlVcAIL+lAxG567AZ7pddMe43HRQYPViT3bxt+ufV3505NJdWIZfHdxtIr3HXWW8oJtu8vtGQ8v2EgdfSR0+YIIFTQyNqYTFGDfChqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DxJW9yc9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DxJW9yc9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 00EA81A171E;
	Thu, 20 Aug 2026 21:29:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8D5A5FF59;
	Thu, 20 Aug 2026 21:29:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D75711C76888;
	Thu, 20 Aug 2026 23:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jsZ9hF6tLgubo/tix2wxrJXWD2kBowyO8vCSVK1lpTs=;
	b=DxJW9yc9Ls7OZmKWZlB90iiqwn99srR9fI2VISYiMXgDMiEgGd1T7F0t/LT0E+6JYus0IO
	qcQopMGGpysnIcajpV4OPnQzV9rCWJ1zww564HqqnQ/4u3+c/qmVAy8O9VQd1LlsrMJmaD
	9jPXt5GdlNZZN24qv8wq60+NxyVVmcHVPI3xewaRU/IRvlpRIBCoMnjuCDWsaH/JlwIYL7
	uiEkMjFNiS4PosdMjGOxYKwdKTE7yZo1+Dv47eGhVGj/ea8x51fqGsrloUwGRU/RwfRGNJ
	yxApEIc25eaVFlp1X165mAEKzr+U2SrxJP2ts1bBkAzU5PBiTrymoNLHeewXzQ==
Date: Thu, 20 Aug 2026 23:29:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Robert Leussler <robert.leussler@leica-geosystems.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for
 day-of-month mode
Message-ID: <178726066533.423710.8157866801445479034.b4-ty@b4>
References: <20260721081907.3518648-1-robert.leussler@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721081907.3518648-1-robert.leussler@leica-geosystems.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 21 Jul 2026 08:19:07 +0000, Robert Leussler wrote:
> The RX8130 wakeup alarm never fired when set via
> /sys/class/rtc/rtc0/wakealarm. The root cause is that the WADA bit
> (bit 3) in the Extension register (0x1c) was never set before
> programming the alarm registers.
> 
> Per the RX8130 datasheet:
> WADA=0 - Week alarm: register 0x19 is compared against day-of-week
> WADA=1 - Day alarm:  register 0x19 is compared against day-of-month
> 
> [...]

Applied, thanks!

[1/1] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode
      https://git.kernel.org/abelloni/c/878d93aaa596

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
