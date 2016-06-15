Return-Path: <rtc-linux+bncBDA7X7F2WUEBBP45QW5QKGQEHJKITCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id q124si323381wme.3.2016.06.15.05.49.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 05:49:02 -0700 (PDT)
Received: by mail-wm0-x22c.google.com with SMTP id a66so22215121wme.0
        for <rtc-linux@googlegroups.com>; Wed, 15 Jun 2016 05:49:02 -0700 (PDT)
Date: Wed, 15 Jun 2016 13:49:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 02/10] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
Message-ID: <20160615124943.GE4948@dell>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-3-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465986467-14802-3-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 +++++++++++++++++++=
++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentat=
ion/devicetree/bindings/mfd/ac100.txt
> new file mode 100644
> index 000000000000..fbab623e6fba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
> @@ -0,0 +1,42 @@
> +X-Powers AC100 Codec/RTC IC device tree bindings
> +
> +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
> +separated, including power supplies and interrupt lines, but share
> +a common register address space and host interface.
> +
> +Required properties:
> +- compatible: "x-powers,ac100"
> +- reg: The I2C slave address or RSB hardware address for the chip
> +- sub-nodes:
> +  - codec
> +    - compatible: "x-powers,ac100-codec"
> +    - interrupt-parent: The parent interrupt controller
> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pi=
n
> +  - rtc
> +    - compatible: "x-powers,ac100-rtc"
> +    - interrupt-parent: The parent interrupt controller
> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
> +    - #clock-cells: shall be 1
> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
> +    - see clock/clock-bindings.txt for common clock bindings
> +
> +Example:
> +
> +ac100: codec@e89 {
> +	compatible =3D "x-powers,ac100";
> +	reg =3D <0xe89>;
> +
> +	ac100_codec {
> +		compatible =3D "x-powers,ac100-codec";
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	ac100_rtc {
> +		compatible =3D "x-powers,ac100-rtc";
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;

Isn't this the same interrupt as above?  Is it shared?

> +		#clock-cells =3D <1>;
> +		clock-output-names =3D "cko1_rtc", "cko2_rtc", "cko3_rtc";
> +	};
> +};

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
