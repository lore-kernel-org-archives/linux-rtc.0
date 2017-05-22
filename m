Return-Path: <rtc-linux+bncBDP6N55ZUYDRB6HLRXEQKGQELLINS2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id f89si146338pfh.8.2017.05.22.16.36.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 16:36:24 -0700 (PDT)
Received: by mail-pf0-x244.google.com with SMTP id f27so23159007pfe.0
        for <rtc-linux@googlegroups.com>; Mon, 22 May 2017 16:36:24 -0700 (PDT)
Date: Mon, 22 May 2017 16:36:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out
 of I2C realm
Message-ID: <20170522233621.GB12016@dtor-ws>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170521220212.1404-2-wsa@the-dreams.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, May 22, 2017 at 12:02:08AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/input/misc/dm355evm_keys.c        | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>  drivers/mfd/dm355evm_msp.c                | 2 +-
>  drivers/rtc/rtc-dm355evm.c                | 2 +-
>  include/linux/{i2c => mfd}/dm355evm_msp.h | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)
> 
> diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
> index bab256ef32b9b3..c803db64a3760d 100644
> --- a/drivers/input/misc/dm355evm_keys.c
> +++ b/drivers/input/misc/dm355evm_keys.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  
> -#include <linux/i2c/dm355evm_msp.h>
> +#include <linux/mfd/dm355evm_msp.h>
>  #include <linux/module.h>
>  
>  
> diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
> index 86eca614507bd8..2a2756709f22f0 100644
> --- a/drivers/mfd/dm355evm_msp.c
> +++ b/drivers/mfd/dm355evm_msp.c
> @@ -18,7 +18,7 @@
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c/dm355evm_msp.h>
> +#include <linux/mfd/dm355evm_msp.h>
>  
>  
>  /*
> diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
> index f225cd873ff6c2..97d8259b94940f 100644
> --- a/drivers/rtc/rtc-dm355evm.c
> +++ b/drivers/rtc/rtc-dm355evm.c
> @@ -13,7 +13,7 @@
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
>  
> -#include <linux/i2c/dm355evm_msp.h>
> +#include <linux/mfd/dm355evm_msp.h>
>  #include <linux/module.h>
>  
>  
> diff --git a/include/linux/i2c/dm355evm_msp.h b/include/linux/mfd/dm355evm_msp.h
> similarity index 100%
> rename from include/linux/i2c/dm355evm_msp.h
> rename to include/linux/mfd/dm355evm_msp.h
> -- 
> 2.11.0
> 

-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
