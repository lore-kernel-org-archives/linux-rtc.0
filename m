Return-Path: <rtc-linux+bncBDKZNNNLXAHBBVOU3K3AKGQEHFDKIZY@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id ui7si5031709pab.0.2016.03.02.00.54.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 00:54:45 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E00FQ4M35FY20@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 08:54:41 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456907785-11942-1-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D6AA4C.10203@samsung.com>
Date: Wed, 02 Mar 2016 17:54:36 +0900
MIME-version: 1.0
In-reply-to: <1456907785-11942-1-git-send-email-ldewangan@nvidia.com>
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

On 02.03.2016 17:36, Laxman Dewangan wrote:
> Maxim Semiconductor's PMIC MAX77686 has RTC IP which is
> reused in the MAX77620/MAX20024 PMICs.
> 
> Add support for these devices in MAX77686 RTC driver. This
> device does not have RTC alarm pending status outside of
> RTC IP. The RTC IP is having separate I2C address for its
> register access.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Remove macro and use value directly.
> - Handle error returned from platform_get_irq()
> - Remove compatible for max77620.
> - Cleanup like  indenting.
> 
>  drivers/rtc/Kconfig        |  4 ++--
>  drivers/rtc/rtc-max77686.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
