Return-Path: <rtc-linux+bncBAABBZUSQ63AKGQER4HSJRI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si3311827pab.0.2016.02.15.04.49.42
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 04:49:42 -0800 (PST)
Subject: Re: [rtc-linux] [PATCH] rtc: s3c: Document required clocks in the DT binding
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <1455038632-14545-1-git-send-email-javier@osg.samsung.com>
 <56C01FDD.9050204@samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: k.kozlowski.k@gmail.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <56C1C95E.7030002@osg.samsung.com>
Date: Mon, 15 Feb 2016 09:49:34 -0300
MIME-Version: 1.0
In-Reply-To: <56C01FDD.9050204@samsung.com>
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

Hello Krzysztof,

Thanks a lot for your feedback.

On 02/14/2016 03:34 AM, Krzysztof Kozlowski wrote:
> W dniu 10.02.2016 o 02:23, Javier Martinez Canillas pisze:
>> The S3C Real Time Clock driver requires the clock and source clock to
>> be defined in the device node but that requirement is not documented.
>
> +Cc: Alessandro Zummo
>

I didn't add Alessandro to cc deliberately since Alexandre is the one
maintaining the RTC subsystem lately and before that, the RTC patches
were picked by Andrew Morton since Alessandro didn't even answer the
emails.
  
> No, not entirely. The samsung,s3c6410-rtc needs rtc and rtc_src clocks
> but rest of compatible devices need only rtc clock.
>

Right, sorry for missing that. I noticed that this patch has already
been picked by Rob Herring (I thought it would be picked by Alexandre
though) so I will post a follow up patch explaining that rtc_src is
only for the s3c6410-rtc compatible.

> Best regards,
> Krzysztof
>

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
