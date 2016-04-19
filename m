Return-Path: <rtc-linux+bncBCPM5SUWUYIRBAVK3C4AKGQE4D6EZNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com. [2607:f8b0:400c:c05::244])
        by gmr-mx.google.com with ESMTPS id m62si984355vkg.3.2016.04.19.04.22.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Apr 2016 04:22:42 -0700 (PDT)
Received: by mail-vk0-x244.google.com with SMTP id x190so1751769vka.3
        for <rtc-linux@googlegroups.com>; Tue, 19 Apr 2016 04:22:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461039983-32434-1-git-send-email-Qianyu.Gong@nxp.com>
References: <1461039983-32434-1-git-send-email-Qianyu.Gong@nxp.com>
Date: Tue, 19 Apr 2016 20:22:41 +0900
Message-ID: <CAC5umygybxXtdG6bbc6WOVJznoJNTi6ShJT7Lh1R=HA0eA-19g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds3232: fix call trace when
 rtc->ops_lock is used as NULL
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Gong Qianyu <Qianyu.Gong@nxp.com>
Cc: rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Gong,

2016-04-19 13:26 GMT+09:00 Gong Qianyu <Qianyu.Gong@nxp.com>:
> Move devm_rtc_device_register() just before registering irq handler
> to initialize rtc->ops_lock earlier.

It is better to explain why you need this change in the commit log.
You already described it in your first report:
> The problem is that rtc->ops_lock would be accessed in ds3232_irq()
> without being initialized as rtc_device_register() is called too late.

> Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
> ---
>  drivers/rtc/rtc-ds3232.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 7edc889..9d44b2f 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -369,6 +369,8 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>         if (ret)
>                 return ret;
>
> +       ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
> +                                               THIS_MODULE);
>         if (ds3232->irq > 0) {
>                 ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
>                                                 ds3232_irq,
> @@ -380,8 +382,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>                 } else
>                         device_init_wakeup(dev, 1);
>         }
> -       ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
> -                                               THIS_MODULE);
>
>         return PTR_ERR_OR_ZERO(ds3232->rtc);

This error check for devm_rtc_device_register() needs to be moved together.

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
