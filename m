Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C82C15BB;
	Thu,  6 Aug 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020818; cv=none; b=AHVKkJuX9yMsk+XD3TaD4rbT/k/cLRub0QOgG6uLRKk1N12wgKmkbyEdUdmk+gdvlFRJysqr4npwAMfuT+aPpySapRjRUPwg8f+JSZf843CSJKuBA28tVeeme0WqjnyPOHQkIg16IoemwX3rkFL2O5OGhG9wSplSJw/zjIkKRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020818; c=relaxed/simple;
	bh=+xIefjwf8ssk5cRcoO/lIskGPHUwLSnyJiIYe+sXnCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHPciS3+uztRnV4PivILNKGmLacUO5SYomETGFDDCPU8KFHDN8sagQIiJsMP7+ZN0dnEqBGROhefTWOTq2tKxkOQtTS8eiJ7hHGP/uvghzR//bdwIAeWqZu21MPKbpVxnLqq3Y122QYIu8xLiAIqzlB66+XndDIr4phD8KSDvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 766C82020FE;
	Thu, 06 Aug 2026 14:53:28 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1wrxbE-0005ni-18;
	Thu, 06 Aug 2026 14:53:28 +0200
Message-ID: <4b1effd0-3081-4d37-aaf2-3dad8788faff@pengutronix.de>
Date: Thu, 6 Aug 2026 14:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rtc: pcf2127: add pcf2127_pwrmng_get/set
To: Hugo Villeneuve <hugo@hugovil.com>, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bruno.thomsen@gmail.com, giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
 antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-3-hugo@hugovil.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20260311200237.3531981-3-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/26 21:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add common functions to get/set the pwrmng field in the CTRL3 register,
> used by pcf2127_param_get() and pcf2127_param_set().
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> These functions will also be used in the following patch
> to add battery low detection.
> ---
>   drivers/rtc/rtc-pcf2127.c | 42 +++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index e2e9746027348..0605295026564 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -213,6 +213,30 @@ struct pcf2127 {
>   	bool ts_valid[PCF2127_MAX_TS_SUPPORTED];  /* Timestamp valid indication. */
>   };
>   
> +static int pcf2127_pwrmng_get(struct device *dev, u8 *pwrmng)
> +{
> +	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> +	u32 value;
> +	int ret;
> +
> +	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	*pwrmng = FIELD_GET(PCF2127_CTRL3_PM, value);
> +
> +	return 0;
> +}
> +
> +static int pcf2127_pwrmng_set(struct device *dev, u8 pwrmng)
> +{
> +	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> +
> +	return regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
> +				  PCF2127_CTRL3_PM,
> +				  FIELD_PREP(PCF2127_CTRL3_PM, pwrmng));
> +}
> +
>   /*
>    * In the routines that deal directly with the pcf2127 hardware, we use
>    * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -337,18 +361,15 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   
>   static int pcf2127_param_get(struct device *dev, struct rtc_param *param)
>   {
> -	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> -	u32 value;
> +	u8 value;
>   	int ret;
>   
>   	switch (param->param) {
>   	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &value);
> +		ret = pcf2127_pwrmng_get(dev, &value);
>   		if (ret < 0)
>   			return ret;
>   
> -		value = FIELD_GET(PCF2127_CTRL3_PM, value);
> -
>   		if (value < 0x3)
>   			param->uvalue = RTC_BSM_LEVEL;
>   		else if (value < 0x6)
> @@ -367,19 +388,16 @@ static int pcf2127_param_get(struct device *dev, struct rtc_param *param)
>   
>   static int pcf2127_param_set(struct device *dev, struct rtc_param *param)
>   {
> -	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
>   	u8 mode = 0;
> -	u32 value;
> +	u8 value;
>   	int ret;
>   
>   	switch (param->param) {
>   	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &value);
> +		ret = pcf2127_pwrmng_get(dev, &value);
>   		if (ret < 0)
>   			return ret;
>   
> -		value = FIELD_GET(PCF2127_CTRL3_PM, value);
> -
>   		if (value > 5)
>   			value -= 5;
>   		else if (value > 2)
> @@ -400,9 +418,7 @@ static int pcf2127_param_set(struct device *dev, struct rtc_param *param)
>   			return -EINVAL;
>   		}
>   
> -		return regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
> -					  PCF2127_CTRL3_PM,
> -					  FIELD_PREP(PCF2127_CTRL3_PM, mode + value));
> +		return pcf2127_pwrmng_set(dev, mode + value);
>   
>   	default:
>   		return -EINVAL;

Reviewed-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

