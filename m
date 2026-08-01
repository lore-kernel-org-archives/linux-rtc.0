Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336882F25F3;
	Sat,  1 Aug 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622024; cv=none; b=JjiA//+A3a23DfWcOep6IoagEoyRNsfzlMfJJT0+W4Qwwm6o6KyAng4hSuUmjAFRbaS1hCjwBLx6hBi6j5jE0v0Fkrr3gTiVQcy0fDe/NKIzeH+vk9GQQULEEU53VmGPEq2gq7u6GJr+vjJhy17iQ1hnGwHqLV+xDlQc6jHj0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622024; c=relaxed/simple;
	bh=9bNbnuSNDFMKevOF4cUPN9edXzz/pvfChFeX/IYJfu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txROAV6cgaGpOLoKHa6eiYWty9XGldB3061ExbYZN74+mAJhhKchRSlLYj16n+DGVy0ck9LAYH6a6lhR9g2wEi833vIIKntRu3PRazUMl2NwLlGe2wFgYx/ebGElpeXb3lPspLL8khbgEgHxe0MLNwzxJoyNpRWONL2ljml3cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lzihplHd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lzihplHd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 34E174E41078;
	Sat,  1 Aug 2026 22:06:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 079A06029E;
	Sat,  1 Aug 2026 22:06:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77D2211C171DE;
	Sun,  2 Aug 2026 00:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785622014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aLoW75OeyWjCn5mDPhOVH7SIR/aVWGMDXLzfTVWEJBI=;
	b=lzihplHdvydJH/091E/Cch/Ix9xYTjr/DAo4r5EjdA0yD+khNcV+3KsvIk2Q8KQUUYlHGo
	e+6A7uJ/41+F2VP+zcQLxSdjrVXapxvj18T+U+hAHnkWQGi3Cmww8bgohlyPz5y7RiNXJl
	XK7imxuZftWFkN/Q1YXkNt4PxgoCIdk4xp3dpjCFW7Ak0pNC3Q500kZor/A/28MtjECYpV
	RyHHh/4sVGypHjeleizjW4SA+cD87D9mdRHthsNCoMko3u+qw0oDS72McStmQ6pusVD2EI
	0X4mLDxgqGy+i1vs/8IvtvS3q/b9rJy4o5qiYopWBHAUMT9CPl+LLg+Xbx9O4Q==
Date: Sun, 2 Aug 2026 00:06:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] rtc: s35390a: Fix alarm not disabling
Message-ID: <20260801220650361c83dd@mail.local>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-3-f10c99ad1d6c@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-rtc_s35390a_int1-v2-3-f10c99ad1d6c@posteo.de>
X-Last-TLS-Session-Version: TLSv1.3

On 01/08/2026 18:43:02+0000, Markus Probst wrote:
> Implement alarm_irq_enable callback to disable alarm if requested.
> On reenable restore last used alarm time.
> 
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support for rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/rtc/rtc-s35390a.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4cfe7034c516..fbf5471eb3d0 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -64,6 +64,7 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
>  
>  struct s35390a {
>  	struct i2c_client *client[8];
> +	struct rtc_time tm_alarm;
>  	int twentyfourhour;
>  };
>  
> @@ -320,6 +321,9 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
>  								sizeof(buf));
>  
> +	if (!err)
> +		s35390a->tm_alarm = alm->time;
> +
>  	return err;
>  }
>  
> @@ -379,6 +383,19 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	return 0;
>  }
>  
> +static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct s35390a *s35390a = dev_get_drvdata(dev);
> +	struct rtc_wkalrm alm;
> +
> +	alm.enabled = enabled;
> +
> +	if (enabled)
> +		alm.time = s35390a->tm_alarm;
> +
> +	return s35390a_rtc_set_alarm(dev, &alm);

You should do the opposite, set_alarm needs to call
s35390a_rtc_alarm_irq_enable instead or simply set S35390A_CMD_STATUS2
here.

> +}
> +
>  static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
>  			     unsigned long arg)
>  {
> @@ -410,11 +427,12 @@ static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
>  }
>  
>  static const struct rtc_class_ops s35390a_rtc_ops = {
> -	.read_time	= s35390a_rtc_read_time,
> -	.set_time	= s35390a_rtc_set_time,
> -	.set_alarm	= s35390a_rtc_set_alarm,
> -	.read_alarm	= s35390a_rtc_read_alarm,
> -	.ioctl          = s35390a_rtc_ioctl,
> +	.read_time		= s35390a_rtc_read_time,
> +	.set_time		= s35390a_rtc_set_time,
> +	.set_alarm		= s35390a_rtc_set_alarm,
> +	.read_alarm		= s35390a_rtc_read_alarm,
> +	.alarm_irq_enable	= s35390a_rtc_alarm_irq_enable,
> +	.ioctl			= s35390a_rtc_ioctl,
>  };
>  
>  static int s35390a_nvmem_read(void *priv, unsigned int offset, void *val,
> 
> -- 
> 2.54.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
