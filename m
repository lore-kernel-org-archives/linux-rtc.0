Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700337FF60;
	Mon, 11 May 2026 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530873; cv=none; b=U9mfc5SdGiEekhlh2u/oNgZefTSpbbMIf7EU5h9qxwPzo8WB3uzYlMhkJ1IZ5nmOzr1gOLzjZUHsGktDXYddldB/eWJU8BYFVzXAMVuT/Nz+cmTv7U/TISuFb83XvMJvj2ssbWPMJaPMsULcfRszteG5pYFZCezAG95GGm37v7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530873; c=relaxed/simple;
	bh=l+WaMOawBO/RYowmCmiGK1x9IGPkzXV98PevDOVbzns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipbKCWhYNz2o92GpQBbCrSWEb4uePr231WT+547TE7hcFiAHQXhOvUKpzOUrgkXiuftg0wJyghJHnJt6ihev3oAjdk6fQOnO/vmoiUDLvdxta9m/3PN7Dsppce6M4B8cwFUh9JR9YX7yOet8OHdl/4/hHGLl9suZyHNAQ1cnrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlRaFajK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlRaFajK"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id 0F88420B7166; Mon, 11 May 2026 13:21:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F88420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778530870;
	bh=9Isige1wAsuEWm8kiOJqaV5UCc3ybjvYEdwmOW4BkR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlRaFajK8JndLUmCb4YQW9e10vVf3wMV/xjkeurIgeCHBzFtE3a6w0v60bdooP21M
	 V667AxYNNRmqZcxdLeYGhQEzluAmYW1+6nQNytu4+Ckn8jo6aqF+P5pjI1ucDhYtd0
	 c/lokDTif+ETY7VKX5QRkzy6OPMKDyozyxMEl1n8=
Date: Mon, 11 May 2026 13:21:10 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Sasha Levin <sashal@kernel.org>,
	Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3] rtc: ds1307: handle oscillator stop flag for
 ds1337/ds1339/ds3231
Message-ID: <20260511-da8f705069778e5e3335ca43@linux.microsoft.com>
References: <20260508032518.3696705-2-ronan.dalton@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508032518.3696705-2-ronan.dalton@alliedtelesis.co.nz>

On Fri, May 08, 2026 at 03:24:49PM +1200, Ronan Dalton wrote:
> Prior to commit 48458654659c ("rtc: ds1307: remove clear of oscillator
> stop flag (OSF) in probe"), the oscillator stop flag (OSF) bit was
> checked during device probe for the ds1337, ds1339, ds1341, and ds3231
> chips; if it was set, it would be cleared and a warning would be logged
> saying "SET TIME!". Since that commit, the OSF bit is no longer cleared,
> but the warning is still printed.
> 
> Directly following that commit, there was no way to get rid of this
> warning because nothing cleared the OSF bit on these chips.
> 
> The commit associated with the previous commit, 523923cfd5d6 ("rtc:
> ds1307: handle oscillator stop flag (OSF) for ds1341"), made proper use
> of the OSF when getting and setting the time in the RTC. However, the
> other RTC variants ds1337, ds1339 and ds3231 didn't have a corresponding
> change made.
> 
> Given that the OSF bit is no longer cleared at probe time when it is
> set, the remaining three chips should have the same handling as the
> ds1341 chip has for the OSF bit.
> 
> Fix the issue on the ds1337, ds1339 and ds3231 chips by applying the
> same logic as the ds1341 has to these chips.
> 
> Note that any devices brought up between the first referenced commit and
> this one may begin mistrusting the time reported by the RTC until it is
> set again, if the bit was never explicitly cleared.
> 
> Note that only the ds1339 was tested with this change, but the
> datasheets for the other chips contain essentially identical
> descriptions of the OSF bit so the same change should work.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> Cc: Rodolfo Giometti <giometti@enneenne.com>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Fixes: 48458654659c ("rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe")
> ---
> Changes in v3:
> - Remove paragraph mentioning alternative fix from commit message
> 
> Changes in v2:
> - Fix hashes of referenced commits

Reviewed-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>

> 
>  drivers/rtc/rtc-ds1307.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 7205c59ff729..edf81b975dec 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -269,6 +269,16 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
>  		if (tmp & DS1338_BIT_OSF)
>  			return -EINVAL;
>  		break;
> +	case ds_1337:
> +	case ds_1339:
> +	case ds_1341:
> +	case ds_3231:
> +		ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &tmp);
> +		if (ret)
> +			return ret;
> +		if (tmp & DS1337_BIT_OSF)
> +			return -EINVAL;
> +		break;
>  	case ds_1340:
>  		if (tmp & DS1340_BIT_nEOSC)
>  			return -EINVAL;
> @@ -279,13 +289,6 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
>  		if (tmp & DS1340_BIT_OSF)
>  			return -EINVAL;
>  		break;
> -	case ds_1341:
> -		ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &tmp);
> -		if (ret)
> -			return ret;
> -		if (tmp & DS1337_BIT_OSF)
> -			return -EINVAL;
> -		break;
>  	case ds_1388:
>  		ret = regmap_read(ds1307->regmap, DS1388_REG_FLAG, &tmp);
>  		if (ret)
> @@ -380,14 +383,17 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
>  		regmap_update_bits(ds1307->regmap, DS1307_REG_CONTROL,
>  				   DS1338_BIT_OSF, 0);
>  		break;
> +	case ds_1337:
> +	case ds_1339:
> +	case ds_1341:
> +	case ds_3231:
> +		regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
> +				   DS1337_BIT_OSF, 0);
> +		break;
>  	case ds_1340:
>  		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
>  				   DS1340_BIT_OSF, 0);
>  		break;
> -	case ds_1341:
> -		regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
> -				   DS1337_BIT_OSF, 0);
> -		break;
>  	case ds_1388:
>  		regmap_update_bits(ds1307->regmap, DS1388_REG_FLAG,
>  				   DS1388_BIT_OSF, 0);
> -- 
> 2.53.0
