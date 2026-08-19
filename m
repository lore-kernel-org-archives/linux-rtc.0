Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80854361DAB;
	Wed, 19 Aug 2026 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178353; cv=none; b=VWNhonlBTuOqvitOYg5z/Zq1xqo0j8vJkrJoawtQdAWxt6XyqXWcWHNU1y+CKi5XBE9nFVo2ULf5hG9VTCLlCvOTSDmJnJkihVVPtD06BIve+D+Kde2GxBTb0jHXPtTBpma6kJRLvHqLglvno7z1kqDiz0pgew+Z4E2SweYwkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178353; c=relaxed/simple;
	bh=FcfWrywkDBqGoLU1Yrszmtu1f4x4VGFP2Fp34lnybro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZoEaWXOEmFKF4Nh/BLDURe3q17UzxGuqoJPEu4aRyStgos+aReJkUd8mFSDPoz2Nb3xlmZHdN20t8eh33H2t1YPQm6an5RLMVb1ewxkP3oKawBm3RQr+fE218uyFlBXPvuo8Ck8EJfNwS4QHIudt5wv/2bzuA4IAGe6LyLIj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYbCaxaU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYbCaxaU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D56F34E412DF;
	Wed, 19 Aug 2026 22:25:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FDF45FF42;
	Wed, 19 Aug 2026 22:25:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F4A711C75BF8;
	Thu, 20 Aug 2026 00:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787178344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qUHF/iiwesIbimQHX6jq2u+WabfFlLd7D+fMwnkKIsA=;
	b=JYbCaxaU3RsAOJeIbw/wpZPp+zf5o1Q32Yfcredac8E06E91juxJ4zuUmiVunBi5poy1E9
	9CPGhpZ13mrps2B7PuIfs6ujXEZ5hCdZjVf4dYIQ9FnDRIkaPta+abyrAFemliH3NPcOkE
	9SLuj3bUIRxgm7ner+/CRQbT9zw/G3f/5UPM+NdJSuIX/0+eHju1kMz5ED6njDYcjhTPkE
	rjAmw3qnAV6Zmne+d/Git/elI6mAGZxYWw1TfTQ6OQ/jvpr3krJmlWyymTpqwAh0SQwzKa
	XvSlolFeFiDkgnsZiacjpK9/6xEL9XNB68XygzPDx/utRKEECGqLi4pRpQhdoQ==
Date: Thu, 20 Aug 2026 00:25:41 +0200
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
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] rtc: s35390a: Fix alarm not disabling
Message-ID: <2026081922254172956b52@mail.local>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-3-5eb4ef85c6a9@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-rtc_s35390a_int1-v5-3-5eb4ef85c6a9@posteo.de>
X-Last-TLS-Session-Version: TLSv1.3

On 19/08/2026 22:05:55+0000, Markus Probst wrote:
> Implement alarm_irq_enable callback.
> 
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support for rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/rtc/rtc-s35390a.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4cfe7034c516..575bb256eb25 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -270,6 +270,24 @@ static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> +static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct s35390a *s35390a = dev_get_drvdata(dev);
> +	u8 sts;
> +	int err;
> +
> +	if (enabled)
> +		sts = S35390A_INT2_MODE_ALARM;
> +	else
> +		sts = S35390A_INT2_MODE_NOINTR;
> +
> +	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}


You can definitively call this from s35390a_rtc_set_alarm instead of
duplicating code.

> +
>  static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -410,11 +428,12 @@ static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
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
