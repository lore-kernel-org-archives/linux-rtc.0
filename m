Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE44334B5
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790516; cv=none; b=mA6RUijDdsLM+aYpcOslboKOmohC3Qty9tFFtx+x7MbeVm349two3pRvTE6MlHjucwI1Ks1lpm41viyPIIhi1EBp3fWDOIXx4SYAKhiP8BIp3MYHR1QfGNgBhnRMD+CCLapncy8fhfj4Qz76CBxqViwPkDe4ZTyJIWYyoDEJ0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790516; c=relaxed/simple;
	bh=BgsAwpUzDQBIT+HF1gKLi+DdWbSVovW5ofJCSPcSdjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR5xQx4Y8F6yHVEvylJtX4IKb34KHm1yUKV2W89deMzNcquRfzZC4hWCLthHcGSqT9TsA/9zUETgl/XaJnT6/rCv4x2nG9Z5thV3rs/UkdLpluEWbsDWCKjV1loO4C3GvvAGjVG6PRxp5FY1BkP4mqvjelfE5wMafbUnpbkKN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQev1zid; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQev1zid"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so193598f8f.1
        for <linux-rtc@vger.kernel.org>; Mon, 03 Aug 2026 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790513; x=1786395313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHA0Rp1gGRF6nGr+o0rQ0J4609nkyA5NKjL7qIfbGSk=;
        b=NQev1zidKMl0D0EtPUFqv1v5jQyt4sdWZdDRDH6xOmOo2xtqdDTuUGJZOig2Lzx+J+
         W219WY9IQteJ4vV3v7t93K3bdUf+I/22pmyR0lkvNY14tW+6+C1GqHbELAGtuuro3QMx
         2ztKHawNc6hRbGJK620RRLVymUnOynC0O1VqGP8T/JIpRMnJ0M/pZvAzGthuNn32qKff
         DJm7ssww2wIHXYrXCM/bTV1mUfN1NxmO59utZcR5KYgJThVob9fScusKv9twBmspC43K
         8L4vtQXre45rcclGBAnCGJ1ezj5PTmTwDYoQeFONH4wYAOnh26qXkB5mDRzM+jEiCQzU
         LRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790513; x=1786395313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pHA0Rp1gGRF6nGr+o0rQ0J4609nkyA5NKjL7qIfbGSk=;
        b=C0XhftWvE5PNKN5SejZNFFlWPSUL9mij/TXRhBg6ubzUve3H5HgK/mCpvaRp6b9ucj
         jPw1/2o3356caLLnB0N3hMGqapH9pk3Bb0Sab+1QhRZ13R3Nvi9peY8AzTVCgx60rcgG
         GexaxQE8X4mCxOveH0UIh7jpaokwJjnKYB4NzCo+RH6N+FlGs/zTp9JoTtI1RelbjGtO
         DjIgOlC8ZHf5MGf2tErV+NeVJW52HB8wb2pJ1tiCDSr5YHjtuksoaxJajjDnQmRBGqrC
         BSLrSq7XmoriQELZh2Xe9SlTEkRtTC3mtHQF4LSP1NjU9ILev8eDfyMTZgXzkg7BalQb
         EwSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0t70YFmOpWGORmG6FnaolznAPI25tNhTx2wCfwVGNvQHMFpO/nnL0TgSRRTtRIwqmidaGcm2h0cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZTaeSPKHUwEey+X559rmLQi1jkhjYmihpYUK+r5vR51x8vvT
	fiKxsmeXJkydmDtO8o4TBXddxtdqtZsNgsbGZ1F31Tf55wyhrbmmUj4i
X-Gm-Gg: AR+sD126jZgXp6OPtlPZj6uPkSr/mklECV5qFhok2kP8GiSr/Y6DJVFL75mqcW56f3y
	Z9dl8cKw99SfG2jTmeWtzCj/Dy/iydnyVoKP15VpsKGejX5CqK00n/Wc2JlBStnJzMGKSwSsM3j
	PxF/LfLaCn72s5BZ4aQrOnjjl4JbCl5WWAF/Ji8gT8DgK7DuqHwYd0sFBnhNXp7cbday4hGIPdW
	EYowLsCsCr792ScIUWr1dgIY1YYLZeoaEV4iKb4DP2hYB2HFE3bVPm1DlpPR5NNhf+la42Zk1FX
	eNmnNyLYr7PorHlTq7YCMQ5Z0OE/lzs9JLNKWnfoHn8nRdACYRoqxm3Y42Glcj5YmbEJ06XwClb
	Yj+NyVjv/De4kfMnWGwINByU4r4b4rLgH+IahqvkNgoeGkNANOeq08zgdj52+xVLBv9yY8d03MU
	DuYU1EmZ9bS8sE2F4+FU5xpr+Yxi/HXSXy4G5ig+FahBpFy3GL48Yux85H7uua8Cw9Lw==
X-Received: by 2002:a5d:5412:0:b0:47f:e746:dcab with SMTP id ffacd0b85a97d-47fe81b3b3fmr1985661f8f.10.1785790513110;
        Mon, 03 Aug 2026 13:55:13 -0700 (PDT)
Received: from antoniarch ([78.209.183.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2abbsm36731917f8f.9.2026.08.03.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:55:12 -0700 (PDT)
Date: Mon, 3 Aug 2026 22:53:41 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, 
	linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 5/8] rtc: abx80x: use regmap instead of I2C specific
 API
Message-ID: <anD_b4RX2Lz0kHs7@antoniarch>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-6-apokusinski01@gmail.com>
 <20260731190559.39CCB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731190559.39CCB1F00AC4@smtp.kernel.org>

On Fri, Jul 31, 2026 at 07:05:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Variables declared as `int` are passed by reference to `regmap_read`, which expects an `unsigned int *`.
> --
> 
> --- Patch [5]: [PATCH v3 5/8] rtc: abx80x: use regmap instead of I2C specific API ---
> commit 5bae78c37282c7d7693255ad432126ac7e8c51f8
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: use regmap instead of I2C specific API
> 
> This commit reworks the abx80x RTC driver to use regmap API instead of 
> i2c_smbus functions. This prepares the driver for future ABX81X SPI support.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 4ac3ace687a1e..23823fc2f5458 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> 
> [ ... ]
> 
> > @@ -221,8 +224,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >  
> >  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
> >  {
> > -	struct i2c_client *client = to_i2c_client(dev);
> > -	struct abx80x_priv *priv = i2c_get_clientdata(client);
> > +	struct abx80x_priv *priv = dev_get_drvdata(dev);
> >  	unsigned char buf[8];
> >  	int err, flags;
> >  
> 
> [ ... ]
> 
> >  	/* Clear the OF bit of Oscillator Status Register */
> > -	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
> > -	if (flags < 0)
> > -		return flags;
> > +	err = regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
> 
> [Severity: Low]
> Will this cause a compiler error on GCC 14+ due to incompatible pointer types?
> 
> The regmap_read() function expects an "unsigned int *" for its third argument,
> but "flags" is declared as an "int" here.
> 
> It looks like this same issue with passing an "int *" to regmap_read() also
> happens with the "flags" variable in abx80x_rtc_set_autocalibration() and
> oscillator_store(), as well as with the "data" variable in abx80x_probe().
>
I compiled this with arm-linux-gnueabihf-gcc (GCC) 15.2.1 and did not
experience any issues. But it's no big deal to have make the `flags`
variable an uint, will change that in v4
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731184831.44037-1-apokusinski01@gmail.com?part=5
