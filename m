Return-Path: <rtc-linux+bncBDA7X7F2WUEBBHF5YLAAKGQETKU7YPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id s80si218312wme.3.2016.10.26.05.16.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 05:16:28 -0700 (PDT)
Received: by mail-wm0-x22e.google.com with SMTP id d128so82027748wmf.1
        for <rtc-linux@googlegroups.com>; Wed, 26 Oct 2016 05:16:28 -0700 (PDT)
Date: Wed, 26 Oct 2016 13:19:01 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/4] mfd: Enable compile testing for max77620
 and max77686
Message-ID: <20161026121901.GU8574@dell>
References: <1475441897-15730-1-git-send-email-krzk@kernel.org>
 <1475441897-15730-5-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1475441897-15730-5-git-send-email-krzk@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 02 Oct 2016, Krzysztof Kozlowski wrote:

> The OF is not a strict build-time dependency so max77620 and max77686
> can be compile tested to increase build coverage.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df6442ba2b..ccea26943746 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -563,7 +563,7 @@ config MFD_MAX14577
>  config MFD_MAX77620
>  	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
>  	depends on I2C=3Dy
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> @@ -578,7 +578,7 @@ config MFD_MAX77620
>  config MFD_MAX77686
>  	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
>  	depends on I2C
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ

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
