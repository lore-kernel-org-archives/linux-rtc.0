Return-Path: <rtc-linux+bncBDEKVJM7XAHRBRFBY7CAKGQEQ7IJAPY@googlegroups.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com. [2607:f8b0:4001:c0b::242])
        by gmr-mx.google.com with ESMTPS id f73si1421514ita.1.2017.02.01.04.12.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 04:12:52 -0800 (PST)
Received: by mail-it0-x242.google.com with SMTP id 203so2229031ith.2
        for <rtc-linux@googlegroups.com>; Wed, 01 Feb 2017 04:12:52 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170201115706.3750-1-alexandre.belloni@free-electrons.com>
References: <20170201115706.3750-1-alexandre.belloni@free-electrons.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 1 Feb 2017 13:12:51 +0100
Message-ID: <CAK8P3a1Gsv4OQDQ4MSou=65_ieCRWHWMC43=+-FcWW4Nh7pfOA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: sun6i: extend test coverage
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Feb 1, 2017 at 12:57 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> COMPILE_TEST was wrongly placed, move it to the "depends on" line. Also,
> select COMMON_CLK has the driver now needs it to be properly compiled.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ee287cf63b01..06f3beb8e30f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1435,8 +1435,9 @@ config RTC_DRV_SUN4V
>
>  config RTC_DRV_SUN6I
>         bool "Allwinner A31 RTC"
> -       default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
> -       depends on ARCH_SUNXI
> +       default MACH_SUN6I || MACH_SUN8I
> +       select COMMON_CLK

I think this needs to be "depends on COMMON_CLK", otherwise it looks good.

     Arnd

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
