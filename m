Return-Path: <rtc-linux+bncBDA7X7F2WUEBBQGU4C5AKGQEXO75IAY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id f10si27985wmg.2.2016.06.08.07.22.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2016 07:22:55 -0700 (PDT)
Received: by mail-wm0-x232.google.com with SMTP id k204so19119630wmk.0
        for <rtc-linux@googlegroups.com>; Wed, 08 Jun 2016 07:22:55 -0700 (PDT)
Date: Wed, 8 Jun 2016 15:23:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Subject: [rtc-linux] Re: [RESEND PATCH v5 3/5] mfd: dt-bindings: Add RK818
 device tree bindings document
Message-ID: <20160608142326.GF14888@dell>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <1464850228-17244-3-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1464850228-17244-3-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 02 Jun 2016, Wadim Egorov wrote:

> Add device tree bindings documentation for Rockchip's RK818 PMIC.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 37 +++++++++++++++++++=
++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentat=
ion/devicetree/bindings/mfd/rk808.txt
> index 4ca6aab..9636ae8 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -1,7 +1,11 @@
> -RK808 Power Management Integrated Circuit
> +RK8XX Power Management Integrated Circuit
> +
> +The rk8xx family current members:
> +rk808
> +rk818
> =20
>  Required properties:
> -- compatible: "rockchip,rk808"
> +- compatible: "rockchip,rk808", "rockchip,rk818"
>  - reg: I2C slave address
>  - interrupt-parent: The parent interrupt controller.
>  - interrupts: the interrupt outputs of the controller.
> @@ -13,6 +17,8 @@ Optional properties:
>    default output clock name
>  - rockchip,system-power-controller: Telling whether or not this pmic is =
controlling
>    the system power.
> +
> +Optional RK808 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
>  - vcc3-supply:  The input supply for DCDC_REG3
> @@ -29,7 +35,20 @@ Optional properties:
>    the gpio controller. If DVS GPIOs aren't present, voltage changes will=
 happen
>    very quickly with no slow ramp time.
> =20
> -Regulators: All the regulators of RK808 to be instantiated shall be
> +Optional RK818 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- boost-supply: The input supply for DCDC_BOOST
> +- vcc6-supply:  The input supply for LDO_REG1 and LDO_REG2
> +- vcc7-supply:  The input supply for LDO_REG3, LDO_REG5 and LDO_REG7
> +- vcc8-supply:  The input supply for LDO_REG4, LDO_REG6 and LDO_REG8
> +- vcc9-supply:  The input supply for LDO_REG9 and SWITCH_REG
> +- h_5v-supply:  The input supply for HDMI_SWITCH
> +- usb-supply:   The input supply for OTG_SWITCH
> +
> +Regulators: All the regulators of RK8XX to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> =20
> @@ -48,6 +67,18 @@ number as described in RK808 datasheet.
>  	- SWITCH_REGn
>  		- valid values for n are 1 to 2
> =20
> +Following regulators of the RK818 PMIC block are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC =
or LDO
> +number as described in RK818 datasheet.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 4.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9.
> +	- SWITCH_REG
> +	- HDMI_SWITCH
> +	- OTG_SWITCH
> +
>  Standard regulator bindings are used inside regulator subnodes. Check
>    Documentation/devicetree/bindings/regulator/regulator.txt
>  for more details

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
