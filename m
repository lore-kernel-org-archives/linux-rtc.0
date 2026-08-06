Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090022423A;
	Thu,  6 Aug 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020956; cv=none; b=F44AS3poTV6On/xYTvnvoue69apXCm0KMBcMvaDdKuB9Ryc6Ip/M8BxvdCi1q5ib1Bpw4PT3WWXzbtYjpLIQBtW8ibqZ5D/ApdURTO21u1iAHU+36G9H2MUywwlwqVS/ryomOU5/3Pnb9YshUjmIE2wk1rcQRo58VWWnOzmkudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020956; c=relaxed/simple;
	bh=lITnFJ9oUmoJVTib3q4ocbGMx55D0tmM9rlXFJkq6OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj+afbABpD1qwSUl2i7TBSj/HTR+zeEaQrVBoP9VDMkxN6Vytb1TZ092ZaalkJ83VbG/+J/GhG3PdfgbKB8Vmyz6vpl8WheVRHWOROAzE+VL0Q4x+l4L8UrH3BGQ88nPATm7sEqfaCJjZoHiWgvjmMAirDh+4xx1XDu707C37DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3BCD32000DC;
	Thu, 06 Aug 2026 14:55:47 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1wrxdT-0005o0-0D;
	Thu, 06 Aug 2026 14:55:47 +0200
Message-ID: <0ffe6251-700c-463a-b718-d1ce5caf0e0f@pengutronix.de>
Date: Thu, 6 Aug 2026 14:55:45 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rtc: pcf2127: support battery low voltage detection
 function
To: Hugo Villeneuve <hugo@hugovil.com>, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bruno.thomsen@gmail.com, giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
 antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-5-hugo@hugovil.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20260311200237.3531981-5-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/26 21:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add support for parameter RTC_PARAM_BATTERY_LOW_DETECT in RTC_PARAM_SET
> ioctl to enable/disable/query battery low voltage detection. This is
> especially relevant on the pcf2131 where this function is disabled by
> default, contrary to the pcf2127.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   drivers/rtc/rtc-pcf2127.c | 60 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 0605295026564..05b08867ffcb3 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -364,12 +364,12 @@ static int pcf2127_param_get(struct device *dev, struct rtc_param *param)
>   	u8 value;
>   	int ret;
>   
> +	ret = pcf2127_pwrmng_get(dev, &value);
> +	if (ret < 0)
> +		return ret;
> +
>   	switch (param->param) {
>   	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		ret = pcf2127_pwrmng_get(dev, &value);
> -		if (ret < 0)
> -			return ret;
> -
>   		if (value < 0x3)
>   			param->uvalue = RTC_BSM_LEVEL;
>   		else if (value < 0x6)
> @@ -379,6 +379,14 @@ static int pcf2127_param_get(struct device *dev, struct rtc_param *param)
>   
>   		break;
>   
> +	case RTC_PARAM_BATTERY_LOW_DETECT:
> +		if (value == 0x0 || value == 0x3)
> +			param->uvalue = RTC_BATTERY_LOW_DETECT_ENABLED;
> +		else
> +			param->uvalue = RTC_BATTERY_LOW_DETECT_DISABLED;
> +
> +		break;
> +
>   	default:
>   		return -EINVAL;
>   	}
> @@ -392,12 +400,12 @@ static int pcf2127_param_set(struct device *dev, struct rtc_param *param)
>   	u8 value;
>   	int ret;
>   
> +	ret = pcf2127_pwrmng_get(dev, &value);
> +	if (ret < 0)
> +		return ret;
> +
>   	switch (param->param) {
>   	case RTC_PARAM_BACKUP_SWITCH_MODE:
> -		ret = pcf2127_pwrmng_get(dev, &value);
> -		if (ret < 0)
> -			return ret;
> -
>   		if (value > 5)
>   			value -= 5;
>   		else if (value > 2)
> @@ -418,13 +426,45 @@ static int pcf2127_param_set(struct device *dev, struct rtc_param *param)
>   			return -EINVAL;
>   		}
>   
> -		return pcf2127_pwrmng_set(dev, mode + value);
> +		break;
> +
> +	case RTC_PARAM_BATTERY_LOW_DETECT:
> +		if (value > 5) {
> +			value -= 5;
> +			mode = 5;
> +		} else if (value > 2) {
> +			value -= 3;
> +			mode = 3;
> +		}
> +
> +		switch (param->uvalue) {
> +		case RTC_BATTERY_LOW_DETECT_DISABLED:
> +			if (mode != 5)
> +				if (value == 0)
> +					value = 1;
> +
> +			break;
> +		case RTC_BATTERY_LOW_DETECT_ENABLED:
> +			if (mode != 5)
> +				value = 0; /* Enable battery low detection. */
> +			else
> +				return -EINVAL; /*
> +						 * battery low detection can't be enabled if
> +						 * battery switch over is disabled.
> +						 */
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		break;
>   
>   	default:
>   		return -EINVAL;
>   	}
>   
> -	return 0;
> +	return pcf2127_pwrmng_set(dev, mode + value);
>   }
>   
>   static int pcf2127_rtc_ioctl(struct device *dev,

Works as expected, thank you!

Reviewed-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

