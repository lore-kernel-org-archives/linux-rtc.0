Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503726;
	b=BpFVBwS5vrhrJIvMYtchB7mKHrdIcpGIE4soxMJaZJ4Nd2cQQxShOQYk3G1ftJZR+URZ
	 KrSvm4QoRBWOWNc2ip8sqNeAjhoChXcn6KHnjLjrUaf7MqCBSXVdBqLV5Qel3qQB5kLyP
	 mW6N1EZ9nLtzpXlzMX34yilH5tJ03k9MuI3zgFgZZ8bw84Vlra+Ry88fgvCFIqNPrGSa1
	 m7clcD8LOBWSelZR7sMxTx0Pkj/lYVOmWHZj4Pjw/SjCEVbYyfye68n29HtMDq5NJYb5v
	 v/cDoW8rJyLifQtnlQJ78reEzMhqcAyZM/k9IIfp7+2q0sBchxE7V2b8icgAP2h7fsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503726;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=zQLnXSYHk6nit6Hb8Rg/xJ/6xtIZRw6yjbUGILEvCYc=;
	b=gw9BZuYRNRB5OZhjSiYPe31+NwTWAEFEIg1d6Bmmy6/xp4VjIVQEmxCL+M/OeREOYVWz
	 PdeMtNjHIz7U2C8YX064kGoZXDje03iHSqXSRIa30wJaCtS3l/2zxnYXswkFmSX5DfnDq
	 x5AgSEBpbr5xkUTB3hB7AkLA+y0LGuZ5Bw5FnYp/EGs1JEcEwttJmMetdjd1fvovCCfDY
	 WGUUo7rFI/3fYjFZ+qKaSFzkD+bbFAGJKMpq08z0ojn6Kd/soGJ+5BGs09DUFHbWiqezH
	 dXJV/pRTq0TPpo3B8WZPE7H2laDAH4vSJvxbguQmm9MmVemev3n0LAw6kaznZg2YFAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TxB9nsUQ;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886B606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 13:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3886B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TxB9nsUQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C57684E41259
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 13:42:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9400A60393;
	Tue, 20 Oct 2026 13:42:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F86D10328934;
	Tue, 20 Oct 2026 15:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792503722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zQLnXSYHk6nit6Hb8Rg/xJ/6xtIZRw6yjbUGILEvCYc=;
	b=TxB9nsUQ0uMjPU/p3ETb/1rgqrdR1yFhl+aaIewcQOsX6ORKF5lShoBQN/FpqNIlgZX/yU
	EqsK1amwd6QOkmC/YpdDNAixJ4VR9n9h3XKyY1ZTtY3/SAG0z92Rjt00AIxWj21L9z1GZb
	zuBbqldX+PFlq1/fxDKZfXT7pu/mpfpY2csmVKwcm5k0WW8lagipomozQay+ITp81+Rgds
	cGwi5DlR9MzHTbPRhZ2ZebyoS76OGL5e2dXRHv+rLaI82eQKUQ3JWHheOUNdaJ7aTf24Ut
	gJH0DHJHxs9LE9M2XdN7vUxOvNav//N2WPGhzxNGjWo3vAVWFM7XgjBwfIElBQ==
Date: Tue, 20 Oct 2026 15:42:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: chenguoming88s@gmail.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: drop redundant dev_set_drvdata() in probe
Message-ID: <179250371148.320299.13336543969308066261.b4-ty@b4>
References: <20260821131644.71794-1-chenguoming88s@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821131644.71794-1-chenguoming88s@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 21 Aug 2026 21:16:44 +0800, chenguoming88s@gmail.com wrote:
> i2c_set_clientdata() is a thin wrapper around
> dev_set_drvdata(&client->dev, ...), so calling both in ds1307_probe()
> stores the same driver-data pointer twice. The two calls were introduced
> together in the regmap conversion in commit 11e5890b5342c ("rtc: ds1307:
> convert driver to regmap").
> 
> Keep i2c_set_clientdata(), which matches the convention used by every
> other I2C RTC driver in the subsystem, and drop the redundant
> dev_set_drvdata().
> 
> [...]

Applied, thanks!

[1/1] rtc: ds1307: drop redundant dev_set_drvdata() in probe
      https://git.kernel.org/abelloni/c/0bbeed584e92

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
