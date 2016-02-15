Return-Path: <rtc-linux+bncBDKZNNNLXAHBBSV3RG3AKGQEZWA6FII@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id ff2si3152133pad.2.2016.02.15.15.22.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 15:22:50 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2M00BUB3LW2AA0@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 15 Feb 2016 23:22:44 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 devicetree@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56C25DC0.1040202@samsung.com>
Date: Tue, 16 Feb 2016 08:22:40 +0900
MIME-version: 1.0
In-reply-to: <1455545466-25709-1-git-send-email-javier@osg.samsung.com>
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

On 15.02.2016 23:11, Javier Martinez Canillas wrote:
> The S3C binding doc says that the RTC and RTC source clocks are required
> but the S3C driver supports different HW IP and only the s3c6410 needs a
> source clock.
> 
> Fix the binding explaining that the source clock is only needed for the
> s3c6410-rtc compatible controller.
> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> ---
> Hello,
> 
> This patch depends on a previous one that was picked by Rob Herring so
> this one has to go through his tree again and not through the RTC tree
> to avoid conflicts.
> 
> Best regards,
> Javier
> 
> Changes in v2:
> - Remove the mention to a commit sha-1 that's not in mainline (Alexandre).
> - Fix typo in commit message (Alexandre).
> - Add Alexandre's Acked-by tag.
> 
>  Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
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
