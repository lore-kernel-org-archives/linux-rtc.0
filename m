Return-Path: <rtc-linux+bncBAABBPHXZK2QKGQELZ7RK6Y@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 12si1117598pfb.1.2016.02.03.18.47.24
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Feb 2016 18:47:24 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: max77686: Properly handle
 regmap_irq_get_virq() error code
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alessandro Zummo
 <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
References: <1454545595-31725-1-git-send-email-k.kozlowski@samsung.com>
Cc: ldewangan@nvidia.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56B2BBB4.8090607@osg.samsung.com>
Date: Wed, 3 Feb 2016 23:47:16 -0300
MIME-Version: 1.0
In-Reply-To: <1454545595-31725-1-git-send-email-k.kozlowski@samsung.com>
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

Hello Krzysztof,

On 02/03/2016 09:26 PM, Krzysztof Kozlowski wrote:
> The regmap_irq_get_virq() can return 0 or -EINVAL in error conditions
> but driver checked only for value of 0.
>
> This could lead to a cast of -EINVAL to an unsigned int used as a
> interrupt number for devm_request_threaded_irq(). Although this is not
> yet fatal (devm_request_threaded_irq() will just fail with -EINVAL) but
> might be a misleading when diagnosing errors.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq")
>
> ---
>

Good catch.

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
