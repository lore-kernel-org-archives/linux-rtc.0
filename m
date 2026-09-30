Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E84E1C73
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781927; cv=none; b=glMdXSx0dn2jYQArGA/Ef8VoIwX+7lQe1PSMQjBp/6OR4U5/0hr5SbdGlvXgZMeTsftz/8eAZ5U4Nv1zhrkmzMDMPP6/MqqqXNN1Mzz6GPTEt6Ucmv3l6aZrVtEw3MDhq5q/eTS8QQe3/TJxHsYbiI+yhX5MO1FJ0LOwJ//3vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781927; c=relaxed/simple;
	bh=PFa7S4pW+Hy8bZZeeL38QaLRJgemHnL/A2Y1cYYlfd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHpTkr3rVjeL20LNT4PHteVuIEYhFwPnKprkbu51AdtCh0aKbIVui3Eaxp00F7uxpBIF4yANQ9TZHQYxNuiX7iZlncDs51gUEI3YP+Ri7Fz8Kzjm739B0LfrJufo5nAkAT17OkqW9dMuBB+E0vmBvHHNYSkeHEqme/dbYKCL99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bz66pLxC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bz66pLxC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D86561A1050
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 15:25:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A48CE60749;
	Wed, 30 Sep 2026 15:25:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EB68103281E9;
	Wed, 30 Sep 2026 17:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790781915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ldNxRRaVyUs1307HOf8eQfls4TO8viEDxDPiJue7YlA=;
	b=bz66pLxCxPWoGBLTXP0EKgnSzepn/rcr8CwnG6OHeyc5j9iZifld/9XpJ2WS8eUku5aRPB
	nPSA7yCK4/BMJ+gUz9zDbJnSAThSdSpOvGknVFfm2KaswwC61uJMg89l3MJaty/9ewU9LY
	w/WoaOcQs9hJdxZkgkbe9T8ncxBze7QqfkgmplDmQsIdPlLeVLxtZLITlrVFz/pCnE47d3
	Hvq8kqQ9ijUCo9gTY1Lqexa/bKLenLlLSYMEZr5uHJkv6YAa0jh3fsvUIh7+1mZQGF4pEh
	Dw4qGe6L14Z8aLAPC/KbbeBShDeB7fvqup5XAz9eJm4HJSyMCyvb2nS8uKRCoA==
Date: Wed, 30 Sep 2026 17:25:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Walle <mwalle@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8563: add SMBus support
Message-ID: <20260930152513dd617b74@mail.local>
References: <20260930113126.720555-1-mwalle@kernel.org>
 <20260930114005.2C6661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930114005.2C6661F000FF@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 30/09/2026 11:40:04+0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] rtc: pcf8563: time tearing on SMBus adapters lacking block read
> --
> 
> commit 22b80c04bcdbffd7bde30f876c7c59ca8c532372
> Author: Michael Walle <mwalle@kernel.org>
> 
> rtc: pcf8563: add SMBus support
> 
> This commit removes the restriction that the driver can only be used with
> I2C controllers. It delegates bus compatibility checks to regmap, aiming
> to allow the driver to work on SMBus controllers that support block
> accesses.
> 
> > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> > index 7eebdb0580674..eee9bc752b52a 100644
> > --- a/drivers/rtc/rtc-pcf8563.c
> > +++ b/drivers/rtc/rtc-pcf8563.c
> > @@ -479,9 +479,6 @@ static int pcf8563_probe(struct i2c_client *client)
> >  
> >  	dev_dbg(&client->dev, "%s\n", __func__);
> >  
> > -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > -		return -ENODEV;
> > -
> [Severity: High]
> Could removing this check lead to time tearing on restricted SMBus adapters?
> 
> While the commit message mentions SMBus controllers supporting block
> accesses, removing the check entirely delegates bus validation to regmap. If
> the adapter only supports I2C_FUNC_SMBUS_BYTE_DATA and lacks block transfer
> capabilities, regmap silently falls back to regmap_smbus_byte:
> 
> drivers/base/regmap/regmap-i2c.c:regmap_get_i2c_bus() {
>     ...
>     else if (config->val_bits == 8 && config->reg_bits == 8 &&
>              i2c_check_functionality(i2c->adapter,
>                                      I2C_FUNC_SMBUS_BYTE_DATA))
>         bus = &regmap_smbus_byte;
>     ...
> }
> 
> Because of this fallback, when pcf8563_rtc_read_time() reads the time:
> 
> drivers/rtc/rtc-pcf8563.c:pcf8563_rtc_read_time() {
>     ...
>     err = regmap_bulk_read(pcf8563->regmap, PCF8563_REG_ST1, buf,
>                            sizeof(buf));
>     ...
> }
> 
> The bulk read executes as a loop of separate single-byte SMBus reads instead
> of an atomic transaction. Since each SMBus byte transaction issues its own
> STOP condition, the RTC's internal register latch is released between reads.
> 
> Does this allow the hardware time to roll over mid-read and result in
> corrupt time data?

This is a valid concern, did you test?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
