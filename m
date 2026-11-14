Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662633;
	b=yHnQ5q/YDGCl+HtHyad1IqbTXLeYm2pEdY9PRwAEd3pB3+qloVBqLE8Czptzy/HJ9YB7
	 ICCI2lRS+c6sS5+wdDXqJw+uEBJQ6C2WYhPgROIyjIA5xXWzWjmjgB3IoQjKLfl64jRZR
	 jqmRjnQFKyILkv21Eubjgsv9oPTDABy3c4pQ7joLlKuMhbvwSdod/Y9qPnmtlrA2LotAo
	 DUb40oLgsD52eFusK9Imk+3PSNhi1fbRGD6Rhc7ytnoR9jEBoMuVM/f2xwbrVrmZaJjdM
	 LbJ9KtRqMCjqtu7UEFSle1xO6uaYwcDRnk10Ih0KsdJ7I5I3WU61AJrrWqpksNbl/sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662633;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NWrVtl/dzsYg5YxNip4eBu5kQCyqGy37ampUlkGDtH4=;
	b=shJEHOvJOwT4LP18WDKJkQ8VZiOHTpWJANrKr3CLQvApKwofotJP9rhJxlwWBMuIFPq/
	 h1l9Ri0PB6SYZGNvbzzjv0zxlB7bErZY4WYDtwv5eoFTX2h25vyVisbf3mmquxU5uJRji
	 itsjrXo5pzMB++7pz5zxExu9mdcRegyWbcyAjBHmm/XuJhbY4sHG+L27VRhuFuHro200E
	 /8X9Lstdd1q3Qln7gHsB8yaLcnC62nK93e8OcPvEgz+1tvX6C3FYqvdMjsZen1lFv/9w8
	 x6EOJIokWlltqvnNZubM+4zQn36M3F3AFcH1GhAaJCnlyGb1sKe00MJBUbCnBcNBoQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/JaHfwV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D7606A32D
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/JaHfwV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC81F00934
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662633;
	bh=NWrVtl/dzsYg5YxNip4eBu5kQCyqGy37ampUlkGDtH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z/JaHfwVTYprVbWfpFU7g3ktMRESzquCvhkj0RIQUFukyUsp10fgxhSo1uAjw4+xe
	 hXJYIBAhtdVOFaXkSepxaktDFW1dftiCFQGeiW09EFbEiJeHdxCyIT0gl0F8BLPsCH
	 ocx3QrHQd43oO8a9U5rcXF9QoK2s/necUs5HCVjzA0QjpYtO9MHLVtRmb0QoHMby8s
	 o8LuqySq1rIHxK+ZT4GJc0ULrMjU+ylGPL9IaPKjTFMbhnh0hikF7qZAEizhR9e1QF
	 1Isd+fYCQ5aD8DCsue4Fck+Zykiw7VOKqhPI0MMLetZwHIIn+G2oiXVZbAI4CRpZUH
	 7xKmAAPiaedmg==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4910b863b84so1699392f8f.0
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 05:23:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHyyExRzENu9awn20H1nD2sip8ZpQuvgOiM0mjCsWMtMC4pNDcsKS8RToUOGCr78xEC8FDUpBKV+PI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1lZVMK9rY0ZVhdZRnW+VrULfGMajW85CcnFroKZvdK3Nl7m1c
	JcKR/U+vKEDIwGCu/LBJGgrlsZsYJRB4H3DmWmViUp8Dp8hNURXkdKIo8DSYupZf7qoYIKtuMJo
	+vajezRpjE5oQd+vD35135+vHXujVK48=
X-Received: by 2002:a05:6000:1787:b0:495:728a:5f6f with SMTP id
 ffacd0b85a97d-49c70823789mr12754306f8f.19.1794662631468; Sat, 14 Nov 2026
 05:23:51 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-16-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-16-eb71ec3ee523@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Nov 2026 21:23:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRuczsSR81XcGRGCmYzXpLP3_PXs=uaJZ_zSF+-UXeLcQ@mail.gmail.com>
