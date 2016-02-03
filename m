Return-Path: <rtc-linux+bncBAABB7PNY62QKGQEXHKJNUY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si820022pfr.0.2016.02.03.04.47.56
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Feb 2016 04:47:56 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V2 4/5] mfd: max77686: do not set i2c client
 data for rtc i2c client
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
 <1454491848-26551-5-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56B1F6F4.6040601@osg.samsung.com>
Date: Wed, 3 Feb 2016 09:47:48 -0300
MIME-Version: 1.0
In-Reply-To: <1454491848-26551-5-git-send-email-ldewangan@nvidia.com>
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
> There is different RTC I2C address for RTC block in MAX77686.
> Driver is creating dummy i2c client for this address to access
> the register of this IP block.
>
> As there is no need to get any data from this rtc i2c client,
> it is not required to set client data for this i2c client.
>
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

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
