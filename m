Return-Path: <rtc-linux+bncBDKZNNNLXAHBBTODUC2QKGQERMZBORQ@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id u66si45311pfa.2.2016.01.26.17.47.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 17:47:57 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L005CO8ZSE7A0@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 01:47:52 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 04/10] rtc: max77686: Use a driver data
 struct instead hard-coded values
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-5-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A821C1.6090402@samsung.com>
Date: Wed, 27 Jan 2016 10:47:45 +0900
MIME-version: 1.0
In-reply-to: <1453836020-29579-5-git-send-email-javier@osg.samsung.com>
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

On 27.01.2016 04:20, Javier Martinez Canillas wrote:
> The driver has some hard-coded values such as the minimum delay needed
> before a RTC update or the mask used for the sec/min/hour/etc registers.
> 
> Use a data structure that contains these values and pass as driver data
> using the platform device ID table for each device.
> 
> This allows to make the driver's ops callbacks more generic so other RTC
> that are similar but don't have the same values can also be supported.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> 
> Changes in v3:
> - Fix max77686 delay. Suggested by Krzysztof Kozlowski.
> - Assign mask to u8 instead of int. Suggested by Krzysztof Kozlowski.
> - Add Laxman Dewangan's Acked-by tag to patch #4.
> 
> Changes in v2:
> - Add a max77686 prefix to rtc_driver_data. Suggested by Krzysztof Kozlowski.
> - Comment about the .delay and .mask fields. Suggested by Krzysztof Kozlowski.
> - Change .mask type to u8. Suggested by Krzysztof Kozlowski.
> - Make .drv_data field const. Suggested by Krzysztof Kozlowski.
> - Don't cast to drop const on .drv_data asign. Suggested by Krzysztof Kozlowski.
> - Use platform_get_device_id() macro. Suggested by Krzysztof Kozlowski.
> 
>  drivers/rtc/rtc-max77686.c | 51 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 

Tested on Trats2 (max77686):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
