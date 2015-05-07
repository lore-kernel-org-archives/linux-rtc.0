Return-Path: <rtc-linux+bncBDA7X7F2WUEBBZFNVSVAKGQEOA6WA5A@googlegroups.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com. [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id p12si74289wiv.1.2015.05.07.00.40.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 00:40:20 -0700 (PDT)
Received: by mail-wi0-f171.google.com with SMTP id di4so49133806wid.0
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 00:40:20 -0700 (PDT)
Date: Thu, 7 May 2015 08:40:16 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Sangbeom Kim <sbkim73@samsung.com>,
	Mike Turquette <mturquette@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [rtc-linux] Re: [PATCH] MAINTAINERS: Extend Samsung MFD drivers entry
 and add myself
Message-ID: <20150507074016.GD12484@x1>
References: <1430889576-7779-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430889576-7779-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, 06 May 2015, Krzysztof Kozlowski wrote:

> Extend the entry for Samsung MFD drivers for PMIC devices (Power
> Management Integrated Circuit) with bindings documentation, clock
> (clk-s2mps11.c) and RTC drivers (rtc-s5m.c).
>=20
> These PMIC devices are used on many Exynos-based boards like Arndale
> Octa (S2MPS11), Gear 2 (S2MPS14).
>=20
> Add myself as a supporter for reviewing them.
> I am not the author of these drivers. However I have recently
> contributed to most of them and I have access to datasheets and hardware.
>=20
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Stephen Boyd <sboyd@codeaurora.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Liam Girdwood <lgirdwood@gmail.com>
> CC: Mark Brown <broonie@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  MAINTAINERS | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

I can't see anyone having an issue with this.

Applied, thanks.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e278814388f7..fc01dc9f96af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8533,14 +8533,20 @@ L:	linux-fbdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/video/fbdev/s3c-fb.c
> =20
> -SAMSUNG MULTIFUNCTION DEVICE DRIVERS
> +SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
>  M:	Sangbeom Kim <sbkim73@samsung.com>
> +M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
>  L:	linux-kernel@vger.kernel.org
> +L:	linux-samsung-soc@vger.kernel.org
>  S:	Supported
>  F:	drivers/mfd/sec*.c
>  F:	drivers/regulator/s2m*.c
>  F:	drivers/regulator/s5m*.c
> +F:	drivers/clk/clk-s2mps11.c
> +F:	drivers/rtc/rtc-s5m.c
>  F:	include/linux/mfd/samsung/
> +F:	Documentation/devicetree/bindings/regulator/s5m8767-regulator.txt
> +F:	Documentation/devicetree/bindings/mfd/s2mp*.txt
> =20
>  SAMSUNG S5P/EXYNOS4 SOC SERIES CAMERA SUBSYSTEM DRIVERS
>  M:	Kyungmin Park <kyungmin.park@samsung.com>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
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
