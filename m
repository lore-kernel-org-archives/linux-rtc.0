Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6A4D4892
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668326; cv=none; b=KhgEVS6MKfdblxe71+cIdETxmo9KYP5B7JB0Ljw8l27Hk205osOfgunivS+Xl4f5aaxaLZUrdnlqD16ZmEV+w2mKuB3iLGyIyHDmcbS+XoImPYc38Mb4CFNWOdtIzaTIvpCb4WxozIc01nU5Q5LxWJel3GX0Pp6cwGw6cYMqsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668326; c=relaxed/simple;
	bh=MbLE0/tphrYEhfD98JIFLgdMtoiQslM//snl30eHR2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewW4vm0S6+KIC9GULIVIgFdPsN6sVTNKzvqvwtiepCiZeLmFomDvxRPyQLWR9rOfAjWrr+Uv85nIvARe5zNYYKUP8BATr+4qV3WG9H7x/3/GJFgP5dTKvjuaVH43yE4dCVhknKgL9zmybA1yRhGLiA+WQlKFvn8tFVq5ytFWq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deMPRV6Q; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deMPRV6Q"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so8540795e9.0
        for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668322; x=1790273122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3zIgykrgkmh6eNKEplSOXvIBXzQuOLD+0yjUNIOrOE=;
        b=deMPRV6Q5DVDs9ubWgr+5WNmxlolZ2GyYc42MQgPSFhZsvgqcjLwXlHsbokViMBwHF
         31SlcEUE+kY7z25vV4iWsnJZM3o+Kcul2iZClRBKSJRfrP3cQ29qbKxjJSghuY7ri7vv
         AyY94/Cvcs27z4qZU5NcdLCXhTnDmqWn5CEJecp+iQ8BdvlZql4QrnXfTZQOINDg5ex4
         jd3chwD329yvGFkXAVbnrLer2/XAyxEcNaD/qcMWX3TfkBJIXcQ8Ze9b7HSldXRn7t+J
         LLhYcS6/OghWS6x4p+LizMwVahNwrpGFaqtTV332E6jhWoSYjTNamm+5AlGia8LAqHMr
         9mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668322; x=1790273122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B3zIgykrgkmh6eNKEplSOXvIBXzQuOLD+0yjUNIOrOE=;
        b=VKz+b4gk8b8Bs5VL5eY0pUjm6Rk/IVHDlFkMgpGCbbrRS+h9RzzFLxNHOlNhzFdt+r
         5tegoe0kb+70smT0OLri11BnUDkndYBenkBXl7EMkT9zEuCFWgXUACBtjeDJ5XPtr+bV
         a2uoxt4ovggonjTvAokXWY2kj7E8/Dzz5u+9rFddyAcqFRJPjD0RLjNF3GSvzHeH7k6z
         G8e48UyM7bBnmCE9hgw5bhxshDhwpQRFZH3USQAarMKsggdELqbKtRT80U8jS1v2xDEI
         hqAQ+j2195Z0c7es9y8wdl1l9fuGWZjU0H6Dlx2fEPF5VD0OLAdm923qUZpxcgW6bD0F
         0abw==
X-Gm-Message-State: AFuF++kb8Jc3c7yOlnrz4UMxnShRZMZ5C/PLuHaCQZD5TWqCqxuW3wHK
	Yv+H/XOrOYUREsyPjqRlxvdgkXmRwgTY42Q4oY5I+AOH3QUeylmhd6WZ
X-Gm-Gg: AYBFou0nFAGQ5ZkE1vC9du9weTfw6HnZwwt9yOxb+J9qMGGfxR2/28n8BgcV79iL2YF
	CxtyHs5+nal7/jbEvm1BOBCYxNyY8XJHJWnh56nxTVQ9gJAzguhlXvmZdNBW2An7alxJbGe00Oh
	Dx/6gHbhaKCZkuEkp0miedRHy7nAe+FP9P7QVRdwDUCuiiD2EF7+0GaUM+St/kGsUEjiGbMOHRm
	BsFVcJE5glLt9FZzAwMZIpvYyJwc1BOcQImtARylwm40DZvKmMStG7IUOGIE/hE49lefTeoGdvz
	EoIKovQSXuHFZldIJqDmAR/hLUYIBKHHAnxUNM99cN0LftSYje9uj8Ccqtj3FvFS5SrGOvQOlKA
	nQSCcGmJne4FIlP0azFmkr8eGTWTgXvBjsYSlyP7TStrLmVc1xRVtjlZ5t1iEUJTas+UDRxBkZI
	eX2s7EhW2/vohP+mEvaJKbYzwgpm5hvbyvD+PIZ3Re9njZdlriTbKdb5EhOFupI9arNQ==
