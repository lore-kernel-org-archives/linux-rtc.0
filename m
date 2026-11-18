Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963069;
	b=IcCd6yir7SxwFX7kkAF60vYQMAs/z5KJk6NuyhrrcKcplXiT9TswKzRSa/KQTqMp6q4W
	 RmfyZ+N59yn+d2oxb257lPkF5y7fYcv3+bDGhZboEp/yvQ8HNmhVMRZ+lfD4258+JMLje
	 /3zfIDory8r+yzvN8Q3aDpMAHGITeMg+uvdMaLiVEMajrLzAVTOreCzm/Cxxwc+F+fpw8
	 orTc1lv/LqwF/pF6tDrqzVgzn8cb7HDWZtwzysyZVCB5brtuzexvRdELBBL+2zyl7E/+T
	 XaVz94MjsATNHrr0UaJADb79VNdW5+yeEA6Dnqe1oXrDXZYqyt3lbD+MzLv0b4ZIi9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963069;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=1UbMEHB0WKx0u4dst6bzVbW5BKGdyKKbsda1yqu6+p8=;
	b=POBiRUzik8wfC4dKYWB69+522w/q7zN39KiMsz/Rtf3oX29W5bmN5YkwUbZqrhjxWZgo
	 eQLILUGosZb6fKysf1MkEdGnfuVcA+HaMsc2skH3dt7MCOdobbmDnRcZggrWNxvWN7Sa8
	 VPhLeZc4xdr5ju+P1KW4EPOKfhMQvOiF6g7n/iivIhvOxigIg57B0fhHm2OOOr6ZAeOmf
	 yxwJrSOnEu8twAULD4gjftqR5Vm1hFApV4YYz+196N21qoqa0abNpf3m79+Mh9gs9DQhB
	 vb2/aQF1ImVE/wmS1BvbeXHKP+M99DyzOzqUj0wg76El9NaRfTj3HkuCg+IJMe8cCTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vix5oa89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C98606A31C;
	Wed, 18 Nov 2026 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vix5oa89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874611F000C4;
	Wed, 18 Nov 2026 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963068;
	bh=1UbMEHB0WKx0u4dst6bzVbW5BKGdyKKbsda1yqu6+p8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Vix5oa89sYVH+p/PIq4YrS+tl+Q2d4GuSof4iYPr1Jes1ukCV07Ax1mT31gYyRuBk
	 KDVy1Xc7YkJFjBGk5YUHJzXhopjFDdL078g//rtk1yAnqg319z95CNtPuGG0OYycRO
	 8Wa4KGYOH0uIUrNnDpu51YSb5byQaABCxt57BX04GkSmivdOSX53foyLpW6Hir1D/2
	 Ojjfm7+wHiSWS3iuLZLjwaicqWHiDLEhCM8IKXgCSRYPXKRQo8/HxBpYGfmGkUl7uh
	 +vbQm41d1rp042Qx55pJ1nSLVSkIsdEJ9zElVuG66GwEr7i5ZiJxXGuq6KYhnQeAcp
	 dwuP02Th8yGRQ==
Date: Tue, 17 Nov 2026 17:51:05 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
    Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
    Brian Masney <bmasney+clk@redhat.com>, 
    Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, 
    Philipp Zabel <p.zabel@pengutronix.de>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>, 
    Andre Przywara <andre.przywara@arm.com>, Han Gao <rabenda.cn@gmail.com>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
    devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
    linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
    linux-gpio@vger.kernel.org
Subject: Re: [PATCH 01/19] riscv: sunxi: describe the wider Allwinner SoC
 family
In-Reply-To: <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
Message-ID: <fc63c0c4-5b79-87f9-aa42-7ed541361052@kernel.org>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 14 Nov 2026, Han Gao via B4 Relay wrote:

> From: Han Gao <gaohan@iscas.ac.cn>
> 
> ARCH_SUNXI is about to cover the V861 as well. Update its prompt and
> help text instead of adding another option.
> 
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Assuming this series is going to go up through arm-soc -

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paulk
