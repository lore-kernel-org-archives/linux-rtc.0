Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BA46DFF6;
	Thu,  8 Oct 2026 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460766; cv=none; b=D7Dcz6C0qCo65iDgekNyOIGWzfSOOywvXVd6ude8x+X3ffiyenj7nWE48IwM1vZEkg5AhP10I/7VMPyIIAentcdHWfpJzkQPUsmvELqWXnXEqbo0yF/erQugnItelv4UDzjJEA78yagJL7ZTlexbY62Zd93TjgYiavSz/ODFXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460766; c=relaxed/simple;
	bh=Qt8suwJWaxRG1L5CDEAXgFKnHkSqO9unr6jlAg3gR5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkty5lnh6xjhx+Br7oGHxoStHkzPzRAh6yaG7QLN3Xe+8tGB+sdcMW4zPYteFiTi5eGlclkZDzqnZ9sOIAMZS41neHkmJSRWqVgWj6OYgUfDZD9HHhc6+ILCJjypL/+V763Lg+Aa5BFTvch8lYFAh2cH13St8vSSYIYRw25PezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h9scnPu5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h9scnPu5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67E561A1195;
	Thu,  8 Oct 2026 11:59:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C6C060341;
	Thu,  8 Oct 2026 11:59:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6901A103301F4;
	Thu,  8 Oct 2026 13:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791460759; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xkO25mB5BDH7ovWjVpJGWO1rosQkPbuoBI1tM3KF7co=;
	b=h9scnPu53B0XT7ap+VXA3YM5UTxu3E7cvCiZ3uWalIPHXRwppJ+EBtuwc3of6iuVsTv7F0
	qpspVjlNainyL+uA0IyXmHUqFwsHhz6ojo5FyKp0Mb6gcHqEwAorAJtHzigaG5aBuvkOnR
	9LfFuYdta45DHoMjgn77JAacwKC0KkEhHPT/B7GEzMiJkobq3CTWtxtHsp7kSh18WJuJ2E
	8VOMS7dvhZs3jrhwHP/oAP0Dq3p482ebvTHM7BmyrsMzHl0hSTbaxXy/ylODDR+sGeyny4
	Nhep/BcMWwnOBId61LI/YEZjjR3CdSetxI7sjWTw3PZx9ukriIY7eHu9p4g6Xw==
Date: Thu, 8 Oct 2026 13:59:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Liu Dalin <liudalin@kylinsec.com.cn>
Cc: Dan Carpenter <error27@gmail.com>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: Re: [PATCH] rtc: ftrtc010: fix negative offset handling and smatch
 warning
Message-ID: <20261008115913bfd12cb4@mail.local>
References: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
X-Last-TLS-Session-Version: TLSv1.3

On 08/10/2026 19:37:32+0800, Liu Dalin wrote:
> A prior attempted to fix the 32-bit arithmetic overflow by turning
> the implicit u32-to-timeu64_t cast into an explicit one. However,
> all calculations still happen in u32, inheriting the existing
> negative offset sign-extension bug, and the explicit cast triggers
> smatch "cast after binop" warning.
> 

AI is lying to you, offset will never ever be negative.

> The FTRTC010 RECORD register stores a signed 32-bit two's complement
> offset exposed through readl() as a u32. Casting the whole u32
> expression result to timeu64_t performs zero extension, so negative
> offsets become huge positive values.
> 
> Fix it by casting offset to s32 first to correctly interpret the
> two's complement sign, then promote all operands to timeu64_t so all
> calculations are done in 64-bit space. days/hour/min/sec are
> non-negative hardware counters, so promoting them directly to
> timeu64_t is safe.
> 
> Fixes: 1d61d2592c1f ("rtc: gemini/ftrtc010: rename driver and symbols")
> 
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index b29c96be40f4..65fe1e872239 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -72,7 +72,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
>  
> -	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
> +	time = (timeu64_t)(s32)offset + (timeu64_t)days * 86400 +
> +	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + (timeu64_t)sec;
>  
>  	rtc_time64_to_tm(time, tm);
>  
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
