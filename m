Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663035;
	b=bu+tIwt+3wBFGUWRcvIEI8rxysvuiOnTG3MAgktkyYDf4xtJmdLrXsEzaiF5GqMZBx3B
	 qcS2sgZ4jsi7ssyycsX+FX8R6OOHcD8SecPZGd1zOqefpCa1jLZ/HqYGSkRdE65sk3WH8
	 oAn85i1bRUc4gmIVI03GbIFtG60wo7FpRsFLQ3H5aAPW9Peqv0qb4qQDTSjep1sJXoXEl
	 LoLQTHhrfCHVg2rN6M/rySZT/C4Xeitp3XewnkBlanIfLX31gSQ9Lpxm18IGTKptuUYIG
	 5k+QprRz3EEoIveRdhseR19ktnXYmR2qz3QrygjAZk99GTtCEuJpsCECx0Nt3djEBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663035;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4kdsxrLqnYOpX1QyU0iNFte1eOYe1nCLmGqKY73MdjQ=;
	b=0PzQs4NndsdJx+iQeZ+3e5817V1cWQs3YKkFk4YYh/EsdUbI7+eRYgzBPcJMCyF+lGXH
	 i6syL+6IrqEd6hjmEc7/mMD7GeoiE+UliidEb0XQFjP38qq2iQDsVeV3KxMeybuhSm7YB
	 FW647wdil7xwhRcQ/IKwci66jB+ghNIesIDgWYw1jld7SCJXCVdA9C/x3UJQkWm5ZZj63
	 NGhCClaREkzNlXIHkeiZ5EeSb7gOZNhFM6ZKIguh8GGO9/zXkSqoaVRgU8BTt5UGr9Mgh
	 CLnZxH8rqwS8IR7Fqnjk5lkbK2LNeA4OTXh9yJGFKFljMJAeOaxkL+G7q5RMpV4zBzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbe77+1G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C65606A32E
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbe77+1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB21F000CC
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663035;
	bh=4kdsxrLqnYOpX1QyU0iNFte1eOYe1nCLmGqKY73MdjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mbe77+1GhvODI+6mWq5hPRR5d8VCtc9UMyfbjr+wccQGdxYPb9nXX6Y3s8yGz6kIb
	 fARVMe7B9b5Et13NlB8hB5LeWaFryaB7pJSkHiyWDoClDmPB2TlzhG/YI8qDTjQyE/
	 WDYvttsj6kL3Jr40rcFF7sVzzMxutqB1pjXLA3LPT/3vG60X33w+vhS0JbUTe+7ifG
	 pRaQ8FCones0hTHahfg6b0pKCSEghuci+Q5h5pGV3/RP7te5YPKnzUWRAgSWqWAJJm
	 1x/N9wO2eWU3JIquYC91FWUiwJsvg9fCcORSszU+M2uU6/IAYsisGgX7mvKHBJlkZ3
	 /lEINIMPlev0w==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491aaed7565so841785f8f.2
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 05:30:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG+RYXcyHS1d65G0wVVpRkjCDDq80yGfe/7fR49I9/Ijq3D/jHsHfNE4CdrPkh1bl4IodG1a4cUnew=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Iv7FRmRtgq3CwdT8sU9tcDQCVB2iMO0UgDuGYJvYNyYb2jtI1
	17KVBIlTd9Ka5r2D4w5cJOSwI7hXjy+lOTpJYIzK5JwaTp9YQDDrxWXGXmPYU8lVLceAp+PWVLo
	Q40FlnSrhjc+cN95KNjuCK+rpPxG5l04=
X-Received: by 2002:a05:6000:288c:b0:49d:1ce3:1849 with SMTP id
 ffacd0b85a97d-49d1ce31d46mr9587940f8f.21.1794663033180; Sat, 14 Nov 2026
 05:30:33 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Nov 2026 21:30:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRDcAVjTu5N+-8zhPJRvgCBiTtt3xZRbF_1s7D+yXXJ+A@mail.gmail.com>
X-Gm-Features: AclHuK8K2OPl8wvZJVK74a7K9gwaF5hUGnQfkFwAnJJ_kB4aFWWolyDhl3_PTvA
Message-ID: <CAJF2gTRDcAVjTu5N+-8zhPJRvgCBiTtt3xZRbF_1s7D+yXXJ+A@mail.gmail.com>
Subject: Re: [PATCH 04/19] dt-bindings: timer: add the Allwinner V861 CLINT
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
> The V861 uses the XuanTie C900 CLINT implementation, like the D1. Add an
> SoC-specific compatible with "thead,c900-clint" as the fallback.
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index d53f52e80d88..313fb39bd453 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -49,6 +49,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> +              - allwinner,sun252i-v861-clint
>                - canaan,k230-clint
>                - sophgo,cv1800b-clint
>                - sophgo,cv1812h-clint
>
> --
> 2.55.0
>
>
Oh, my misunderstanding, thead,c900-clint is used by opensbi. Please
keep this in the commit log.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
