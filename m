Return-Path: <rtc-linux+bncBCSL7B6LWYHBBE4B7SXAKGQELDLVELY@googlegroups.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id z4si163662wiy.3.2015.08.27.05.20.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2015 05:20:34 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id dq5so76184163wid.1
        for <rtc-linux@googlegroups.com>; Thu, 27 Aug 2015 05:20:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
References: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:20:34 +0300
Message-ID: <CAPAsAGyrEm--=WfGB4wSFSXE8HZpp+HDuV=p4JmFbV-X2keQCg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: Fix module autoload for
 rtc-{ab8500,max8997,s5m} drivers
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Luis de Bethencourt <luis.bg@samsung.com>,
	linux-samsung-soc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Sangbeom Kim <sbkim73@samsung.com>, Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-08-27 13:34 GMT+03:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> These platform drivers have a platform device ID table but the module
> alias information is not created so module autoloading will not work.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  drivers/rtc/rtc-ab8500.c  | 1 +
>  drivers/rtc/rtc-max8997.c | 1 +
>  drivers/rtc/rtc-s5m.c     | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
> index 133d2e2e1a25..8537d1e3a995 100644
> --- a/drivers/rtc/rtc-ab8500.c
> +++ b/drivers/rtc/rtc-ab8500.c
> @@ -446,6 +446,7 @@ static const struct platform_device_id ab85xx_rtc_ids[] = {
>         { "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
>         { "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },

Completely irrelevant, but this array should have an empty terminating element.

>  };
> +MODULE_DEVICE_TABLE(platform, ab85xx_rtc_ids);
>

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
