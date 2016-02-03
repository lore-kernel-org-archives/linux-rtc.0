Return-Path: <rtc-linux+bncBAABBEXSY62QKGQEUKVIQWQ@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si823965pfr.0.2016.02.03.04.56.50
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Feb 2016 04:56:50 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V2 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
 <1454491848-26551-6-git-send-email-ldewangan@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Message-ID: <56B1F90A.6030105@osg.samsung.com>
Date: Wed, 3 Feb 2016 09:56:42 -0300
MIME-Version: 1.0
In-Reply-To: <1454491848-26551-6-git-send-email-ldewangan@nvidia.com>
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

Hello Laxman,

On 02/03/2016 06:30 AM, Laxman Dewangan wrote:
> To make RTC block of MAX77686/MAX77802 as independent driver,
> move the registration of i2c device, regmap for register access
> and irq_chip for interrupt support inside the RTC driver.
> Removed the same initialisation from MFD driver.
>
> Having this change will allow to reuse this driver for different
> PMIC/devices from Maxim Semiconductor if they kept same RTC IP on
> different PMIC. Some of examples as PMIC MAX77620, MAX20024 where
> same RTC IP used and hence driver for these chips will use this
> driver only for RTC support.
>
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
>

[snip]

>
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index ab1f2cd..10984c4 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -12,6 +12,7 @@
>    *
>    */
>
> +#include <linux/i2c.h>
>   #include <linux/slab.h>
>   #include <linux/rtc.h>
>   #include <linux/delay.h>
> @@ -22,6 +23,9 @@
>   #include <linux/irqdomain.h>
>   #include <linux/regmap.h>
>
> +#define MAX77686_I2C_ADDR_RTC		(0x0C >> 1)
> +#define INVALID_I2C_ADDR		(-1)
> +

Maybe call it MAX77686_INVALID_I2C_ADDR for consistency?

The patch looks good modulo the issues pointed out by Krzysztof, so after
fixing these feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Since you are going to re-spin another version, I'll wait for that to test.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
