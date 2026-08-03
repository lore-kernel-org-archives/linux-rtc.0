Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8984334D4
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790738; cv=none; b=LkWSB2xHOAVW2KuSxnNNEQub8hPEg7IXRODytn4DXFWyhu6HQ8Qkl5cCozSE4kj66rfblbIit5tkjN3fh9sFx2eKbeLf2MldTjYmrBH72aAkHNzhjKtBaSErGokZMQAio+9yK5DZBV8hvT4u1FvQBZsvsZ3fWcHAZBXNYCqnLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790738; c=relaxed/simple;
	bh=WL+ga9AoN/j7RlE3rJ4Q6wn9IKo+XDS+L+c88fic/Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5ERaQVqWVceL1wBMPauOtUnF8X3Apcwh58LF/BTgjqLxMTjykb5/OYMeEESajkjICF5xjljPoFWZ9T3h0v3LWk+1tUOO/Sy2+bNfQzh9TrGxQak70sEqxAm0jX3S1ZO/TNHa5bbTjdOnVCBWXkuO+hb+6H5Le3kq6+uDIQ2LwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q11/kxWR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q11/kxWR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4957eefd361so17793605e9.1
        for <linux-rtc@vger.kernel.org>; Mon, 03 Aug 2026 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790735; x=1786395535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTNIwA5rIl7yheggGg5y8ZUCyvaskjkiO8o5tUu1AJc=;
        b=Q11/kxWRy/6lnbYXlQVCWzTKWXoE74iUR3Af6bVUGpCSU7GfWlvU71zUjiauHHfB0+
         hmQLAvB1R0Ic1rqPXdfNTcrnuumk3A6MvgcFO5gN+WXjyRv+4x4esLXkPZDvvSN/odxp
         L6IXvdIatXK6+OTOTvOygjV/0I5oO6HlHIkPkdvPNEK4G6OeT56jlkW9AqzRcZ7Huf3z
         /5h5gO8tZlfiC8yWnzhru/U/W2/rZ9NnJcLgtdlp7ycUuZWlRuodSAY1OPw3k8r9oFtC
         45pBHfVI4GyTpuHHrkZmfY70p/DYgja8cAeV7QPsYCEljBU0DdnXzmkikKcV1TQkvEj6
         xIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790735; x=1786395535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VTNIwA5rIl7yheggGg5y8ZUCyvaskjkiO8o5tUu1AJc=;
        b=BG3fSwKHJBPbk71ArISwBgyrucix4U/9Bhtp+Oo15pHSi/Wmt0ie019+/CBCjzMdLB
         03uI4pf2Z2c15iZcBR389VhWL8Jz/jCcX7phXId95bH1+KQcNKT0e0poV/Ts8PgDrJTe
         k9nWxcPU/wHmNBym3h0aI4c91Lza6D1ruluFn0tyd1YKYq1tXAUfeXTaGuz34cFIAPbj
         Gk8XLLzCDU1usnJvhyB8ggzmi6xIJnbwcyE+syJEIcZzdyDN3f7eWnK0akaRqoSnkpVt
         ooYRtu2hdMWTUMJ2Y/hPiIMaguTq8S/HlTQumk+nVe7ts1vJqMTCyZ3BKASYXXwzs8Vq
         kf1g==
X-Forwarded-Encrypted: i=1; AHgh+RqYtLRuVKYcV4VudUcR6jt0dZ1l3S5ZV6SPeM6w9aGAYoDFJ+4xZrtUzezDRWMFFD4AFvJPGTCJFjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Q4n70cKcFzmkUUZSmAriTRAbjB40M4k8KpvKHt/FM428LWQH
	Jixs5/5gCXmdZd58CTKLqjpj2JIP/AYp/iW+nklX2HLXEQVzulQsTpEk
