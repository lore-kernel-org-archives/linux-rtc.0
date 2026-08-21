Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39F2931DB;
	Fri, 21 Aug 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320490; cv=none; b=GehrzW+4Yi8oy/a893u7LuM56h1j7938prR6v8qvhr5I5eXoV0iPYs3aLD8rpCNHtEO0qtSHcqWimEgTWgOXlFslQJBKpMKx7zNDE3xKVXb7Wu6GHvntmoc7k6bvC8DAJmqlxfSAx+VLuCYnHhIG74thVSJLEUqrO5vw4NRViag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320490; c=relaxed/simple;
	bh=FW+YHRAAezdXHllbTmKdQb0R80HnI1ALIlfYTYoQpg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOoIE3HJJLgp/B1aDgWYnqeBjGXQZitV6TbwLW0OqjvtGLel/ux3CaO3krkOacPy3/S1cfo+GtK32i2vfXkbDaXtpUFgEkRKeUbHW6KfUSJ4uepdhIgv7/lkZqGn3WOBb9SVT6Z/AKOFt4aCNzufmKrmiZu5BeAFv+n90TqbOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nu4ruQ25; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nu4ruQ25"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9DA161A176B;
	Fri, 21 Aug 2026 13:54:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E3CC604AA;
	Fri, 21 Aug 2026 13:54:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE67B11C77197;
	Fri, 21 Aug 2026 15:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787320481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8hwp+cZu4luscm7WbqEYBLjqRuTMyjtV7Tpax15WZyU=;
	b=Nu4ruQ25Tbq0H9PcR5sCDLW9JpyMHv7lsWuBAkQOnDpctFJTrf4YE06v9Pbpt8qwcql+FM
	+/bx8WBUjwk5+WSd9jlAqUOrzq66l4tUYwXRVwJkt1lJoLYl9JNZ1gQWIu/7EAKsAqZatZ
	yySphCQ45OgNdl7M3F9F3bK0ngqPmvttQs6AftzlRfFc+4j6U6aCuCeIiubwh54unLo7Gu
	xyKeL1ttsClyzwmS8J36ExbqcuHbM+aInrHr/rh4VaRd5I1Pc6qJQxqvMAbxyaGoM2dEMI
	QjZ9uJO3PzdyGgsw91Ejsonjh/wwYK5MfTKnPrwLZQS7td1k6IFp7fqqeAltzg==
Date: Fri, 21 Aug 2026 15:54:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH v2] rtc: pcf85363: Add error checking to regmap calls in
 probe()
Message-ID: <178732045076.528022.11850301032051907188.b4-ty@b4>
References: <20260717193705.2003175-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717193705.2003175-1-chou.cosmo@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 18 Jul 2026 03:37:05 +0800, Cosmo Chou wrote:
> The probe() function ignores errors returned by regmap operations.
> If an I2C transport error occurs (e.g., -ENXIO), the driver continues
> probing and may register a non-functional RTC device.
> 
> Propagate errors from all unchecked regmap calls in probe() using
> dev_err_probe().
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf85363: Add error checking to regmap calls in probe()
      https://git.kernel.org/abelloni/c/78acddfde751

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
