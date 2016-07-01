Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXWY3C5QKGQENQ2WUWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id f138si77330wmf.3.2016.07.01.01.39.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jul 2016 01:39:58 -0700 (PDT)
Received: by mail-wm0-x231.google.com with SMTP id v199so17049248wmv.0
        for <rtc-linux@googlegroups.com>; Fri, 01 Jul 2016 01:39:58 -0700 (PDT)
Date: Fri, 1 Jul 2016 09:40:50 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 1/7] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
Message-ID: <20160701084050.GI1707@dell>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-2-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467302331-9663-2-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 30 Jun 2016, Chen-Yu Tsai wrote:

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v3:
>=20
>   - Fixed device node names and added labels.
>   - Added clock output from codec and input to rtc.
>=20
> Changes since v2:
>=20
>   - Fix interrupt line for ac100_codec in provided example.
>=20
> ---
>  Documentation/devicetree/bindings/mfd/ac100.txt | 49 +++++++++++++++++++=
++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentat=
ion/devicetree/bindings/mfd/ac100.txt
> new file mode 100644
> index 000000000000..31e6f9cc41bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
> @@ -0,0 +1,49 @@
> +X-Powers AC100 Codec/RTC IC device tree bindings

Nit: Device Tree

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
> +    - #clock-cells: shall be 0

Nit: Shall

> +    - clock-output-names: "4M_adda"
> +    - see clock/clock-bindings.txt for common clock bindings

    - compatible:           "x-powers,ac100-codec"
    - interrupt-parent:	    The parent interrupt controller
    - interrupts: 	    SoC NMI / GPIO interrupt connected to the IRQ_AUDIO =
pin
    - #clock-cells:   	    shall be 0
    - clock-output-names:   "4M_adda"

    - see clock/clock-bindings.txt for common clock bindings

Don't you think these are easier to read when they're separated?

> +  - rtc
> +    - compatible: "x-powers,ac100-rtc"
> +    - interrupt-parent: The parent interrupt controller
> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
> +    - clocks: A phandle to the codec's "4M_adda" clock
> +    - #clock-cells: shall be 1

Nit: Shall

> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
> +    - see clock/clock-bindings.txt for common clock bindings

Same here.

> +Example:
> +
> +ac100: codec@e89 {
> +	compatible =3D "x-powers,ac100";
> +	reg =3D <0xe89>;
> +
> +	ac100_codec: codec {
> +		compatible =3D "x-powers,ac100-codec";
> +		interrupt-parent =3D <&r_pio>;
> +		interrupts =3D <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
> +		#clock-cells =3D <0>;
> +		clock-output-names =3D "4M_adda";
> +	};
> +
> +	ac100_rtc: rtc {
> +		compatible =3D "x-powers,ac100-rtc";
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +		clocks =3D <&ac100_codec>;
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
