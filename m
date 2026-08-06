Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E122423A;
	Thu,  6 Aug 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020910; cv=none; b=THAoH727Ugkun+6dFCxRwWqVGgYAEMNgTWmcCmGL4Fcd1coxn4PCiRQUH9f6w+1YYejcivPIMlKcX6rKW9BgL0XhyMOOvewtKxZe1onq2ZMp4ij87hiazU+708skDM70R48ClIlgWTmzoPCQG09ouyN6Z+vPToiDjUH7KKNXww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020910; c=relaxed/simple;
	bh=V3EeXlDAsyqF2CYhE/gpQ6g8ynCKSbxXduaQvQSZrPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2FaYfDIDXaZUNK3zdmvoCrDmGWnmbL/iGOQq66NSvyM50IovDfvCprsL2J6CHPAsiDk/bLwb5mj3d4S+sWf5/uVamd+yBRGcoR2bHCo9Y1J/ugwQVd8YJ12pxt9i35bMbk23tvrGuBMY+e2MoD+Cs+CWwEQp1/qTtvf23U2JTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C98A2200F4F;
	Thu, 06 Aug 2026 14:55:01 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1wrxcj-0005nq-2C;
	Thu, 06 Aug 2026 14:55:01 +0200
Message-ID: <eeff2fb8-889a-4884-81d8-e4cda7ac5e9e@pengutronix.de>
Date: Thu, 6 Aug 2026 14:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rtc: add battery low voltage detection feature
To: Hugo Villeneuve <hugo@hugovil.com>, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bruno.thomsen@gmail.com, giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
 antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
 <20260311200237.3531981-4-hugo@hugovil.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20260311200237.3531981-4-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/26 21:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Some RTCs have a battery low voltage detection function. Add new feature
> so that it can be enabled, disabled or queried at runtime.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   include/uapi/linux/rtc.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
> index 97aca4503a6a3..596eec119bb3a 100644
> --- a/include/uapi/linux/rtc.h
> +++ b/include/uapi/linux/rtc.h
> @@ -134,18 +134,23 @@ struct rtc_param {
>   #define RTC_FEATURE_CORRECTION		5
>   #define RTC_FEATURE_BACKUP_SWITCH_MODE	6
>   #define RTC_FEATURE_ALARM_WAKEUP_ONLY	7
> -#define RTC_FEATURE_CNT			8
> +#define RTC_FEATURE_BATTERY_LOW_DETECT	8
> +#define RTC_FEATURE_CNT			9
>   
>   /* parameter list */
>   #define RTC_PARAM_FEATURES		0
>   #define RTC_PARAM_CORRECTION		1
>   #define RTC_PARAM_BACKUP_SWITCH_MODE	2
> +#define RTC_PARAM_BATTERY_LOW_DETECT	3
>   
>   #define RTC_BSM_DISABLED	0
>   #define RTC_BSM_DIRECT		1
>   #define RTC_BSM_LEVEL		2
>   #define RTC_BSM_STANDBY		3
>   
> +#define RTC_BATTERY_LOW_DETECT_DISABLED	0
> +#define RTC_BATTERY_LOW_DETECT_ENABLED	1
> +
>   #define RTC_MAX_FREQ	8192
>   
>   

I have opened a PR against util-linux to add support and tested the patchset 
with the extended hwclock binary.

See: https://github.com/util-linux/util-linux/pull/4513

Reviewed-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

