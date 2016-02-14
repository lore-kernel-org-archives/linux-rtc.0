Return-Path: <rtc-linux+bncBDKZNNNLXAHBB2NDQS3AKGQE4DFL7CI@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ui7si3021197pab.0.2016.02.14.15.46.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 15:46:49 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2K00C7VA1WCB00@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Sun, 14 Feb 2016 23:46:44 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V7 4/5] mfd: max77686: do not set i2c client
 data for rtc i2c client
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com,
 broonie@kernel.org, gregkh@linuxfoundation.org, a.zummo@towertech.it
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
 <1455038794-9921-5-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56C111DF.2020005@samsung.com>
Date: Mon, 15 Feb 2016 08:46:39 +0900
MIME-version: 1.0
In-reply-to: <1455038794-9921-5-git-send-email-ldewangan@nvidia.com>
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
> There is different RTC I2C address for RTC block in MAX77686.
> Driver is creating dummy i2c client for this address to access
> the register of this IP block.
> 
> As there is no call to i2c_get_clientdata() for rtc_i2c client,
> there is no need to store pointer and hence removing the call
> to set client data for rtc i2c client.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

FWIW, on max77686:
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
