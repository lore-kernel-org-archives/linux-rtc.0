Return-Path: <rtc-linux+bncBDKZNNNLXAHBBTMIYW2QKGQEHNGAS7A@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id jg4si465628pac.2.2016.02.02.16.05.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 16:05:33 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Y002GY2X43180@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 03 Feb 2016 00:05:28 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: max77686: avoid reference of parent
 device info multiple palces
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454419012-18050-1-git-send-email-ldewangan@nvidia.com>
 <1454419012-18050-4-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B14447.6070702@samsung.com>
Date: Wed, 03 Feb 2016 09:05:27 +0900
MIME-version: 1.0
In-reply-to: <1454419012-18050-4-git-send-email-ldewangan@nvidia.com>
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

On 02.02.2016 22:16, Laxman Dewangan wrote:
> Get rid of referring parent device info for register access
> all the places by making regmap as part of max77686 rtc
> device info. This will also remove the need of storing parent
> device info in max77686 rtc device info as this is no more required.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/rtc/rtc-max77686.c | 52 ++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 29 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on Trats2/max77686:
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
