Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B54396D38
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977106; cv=none; b=jlZkgLENvh0BhgBq2PaaofaEFezOxZWCKi6496V0v52JykqVHaUiZ6k3RnUtBN9kVL1LsTN2qYz5bhBrsoGQZ3hV23eOe6ZTDpTCv8hqN8t5IIw9IdUxFaGmTCG0IG+Wfmj09OIT8GjNQKMaD9HNWce/hNmP3IJMF9xrfySq5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977106; c=relaxed/simple;
	bh=QG0AT3+mb6FrbZ9x9E6LCK3X/iginCERwfdb3AFxZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3JBuCImPH1c7v97qw4q8cJeKzjthfhW3gHtK212zKcySyeJI7Y1/TcgLBEtN0Zr+dKnca+pLXpiJjPtuGempDiCc3MFBH6wX3hBkJrehJ6LpA0yBwrjBYhvYRV8+6/hw3z7lZGIbdZTRVh7EqP7t2RBMeSPjnVmQmdcezBXtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2+L1A0f; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2+L1A0f"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4858303de5dso7386793f8f.2
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788977102; x=1789581902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/gxRIKfR1A0u5wLZR5CYHmnf41/Q9xKi2b6NUWXwby4=;
        b=F2+L1A0fnvvgoI2PYk8O1hf/MpYtr+TpWiKb3O2FyKwVLmgPxtmskOr0TbaR9//rNq
         dIQG++JnWdiWFC5jeR0ZspwOFtcjynTd9836oW2ibnuHp2A56M544W6Dx647HU4srH14
         E1dN8SUEVY/SR1K09P5X5AI8+S6SvKQgVooV5W/tQlXALJeby9Moe/E+78GdGoQNAgw7
         UaW9ezwR3PpEx1VwmLriFD9hvYktliI0csKwxM1NqRQqC0+bP9gW53VnFGWzfVJqwpnV
         laJxaQyVST0cDdFFk4zLxHbXVA2npAaiFJfTXAt++pbfvqiPgXJYctePMlb6k89gWKx4
         1cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977102; x=1789581902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/gxRIKfR1A0u5wLZR5CYHmnf41/Q9xKi2b6NUWXwby4=;
        b=alVbCfwa2g8uFjG9PWYh8CE/b3yVMVG7zNLxmiDE/Zxxn38m0pmvfziIba8k1XExpc
         xum4xd4px6TB+OiQmc46Aq0PFjTSqT4XF2UmcIehHNWpfwKLp3Xlar5/+LefZwKvWexn
         VbiuY+V99AfNQ8HYfBnU4u+ZhovX8Shlj722e3DpJlPcKPPzV2e6gJnUUvC0hDLUzCr0
         Cd5KYsgr9MlMWPudwh22K1zOhPdUcv71DUWp9ul66GVvto/K+xN/qRDU7dJjHOoMovO7
         EdbXMGMiCMF1/gvm1JEsUSkMuUUjaJY+PKnp355Hp4eM4fxXPCeuaAVl9Qp/Hfpt1TXt
         B9/g==
X-Gm-Message-State: AFuF++mB4kdz8F/xiwMWIQOY2+6e3j+sAwa77h81AW2HcISJqcoy7uEP
	jz6HAfUhPqDWYmduiEozkMFpruSs974dB0duEJnj1L2PDGI21QtprYQB
X-Gm-Gg: AYBFou3Sb0al0gn5MzwAkWlBxmzlVJ7u1pNwCJm/se2OoodDg9itimGjQy63zKkJMSt
	cEJRVra4+w5+4WbsH8Zx2Ipr2XFUNVXHKOi2s8lxaVzaqHruT1bs66NK43np7qa0+Cmw5fl6ScN
	2P5bLDNJ0Rmf/LlzteUmvGmPp1AipoUEYGkhLEm/6InGoiGPVJzeQUn00SCKjjs+WuhcTdPezCS
	hUPAZAyH7MlRPfLO7l89x99FYfkLtLoKKDDbRAdu9NlXZTB+hM9Jx5KOh6NQ4FJ4H06AtuImcpN
	Ad/Qm09keIVZ00383k5IavlbNeNgMExeA926qaUAdUIF15q1vcyDhprRegekAFBmwIym8TQCYuF
	nqbZX3l/W/j2H90TTLkvbQgCgTYzhiLpJpLWOeF3b/iBDbUwXY828Z7vV/17n/QwbKIVACMnNVn
	vXap38aI9GKb5HVSAAGz3PInGreGvY7g46eyUqN+JVBhUAEFoLhX13h+Rzb6nf6V5Vu/G7PAxw
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49cf82a514cmr387988585e9.16.1788977102076;
        Wed, 09 Sep 2026 11:05:02 -0700 (PDT)
