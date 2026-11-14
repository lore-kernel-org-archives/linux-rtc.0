Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662965;
	b=12NvEmLbVsxwfv/hxGq/xk46EJ43LX26Ncs900PoFe/PV9ob/Lay7227LFDRJJ+S7ieX
	 zpQqdkbWIqoStGN6rxZkxRNQUuhIU5Pp6t/3bHq3lQi/PLVRvPvUM9Kf65wxGOgF+kKc2
	 9qWTVBC2A8tLNsh5DhFUTrBHUnM4x/uWw5t7dG53rxOZqr6nmGKxmLDvjzBOUzvm25wFu
	 DcI1JbrbduIXE6udaE+0riu6xr3A7oUW+3q99sjpFyiHb3QAy6PoQRZuryEkflhWVvq2Z
	 DnQutWGVrWvbi/1Zm6xTR3NZ4DmFDSrcosXZ/d/VhFvUO4SnCPfLmq4aTOb6OLMY0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662965;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8PCw2XdXKwdBOKGqs7jdnmPpKrWXHVDdf62xcZoZaEM=;
	b=IkNuZray7iyhAQqAw0ADnpbM7yGhTUjK4G4lMkQ4q9YMaAxOIAsuVDr5xElGJKDhH+Ji
	 3DSMrZCcGNNPEXG0P0Crh3+z4UmUCUU1dLa/JL8yrmdRUTqRVjRM+X5eF3p/DK6YJSpEP
	 dDbZprMkLbpxXPY9l5IYGOgzXFXgmAWcb8XraAEXR1/JqebHoQD40CUe2itguy13GV9S9
	 BOcEFxLwN36JqhgaZR8SoIgrc15MgfdbR+/SjEJpTfap3snY7fZ2cF48HnMDEOCBLQLzZ
	 77snIYRUbqRdK1bJ3rbq9f6nIJSbY9q3mvHzU3DuqJuiDi9eCF4Mr+HyvlYMHD8A09Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCssEPw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E9606A335
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCssEPw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B371F0092A
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662965;
	bh=8PCw2XdXKwdBOKGqs7jdnmPpKrWXHVDdf62xcZoZaEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EnCssEPw6cov5K9aRkaXKIug9hrEdX7SUkUiCFbnGSp9r5EM7MzYA/v1ySC16+Wq8
	 xhJw/v4UJgT3fI9+hy98dPofqYTOqcqfFiUYFvqKbG3sUVnJ8js7ecNTxyJTA95j6a
	 gHn3YsO13Nsz/w2IGgwJ2xTvov+ogJDyVBcGRKcwifXUqmTy/AVqLLk6RFmfp+odf3
	 qdH8qAe5KkP6byA8F+ntNXj3/YJW3fP52hUWbgzPGAJyMWLYqblHWDCGd4XTuVoeP0
	 dI/ReNThj1xWEba13epitPGrdJlAghmmgVNNXK+zHleuDzGNpdIjGRtC6v034pgMcL
	 00Gzu6a7N7NkQ==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb61185057so3979205e9.1
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 05:29:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEjAM/hmIZELl9XbiLONdvPMbVHyADaeJLrzAybvXN1nuQ2mpgem4HFxtC9d2YI7aQo/iPtQlvdm88=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JZwCh4b/aFjK20P9lQ5OUQ8igosDYnxtf1In0/MF/XkjfX3kb
	9qUAv8CA1IZJ5mUwEQzu3P9w0lxd3czY+GHMp74fUhP8vkLWPDuGOh/TF7UPLI5HAOQe+xHvMpD
	lY+YvPF8tESY7x4BLdlty2gDFyWacP/g=
X-Received: by 2002:a05:600c:a10a:b0:4a2:10f9:37ce with SMTP id
 5b1f17b1804b1-4bb55a4f1d8mr82881675e9.15.1794662963477; Sat, 14 Nov 2026
 05:29:23 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Nov 2026 21:29:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTREPzZeBX+HMvXhPfgW_PUaUQRS=beZdUAX_dWdQXQXoQ@mail.gmail.com>
X-Gm-Features: AclHuK8FYIwK7avJPlBwjKjnw3eVNsp5Aw_49eWaUu--rt0mOUqOqs5zKnvpneU
Message-ID: <CAJF2gTREPzZeBX+HMvXhPfgW_PUaUQRS=beZdUAX_dWdQXQXoQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] dt-bindings: interrupt-controller: add the
 Allwinner V861 PLIC
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
> The V861 uses the XuanTie C900 PLIC implementation, like the D1. Add an
> SoC-specific compatible with "thead,c900-plic" as the fallback.
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml     =
 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index cde4bb691897..6178fea9bbdc 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -72,6 +72,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - allwinner,sun252i-v861-plic
>                - canaan,k230-plic
>                - sophgo,cv1800b-plic
>                - sophgo,cv1812h-plic
>
> --
> 2.55.0
>
>
Oh, my misunderstanding, thead,c900-plic is used by opensbi. Please
keep this in the commit log.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--
Best Regards
 Guo Ren
