Return-Path: <rtc-linux+bncBD2OLRXW4ABBBOXXQ62QKGQEHJGOJOY@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id tn7si655753pac.1.2016.01.22.01.51.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 01:51:54 -0800 (PST)
Message-ID: <56A1F935.2040904@nvidia.com>
Date: Fri, 22 Jan 2016 15:11:09 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	<linux-kernel@vger.kernel.org>
CC: Kukjin Kim <kgene@kernel.org>, <rtc-linux@googlegroups.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <linux-samsung-soc@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 03/10] rtc: max77686: Use usleep_range()
 instead of msleep()
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com> <1453407813-14646-4-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453407813-14646-4-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>   	RTC_SEC = 0,
> @@ -130,7 +130,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
>   				__func__, ret, data);
>   	else {
>   		/* Minimum 16ms delay required before RTC update. */
> -		msleep(MAX77686_RTC_UPDATE_DELAY);
> +		usleep_range(MAX77686_RTC_UPDATE_DELAY,
> +			     MAX77686_RTC_UPDATE_DELAY * 2);
>   	}
>

Instead of making usleep_range(16000, 32000), can we make small range as
usleep_range(16000, 17000)?

I am using as usleep_range(16000, 16000) always.

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
