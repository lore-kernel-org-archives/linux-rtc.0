Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698837;
	b=s/i/a2o63N80nAMmmZ+A6oeui4bCrWt6cEe53SSO502PxXOlxRj7DXG5Nms6onKk9k8u
	 aCpzED8JL8qnw7G9yhKFcQNEA8K7ncIF6RDafB9m53tsgKyTC21JJQs72WvaBXjV59ZBM
	 wSGNqBz6NAdUaLqrLixHVS+5gghJgMQqNokMOwerermDPnmRIjQZRt2gUvmGzteummppU
	 Ttp948erJ6H05IHjLfbg9q/oKRUA72c3O0E0RKDE6FngJZ8Fv5NTqg/EzWpt5GpQ5GjcX
	 cqUT9ivgzrZ4qwNv4XNZF9ayn7O39GoFBwigFj/BYX8CJolPhkSOZlmLSU3/O/THXHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698837;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NGKjIx/lsrYSs635frFVwYK8gqcYIaaf5ELPmMFxaA4=;
	b=J2xc0wui9E5jXI00OuU1+NVrTfMpHlwBBxvATz8yiju+6Oz6m77Sn5F8m0xts+UtB7W7
	 tiAoloWfMyyzI9dG3n38wKXqNthjbcR6hn7RUCnNY6ZYwBXB7X2sCYyhayk4/lhWBQNuv
	 eIaS35EBUA9IX8nK34kog5p9/Vr8XekERt87ydL8HtMZ97xPbI6mS/nXqelqGWfnH4U+I
	 4IOTQ9wj2Jz7rlYC0uA8rL5P2Y4Khei4gEPeXpwl5Tu+epD8XDkCPfL7mJ3xS3nuii1Dw
	 ASVZfmcAdb2b9UZQ9+r/lPEyci6TftkBGRtWvfjsSkadZI5b3HmrmCXnZWkx3hpqLpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E76uDGxf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D9606A321
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E76uDGxf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9571F000EB
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698836;
	bh=NGKjIx/lsrYSs635frFVwYK8gqcYIaaf5ELPmMFxaA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E76uDGxfRoHMxGSx1n/KhJ+/uaL9TdbXC0lWWjb9UmJO+qdb3//M1VgGazAdje1Pf
	 pJKZvnJMW10Z7G9wYhRoZnqJ+GttWxUDW/DmhV5zn1mTSj62mG2eFCOp+qUwhw10Sm
	 kwMz/4/CQQJansfi+O1ysUveSuxNaDvXslw2VllzhDvIe+QiM8Vm0h0/3bZ2eQ73fG
	 EhicxdctRdXs9uh9tuvm+2zx+teaJl8bI2B9RZ0nLnVpHgQLf6ZBJDU0MbqVoUQedI
	 lIG7xfKPt0LJUj6A7L1VG+g9H9szNvIYHLeSPeiQFwyybnEgI1FqgszUlIkUVpSGZW
	 mpeycp5SAbIow==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so4379762e87.2
        for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 05:13:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErELPnZp2IvK2BWxoy7USRgiDWEADF64mcHaQwQHJAzVg5bYpBPAuHU3bR5jCyQI1vlsH5H2vlU7uCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+wp24lzq5Vjge5h5PfTgZWPtBMm47Sb4rFcrFNw+a6QJHwJyO
	ErBbT5l1kdBs0uSMMZCRjXXxgFtLAJjZywpElNZlxUDT2yf5AEMXUYvJhoX/QRlRnAHE5Xzkz0H
	tfltuVp/qGoRCZjnKYIyzLZlwewVl9Nc=
X-Received: by 2002:a05:6512:304d:b0:5c0:a65:ad2 with SMTP id
 2adb3069b0e04-5c1bc814bccmr7600916e87.49.1795698835538; Thu, 26 Nov 2026
 05:13:55 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:13:40 +0100
X-Gmail-Original-Message-ID: <CAD++jLkSr5Rw3vzQH_t2uGq3ZSnFDuFxwhMpdPbZ-OHmTqiMvg@mail.gmail.com>
X-Gm-Features: Aa3M54q_yjAB_gF_ehQIHoUZMFIkQNhkQlSji1urlQGfqAlyuSk3xRkB3BtsRVk
Message-ID: <CAD++jLkSr5Rw3vzQH_t2uGq3ZSnFDuFxwhMpdPbZ-OHmTqiMvg@mail.gmail.com>
Subject: Re: [PATCH 00/19] riscv: add initial support for the Allwinner V861
 and Avaota F2
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, Han Gao <rabenda.cn@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Han,

thanks for your patches!

On Fri, Nov 13, 2026 at 11:33=E2=80=AFPM Han Gao via B4 Relay
<devnull+gaohan.iscas.ac.cn@kernel.org> wrote:


>       dt-bindings: pinctrl: add the Allwinner V861 pin controllers
>       pinctrl: sunxi: allow a per-controller IRQ register base
>       pinctrl: sunxi: add support for the Allwinner V861 PIO
>       pinctrl: sunxi: add support for the Allwinner V861 R-PIO

Can you send these four patches separately so I can review and merge
them in isolation?

I think entire-SoC patch bombs only delay merging the things piecemal.

Thanks!
Linus Walleij
