Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854222;
	b=cxSCBp9QRp1Q3q1H0UbkT5MsExO8+LIcRfcVvnCw6oExjDWY2fFo04yqJVqTM7Fy4YXe
	 tp8UcEFF//N68JFesMyF5jWE0S50n4tKxi0yXaUIwvulE1gR4Hrr53Pvf33pitbGvVk61
	 /yxziHc3y5JkqsN+zqRghMSRpPM8ClJ6Qr34nh5lRKRBs9CVazbDVRAy7wrluN1hgQLJ6
	 Z1c+xZQAO4+6YAo3fTMK9G+i7+FHmRw8BYUmwH02nGR03onkRWPHNaWryiivWReLZGw8B
	 j4WQv6w5mCe8/coNmrabs/IBN24mNX1w9rG8O6l8GEeAdd790xK5cUyKTUnrCLMjAqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JG6CA7hF3cK3MbnlBMlTCcJ/avGWqkbsETlXUPBQl38=;
	b=DZXf+VI1FKsMMU3AVUxhmaX6wVCejw5SLa/tuVBbnoMgxBU77dxYWnfE3R6m+Fra1ssJ
	 RgvAJjZsQp3SaIfJcii0QvaaW7CsTq7I9PQ8oWyZTBH2Ravq+sjrNHa/9IPRfhE/MdW0y
	 NWgfvG3mu1XHnIxy3KG/YUvRIK0w1mgyg2Yek3VIwoXzmMCD+W76weKU211GJUatiSCnK
	 EWtduYEjJ9EzWkcNcNB+zJ8HVlGNHjvxqA83vN9Ek9zQFzkiY9FAVwOlOU6QDwWure7Kl
	 QQLfULJDy9WqylmE+/C5jGJtdlHKpNHcXzqf2d/XqmHvBu6rWco4GAVmL0xn13crREw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndEjBJh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F9606A322;
	Mon, 16 Nov 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndEjBJh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC9B1F000C9;
	Mon, 16 Nov 2026 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854221;
	bh=JG6CA7hF3cK3MbnlBMlTCcJ/avGWqkbsETlXUPBQl38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndEjBJh4ItJInOcvAxXux03Rf6tpEY0aWYJTVaMRE/qyOsLT128+uXQ8uOG3HDHp9
	 ChBqi477ZssuhxtEiLH75iEoGzJY6P83E4z7dKmRH+p8AjK1UugOd4VaCRidUiQy8+
	 ivCV0SQkBr5DT+toW//ktRk/zd1Ku9RJJeGftspFZ4TqWUpsCi8E53JVEpDbg19Ay0
	 7HxLxa+dO4hD3sJmTkhEk5DE35FLaw0ic7fnOkJN7LiuHiL9eCekpMed+XOQwsHlA7
	 JwQ0tdq7fJZ/LczVaXMxWKfzMmdt0PnEA0rfqKNeM5VSl6xv2i0bal3tg3hb5gZh5W
	 QQmK3hHskdGtg==
Date: Mon, 16 Nov 2026 18:36:53 +0000
From: Conor Dooley <conor@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 05/19] dt-bindings: clock: sunxi-ng: document the
 Allwinner V861 CCUs
Message-ID: <20261116-untapped-venomous-10a258880fe4@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-5-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jqXi36KkUpYdOM0M"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-5-eb71ec3ee523@iscas.ac.cn>

--jqXi36KkUpYdOM0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 06:33:31AM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The V861 has a main CCU and a PRCM CCU. Add the binding and the clock
> and reset indices for both.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../bindings/clock/allwinner,sun252i-v861-ccu.yaml |  99 ++++++++++++++++
>  include/dt-bindings/clock/sun252i-v861-ccu.h       | 127 +++++++++++++++=
++++++
>  include/dt-bindings/clock/sun252i-v861-r-ccu.h     |  14 +++
>  include/dt-bindings/reset/sun252i-v861-ccu.h       |  55 +++++++++
>  include/dt-bindings/reset/sun252i-v861-r-ccu.h     |  12 ++
>  5 files changed, 307 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun252i-v8=
61-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun252i-v86=
1-ccu.yaml
> new file mode 100644
> index 000000000000..29fc23ab2401
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun252i-v861-ccu.=
yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/allwinner,sun252i-v861-ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner V861 Clock Control Unit
> +
> +maintainers:
> +  - Han Gao <gaohan@iscas.ac.cn>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - allwinner,sun252i-v861-ccu
> +      - allwinner,sun252i-v861-r-ccu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 4
> +
> +required:
> +  - "#clock-cells"
> +  - "#reset-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

