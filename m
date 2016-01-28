Return-Path: <rtc-linux+bncBAABBH5UUW2QKGQERMM4AHQ@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si1054315pac.2.2016.01.27.16.00.31
        for <rtc-linux@googlegroups.com>;
        Wed, 27 Jan 2016 16:00:31 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: max77686: Cleanup and reduce dmesg output
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alessandro Zummo
 <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
References: <1453877171-30510-1-git-send-email-k.kozlowski@samsung.com>
Cc: Andi Shyti <andi.shyti@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A95A17.2070900@osg.samsung.com>
Date: Wed, 27 Jan 2016 21:00:23 -0300
MIME-Version: 1.0
In-Reply-To: <1453877171-30510-1-git-send-email-k.kozlowski@samsung.com>
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

On 01/27/2016 03:46 AM, Krzysztof Kozlowski wrote:
> Cleanup of entire driver of its dmesg output:
> 1. Remove printing of the function name, because printing device name is
>     sufficient. This also makes the dev_err()-like functions more compact
>     and readable (not need of line break).
> 2. Lower from info to debug printing of each RTC interrupt (no need to
>     make noise on each alarm).
> 3. Remove dev_info() at beginning of probe because a message is already
>     always printed by either probe failure or from registering the RTC
>     device as /dev/rtcX.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Patch looks good to me.

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
