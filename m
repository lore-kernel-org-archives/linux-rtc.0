Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70443B3FF
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902671; cv=none; b=a4iXRzwPDdrxsTY/hJ+3Zb7CvZNyipVIaOhN9X6B/L4U3z1BbfNQf6HrAxjfghJQROeNdsFxVjFsH5gcLZI07KjggYepOgx7i0CojM6mZmqgkIggmFXpqlclUuBbNHqseMP4l+E2hi/lFa4/i2WDKxaTsQNJEMWqIUQJadZPVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902671; c=relaxed/simple;
	bh=T1dEe887YGwkSGBYCL8OCm1bYB3uZYn2VnNicEm6I3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNhb0Ouu+slEZGy9BOuar7mc4DJIdYeon4Tl6oXUaESlwalYByMtXgEjQ0cOCpmnJNjW1pz+HKvhyZERg6WCGNYaWQwqRF/ApHlLQ0wPcRlFUn3GFZzsqpWwyHl5HFVmiqQ6Ak2bGLUs6g+mcKqz0+lzCeTxxxAJ1Ms0SF/IKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZOBNC/Ob; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOBNC/Ob"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 24B941A11EA;
	Fri, 24 Jul 2026 14:17:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDB2560395;
	Fri, 24 Jul 2026 14:17:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E4F711C125CC;
	Fri, 24 Jul 2026 16:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784902665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Dpad6KFFOxb0OhI/jcF0z2hVpKmWQo/vxob+Tyqda9c=;
	b=ZOBNC/ObA6F+BduV6KBAiIbq+vmmktfQwkXfKRLXpnJaz82FcA4S4P5vYmazR0Y4h20tgO
	6IbKKSr3Rj1mcU6/7Gf7PrnVT+VC8fQDqLS6ixI7UWgXAVu7xzqdwYBjyX+MhV1Cjx2HNU
	LPE6htxK3uzvCt3DLrOOENOF/VIxzw2ZqVvCRfaa2vFUJDmQnebLrvKRxbZ6NBtIiMPMLG
	4mO0Bud/axsuHzpkJwFWbjMDlpmK++LYyHAMo4I9ugiHUTeIhAomN4ccUwysfW3QFS8YTa
	fiZBvWf1FLq8AOWqSdAdIhwB4Z2E+XnBU3+243pVlM0/JFUpmkIzzyPCLWvN4A==
Date: Fri, 24 Jul 2026 16:17:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: kr494167@gmail.com, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error return
Message-ID: <202607241417442690eba3@mail.local>
References: <20260724135803.81223-1-kr494167@gmail.com>
 <20260724140633.8FED41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724140633.8FED41F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 24/07/2026 14:06:33+0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The RTC time read retry loop in `p1_rtc_read_time` is vulnerable to a torn read (time corruption) if a time roll-over occurs during the register read.
> --
> 
> --- Patch [1]: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error return ---
> commit a044092d776fab1e96ae2f8b48ace64aa0ab2325
> Author: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> rtc: spacemit: handle regmap_test_bits() error return
> 
> p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> to check if the RTC was enabled. This evaluates negative error codes as
> boolean false, causing read failures to be ignored. Fix this by capturing
> the return value of regmap_test_bits() and returning the error code.
> 
> > diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
> > index 43ab62494bb4b..1de7bd995d296 100644
> > --- a/drivers/rtc/rtc-spacemit-p1.c
> > +++ b/drivers/rtc/rtc-spacemit-p1.c
> > @@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
> >  	u8 time[6];
> >  	int ret;
> >  
> > -	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> > -		return -EINVAL;		/* RTC is disabled */
> > +	ret = regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
> > +	if (ret <= 0)
> > +		return ret ?: -EINVAL;	/* RTC is disabled or error */
> >  
> >  	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
> >  	if (ret)
> >  		return ret;
> >  
> >  	do {
> >  		seconds = time[0];
> >  		ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
> >  		if (ret)
> >  			return ret;
> >  	} while (time[0] != seconds && --count);
> 
> [Severity: High]
> This is a pre-existing issue, but does this loop correctly detect time
> roll-overs that happen during the read?
> 
> If a time roll-over occurs during the second regmap_bulk_read() in
> p1_rtc_read_time(), specifically after reading time[0] (seconds) but before
> reading higher units, time[0] will match the seconds from the previous read.
> 
> This would cause the loop to terminate early and accept the newly read time
> array.
> 
> Could this return a torn time from the RTC (for example, 14:00:59 instead of
> 13:59:59 or 14:00:00)?
> 

While this is a valid concern, I guess this RTC latches the registers


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
