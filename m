Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9466392838;
	Wed, 19 Aug 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156978; cv=none; b=W7MqVynsq0H+qY7pxM37adaEfXPj4E5VTGn1e8pS6oNl1mOkCYq9dWKdwEEkLq9MqHd3juxjMy/T3dt6NqCAiCj+4geM1FzpqKeqY3brqvcrc3L4G5Ib945ewXwR2vFYmq8njepDwM1R1vDvSAK9qg170qTC9QfrwzUE/nsymNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156978; c=relaxed/simple;
	bh=4cVOUvzUto+rXsfnI84d79kiJwDFmq4Z44k5q5g5UI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADl4DrEbA/dRhHuj9Ufa8NXnQraMJL7dq7N2IZbWGYJs78wtOa9m3Ii52MO+upNzZo0UpmlXBdpK5Fuzyii1Zshi4EnpCS/b+5xS+SD5n1pYt2kv5GRqLVc/HZ+NlIWywdxySHKLjCZfyxKV8Z8QUv9YrP2wxb62WwrwkR67ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vW9kfX3t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vW9kfX3t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 398854E412D3;
	Wed, 19 Aug 2026 16:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1AB25FF42;
	Wed, 19 Aug 2026 16:29:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75DD211C75909;
	Wed, 19 Aug 2026 18:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787156968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dA/9EZ9q53klXGxSMo1BE6kAbWq3qo7qffJ+f8rPyrY=;
	b=vW9kfX3tJSa4RM6w2+LuBmB03C7AuJy0pJfGTXDfgiKx4YLzGSSGKzSJ3ahMWzO/Ii9qUT
	h+xqWhkvcM4XV4hNxWZ/6MWHEV7JikuGagdGpJ9lSZLSdJcpJNAkneKh+pqrWAqEuEwyFu
	6TRr1MVf/NVKtvzfyix9EBaPI+u6h1/w/WvfYTgyXiXI1+SGmF8NAWAgREa4A+csCGSYTZ
	lEGvl5HDRSy9b7Zp8ppHPVriCHByMBmP1ZmuId4GSYG2qTZIRr/Z1X32/huTYcvvQH4ERW
	+WHVk3TZ6FFyVjUHDd94OE52JctQ+vdphM2KdrczT2UbBL9hGW0QB+xlQ/dOxQ==
Date: Wed, 19 Aug 2026 18:29:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: dlan@kernel.org, elder@riscstar.com, kr494167@gmail.com
Cc: linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error return
Message-ID: <178715693830.130787.3002190547423884283.b4-ty@b4>
References: <20260724135803.81223-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724135803.81223-1-kr494167@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 24 Jul 2026 19:28:03 +0530, kr494167@gmail.com wrote:
> p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> to check if the RTC was enabled.
> 
> regmap_test_bits() returns 1 if the bit is set, 0 if not set, and a
> negative error code (e.g. -EIO) if reading the control register fails.
> Using !regmap_test_bits(...) evaluates a negative error code as boolean
> false, causing I2C/regmap read failures to be ignored and incorrectly
> proceeding to read time registers from a failing device.
> 
> [...]

Applied, thanks!

[1/1] rtc: spacemit: handle regmap_test_bits() error return
      https://git.kernel.org/abelloni/c/092755367e1a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
