Return-Path: <rtc-linux+bncBDKZNNNLXAHBB5XHUOXQKGQERTV3ZKA@googlegroups.com>
Received: from mail-qk0-x22e.google.com (mail-qk0-x22e.google.com. [2607:f8b0:400d:c09::22e])
        by gmr-mx.google.com with ESMTPS id u67si80661ywf.5.2015.09.03.18.29.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 18:29:26 -0700 (PDT)
Received: by mail-qk0-x22e.google.com with SMTP id v1so3204547qkd.0
        for <rtc-linux@googlegroups.com>; Thu, 03 Sep 2015 18:29:25 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1441305318-24773-1-git-send-email-festevam@gmail.com>
References: <1441305318-24773-1-git-send-email-festevam@gmail.com>
Date: Fri, 4 Sep 2015 10:29:25 +0900
Message-ID: <CAJKOXPe8n8CkJcOQDjddgQuXDfHqQL0Z+nJxi_jK4VHoCjJDHw@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH] rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com, linus.walleij@linaro.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-09-04 3:35 GMT+09:00 Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Add a sentinel to ab85xx_rtc_ids[] in order to fix the following error:
>
> drivers/rtc/rtc-ab8500: struct platform_device_id is 24 bytes.  The last of 2 is:
> 0x61 0x62 0x38 0x35 0x34 0x30 0x2d 0x72 0x74 0x63 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x8c
> FATAL: drivers/rtc/rtc-ab8500: struct platform_device_id is not terminated with a NULL entry!
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/rtc/rtc-ab8500.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

However this was also reported earlier by:
Andrey Ryabinin <ryabinin.a.a@gmail.com>
http://www.spinics.net/lists/arm-kernel/msg441707.html

Could you give him the credits as well?

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
