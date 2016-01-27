Return-Path: <rtc-linux+bncBAABB2WTUC2QKGQEFIBL55Q@googlegroups.com>
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id ui7si519469pab.0.2016.01.26.18.22.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 18:22:34 -0800 (PST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1L01VP0ALLLR20@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 11:22:33 +0900 (KST)
Date: Wed, 27 Jan 2016 11:22:32 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 06/10] rtc: max77686: Add max77802 support
Message-id: <20160127022232.GH14296@samsunx.samsung>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-7-git-send-email-javier@osg.samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1453836020-29579-7-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 26, 2016 at 04:20:16PM -0300, Javier Martinez Canillas wrote:
> The MAX77686 and MAX77802 RTC IP blocks are very similar with only
> these differences:
> 
> 0) The RTC registers layout and addresses are different.
> 
> 1) The MAX77686 use 1 bit of the sec/min/hour/etc registers as the
>    alarm enable while MAX77802 has a separate register for that.
> 
> 2) The MAX77686 RTCYEAR register valid values range is 0..99 while
>    for MAX77802 is 0..199.
> 
> 3) The MAX77686 has a separate I2C address for the RTC registers
>    while the MAX77802 uses the same I2C address as the PMIC regs.
> 
> 5) The minimum delay before a RTC update (16 msecs vs 200 usecs).
> 
> There are separate drivers for MAX77686 and MAX77802 RTC IP blocks
> but the differences are not that big so the driver can be extended
> to support both instead of duplicating a lot of code in 2 drivers.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Just a nitpick, though.

> -static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
> +static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
> +				   struct max77686_rtc_info *info)
>  {
>  	data[RTC_SEC] = tm->tm_sec;
>  	data[RTC_MIN] = tm->tm_min;
> @@ -178,13 +240,19 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>  	data[RTC_WEEKDAY] = 1 << tm->tm_wday;
>  	data[RTC_DATE] = tm->tm_mday;
>  	data[RTC_MONTH] = tm->tm_mon + 1;
> -	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>  
> -	if (tm->tm_year < 100) {
> -		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
> -			1900 + tm->tm_year);
> -		return -EINVAL;
> +	if (!info->drv_data->alarm_enable_reg) {
> +		data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
> +
> +		if (tm->tm_year < 100) {
> +			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
> +				1900 + tm->tm_year);
> +			return -EINVAL;
> +		}
> +	} else {
> +		data[RTC_YEAR] = tm->tm_year;
>  	}
> +

This can be written als as:

if (info->drv_data->alarm_enable_reg) {
	data[RTC_YEAR] = tm->tm_year;
	return 0;
}

[ ... the rest without any indentation ...]

We make also Krzysztof happy by avoiding the if (!...)

>  	return 0;
>  }

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
