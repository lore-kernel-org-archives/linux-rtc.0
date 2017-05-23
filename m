Return-Path: <rtc-linux+bncBDA7X7F2WUEBBCWER7EQKGQEPIHFBOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x234.google.com (mail-wr0-x234.google.com. [2a00:1450:400c:c0c::234])
        by gmr-mx.google.com with ESMTPS id g11si70426wme.2.2017.05.23.00.17.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 00:17:29 -0700 (PDT)
Received: by mail-wr0-x234.google.com with SMTP id w50so50900632wrc.0
        for <rtc-linux@googlegroups.com>; Tue, 23 May 2017 00:17:29 -0700 (PDT)
Date: Tue, 23 May 2017 08:17:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out
 of I2C realm
Message-ID: <20170523071727.tw6vblpnevihqgqk@dell>
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

On Mon, 22 May 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/input/misc/dm355evm_keys.c        | 2 +-

>  drivers/mfd/dm355evm_msp.c                | 2 +-

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
 =20
>  drivers/rtc/rtc-dm355evm.c                | 2 +-
>  include/linux/{i2c =3D> mfd}/dm355evm_msp.h | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{i2c =3D> mfd}/dm355evm_msp.h (100%)
>=20
> diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm35=
5evm_keys.c
> index bab256ef32b9b3..c803db64a3760d 100644
> --- a/drivers/input/misc/dm355evm_keys.c
> +++ b/drivers/input/misc/dm355evm_keys.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> =20
> -#include <linux/i2c/dm355evm_msp.h>
> +#include <linux/mfd/dm355evm_msp.h>
>  #include <linux/module.h>
> =20
> =20
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
> =20
> =20
>  /*
> diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
> index f225cd873ff6c2..97d8259b94940f 100644
> --- a/drivers/rtc/rtc-dm355evm.c
> +++ b/drivers/rtc/rtc-dm355evm.c
> @@ -13,7 +13,7 @@
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> =20
> -#include <linux/i2c/dm355evm_msp.h>
> +#include <linux/mfd/dm355evm_msp.h>
>  #include <linux/module.h>
> =20
> =20
> diff --git a/include/linux/i2c/dm355evm_msp.h b/include/linux/mfd/dm355ev=
m_msp.h
> similarity index 100%
> rename from include/linux/i2c/dm355evm_msp.h
> rename to include/linux/mfd/dm355evm_msp.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
