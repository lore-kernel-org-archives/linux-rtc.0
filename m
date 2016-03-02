Return-Path: <rtc-linux+bncBDKZNNNLXAHBB4OU3K3AKGQEOOEBTSA@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id yd9si4989146pab.1.2016.03.02.00.55.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 00:55:12 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E00DULM3WUT20@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 08:55:09 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 2/2] rtc: max77686: Use REGMAP_IRQ_REG for
 regmap-rtc-irqs initialisation
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456907785-11942-1-git-send-email-ldewangan@nvidia.com>
 <1456907785-11942-2-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D6AA68.7090200@samsung.com>
Date: Wed, 02 Mar 2016 17:55:04 +0900
MIME-version: 1.0
In-reply-to: <1456907785-11942-2-git-send-email-ldewangan@nvidia.com>
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
> Use macro REGMAP_IRQ_REG from regmap.h to initialise the
> regmap irq table for max77686 to have better coding style
> and improve readability.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - Added information in commit message for answering why it is done.
> 
>  drivers/rtc/rtc-max77686.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
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
