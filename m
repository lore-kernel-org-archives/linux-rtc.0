Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662044;
	b=XqdGjqs/bXg3Od7w9JFx1OK/75luXy2TsRwKMrzQ0Wwe1LdqmcogkDlqTkXsqHH/+TpY
	 VpIyGJeKgX//n8xXs70nsVlCM1YLUhHqLq6+oraUkFtOk0kjrxICdsfmVnOg4PRMxJSgy
	 jIUZW3LKf/k2N652bnm1qJnmXxiTNraRhYe5pHKDxs1EjX4P2QqqGSExjbRZj5m/hhHCW
	 iMWVjOMby4FOGCkUDi6zy79EiSIYH3TynoqB+52usJ9Q7mBwunM8QoT1o/jD/3b5QZghj
	 4bmLoajgvhpTH1bk3II0J3Rpl3eQQe3DHEC4ZpEQwF191jNhKT5AK4MqZUvh+C3VnCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662044;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Xu1Ch5SXzmukBzjwhfrUVAX6Y1aXdcS/DpJ5yAXyxco=;
	b=nqz2TXNWONP5i1CFBkPIsjtty1rmCIFpOmsTshrZUbb1YwW9kLtNTuN78CpljGW0Sx2Z
	 g3obJsykH9M04I/ktUgHy6R6yMFLiL0MIZL26EHubHbiXNFDc5Rd+jM74pQhttLwMx8Cp
	 M9ZLdDfBuSJnMkIlAcD1WO5GNyNnFt/7GU1xDDgw7fCuZoMHhxCzgPn9QMI2Ne+Ov7Bbh
	 o7/PeCC2abp7KMI5rqhfEPlN5nlpFCtvoy2f7MLDtzLt5AC0E/xp8A9DBpD3OFKHlZWyZ
	 BUdX9JIT/ySJ4h7eErURidtDugMy+pipqN/pic3C8QvrMWbfwzHbw+GwQF5nJyijR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv0p5Oqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6F606A331
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv0p5Oqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D1F1F00932
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662044;
	bh=Xu1Ch5SXzmukBzjwhfrUVAX6Y1aXdcS/DpJ5yAXyxco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zv0p5OqaUOwOAG7H6IinOG7MKZZLjNtn8OpRuk/AMQ7IhMTG2AbPgDz35aF4yoDo8
	 DMBl1Cjp+ggQQPruYxZxsi4T92QMfMU7YlzFFCLOeYooScYmtjd+qfYgMLJ+TgLlZv
	 Z5NtnB0j5jlAg9G7Dixlnfug9472vn/X8f9ftZe5sM+2bpZcK0t8gwsnTeKc3X1OM4
	 VP1RHgjt/00kaQLWuTi1rmeqCC+huv95dY1n93DRFw8FixtteLaYiG6SVGFZdNtvti
	 m/lJLJz1BEC4f2Lfd6Ewa3QZYnKvvjbtwSDGU/EnnIotuM/pp1L34UTab1BhcblTYD
	 SlTYSEgtX6IJg==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49134c8509fso2051266f8f.1
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 05:14:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGqVyYcbD9Y3XdMa89ujZ7TZppIoBY/WQdLtD7Gf5GEkazFUB9GfAcc2jCt+QsIBnqJUCY1bShLWn4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j7vRk+uep+IPEWxhzX5MVN+3D3E/wHx1xJSksOQNe7VUnDc8E
	bj2ATElbbc+/L1dkqy4BVwREGN8ny21uFkYzluGyBfndA7TE7ilsL9q09tjEvFSSMxu2OiFLpHk
	MzvVnK8ftjElJeBI324lPEIB+kZybDbY=
X-Received: by 2002:adf:e00b:0:20b0:491:45bc:d69a with SMTP id
 ffacd0b85a97d-49c72e852c4mr9010555f8f.44.1794662042739; Sat, 14 Nov 2026
 05:14:02 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Nov 2026 21:13:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTF0b-dkLdznGzwYZmC6rP6GozX1j0Rre5t-aw6i5uDvg@mail.gmail.com>
X-Gm-Features: AclHuK-h5N3J841s1gOOr7kF2F78LtoydmQ7sQ-jEgbZErj4cvRoD35qUys8ixA
Message-ID: <CAJF2gTTF0b-dkLdznGzwYZmC6rP6GozX1j0Rre5t-aw6i5uDvg@mail.gmail.com>
Subject: Re: [PATCH 01/19] riscv: sunxi: describe the wider Allwinner SoC family
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
> ARCH_SUNXI is about to cover the V861 as well. Update its prompt and
> help text instead of adding another option.
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig.socs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index cecbce0c4983..4cf3b24467e8 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -61,13 +61,13 @@ config SOC_STARFIVE
>           This enables support for StarFive SoC platform hardware.
>
>  config ARCH_SUNXI
> -       bool "Allwinner sun20i SoCs"
> +       bool "Allwinner SoCs"
>         depends on MMU
>         select ERRATA_THEAD
>         select SUN4I_TIMER
>         help
> -         This enables support for Allwinner sun20i platform hardware,
> -         including boards based on the D1 and D1s SoCs.
> +         This enables support for Allwinner SoC platform hardware,
> +         including boards based on the D1, D1s and V861 SoCs.
Perhaps we could keep the help text generic and omit the specific SoC
models, so it won't need updating whenever support for another
Allwinner SoC is added:
This enables support for Allwinner SoC platform hardware.

>
>  config ARCH_TENSTORRENT
>         bool "Tenstorrent SoCs"
>
> --
> 2.55.0
>
>


--=20
Best Regards
 Guo Ren
