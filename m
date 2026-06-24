Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD41D5CE0
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335828; cv=none; b=IbTPzmUMZj1CgNVWWucB9FXusQUrDit9krQFPLXZ1FZuLPjrVdVSIYAi3ErhQBnL6K8dzGQR2Urq+q/INmHIrgJUxhs+/4lidIoHnEJ5T2cVsv8SglRthMDpdFgFL/Ag3G82sm1CA3jEhaTkUk/Ba/5l7a5I8o0jT8Wbno8qSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335828; c=relaxed/simple;
	bh=ecxlZnEuj2Eo0/4ompwhkNbm4kF3hIiLP8cU4LvDek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8noEECm5lHP3s9260M2CWwfKkUgDRr+Jr/21V9zVm9S+IynFF8h1SB+eZN+O6dhOb8y+wDk6dhX48MKLyAI/fGIgRuUQMIaMWs9xJWIoWuuIE8ILAWvI0HpxZM9d8b+EHV6Q9gETB5KiDm1SZTSvQ5VwIWZvLUlHvEVA7Qdkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jQ1q0EtQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jQ1q0EtQ"
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 91FBDC6B3BB;
	Wed, 24 Jun 2026 21:17:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73B48601C5;
	Wed, 24 Jun 2026 21:16:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64A32106C846B;
	Wed, 24 Jun 2026 23:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335815; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nkAQuOljHOlOW1xu2RCl/yHIoYiGq9+rhAXaUe531Ak=;
	b=jQ1q0EtQN+4mhEg8krXlW+VqTsQS/E6oyHvUv0Pl4xM64uF9yLJmYXeuCDLABWA/zUPC7g
	FCMoXLULjcaDSkbNAy4Q51rrIMaIUMMQJx8x2HGj74af5qYm5DZv1O3KOCP2n9Hzlus5Is
	i8pUnlaIn5VaV3oqYq78n5o5hu/o3wBdSTh/MVADZd/lpSqJkzruy4B0n14kUDbkobuC6N
	Z0ODxj7211KYvxjD1pRrNjAJzC8rPAe75fP6uLz7/YaCnCNVlRlLA8AeHQAscFqoLYDmQ8
	ISzBdzppoa8jDhZJyyrz9cxUQOpYtVETFkQpuCKORkCv+kD/rkhUu7reOPJ9CQ==
Date: Wed, 24 Jun 2026 23:16:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	=?iso-8859-1?Q?T=F3th_J=E1nos?= <gomba007@gmail.com>,
	Dianlong Li <long17.cool@163.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1] rtc: Use named initializers for arrays of
 i2c_device_data
Message-ID: <178233558801.1517260.6314981975455292147.b4-ty@b4>
References: <20260515154720.406128-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515154720.406128-2-u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 15 May 2026 17:47:20 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> [...]

Applied, thanks!

[1/1] rtc: Use named initializers for arrays of i2c_device_data
      https://git.kernel.org/abelloni/c/3eebec1cb5dc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
