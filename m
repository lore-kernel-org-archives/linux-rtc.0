Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA51891A9;
	Sat, 22 Aug 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787404186; cv=none; b=R1azEHlfpdeyUhFZY5rltxhTK21FRQx5YAdm9269OHFqYRBXVi37Luu6JjCvGTIk/wqvzwfNvvzhOlZxJKjuxWbvtlngPzuAFY4e6yZDwGOeHZHKalAjF5GoEQ7BApb8i6F2BkEdV2RtZVnh08j2FtIJyMWggxRc8rsZZBGZ1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787404186; c=relaxed/simple;
	bh=Vw0uzpLZe/isr7QdmdIM3xHajZnpPhlsLCBP4KFYAZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UluiooWaojuOEvWbJ2qDpI4Uiq37h7xlV5zOnxpj2kKNSYS3L1XkNjhHTRx4izzm/5NbnIXhs9XRoQeOj9xu/MKEqCpjDMgPuoKFgR/zlbI0hQr0jJwEmLAk9wQDkDPo7VoTxa+2XW4hJA1FiP3wZJhJetNfrCT1Dq/uaSUmx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YBcAMDMU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YBcAMDMU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 45A4F1A1787;
	Sat, 22 Aug 2026 13:09:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19EF5604C4;
	Sat, 22 Aug 2026 13:09:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D24E11C77A51;
	Sat, 22 Aug 2026 15:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787404169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oPN5F1mfN0OQ5NCm9rlmolsD/xChmhr0vKixOEJx160=;
	b=YBcAMDMUIX1vEwK7pgSs8X7X+JXCfdqol9eKi3rRHqqDTZuy+ub7vx/+1pqbfq1N3ufYVk
	P+fdX3XauxU7UH0VsJQQ3DY2J3Pww2e3r0chMDk+FEKJvYpcuOWF69uczwlntBZkOi0u4l
	H25fH8RsRCaWYrLdXBJMbfylgHDYdVPTJWS+ToZxCbXOtWmV5agAtRipUC0Hd6EI5Ws5EG
	L+I/WzvZIwizeC3vOP6SXgoOLgqI+uyufjuC2/+JCkZbi+HW3kU0Bbb7OpDPAUgJVoTZnx
	CqX3kPwWbgss0DY50qvN3CzFPByr2i7hLPioJYq2Uxh4cls7VUcU4R5zkVTWvg==
Date: Sat, 22 Aug 2026 15:09:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Message-ID: <2026082213092838377a26@mail.local>
References: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
X-Last-TLS-Session-Version: TLSv1.3

On 22/08/2026 14:59:11+0530, Dhaval Shiroya wrote:
> Enable and set the backup switch mode directly from the device tree at
> probe, instead of requiring a userspace RTC_PARAM_BACKUP_SWITCH_MODE
> ioctl on every unit.
> 

No, just use the ioctl.

