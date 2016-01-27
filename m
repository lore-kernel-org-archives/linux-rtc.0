Return-Path: <rtc-linux+bncBAABBA5XUC2QKGQEYNYCPHA@googlegroups.com>
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id ui7si496512pab.0.2016.01.26.17.21.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 17:21:07 -0800 (PST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1L00ISZ7R5VL50@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 10:21:05 +0900 (KST)
Date: Wed, 27 Jan 2016 10:21:05 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 03/10] rtc: max77686: Use usleep_range()
 instead of msleep()
Message-id: <20160127012105.GC14296@samsunx.samsung>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-4-git-send-email-javier@osg.samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1453836020-29579-4-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 26, 2016 at 04:20:13PM -0300, Javier Martinez Canillas wrote:
> Documentation/timers/timers-howto.txt suggest to use usleep_range()
> instead of msleep() for small msec (1ms - 20ms) since msleep() will
> often sleep for 20ms for any value in that range.
> 
> This is fine in this case since 16ms is the _minimum_ delay required
> by max77686 for an RTC update but by using usleep_range() instead of
> msleep(), the driver can support other RTC IP blocks with a shorter
> minimum delay (i.e: in the range of usecs instead of msecs).
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

> ---
> 
> Changes in v3:
> - Add Krzysztof Kozlowski's Tested-by tag to patch #3.
> - Add Laxman Dewangan's Acked-by tag to patch #3.
> 
> Changes in v2:
> - Add Krzysztof Kozlowski's Reviewed-by tag to patch #3.
> - Fix typo error in changelog. Suggested by Krzysztof Kozlowski.
> 
>  drivers/rtc/rtc-max77686.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index d84a50c9f7f7..025a17a95da3 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -41,7 +41,7 @@
>  #define ALARM_ENABLE_SHIFT		7
>  #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
>  
> -#define MAX77686_RTC_UPDATE_DELAY	16
> +#define MAX77686_RTC_UPDATE_DELAY	16000
>  
>  enum {
>  	RTC_SEC = 0,
> @@ -130,7 +130,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
>  				__func__, ret, data);
>  	else {
>  		/* Minimum 16ms delay required before RTC update. */
> -		msleep(MAX77686_RTC_UPDATE_DELAY);
> +		usleep_range(MAX77686_RTC_UPDATE_DELAY,
> +			     MAX77686_RTC_UPDATE_DELAY * 2);
>  	}
>  
>  	return ret;
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
