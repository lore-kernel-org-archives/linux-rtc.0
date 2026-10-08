Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9B449EB6;
	Thu,  8 Oct 2026 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447194; cv=none; b=KaIS97mVQy94RmTzUEmHFp/VcQhY8eR7tR0zrmJoruQT3ZcWZGzSCtiQS1vzPJSbuVUjugfcajWrqelY9laBf3gzdI1eUyLfnAunRVL/vxolSC1sHpoDGwMxk+N/5EQKASZI24RHHRqynfCuxo1u7+t+j2Y1Q+lWAUEgdR/dUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447194; c=relaxed/simple;
	bh=MQTQSp8bSz8ydjxUs/TEls30eAnRRHUa5ffOX5NjWgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFhyfLDlX4qaTq79jJTUj9EpQBrRwkeyaUw+NyuFyBnECZB7NcGxwI2RHY8k5LqTbeVt7Vjeu1xfoYlleTxU7AcOkLaN2qUhKUAw6q9M2TZMqR/HS1fH1XJVymydZfgvm35j1BUHGgY5ghlWoWhcTdPhvjh25L8l8ZCDOY3LeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=miLTJ3at; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="miLTJ3at"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F3F9D1A1164;
	Thu,  8 Oct 2026 08:13:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE44A60341;
	Thu,  8 Oct 2026 08:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A577C10333632;
	Thu,  8 Oct 2026 10:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791447187; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LxkzrC4dW/biWoM7IemyDVYk0aVeEdbEv3qtsH6SL3A=;
	b=miLTJ3athrga1RbU0M12BPtrjLIasp/uaSCgCIDOambp6XEHjNyHHRyaVBuI7ELkKLqkKw
	1nB5mBHcLrTIZEbfotUk5UJxfqEzAVLfot9l9SAXVxbg45BIJ99VsOayLiOFLo3kOmNLrc
	ldxhK6kV/2c/a/Xp9npsm5y6ldlzP9qNl6Fr+eoW8h4ficcTd+cW6PhUzNgLCxjP/DpSkh
	i/WeHHY07OyDE7U3uhvB3aZVp7eJIzUn1ViPlATLgImzcC6wW8d2jAYij9/TmWFz4reTpl
	PtwRz13rBRKjuHG1BIO6HB2YvRrFlI3Ji6uVnIOvyLGybnO5MplUpiLce44RAg==
Date: Thu, 8 Oct 2026 10:13:04 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: pcf8563: add SMBus support
Message-ID: <179144717944.360620.1628737106889351386.b4-ty@b4>
References: <20261008071408.3548442-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008071408.3548442-1-mwalle@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 08 Oct 2026 09:13:05 +0200, Michael Walle wrote:
> Since commit 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap") the driver
> uses regmap to access the RTC. Regmap itself will figure out if there is
> a suitable I2C or SMBus host controllers. Thus, don't restict the driver
> to just I2C controllers and make it work on SMBus controllers supporting
> i2c block accesses, too.
> 
> This was tested on a custom x86 board.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8563: add SMBus support
      https://git.kernel.org/abelloni/c/237378fd6be4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