X-Gm-Features: AclHuK-htEuUz8jr2TmuXA-X0UbKgsu6ZtLQ4PTtSqP0l4D8RPQK228uAOlkZD4
Message-ID: <CAJF2gTRuczsSR81XcGRGCmYzXpLP3_PXs=uaJZ_zSF+-UXeLcQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] riscv: dts: allwinner: add the Allwinner V861 SoC
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 6:33=E2=80=AFAM Han Gao via B4 Relay
<devnull+gaohan.iscas.ac.cn@kernel.org> wrote:
>
> From: Han Gao <gaohan@iscas.ac.cn>
>
> Add the V861 SoC with its two C907 harts, PLIC, CLINT, clock
> controllers, RTC, pin controllers and UART0.
>
> The cache geometry and PMU events come from the V861 and C907 manuals.
> Zcb, Zbkc and Zvfh were also checked to work on the hardware.
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/allwinner/sun252i-v861.dtsi | 272 ++++++++++++++++++=
++++++
>  1 file changed, 272 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sun252i-v861.dtsi b/arch/riscv=
/boot/dts/allwinner/sun252i-v861.dtsi
> new file mode 100644
> index 000000000000..7a18b973ee32
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/sun252i-v861.dtsi
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/* Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn> */
> +
> +#include <dt-bindings/clock/sun252i-v861-ccu.h>
> +#include <dt-bindings/clock/sun252i-v861-r-ccu.h>
> +#include <dt-bindings/clock/sun6i-rtc.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/reset/sun252i-v861-ccu.h>
> +#include <dt-bindings/reset/sun252i-v861-r-ccu.h>
> +
> +/ {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               timebase-frequency =3D <24000000>;
> +
> +               cpu0: cpu@0 {
> +                       compatible =3D "csky,c907", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <16384>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <16384>;
> +                       mmu-type =3D "riscv,sv39";
> +                       next-level-cache =3D <&l2_cache>;
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v",
> +                               "zicbom", "zicbop", "zicboz", "zicntr", "=
zicond",
> +                               "zicsr", "zifencei", "zihintntl", "zihint=
pause",
> +                               "zihpm", "zawrs", "zfa", "zfbfmin", "zfh"=
,
> +                               "zca", "zcb", "zcd", "zba", "zbb", "zbc",=
 "zbkc",
> +                               "zbs", "zkt", "zvfbfmin", "zvfbfwma", "zv=
fh",
> +                               "sscofpmf", "sstc", "svinval", "svnapot",=
 "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               cpu1: cpu@1 {
> +                       compatible =3D "csky,c907", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <1>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <64>;
> +                       d-cache-size =3D <16384>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <64>;
> +                       i-cache-size =3D <16384>;
> +                       mmu-type =3D "riscv,sv39";
> +                       next-level-cache =3D <&l2_cache>;
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v",
> +                               "zicbom", "zicbop", "zicboz", "zicntr", "=
zicond",
> +                               "zicsr", "zifencei", "zihintntl", "zihint=
pause",
> +                               "zihpm", "zawrs", "zfa", "zfbfmin", "zfh"=
,
> +                               "zca", "zcb", "zcd", "zba", "zbb", "zbc",=
 "zbkc",
> +                               "zbs", "zkt", "zvfbfmin", "zvfbfwma", "zv=
fh",
> +                               "sscofpmf", "sstc", "svinval", "svnapot",=
 "svpbmt";
> +                       riscv,cbom-block-size =3D <64>;
> +                       riscv,cbop-block-size =3D <64>;
> +                       riscv,cboz-block-size =3D <64>;
> +
> +                       cpu1_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               l2_cache: l2-cache {
> +                       compatible =3D "cache";
> +                       cache-block-size =3D <64>;
> +                       cache-level =3D <2>;
> +                       cache-sets =3D <128>;
> +                       cache-size =3D <131072>;
> +                       cache-unified;
> +               };
> +       };
> +
> +       osc24M: osc24M-clk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <24000000>;
> +               clock-output-names =3D "osc24M";
> +       };
> +
> +       pmu {
> +               compatible =3D "riscv,pmu";
> +               riscv,event-to-mhpmcounters =3D
> +                       <0x00003 0x00006 0x0007fff8>,
> +                       <0x00008 0x00009 0x0007fff8>,
> +                       <0x10000 0x10003 0x0007fff8>,
> +                       <0x10008 0x10009 0x0007fff8>,
> +                       <0x10019 0x10019 0x0007fff8>,
> +                       <0x1001b 0x1001b 0x0007fff8>,
> +                       <0x10021 0x10021 0x0007fff8>,
> +                       <0x10028 0x10029 0x0007fff8>;
> +               riscv,event-to-mhpmevent =3D
> +                       <0x00003 0x00000000 0x000000a5>,
> +                       <0x00004 0x00000000 0x000000a6>,
> +                       <0x00005 0x00000000 0x00000036>,
> +                       <0x00006 0x00000000 0x00000038>,
> +                       <0x00008 0x00000000 0x00000027>,
> +                       <0x00009 0x00000000 0x00000028>,
> +                       <0x10000 0x00000000 0x0000000c>,
> +                       <0x10001 0x00000000 0x0000000d>,
> +                       <0x10002 0x00000000 0x0000000e>,
> +                       <0x10003 0x00000000 0x0000000f>,
> +                       <0x10008 0x00000000 0x00000001>,
> +                       <0x10009 0x00000000 0x00000002>,
> +                       <0x10019 0x00000000 0x000000a4>,
> +                       <0x1001b 0x00000000 0x000000a3>,
> +                       <0x10021 0x00000000 0x00000003>,
> +                       <0x10028 0x00000000 0x00000036>,
> +                       <0x10029 0x00000000 0x00000038>;
> +               riscv,raw-event-to-mhpmcounters =3D
> +                       <0x00000000 0x00000001 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000002 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000003 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000005 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000006 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000007 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000008 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000009 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000016 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001b 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001c 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001d 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000001f 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000020 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000021 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000023 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000025 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000027 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000028 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000029 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000002a 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000030 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000036 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x00000038 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000009b 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000009c 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x0000009e 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a3 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a4 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a5 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a6 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a7 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a8 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000a9 0xffffffff 0xffffffff 0x00=
07fff8>,
> +                       <0x00000000 0x000000aa 0xffffffff 0xffffffff 0x00=
07fff8>;
> +       };
> +
> +       soc {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               interrupt-parent =3D <&plic>;
> +               ranges;
> +               dma-noncoherent;
> +
> +               pio: pinctrl@2000000 {
> +                       compatible =3D "allwinner,sun252i-v861-pinctrl";
> +                       reg =3D <0 0x02000000 0 0x400>;
> +                       interrupts =3D <67 IRQ_TYPE_LEVEL_HIGH>, <71 IRQ_=
TYPE_LEVEL_HIGH>,
> +                                    <73 IRQ_TYPE_LEVEL_HIGH>, <75 IRQ_TY=
PE_LEVEL_HIGH>,
> +                                    <77 IRQ_TYPE_LEVEL_HIGH>, <79 IRQ_TY=
PE_LEVEL_HIGH>,
> +                                    <81 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_APB0>, <&osc24M>, <&rtc CLK_=
OSC32K>;
> +                       clock-names =3D "apb", "hosc", "losc";
> +                       gpio-controller;
> +                       #gpio-cells =3D <3>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <3>;
> +
> +                       uart0_ph_pins: uart0-ph-pins {
> +                               pins =3D "PH9", "PH10";
> +                               function =3D "uart0";
> +                               allwinner,pinmux =3D <5>;
> +                               bias-pull-up;
> +                       };
> +               };
> +
> +               r_pio: pinctrl@2000540 {
> +                       compatible =3D "allwinner,sun252i-v861-r-pinctrl"=
;
> +                       reg =3D <0 0x02000540 0 0x60>;
> +                       interrupts =3D <85 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_APB0>, <&osc24M>, <&rtc CLK_=
OSC32K>;
> +                       clock-names =3D "apb", "hosc", "losc";
> +                       gpio-controller;
> +                       #gpio-cells =3D <3>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <3>;
> +               };
> +
> +               ccu: clock-controller@2001000 {
> +                       compatible =3D "allwinner,sun252i-v861-ccu";
> +                       reg =3D <0 0x02001000 0 0x1000>;
> +                       clocks =3D <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CL=
K_IOSC>;
> +                       clock-names =3D "hosc", "losc", "iosc";
> +                       #clock-cells =3D <1>;
> +                       #reset-cells =3D <1>;
> +               };
> +
> +               uart0: serial@2500000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0 0x02500000 0 0x400>;
> +                       interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       clocks =3D <&ccu CLK_BUS_UART0>;
> +                       resets =3D <&ccu RST_BUS_UART0>;
> +                       status =3D "disabled";
> +               };
> +
> +               r_ccu: clock-controller@7010000 {
> +                       compatible =3D "allwinner,sun252i-v861-r-ccu";
> +                       reg =3D <0 0x07010000 0 0x400>;
> +                       clocks =3D <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CL=
K_IOSC>,
> +                                <&ccu CLK_PLL_PERIPH0_200M>;
> +                       clock-names =3D "hosc", "losc", "iosc", "pll-peri=
ph";
> +                       #clock-cells =3D <1>;
> +                       #reset-cells =3D <1>;
> +               };
> +
> +               rtc: rtc@7090000 {
> +                       compatible =3D "allwinner,sun252i-v861-rtc",
> +                                    "allwinner,sun50i-r329-rtc";
> +                       reg =3D <0 0x07090000 0 0x400>;
> +                       interrupts =3D <138 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&r_ccu CLK_BUS_R_RTC>, <&osc24M>,
> +                                <&r_ccu CLK_R_AHB>;
> +                       clock-names =3D "bus", "hosc", "ahb";
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               plic: interrupt-controller@30000000 {
> +                       compatible =3D "allwinner,sun252i-v861-plic", "th=
ead,c900-plic";
> +                       reg =3D <0 0x30000000 0 0x4000000>;
> +                       interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_i=
ntc 9>,
> +                                             <&cpu1_intc 11>, <&cpu1_int=
c 9>;
> +                       riscv,ndev =3D <150>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> +                       #address-cells =3D <0>;
> +               };
> +
> +               clint: timer@34000000 {
> +                       compatible =3D "allwinner,sun252i-v861-clint", "t=
head,c900-clint";
For CPU & clint & PLIC parts, LGTM!

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

> +                       reg =3D <0 0x34000000 0 0x10000>;
> +                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>,
> +                                             <&cpu1_intc 3>, <&cpu1_intc=
 7>;
> +               };
> +       };
> +};
>
> --
> 2.55.0
>
>


--=20
Best Regards
 Guo Ren
