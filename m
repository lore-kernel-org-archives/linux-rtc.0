Return-Path: <rtc-linux+bncBCMILY6JWQBBBYMQRPCAKGQEK77GSQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id 23si2429066pfw.4.2017.01.20.18.33.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jan 2017 18:33:05 -0800 (PST)
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 144B62263D
	for <rtc-linux@googlegroups.com>; Sat, 21 Jan 2017 10:33:03 +0800 (CST)
Received: by mail-it0-f47.google.com with SMTP id c7so33361818itd.1
        for <rtc-linux@googlegroups.com>; Fri, 20 Jan 2017 18:33:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <de1e4b4eda6307b664c40d6c4502058f6bb88c60.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
 <de1e4b4eda6307b664c40d6c4502058f6bb88c60.1484927680.git-series.maxime.ripard@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 21 Jan 2017 10:32:40 +0800
Message-ID: <CAGb2v66rfO8i9MXWtbkjyaQVQjv+3ARNFPtx5maJJ_KS1ZmgOQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/6] rtc: sun6i: Disable the build as a module
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Fri, Jan 20, 2017 at 11:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Since we have to provide the clock very early on, the RTC driver cannot be
> built as a module. Make sure that won't happen.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/rtc/Kconfig     |  2 +-
>  drivers/rtc/rtc-sun6i.c | 17 +----------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index c93c5a8fba32..53e35c138ff3 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1434,7 +1434,7 @@ config RTC_DRV_SUN4V
>           based RTC on SUN4V systems.
>
>  config RTC_DRV_SUN6I
> -       tristate "Allwinner A31 RTC"
> +       bool "Allwinner A31 RTC"
>         default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
>         depends on ARCH_SUNXI
>         help
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 872d18609183..edd5627da10f 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -554,15 +554,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int sun6i_rtc_remove(struct platform_device *pdev)
> -{
> -       struct sun6i_rtc_dev *chip = platform_get_drvdata(pdev);
> -
> -       rtc_device_unregister(chip->rtc);
> -
> -       return 0;
> -}
> -
>  static const struct of_device_id sun6i_rtc_dt_ids[] = {
>         { .compatible = "allwinner,sun6i-a31-rtc" },
>         { /* sentinel */ },
> @@ -571,15 +562,9 @@ MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
>
>  static struct platform_driver sun6i_rtc_driver = {
>         .probe          = sun6i_rtc_probe,
> -       .remove         = sun6i_rtc_remove,

I might have gotten this wrong in the past. It seems that the
.remove callback can still be called, even if the driver is
builtin, by unbinding the driver from the device using the
sysfs interface. So we still need it regardless.

We can get rid of the .remove callback by switching to
devm_rtc_device_register, but that is a separate issue.

Also, a personal preference, is that this change should precede
the clk change you mentioned in the commit message, since you
are making this change in anticipation of possible breakage
by that one.

Regards
ChenYu

>         .driver         = {
>                 .name           = "sun6i-rtc",
>                 .of_match_table = sun6i_rtc_dt_ids,
>         },
>  };
> -
> -module_platform_driver(sun6i_rtc_driver);
> -
> -MODULE_DESCRIPTION("sun6i RTC driver");
> -MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> -MODULE_LICENSE("GPL");
> +builtin_platform_driver(sun6i_rtc_driver);
> --
> git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
