Return-Path: <rtc-linux+bncBDKZNNNLXAHBBIVIY62QKGQESTSDSRQ@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id jg4si690370pac.2.2016.02.03.02.19.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Feb 2016 02:19:14 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Y003WNVBY4K50@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 03 Feb 2016 10:19:10 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 4/5] mfd: max77686: do not set i2c client
 data for rtc i2c client
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
 <1454491848-26551-5-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B1D41B.4090602@samsung.com>
Date: Wed, 03 Feb 2016 19:19:07 +0900
MIME-version: 1.0
In-reply-to: <1454491848-26551-5-git-send-email-ldewangan@nvidia.com>
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

On 03.02.2016 18:30, Laxman Dewangan wrote:
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
> This is new in this series based on review comment from V1.
> 

You could trim a little bit the description - "stored pointer is not
retrieved anywhere, there is no call to i2c_get_clientdata()" might be
sufficient but anyway:

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
