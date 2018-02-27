Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:39007 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0CxP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 26 Feb 2018 21:53:15 -0500
Message-ID: <5A94C80E.8020203@rock-chips.com>
Date: Tue, 27 Feb 2018 10:53:02 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org
CC: zyw@rock-chips.com, briannorris@google.com, dianders@google.com,
        jwerner@chromium.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3] rtc: cros-ec: return -ETIME when refused to set alarms
 in the past
References: <20180227024734.7591-1-jeffy.chen@rock-chips.com>
In-Reply-To: <20180227024734.7591-1-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi guys,

On 02/27/2018 10:47 AM, Jeffy Chen wrote:
>   		/* Don't set an alarm in the past. */
>   		if ((u32)alarm_time < current_time)
Oops, i'm a idiot, forgot to use '<='... will resend it.
> -			alarm_offset = EC_RTC_ALARM_CLEAR;
> -		else
> -			alarm_offset = (u32)alarm_time - current_time;
> +			return -ETIME;
> +
> +		alarm_offset = (u32)alarm_time - current_time;
>   	}
