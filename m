Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHH6QW2QKGQETC7HVWQ@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id r2si432133pfr.0.2016.01.21.17.00.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 17:00:12 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1B00GVFXG7UQ50@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 22 Jan 2016 01:00:07 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2 04/10] rtc: max77686: Use a driver data
 struct instead hard-coded values
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-5-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A17F1A.8020402@samsung.com>
Date: Fri, 22 Jan 2016 10:00:10 +0900
MIME-version: 1.0
In-reply-to: <1453407813-14646-5-git-send-email-javier@osg.samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22.01.2016 05:23, Javier Martinez Canillas wrote:
> The driver has some hard-coded values such as the minimum delay needed
> before a RTC update or the mask used for the sec/min/hour/etc registers.
> 
> Use a data structure that contains these values and pass as driver data
> using the platform device ID table for each device.
> 
> This allows to make the driver's ops callbacks more generic so other RTC
> that are similar but don't have the same values can also be supported.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v2:
> - Add a max77686 prefix to rtc_driver_data. Suggested by Krzysztof Kozlowski.
> - Comment about the .delay and .mask fields. Suggested by Krzysztof Kozlowski.
> - Change .mask type to u8. Suggested by Krzysztof Kozlowski.
> - Make .drv_data field const. Suggested by Krzysztof Kozlowski.
> - Don't cast to drop const on .drv_data asign. Suggested by Krzysztof Kozlowski.
> - Use platform_get_device_id() macro. Suggested by Krzysztof Kozlowski.
> 
>  drivers/rtc/rtc-max77686.c | 51 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 71ef2240b3fc..16033a2c2756 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -41,8 +41,6 @@
>  #define ALARM_ENABLE_SHIFT		7
>  #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
>  
> -#define MAX77686_RTC_UPDATE_DELAY	16000
> -
>  enum {
>  	RTC_SEC = 0,
>  	RTC_MIN,
> @@ -54,6 +52,13 @@ enum {
>  	RTC_NR_TIME
>  };
>  
> +struct max77686_rtc_driver_data {
> +	/* Minimum delay needed for a RTC update */
> +	unsigned long		delay;
> +	/* Mask used to read RTC registers value */
> +	u8			mask;
> +};
> +
>  struct max77686_rtc_info {
>  	struct device		*dev;
>  	struct max77686_dev	*max77686;
> @@ -63,6 +68,8 @@ struct max77686_rtc_info {
>  
>  	struct regmap		*regmap;
>  
> +	const struct max77686_rtc_driver_data *drv_data;
> +
>  	int virq;
>  	int rtc_24hr_mode;
>  };
> @@ -72,12 +79,19 @@ enum MAX77686_RTC_OP {
>  	MAX77686_RTC_READ,
>  };
>  
> +static const struct max77686_rtc_driver_data max77686_drv_data = {
> +	.delay = 1600,

16000.
wakealarm does not work with 1600.


> +	.mask  = 0x7f,
> +};
> +
>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
> -				   int rtc_24hr_mode)
> +				    struct max77686_rtc_info *info)
>  {
> -	tm->tm_sec = data[RTC_SEC] & 0x7f;
> -	tm->tm_min = data[RTC_MIN] & 0x7f;
> -	if (rtc_24hr_mode)
> +	int mask = info->drv_data->mask;

u8 mask

Best regards,
Krzysztof

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