> Signed-off-by: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>
> 
> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> index d96f6bb68850..5dde1aed76dd 100644
> --- a/drivers/rtc/rtc-rv3028.c
> +++ b/drivers/rtc/rtc-rv3028.c
> @@ -80,6 +80,7 @@
>  #define RV3028_EEBUSY_TIMEOUT		100000
>  
>  #define RV3028_BACKUP_TCE		BIT(5)
> +#define RV3028_BACKUP_FEDE		BIT(4)
>  #define RV3028_BACKUP_TCR_MASK		GENMASK(1,0)
>  #define RV3028_BACKUP_BSM		GENMASK(3,2)
>  
> @@ -519,70 +520,6 @@ static int rv3028_set_offset(struct device *dev, long offset)
>  
>  }
>  
> -static int rv3028_param_get(struct device *dev, struct rtc_param *param)
> -{
> -	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
> -	int ret;
> -	u32 value;
> -
> -	switch(param->param) {
> -	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &value);
> -		if (ret < 0)
> -			return ret;
> -
> -		value = FIELD_GET(RV3028_BACKUP_BSM, value);
> -
> -		switch(value) {
> -		case RV3028_BACKUP_BSM_DSM:
> -			param->uvalue = RTC_BSM_DIRECT;
> -			break;
> -		case RV3028_BACKUP_BSM_LSM:
> -			param->uvalue = RTC_BSM_LEVEL;
> -			break;
> -		default:
> -			param->uvalue = RTC_BSM_DISABLED;
> -		}
> -		break;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int rv3028_param_set(struct device *dev, struct rtc_param *param)
> -{
> -	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
> -	u8 mode;
> -
> -	switch(param->param) {
> -	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		switch (param->uvalue) {
> -		case RTC_BSM_DISABLED:
> -			mode = 0;
> -			break;
> -		case RTC_BSM_DIRECT:
> -			mode = RV3028_BACKUP_BSM_DSM;
> -			break;
> -		case RTC_BSM_LEVEL:
> -			mode = RV3028_BACKUP_BSM_LSM;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		return rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_BSM,
> -					 FIELD_PREP(RV3028_BACKUP_BSM, mode));
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int rv3028_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  {
>  	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
> @@ -852,8 +789,6 @@ static const struct rtc_class_ops rv3028_rtc_ops = {
>  	.read_offset = rv3028_read_offset,
>  	.set_offset = rv3028_set_offset,
>  	.ioctl = rv3028_ioctl,
> -	.param_get = rv3028_param_get,
> -	.param_set = rv3028_param_set,
>  };
>  
>  static const struct regmap_config regmap_config = {
> @@ -920,6 +855,65 @@ static u8 rv3028_set_trickle_charger(struct rv3028_data *rv3028,
>  	return ret;
>  }
>  
> +/*
> + * Configure backup switchover mode from device tree.
> + *   0 = disabled
> + *   1 = DSM (Direct Switching Mode)  - switch when VDD < VBACKUP
> + *   3 = LSM (Level Switching Mode)   - switch when VDD < 2.0V
> + */
> +static int rv3028_set_bsm_from_dt(struct rv3028_data *rv3028,
> +				  struct i2c_client *client)
> +{
> +	u32 val_old, bsm_dt, bsm_bits;
> +	int ret;
> +
> +	if (device_property_read_u32(&client->dev, "backup-switch-mode",
> +				     &bsm_dt))
> +		return 0;
> +
> +	/* Validate and convert DT value to register bits */
> +	switch (bsm_dt) {
> +	case 0:
> +		bsm_bits = 0;
> +		break;
> +	case 1:
> +		bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_DSM);
> +		break;
> +	case 3:
> +		bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_LSM);
> +		break;
> +	default:
> +		dev_warn(&client->dev,
> +			 "invalid backup-switch-mode %u (use 0, 1, or 3)\n",
> +			 bsm_dt);
> +		return 0;
> +	}
> +
> +	/* Read current BACKUP register */
> +	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check if BSM and FEDE already match desired values */
> +	if ((val_old & (RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) ==
> +	    (bsm_bits | RV3028_BACKUP_FEDE)) {
> +		dev_dbg(&client->dev,
> +			"backup switch mode already set to %u\n", bsm_dt);
> +		return 0;
> +	}
> +
> +	dev_info(&client->dev,
> +		 "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",
> +		 bsm_dt, val_old,
> +		 (val_old & ~(RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) |
> +		 bsm_bits | RV3028_BACKUP_FEDE);
> +
> +	/* Set BSM and always enable FEDE as recommended by datasheet */
> +	return rv3028_update_cfg(rv3028, RV3028_BACKUP,
> +				 RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE,
> +				 bsm_bits | RV3028_BACKUP_FEDE);
> +}
> +
>  static int rv3028_probe(struct i2c_client *client)
>  {
>  	struct rv3028_data *rv3028;
> @@ -1005,11 +999,14 @@ static int rv3028_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
> +	/* Configure backup switchover mode from device tree */
> +	ret = rv3028_set_bsm_from_dt(rv3028, client);
>  	if (ret)
>  		return ret;
>  
> -	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rv3028->rtc->features);
> +	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
> +	if (ret)
> +		return ret;
>  
>  	rv3028->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
>  	rv3028->rtc->range_max = RTC_TIMESTAMP_END_2099;
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
