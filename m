Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422775;
	b=GpmtFYPyTUaK+opAqo56oV0EqeIo3sFHPmzKNKS588nHGzG5zWhJcuMTt0dvf52QrB1m
	 Upee9Q30n3p/nCB/lqf77YCFhVInXKWXI11/2eRqpWKu1rxV73lDMNLmjCyCnsFXyztxs
	 WILR6Jbx4KCHM4cfrl3ZkZ4I4ND0UHgHjMsaz3StudJ8LookUTo4Giu4vsnFFzcOOEdKx
	 E9tEoOogOYok5smO2CqOySctkDSb048uhacQwHx33sjyD0H/7b4dmWDsSebUuYi8xr7RM
	 3s7sQXLQTnljK9pMj3PCrtaBNHQQorIHXnLsBzOYuYs2VtZMGac6Y24hlEB5zYTGvAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hK+8Q2rxW3+mXQi4LiySks8WPSozUnGzSojRtXKXJ6k=;
	b=QngC/Xuj0W+zd+6iMpOX2ID0l73o6m3DB8P6KX+WqO8dFWF0prlZtkSNJi8Pidn5QWhO
	 ryVdnRDZ0b5k9hKbAL3/roWHfNOd7D1zNcOqbeMl9qCQT3nuvCa41L1lVpwzNUfhYhf9P
	 ILmLp2RGE0rcgrB8p3ZdPoYlQzi4xhVQA88A5CAyKzH6pkpueinct4GjY4UA1+jRGsMYU
	 oeyr3bS8uhT3J9tuqng3qAgxUMcLxDjbiG7IDRsfgh64nPkOkUFEqmueAB2i2zCWXqVbG
	 laKt3AGQp2CJ1TZ4S8sTjux2nmAC37gsKEDyDd5pQtw0DIFF2MxtT4ascm42dhkjX1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WByc7++y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC6606A31A;
	Mon, 23 Nov 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WByc7++y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA11F000CA;
	Mon, 23 Nov 2026 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422775;
	bh=hK+8Q2rxW3+mXQi4LiySks8WPSozUnGzSojRtXKXJ6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WByc7++ygvLRkDheW+2yLC+5gjdqpspTl98UBYEJeKQcwwr1WDtHL67TbgEKJJouy
	 x4uMtXza5ipbnq3OEq1egoS9+ZypPMyEGGdGD4s4anBUAkMc10VPUotmky/lc9DvJX
	 tS8+m31iQrZMcT07FtdgOQlg6/8gCVwBhFftrUyF7H3rR5G4wABafD5OmqQ9mXHNWq
	 ThbSRO75lWHL5sxPbnCNyKniyin1NnX78Wc8h+tHBWJt2DbmJVryhHTQ1H+HNyI1jO
	 lCtIcG6Xz9lg2N/g3EWSBkQPFjc9XcQglRQ2sTDxJYapGVDbVlKhu96urptr8gDu39
	 dmJyzEwTQ98/g==
Date: Mon, 23 Nov 2026 09:32:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
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
	Linus Walleij <linusw@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 08/19] dt-bindings: rtc: sun6i: add the Allwinner V861 RTC
Message-ID: <20261123-agile-energetic-mouflon-dba749@quoll>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-8-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-8-eb71ec3ee523@iscas.ac.cn>

On Sat, Nov 14, 2026 at 06:33:34AM +0800, Han Gao wrote:
> The V861 RTC is compatible with the R329 one. Add a compatible with the
> R329 one as fallback.
> 
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

