Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F2376A17;
	Fri, 24 Jul 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900384; cv=none; b=QKKbZXxao7qLlxvv1H48uIpn2nXyK2sD+3T/h69aYRSwnW7buwnX41hqpAeM/To6Ae+oXRwrhFW/OmC6xzO2cbz1+x5t+7QcVKul0oaFlXDtnoY99G0g4hMyw6MOKncZa2POz/Qyonwh2zsNe+ahUcM4eLeE7dLxGQQWHmsZVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900384; c=relaxed/simple;
	bh=7pDSNUGJbkDSI68gOzaHVveqMiief8P7DDD14N2xZcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA4q8BgGw9RMr+7h3d9LWg5lf13BSahok78k30UpLlzsikfSUb3tLniPbw31zQ/9CYN+/KUEbTjvinpZWjf2PAuQ1Kx1w3kMRzE3y5yFO26c7/Agzmdllevyd/wdCqQOig4M6lEB1iPyzC0vTUpeqVKiidvJsOHY6TJOl5JjN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YtyPMYTP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YtyPMYTP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5A504E40F26;
	Fri, 24 Jul 2026 13:39:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B98860395;
	Fri, 24 Jul 2026 13:39:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F04611C12509;
	Fri, 24 Jul 2026 15:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784900372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eyUYSsg2coHiCNrbgbB0nPMXe3+a5ilhxAZu+w9jOoY=;
	b=YtyPMYTPCn0uNgIsxL52ARPZLPxyXw8mN05kGNuwpMf730269zH2/gVsPY0b6Z09rM3FCo
	jmEUpusknh4Mgsuaz07HKAGuh5CbbbAZQrZoiE1edj9LVeQ+cu72GIN9pDuNTecEXJNWmA
	9zx/r3djRQ5p/1P/yYjhVjO6lC1mWfwYNrpeiFzkFfqy62aeRoEbQVAw9AeUj8SQ9DdVzY
	ptkMP7+vnzNYqvUG5ZTA65erfpDK0/FhGgA9Bj1JVrjd6ytTehjYd4lsBG2w7MtMW5ei53
	bBHwicRIT6Zjrm3Q0O+dxbAwBXCBV/4OCe5zsyjWmFoFkXIgxcb/XfM+bZITtw==
Date: Fri, 24 Jul 2026 15:39:30 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: kr494167@gmail.com, dlan@kernel.org, linux-rtc@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: spacemit: handle regmap_test_bits() error return
Message-ID: <20260724133930d86e7b97@mail.local>
References: <20260724024220.10113-1-kr494167@gmail.com>
 <39995013-3520-4290-a791-1f5d6a25388c@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39995013-3520-4290-a791-1f5d6a25388c@riscstar.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/07/2026 08:32:13-0500, Alex Elder wrote:
> On 7/23/26 9:42 PM, kr494167@gmail.com wrote:
> > From: Surendra Singh Chouhan <kr494167@gmail.com>
> > 
> > p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> > to check if the RTC was enabled.
> > 
> > regmap_test_bits() returns 1 if the bit is set, 0 if not set, and a
> > negative error code (e.g. -EIO) if reading the control register fails.
> > Using !regmap_test_bits(...) evaluates a negative error code as boolean
> > false, causing I2C/regmap read failures to be ignored and incorrectly
> > proceeding to read time registers from a failing device.
> > 
> > Fix this by capturing the return value of regmap_test_bits() and returning
> > the error code if negative, or -EINVAL if the RTC is disabled.
> > 
> > Fixes: a6de182daa2b ("rtc: spacemit: support the SpacemiT P1 RTC")
> > Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> This is an I2C-based regmap, so yes, we do need to test
> for errors when reading or writing registers.
> 
> I think this is a good fix.  I have a minor suggestion or
> two below but either way:
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> 
> > ---
> >   drivers/rtc/rtc-spacemit-p1.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
> > index 43ab62494bb4..c1820c920ba3 100644
> > --- a/drivers/rtc/rtc-spacemit-p1.c
> > +++ b/drivers/rtc/rtc-spacemit-p1.c
> > @@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
> >   	u8 time[6];
> >   	int ret;
> > -	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> > -		return -EINVAL;		/* RTC is disabled */
> > +	ret = regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
> > +	if (ret <= 0)
> > +		return ret ? ret : -EINVAL;	/* RTC is disabled or error */
> 
> Since regmap_test_bits() can return -EINVAL, I wonder if a
> different error code would be better to indicate "disabled".
> It can return -EBUSY and -EIO too, as well as anything any
> regmap->reg_read() can return.  Scanning through the list of
> basic error codes I don't have a good suggestion, unfortunately.
> 

No, EINVAL is standard across all the drivers. I considered changing
this to ETIME or ENODATA but that would break userspace too much.

> Otherwise, perhaps just:
> 
> 		return ret ? : -EINVAL;  /* comment if you like */
> 
> >   	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
> >   	if (ret)
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
