Return-Path: <rtc-linux+bncBDKZNNNLXAHBB5NEQS3AKGQEHUQDURY@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ui7si3022149pab.0.2016.02.14.15.49.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 15:49:08 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2K00C8EA5SCB00@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Sun, 14 Feb 2016 23:49:04 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V7 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com,
 broonie@kernel.org, gregkh@linuxfoundation.org, a.zummo@towertech.it
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
 <1455038794-9921-6-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56C1126B.80900@samsung.com>
Date: Mon, 15 Feb 2016 08:48:59 +0900
MIME-version: 1.0
In-reply-to: <1455038794-9921-6-git-send-email-ldewangan@nvidia.com>
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

On 10.02.2016 02:26, Laxman Dewangan wrote:
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
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Changes from V1:
> - Remove changes from Kconfig.
> - Maintain all register definition in max77686 private header and remove
>   the movement to rtc driver.
> - Taken care of all comments on V1 from Krzysztof and Javier.
> 
> Changes from V2:
> - Taken care of missed sequence for removing the resource.
> - Fix the crash when doing unbind by using requested_threaded_irq()
>   instead of demv_requested_threaded_irq().
> 
> Changes from V3:
> - Fix the issue of suspend-resume with unbind/bind by unmapping the
>   virq.
> 
> Changes from V4:
> - Dispose mapped irq in error path in probe
> 
> Changes from V5:
> - Remove the new APIs from regmap as functionality added to dispose the
>   virq inside the regmap_del_irq_chip().
> 
> Changes from V6:
> Make this as 5th of series as regmap change applied independently.
> Also rebase on linux-next 20160209
> 
>  drivers/mfd/max77686.c               |  85 +-------------------
>  drivers/rtc/rtc-max77686.c           | 148 ++++++++++++++++++++++++++++++-----
>  include/linux/mfd/max77686-private.h |   3 -
>  3 files changed, 130 insertions(+), 106 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
On max77686:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
