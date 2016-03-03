Return-Path: <rtc-linux+bncBCPM5SUWUYIRBXEL4G3AKGQEQHUMZLY@googlegroups.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com. [2607:f8b0:400c:c05::243])
        by gmr-mx.google.com with ESMTPS id c66si1534436vkf.0.2016.03.03.06.10.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 06:10:36 -0800 (PST)
Received: by mail-vk0-x243.google.com with SMTP id e185so1530622vkb.2
        for <rtc-linux@googlegroups.com>; Thu, 03 Mar 2016 06:10:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456758832-10590-7-git-send-email-akinobu.mita@gmail.com>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
	<1456758832-10590-7-git-send-email-akinobu.mita@gmail.com>
Date: Thu, 3 Mar 2016 23:10:35 +0900
Message-ID: <CAC5umygNbz=nnPU6oTDsmrwWRKLFJE3Hq2ei1mPQ425CvfVE9Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 7/8] rtc: ds3232-core: fix issue when irq
 is shared several devices
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-03-01 0:13 GMT+09:00 Akinobu Mita <akinobu.mita@gmail.com>:
> ds3232-core requests irq with IRQF_SHARED, so irq can be shared by
> several devices.  But the irq handler for ds3232 unconditionally
> disables the irq at first and the irq is re-enabled only when the
> interrupt source was the ds3232's alarm.  This behaviour breaks the
> devices sharing the same irq in the various scenarios.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Dennis Aberilla <denzzzhome@yahoo.com>
> ---
> * New patch from this version
>
>  drivers/rtc/rtc-ds3232-core.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
> index be8dfe0..6489380 100644
> --- a/drivers/rtc/rtc-ds3232-core.c
> +++ b/drivers/rtc/rtc-ds3232-core.c
> @@ -59,7 +59,6 @@ struct ds3232 {
>          */
>         struct mutex mutex;
>         bool suspended;
> -       int exiting;
>  };
>
>  static int ds3232_check_rtc_status(struct device *dev)
> @@ -314,8 +313,6 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
>         struct device *dev = dev_id;
>         struct ds3232 *ds3232 = dev_get_drvdata(dev);
>
> -       disable_irq_nosync(irq);
> -
>         /*
>          * If rtc as a wakeup source, can't schedule the work
>          * at system resume flow, because at this time the i2c bus

I found that this patch is not correct because interrupt is re-enabled
after this hardirq handler finished without clearing Alarm Flag or
Alarm Interrupt Enable in RTC register.

Maybe we should drop IRQF_SHARED flag.

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
