Return-Path: <rtc-linux+bncBAABBTXZ462QKGQEMMZWZ6Q@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id u66si5303566pfa.2.2016.02.09.06.50.54
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Feb 2016 06:50:54 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V6 1/6] regmap: irq: dispose all virtual irq
 before removing domain
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
 broonie@kernel.org, gregkh@linuxfoundation.org, a.zummo@towertech.it
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
 <1455020907-4564-2-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56B9FCC7.1000303@osg.samsung.com>
Date: Tue, 9 Feb 2016 11:50:47 -0300
MIME-Version: 1.0
In-Reply-To: <1455020907-4564-2-git-send-email-ldewangan@nvidia.com>
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

On 02/09/2016 09:28 AM, Laxman Dewangan wrote:
> It is require to dispose all virtual irq of hwirq on chip
> created on given irq domain before removing this irq domain.
> Hence dispose all mapped irqs before deleting the irq domains
> in regmap_del_irq_chip();
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>

The patch looks good to me and I've also tested on an Exynos5800
Peach Pi Chromebook that S2R works correctly after the RTC dev
was unbind so the bug is gone with this version of your series.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

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