reg and compatible should come before other properties, here and above.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - allwinner,sun252i-v861-ccu
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: High Frequency Oscillator (usually at 24MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +
> +        clock-names:
> +          items:
> +            - const: hosc
> +            - const: losc
> +            - const: iosc

both devices duplicate this, so it can move to the top level.
then all you need to do is set maxItems to 3 here and minitems to 4
below.

pw-bot: changes-requested

Thanks,
Conor.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - allwinner,sun252i-v861-r-ccu
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: High Frequency Oscillator (usually at 24MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +            - description: Peripherals PLL (200 MHz output)
> +
> +        clock-names:
> +          items:
> +            - const: hosc
> +            - const: losc
> +            - const: iosc
> +            - const: pll-periph
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@2001000 {
> +        compatible =3D "allwinner,sun252i-v861-ccu";
> +        reg =3D <0x02001000 0x1000>;
> +        clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> +        clock-names =3D "hosc", "losc", "iosc";
> +        #clock-cells =3D <1>;
> +        #reset-cells =3D <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/sun252i-v861-ccu.h b/include/dt-bi=
ndings/clock/sun252i-v861-ccu.h
> new file mode 100644
> index 000000000000..1123b894a493
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun252i-v861-ccu.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN252I_V861_CCU_H_
> +#define _DT_BINDINGS_CLK_SUN252I_V861_CCU_H_
> +
> +#define CLK_PLL_DDR		0
> +#define CLK_PLL_PERIPH0_4X	1
> +#define CLK_PLL_PERIPH0_2X	2
> +#define CLK_PLL_PERIPH0_800M	3
> +#define CLK_PLL_PERIPH0_480M	4
> +#define CLK_PLL_PERIPH0_600M	5
> +#define CLK_PLL_PERIPH0_400M	6
> +#define CLK_PLL_PERIPH0_300M	7
> +#define CLK_PLL_PERIPH0_200M	8
> +#define CLK_PLL_PERIPH0_160M	9
> +#define CLK_PLL_PERIPH0_150M	10
> +#define CLK_PLL_VIDEO_8X	11
> +#define CLK_PLL_VIDEO_4X	12
> +#define CLK_PLL_VIDEO_2X	13
> +#define CLK_PLL_VIDEO_1X	14
> +#define CLK_PLL_CSI_8X		15
> +#define CLK_PLL_CSI_4X		16
> +#define CLK_PLL_CSI_2X		17
> +#define CLK_PLL_CSI_1X		18
> +#define CLK_PLL_AUDIO		19
> +#define CLK_PLL_AUDIO_DIV2	20
> +#define CLK_PLL_AUDIO_DIV3	21
> +#define CLK_PLL_AUDIO_DIV5	22
> +#define CLK_PLL_AUDIO_4X	23
> +#define CLK_PLL_AUDIO_1X	24
> +#define CLK_PLL_NPU_8X		25
> +#define CLK_PLL_NPU_4X		26
> +#define CLK_PLL_NPU_2X		27
> +#define CLK_PLL_NPU_1X		28
> +#define CLK_AHB			29
> +#define CLK_APB0		30
> +#define CLK_APB1		31
> +#define CLK_APB_UART		32
> +#define CLK_DE			33
> +#define CLK_BUS_DE		34
> +#define CLK_G2D			35
> +#define CLK_BUS_G2D		36
> +#define CLK_CE			37
> +#define CLK_BUS_CE		38
> +#define CLK_BUS_CE_SYS		39
> +#define CLK_VE			40
> +#define CLK_BUS_VE		41
> +#define CLK_NPU			42
> +#define CLK_BUS_NPU		43
> +#define CLK_BUS_SGDMA		44
> +#define CLK_BUS_NDMA		45
> +#define CLK_BUS_MSGBOX0		46
> +#define CLK_BUS_MSGBOX1		47
> +#define CLK_BUS_SPINLOCK	48
> +#define CLK_BUS_HSTIMER		49
> +#define CLK_AVS			50
> +#define CLK_BUS_TIMER		51
> +#define CLK_BUS_DBG		52
> +#define CLK_BUS_PWM		53
> +#define CLK_DRAM		54
> +#define CLK_MBUS		55
> +#define CLK_MBUS_DMA		56
> +#define CLK_MBUS_VE		57
> +#define CLK_MBUS_CE		58
> +#define CLK_MBUS_CSI		59
> +#define CLK_MBUS_ISP		60
> +#define CLK_MBUS_G2D		61
> +#define CLK_BUS_DRAM		62
> +#define CLK_MMC0		63
> +#define CLK_MMC1		64
> +#define CLK_MMC2		65
> +#define CLK_BUS_MMC0		66
> +#define CLK_BUS_MMC1		67
> +#define CLK_BUS_MMC2		68
> +#define CLK_PSRAM		69
> +#define CLK_BUS_PSRAM		70
> +#define CLK_BUS_UART0		71
> +#define CLK_BUS_UART1		72
> +#define CLK_BUS_UART2		73
> +#define CLK_BUS_UART3		74
> +#define CLK_BUS_I2C0		75
> +#define CLK_BUS_I2C1		76
> +#define CLK_BUS_I2C2		77
> +#define CLK_BUS_I2C3		78
> +#define CLK_SPI0		79
> +#define CLK_SPI1		80
> +#define CLK_SPI2		81
> +#define CLK_SPIF		82
> +#define CLK_BUS_SPI0		83
> +#define CLK_BUS_SPI1		84
> +#define CLK_BUS_SPI2		85
> +#define CLK_BUS_SPIF		86
> +#define CLK_GMAC_25M		87
> +#define CLK_BUS_GMAC		88
> +#define CLK_BUS_GPADC		89
> +#define CLK_BUS_THS		90
> +#define CLK_I2S0		91
> +#define CLK_BUS_I2S0		92
> +#define CLK_AUDIO_CODEC_DAC	93
> +#define CLK_AUDIO_CODEC_ADC	94
> +#define CLK_BUS_AUDIO_CODEC	95
> +#define CLK_USB_OHCI0		96
> +#define CLK_BUS_OHCI0		97
> +#define CLK_BUS_EHCI0		98
> +#define CLK_BUS_OTG		99
> +#define CLK_BUS_DPSS_TOP	100
> +#define CLK_TCON_LCD		101
> +#define CLK_BUS_TCON_LCD	102
> +#define CLK_CSI			103
> +#define CLK_CSI_MCLK0		104
> +#define CLK_CSI_MCLK1		105
> +#define CLK_CSI_MCLK2		106
> +#define CLK_BUS_CSI		107
> +#define CLK_FANOUT_24M		108
> +#define CLK_FANOUT_12M		109
> +#define CLK_FANOUT_16M		110
> +#define CLK_FANOUT_25M		111
> +#define CLK_FANOUT_27M		112
> +#define CLK_FANOUT_PCLK		113
> +#define CLK_FANOUT0		114
> +#define CLK_FANOUT1		115
> +#define CLK_FANOUT2		116
> +
> +#endif /* _DT_BINDINGS_CLK_SUN252I_V861_CCU_H_ */
> diff --git a/include/dt-bindings/clock/sun252i-v861-r-ccu.h b/include/dt-=
bindings/clock/sun252i-v861-r-ccu.h
> new file mode 100644
> index 000000000000..41eaf8aab2c0
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun252i-v861-r-ccu.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN252I_V861_R_CCU_H_
> +#define _DT_BINDINGS_CLK_SUN252I_V861_R_CCU_H_
> +
> +#define CLK_R_AHB		0
> +#define CLK_R_APB0		1
> +#define CLK_BUS_R_PPU		2
> +#define CLK_BUS_R_RTC		3
> +
> +#endif /* _DT_BINDINGS_CLK_SUN252I_V861_R_CCU_H_ */
> diff --git a/include/dt-bindings/reset/sun252i-v861-ccu.h b/include/dt-bi=
ndings/reset/sun252i-v861-ccu.h
> new file mode 100644
> index 000000000000..4e0245c6c99a
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun252i-v861-ccu.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUN252I_V861_CCU_H_
> +#define _DT_BINDINGS_RST_SUN252I_V861_CCU_H_
> +
> +#define RST_MBUS		0
> +#define RST_BUS_DE		1
> +#define RST_BUS_G2D		2
> +#define RST_BUS_CE		3
> +#define RST_BUS_CE_SYS		4
> +#define RST_BUS_VE		5
> +#define RST_BUS_NPU		6
> +#define RST_BUS_SGDMA		7
> +#define RST_BUS_NDMA		8
> +#define RST_BUS_MSGBOX0		9
> +#define RST_BUS_MSGBOX1		10
> +#define RST_BUS_SPINLOCK	11
> +#define RST_BUS_HSTIMER		12
> +#define RST_BUS_TIMER		13
> +#define RST_BUS_DBG		14
> +#define RST_BUS_PWM		15
> +#define RST_BUS_DRAM		16
> +#define RST_BUS_MMC0		17
> +#define RST_BUS_MMC1		18
> +#define RST_BUS_MMC2		19
> +#define RST_BUS_PSRAM		20
> +#define RST_BUS_UART0		21
> +#define RST_BUS_UART1		22
> +#define RST_BUS_UART2		23
> +#define RST_BUS_UART3		24
> +#define RST_BUS_I2C0		25
> +#define RST_BUS_I2C1		26
> +#define RST_BUS_I2C2		27
> +#define RST_BUS_I2C3		28
> +#define RST_BUS_SPI0		29
> +#define RST_BUS_SPI1		30
> +#define RST_BUS_SPI2		31
> +#define RST_BUS_SPIF		32
> +#define RST_BUS_GMAC		33
> +#define RST_BUS_GPADC		34
> +#define RST_BUS_THS		35
> +#define RST_BUS_I2S0		36
> +#define RST_BUS_AUDIO_CODEC	37
> +#define RST_USB_PHY0		38
> +#define RST_BUS_OHCI0		39
> +#define RST_BUS_EHCI0		40
> +#define RST_BUS_OTG		41
> +#define RST_BUS_DPSS_TOP	42
> +#define RST_BUS_TCON_LCD	43
> +#define RST_BUS_CSI		44
> +
> +#endif /* _DT_BINDINGS_RST_SUN252I_V861_CCU_H_ */
> diff --git a/include/dt-bindings/reset/sun252i-v861-r-ccu.h b/include/dt-=
bindings/reset/sun252i-v861-r-ccu.h
> new file mode 100644
> index 000000000000..ed0f3063df49
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun252i-v861-r-ccu.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUN252I_V861_R_CCU_H_
> +#define _DT_BINDINGS_RST_SUN252I_V861_R_CCU_H_
> +
> +#define RST_BUS_R_PPU		0
> +#define RST_BUS_R_RTC		1
> +
> +#endif /* _DT_BINDINGS_RST_SUN252I_V861_R_CCU_H_ */
>=20
> --=20
> 2.55.0
>=20
>=20

--jqXi36KkUpYdOM0M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtNRAAKCRB4tDGHoIJi
0s9KAQCX4Bs6wwg+pTycon8WFV2ntH+sKnw+Q81hcKt96NcBzAEA7J6TxHPWsnUN
XyUZNGs0O+rQmq5NSbKFCG3P8mHbsQE=
=LJxo
-----END PGP SIGNATURE-----

--jqXi36KkUpYdOM0M--