X-Gm-Gg: AR+sD12vouqXuG3OL4itNbCfeluQK921QIIbSVhGY714UvPScNd/r662NHi2EGOAcyX
	UyE5J3As/BgSFPrTVJIQwXUss40NPLNIPYm0p3TbDvFgC/0pV3OAPkDqB53ci57hGEiIVqy3fXq
	4Hd3VuZTqssmYCG6HQwktrlxsT2dKPF+hhXS7ncxdYjs0oe2UNUuusPU+h++/lGtXn0h6g8fbzw
	5ewwnIYhqb/vzsjpPX1lG2QEH6ngL3EfKyTLQwhGXMCD7Sc+hjDuEDBUWPR4wrh24WSE1H90i53
	QAxZT2CQFmst7DZRd9oaHkhs6besDNSK2sa6elEwv47JO/6vbfak7TFeOtxniB3RHz3xAsCgy3x
	FQuSRACMG+NgmKHm462WynX4vqB7aKs7dej5LfYEG/D6uiO8lTCHXzP1r1VLcprLapkgJfpbGpk
	Pn9Ghl+MpVzNd5quf/s4izRWDYLkrSKJ4LrYg7YShiYA/Tg3aRWKRLzzf+qj4uBMjd
X-Received: by 2002:a05:600c:6989:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4980c664d83mr310149265e9.17.1785790734612;
        Mon, 03 Aug 2026 13:58:54 -0700 (PDT)
Received: from antoniarch ([78.209.183.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4bbcsm23236215e9.7.2026.08.03.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:58:54 -0700 (PDT)
Date: Mon, 3 Aug 2026 22:57:26 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
Subject: Re: [PATCH v3 6/8] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Message-ID: <anEAX5qGZzIGH02T@antoniarch>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-7-apokusinski01@gmail.com>
 <20260731190137.E8A701F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731190137.E8A701F00AC4@smtp.kernel.org>

On Fri, Jul 31, 2026 at 07:01:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Using `guard(mutex)` inside a `switch` statement case without an enclosing block causes a compilation failure (or uninitialized cleanup execution).
> - [High] Configuration Key unlock sequence is broken by unprotected concurrent reads and newly introduced read-modify-write regmap helpers.
> --
> 
> --- Patch [6]: [PATCH v3 6/8] rtc: abx80x: replace read-modify-write pattern with regmap helpers ---
> commit 68e1add63890d6b130ad7ce142d172f06e590b90
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> rtc: abx80x: replace read-modify-write pattern with regmap helpers
> 
> This commit replaces manual read-modify-write register operations in the 
> rtc-abx80x driver with regmap_update_bits() and regmap_write_bits() 
> functions to simplify the code.
> 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 23823fc2f5458..52f958e2aecd2 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> [ ... ]
> > @@ -371,7 +364,7 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
> >  					  int autocalibration)
> >  {
> [ ... ]
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
> Does switching to regmap_write_bits() break the configuration key unlock
> sequence here?
> 
> The hardware requires writing the configuration key immediately before 
> writing a protected register. If any other register is accessed in between, 
> the unlock state is cleared. 
> 
> Because regmap_write_bits() performs a read operation internally before 
> writing, does that read happen after the configuration key is written,
> causing the hardware to relock itself before the write can execute?
> 
> Additionally, can an unlocked concurrent read sequence interleave here and
> clear the unlock state? Looking at abx80x_rtc_read_time(), it performs I2C 
> reads without taking priv->lock:
> 
> abx80x_rtc_read_time() {
>     ...
>     err = regmap_bulk_read(priv->regmap, ABX8XX_REG_HTH, buf, sizeof(buf));
>     ...
> }
Same answer as in patch 2 ("rtc: abx80x: add mutex protection for register writes"):
register reads do not cause a reset of the configuration key, so no
issue here.
> 
> [ ... ]
> > @@ -566,17 +545,8 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> >  	case RTC_VL_CLR:
> >  		guard(mutex)(&priv->lock);
> >  
> > -		err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
> > -		if (err < 0)
> > -			return err;
> > -
> > -		status &= ~ABX8XX_STATUS_BLF;
> > -
> > -		err = regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
> > -		if (err < 0)
> > -			return err;
> > -
> > -		return 0;
> > +		return regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
> > +					  ABX8XX_STATUS_BLF, 0);
> >  
> >  	default:
> >  		return -ENOIOCTLCMD;
> >  	}
> 
> [Severity: High]
> Will this cause a compiler error or undefined behavior?
> 
> The guard(mutex) is declared inside the case block, but without an 
> enclosing scope. If cmd is an unhandled ioctl, the switch statement jumps 
> to the default label, bypassing the initialization of the guard(mutex) 
> variable. 
> 
> Does this require adding braces around the RTC_VL_CLR case to restrict the 
> lifetime of the guard?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731184831.44037-1-apokusinski01@gmail.com?part=6
