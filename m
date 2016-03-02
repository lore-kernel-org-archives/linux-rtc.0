Return-Path: <rtc-linux+bncBCQJP74GSUDRB56V3K3AKGQELADD35Q@googlegroups.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com. [2607:f8b0:4001:c06::244])
        by gmr-mx.google.com with ESMTPS id iq8si285413igb.0.2016.03.02.00.57.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 00:57:27 -0800 (PST)
Received: by mail-io0-x244.google.com with SMTP id g203so18724097iof.0
        for <rtc-linux@googlegroups.com>; Wed, 02 Mar 2016 00:57:27 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1456851608-3374907-2-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
	<1456851608-3374907-2-git-send-email-arnd@arndb.de>
Date: Wed, 2 Mar 2016 09:57:27 +0100
Message-ID: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/6] rtc: generic: allow building on all architectures
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kyle McMartin <kyle@mcmartin.ca>,
	RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	Parisc List <linux-parisc@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On Tue, Mar 1, 2016 at 5:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> There are four architectures using this driver, but since we can
> build it with COMPILE_TEST, we should try dealing with the absence
> of the asm/rtc.h header file, to avoid getting a build error:
>
> drivers/rtc/rtc-generic.c:12:21: fatal error: asm/rtc.h: No such file or directory
>
> This creates an alternative use of the driver, allowing architectures
> to pass a set of rtc_class_ops in platform data. We can convert the
> four architectures to use this and then remove the original
> code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-generic.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
> index e782ebd719b2..d726c6aa96a8 100644
> --- a/drivers/rtc/rtc-generic.c
> +++ b/drivers/rtc/rtc-generic.c
> @@ -9,6 +9,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>
> +#if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
> +    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
>  #include <asm/rtc.h>
>
>  static int generic_get_time(struct device *dev, struct rtc_time *tm)
> @@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
>         .read_time = generic_get_time,
>         .set_time = generic_set_time,
>  };
> +#else
> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
> +#endif
>
>  static int __init generic_rtc_probe(struct platform_device *dev)
>  {
>         struct rtc_device *rtc;
> +       const struct rtc_class_ops *ops;
> +
> +       ops = dev_get_platdata(&dev->dev);
> +       if (!ops)
> +               ops = &generic_rtc_ops;

I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
undefined behavior?

>
>         rtc = devm_rtc_device_register(&dev->dev, "rtc-generic",
> -                                       &generic_rtc_ops, THIS_MODULE);
> +                                       ops, THIS_MODULE);
>         if (IS_ERR(rtc))
>                 return PTR_ERR(rtc);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
