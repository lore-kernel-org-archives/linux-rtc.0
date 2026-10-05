Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE438429037
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203083; cv=none; b=QzlOSy4VYrv4wmrINBh1kTW7SsKgfxu+AYGA4rYa6YT1nKN0VWl/6p/qzXmaVy6OAcgslQyuJxdSCf/534lzHDa75OEahOe2jTvcisn/JHOKOvW6FVn8cqZrTVOuOFNcI+17NH6dem7NbjQokii4xtQtwy21BRz1s7KC3BJAeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203083; c=relaxed/simple;
	bh=qUOkumMnwJfFMMoM3tWFuUz3pIkaM5fDFt8gDbkFbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elKtCwEN4ExMcMtXvvYBPjKhgR94gdiDKkyTKIHjPYz8oKrEll9yJN+/2iZI1T7Q9eyFgfAesbXRy95Wb9wIwu1eonjsCv5nd7FoV1TRDeN9HafT6XF3KYYAJO+G5TZNfcvT/7DIVmqPnqXkSZQAsBx4ynhvncLxAg/21FJZRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uve4j2ti; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uve4j2ti"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EA1D44E41188
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 12:24:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEF64601A5;
	Mon,  5 Oct 2026 12:24:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87C3F10330608;
	Mon,  5 Oct 2026 14:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791203072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eSOfea8A8CadGj+B4+dbXmXA4L8v/ccUNrJQZSRutdQ=;
	b=uve4j2tikFGqHz/gGZ4rE3ftBIxN6taEuixfv1OBNCDoY46jLdj2k2VQH7gz/HeJ6Kw0Ft
	daYnPKuDtYa1bpkCfRnfa+w8gz92E+REpuKuF7yEH4stNtB7PyOYTo1QV5uTdElTixDZs1
	47FJ6s53yMkF72PuDjh9ZIL9FdPuFgIYwE/bf1erg5fwOVeEdScNXYumi9KsAs0KsX8q7z
	NN4yj+cAoCjFz3BdeaIwiJkgT6Zvxj2QXDRwNv8vf9V0sGlSt5yVT1S7yRPpDlJV49PWCk
	VA50zG9rvEI9GeQafT3EbLJ6Gk+ocq9A8wUdoqBZl60wnuP/wNRv4ypz6CeIcQ==
Date: Mon, 5 Oct 2026 14:24:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: ftrtc010: fix cast
Message-ID: <202610051224282c785760@mail.local>
References: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
 <20261005112417.A42BE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005112417.A42BE1F000FF@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 05/10/2026 11:24:17+0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] rtc: ftrtc010: 64-bit promotion breaks negative offset wraparound
> --
> 
> commit 2ccc1a04cd44cfcc28a0e0150aa880f011201f5c
> Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> rtc: ftrtc010: fix cast
> 
> The hour and minute registers will rollover before the multiplication to
> convert to a number of seconds can exceed an 32bit integer, there is no
> need to cast them.
> 
> Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRoXi2kgq8FTSaDPA@z/
> 
> > diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> > index b29c96be40f4a..c66d4a85f23c1 100644
> > --- a/drivers/rtc/rtc-ftrtc010.c
> > +++ b/drivers/rtc/rtc-ftrtc010.c
> > @@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >  	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> >  	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
> >  
> > -	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
> > +	time = offset + (timeu64_t)days * 86400 + hour * 3600 + min * 60 + sec;
> 
> [Severity: High]
> Does this 64-bit promotion break the negative offset wraparound?
> 
> In ftrtc010_rtc_set_time(), if the target time is set backwards to a value
> smaller than the elapsed hardware counter (time < hw_counter), the 64-bit
> subtraction yields a negative offset that is truncated and stored in the
> 32-bit offset register as a two's complement value (e.g., 0xFFFFFC18).
> 
> The previous implementation explicitly performed offset + hw_counter in
> 32-bit arithmetic, allowing the negative offset to correctly wrap around
> modulo 2^32 and yield the correct time.
> 
> By removing the outer grouping parentheses and casting days to timeu64_t,
> the entire addition is promoted to 64-bit arithmetic. Because offset is an
> unsigned 32-bit integer, it is zero-extended to 64-bit rather than
> sign-extended, which prevents the necessary 32-bit wraparound.
> 
> As a result, the negative offset is added as a massive positive value
> (e.g., 4,294,967,295), causing the RTC read time to leap about 136 years
> into the future. Setting the clock backwards triggers this logic error,
> resulting in corrupted time reading.
> 

offset is unsigned and is never going to be negative.

> [ ... ]
> > @@ -92,8 +92,7 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
> >  	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
> >  	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> >  
> > -	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> > -			 (timeu64_t)min * 60 + (timeu64_t)sec);
> > +	offset = time - ((timeu64_t)day * 86400 + hour * 3600 + min * 60 + sec);
> 
> [Severity: High]
> Does setting the time to a value smaller than the elapsed hardware counter
> generate a two's complement negative offset in this 32-bit unsigned register?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261005111502.159855-1-alexandre.belloni@bootlin.com?part=1

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
