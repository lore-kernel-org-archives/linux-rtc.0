Return-Path: <rtc-linux+bncBDKZNNNLXAHBBGP3QW2QKGQEFYEBV5A@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id r2si430436pfr.0.2016.01.21.16.53.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 16:53:45 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1B00JYAX5HA650@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 22 Jan 2016 00:53:41 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2 02/10] rtc: max77686: Use ARRAY_SIZE()
 instead of current array length
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-3-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A17D98.7010907@samsung.com>
Date: Fri, 22 Jan 2016 09:53:44 +0900
MIME-version: 1.0
In-reply-to: <1453407813-14646-3-git-send-email-javier@osg.samsung.com>
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

On 22.01.2016 05:23, Javier Martinez Canillas wrote:
> It is better to use the ARRAY_SIZE() macro instead of the array length
> to avoid bugs if the array is later changed and the length not updated.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---

Tested on Trats2 board with max77686:
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