Received: from antoniarch ([37.163.183.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bc08edsm4882485e9.3.2026.09.09.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:05:01 -0700 (PDT)
Date: Wed, 9 Sep 2026 20:03:14 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Message-ID: <aqGfFsFxy6LtKMjH@antoniarch>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-8-apokusinski01@gmail.com>
 <20260907204635.27AB71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907204635.27AB71F00A3D@smtp.kernel.org>

On Mon, Sep 07, 2026 at 08:46:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Refactoring to `regmap_write_bits()` and `regmap_update_bits()` breaks the hardware register unlock sequence by inserting an implicit I2C read transaction.
> --
> 
> commit 46c86d8ff37edcfaf17e15de29d0c3426614da35
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> Date:   Mon Sep 7 20:32:14 2026 +0000
> 
>     rtc: abx80x: replace read-modify-write pattern with regmap helpers
>     
>     Before introducing the regmap usage in the driver, updating specific
>     bits of a register was performed using the read-modify-write pattern.
>     Now, the functions regmap_update_bits() and regmap_write_bits() can
>     be used to simplify the code.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 7b8e6546ccffc..b1d8d5a5ddcf0 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> [ ... ]
> > @@ -405,13 +390,15 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
> Does this implicit read within regmap_write_bits() reset the hardware unlock
> key?
>
No, because reads do not cause configuration key reset.
Same thing for all the comments below. 
> Because the driver does not use a regmap cache (REGCACHE_NONE), calling
> regmap_write_bits() or regmap_update_bits() will perform an implicit I2C
> read before the write. 
> 
> In abx80x_rtc_set_autocalibration(), any I2C transaction occurring after the
> unlock key is written might reset the hardware protection state machine, causing
> the subsequent write to fail.
> 
> [ ... ]
> > @@ -488,24 +474,14 @@ static ssize_t oscillator_store(struct device *dev,
> >  
> >  	guard(mutex)(&priv->lock);
> >  
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
> >  
> >  	return retval ? retval : count;
> 
> [Severity: High]
> Does this have the same issue with the implicit read voiding the unlock
> sequence? 
> 
> The sysfs update to ABX8XX_REG_OSC might silently fail here.
> 
> [ ... ]
> > @@ -948,8 +891,14 @@ static int abx80x_probe(struct i2c_client *client)
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
> >  			dev_err(&client->dev,
> >  				"Unable to write output control register\n");
> 
> [Severity: High]
> Can the RV1805 specific output control configuration fail here?
> 
> Similar to the oscillator register, writing to ABX8XX_REG_OUT_CTRL requires an
> unlock key sequence that could be broken by the implicit I2C read.
> 
> [ ... ]
> > @@ -1026,11 +961,10 @@ static int abx80x_probe(struct i2c_client *client)
> >  	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
> >  		return -EIO;
> >  
> > -	err = regmap_write(regmap, ABX8XX_REG_OSC,
> > -			   data & ~(ABX8XX_OSC_ACIE |
> > -				    ABX8XX_OSC_OFIE));
> > +	err = regmap_write_bits(regmap, ABX8XX_REG_OSC,
> > +				ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
> >  	if (err < 0) {
> > -		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
> > +		dev_err(&client->dev, "Unable to update Oscillator Control register\n");
> >  		return -EIO;
> >  	}
> 
> [Severity: High]
> Will oscillator control initialization at probe time fail due to the injected
> read?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907203216.53192-1-apokusinski01@gmail.com?part=7
