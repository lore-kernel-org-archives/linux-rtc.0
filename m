Return-Path: <rtc-linux+bncBDKZNNNLXAHBBRMMUG2QKGQEDCYXE2I@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id tn7si535468pac.1.2016.01.26.20.23.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 20:23:32 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L000GIG74GQ00@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 04:23:28 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v4 06/10] rtc: max77686: Add max77802 support
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
 <1453865806-4661-7-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A84636.2000107@samsung.com>
Date: Wed, 27 Jan 2016 13:23:18 +0900
MIME-version: 1.0
In-reply-to: <1453865806-4661-7-git-send-email-javier@osg.samsung.com>
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

On 27.01.2016 12:36, Javier Martinez Canillas wrote:
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
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> 
> ---
> 
> Changes in v4:
> - Add Krzysztof Kozlowski's Tested-by tag to patch #6.
> - Add Andi Shyti's Reviewed-by tag to patch #6.
> - Reverse alarm enable reg check logic. Suggeted by Krzysztof Kozlowski.
> - Return early to avoid an else statement. Suggested by Andi Shyti.
> 
> Changes in v3:
> - Add Laxman Dewangan's Acked-by tag to patch #6.
> 
> Changes in v2:
> - Add a MAX77802 prefix to ALARM_ENABLE_VALUE. Suggested by Krzysztof Kozlowski.
> - Rename .rtcae to .alarm_enable_reg and .rtcrm to .separate_i2c_addr.
>   Suggested by Krzysztof Kozlowski.
> - Don't use func and LINE in error messages. Suggested by Krzysztof Kozlowski.
> - Remove REG_RTC_AE2 since is not used by neither max77686 nor max77802.
> - Check if REG_RTC_AE1 has a valid address before accessing it.
> 
>  drivers/rtc/rtc-max77686.c | 196 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 156 insertions(+), 40 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

One comment at the end...

[...]


> @@ -524,6 +636,9 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  	info->drv_data = (const struct max77686_rtc_driver_data *)
>  		id->driver_data;
>  
> +	if (!info->drv_data->separate_i2c_addr)
> +		info->max77686->rtc_regmap = info->max77686->regmap;
> +

At this stage I don't like the idea of messing with parent's state
structure. The driver should not modify any of parents data (the best
way would be to take a pointer to const). In this patch this looks like
breaking the encapsulation. If the parent is responsible for regmaps,
then the parent should set rtc_regmap for children (parent also knows
what type device it is working on).

...but I am assuming that a new patch will be following this one - the
patch moving ownership of i2c dummy and regmap to the RTC driver. In
that case this code makes a lot more sense. Am I thinking correctly?

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