X-Received: by 2002:a05:600c:46cd:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-49eb7329ee2mr98391675e9.25.1789668322211;
        Thu, 17 Sep 2026 11:05:22 -0700 (PDT)
Received: from antoniarch ([78.211.139.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24034esm112207695e9.15.2026.09.17.11.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:05:21 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:03:34 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v7 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Message-ID: <aqwq25uszbldkd2E@antoniarch>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-8-apokusinski01@gmail.com>
 <20260916210520.96B6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916210520.96B6A1F000FF@smtp.kernel.org>

On Wed, Sep 16, 2026 at 09:05:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] rtc: abx80x: hardware unlock broken by regmap RMW helpers
> --
> 
> commit aad0cc39d854acf9e4ccd3b1fa7b17484a428c9a
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: replace read-modify-write pattern with regmap helpers
> 
> This commit refactors the driver to replace open-coded read-modify-write
> sequences with the regmap_update_bits() and regmap_write_bits() helpers to
> simplify the code.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> [ ... ]
> > @@ -403,13 +388,15 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
> >  		flags |= (ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512);
> >  	}
> >  
> > +	guard(mutex)(&priv->lock);
> > +
> >  	/* Unlock write access to Oscillator Control Register */
> >  	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
> >  		return -EIO;
> >  
> > -	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> > -
> > -	return retval;
> > +	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
> > +				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
> > +				 flags);
> >  }
> 
> [Severity: High]
> Since regmap_write_bits() performs an internal read-modify-write cycle, will
> the initial read operation consume the configuration key unlock? 
>
Everything alright here, read operations do not cause the configuration
key unlock.
Same thing applies to all the comments below.
> It looks like writing the configuration key only unlocks the very next 
> transaction. If the regmap helper reads first, the actual write might fail 
> silently and the hardware would reject the autocalibration settings.
> 
> [ ... ]
> > @@ -486,24 +472,14 @@ static ssize_t oscillator_store(struct device *dev,
> >  
> >  	guard(mutex)(&priv->lock);
> >  
> > -	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
> > -	if (retval < 0)
> > -		return retval;
> > -
> > -	if (rc_mode == 0)
> > -		flags &= ~(ABX8XX_OSC_OSEL);
> > -	else
> > -		flags |= (ABX8XX_OSC_OSEL);
> > -
> >  	/* Unlock write access on Oscillator Control register */
> >  	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
> >  		return -EIO;
> >  
> > -	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> > -	if (retval < 0) {
> > +	retval = regmap_write_bits(priv->regmap, ABX8XX_REG_OSC, ABX8XX_OSC_OSEL,
> > +				   rc_mode == 0 ? 0 : (ABX8XX_OSC_OSEL));
> > +	if (retval < 0)
> >  		dev_err(dev, "Failed to write Oscillator Control register\n");
> 
> [Severity: High]
> Does the same issue apply here in oscillator_store()? The internal read 
> within regmap_write_bits() may consume the unlock key, preventing the 
> oscillator selection from being properly updated.
> 
> [ ... ]
> > @@ -946,8 +889,14 @@ static int abx80x_probe(struct i2c_client *client)
> >  		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
> >  			return -EIO;
> >  
> > -		err = regmap_write(regmap, ABX8XX_REG_OUT_CTRL,
> > -				   data | ABX8XX_OUT_CTRL_EXDS);
> > +		/*
> > +		 * Avoid extra power leakage. The RV1805 uses smaller
> > +		 * 10pin package and the EXTI input is not present.
> > +		 * Disable it to avoid leakage.
> > +		 */
> > +		err = regmap_write_bits(regmap, ABX8XX_REG_OUT_CTRL,
> > +					ABX8XX_OUT_CTRL_EXDS,
> > +					ABX8XX_OUT_CTRL_EXDS);
> >  		if (err < 0) {
> 
> [Severity: High]
> Could this cause the power leakage mitigation write in abx80x_probe() to be 
> rejected by the hardware because the unlock transaction was already consumed 
> by the regmap_write_bits() read phase?
> 
> [ ... ]
> > @@ -1014,11 +949,10 @@ static int abx80x_probe(struct i2c_client *client)
> >  	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
> >  		return -EIO;
> >  
> > -	err = regmap_write(regmap, ABX8XX_REG_OSC,
> > -			   data & ~(ABX8XX_OSC_ACIE |
> > -				    ABX8XX_OSC_OFIE));
> > +	err = regmap_write_bits(regmap, ABX8XX_REG_OSC,
> > +				ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
> >  	if (err < 0) {
> 
> [Severity: High]
> Will the interrupt disable write also fail silently here due to the unlock 
> being consumed by the regmap read?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260916205138.16771-1-apokusinski01@gmail.com?part=7
