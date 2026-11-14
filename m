Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661654;
	b=hefPnEfOap2JPw9RGvcTl7LTXZx+iRbFsGdqjMkMCTBy2XE6AV5J1kQMQSR165ZPEGAG
	 HbGkNOTOH1K8tqLrV/godXO6WQS/LsfaCK+HZT1d5WHHyTMQaGxoFoY0P6EfI7egpWkU8
	 4kXAARHegeetOU8JQeznxHn9vXNEJUJSCJeoOCeN/eCnCQOuXVhRIL3tlpO391GHJJnWA
	 INxsjz6+dt9A5kYRDo6eI29tjTpDMJzm8bEUr6w/CoONmNfcwJQ/IC0EcVEd3sezX/NRg
	 FntEP+bYCwOcGWN2sFfNwP6G10g+3MBmlcAAASx02VNdyPe1PxOgfwzfvyzfqH6TB5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661654;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O67Sld1N23xdXCx6gIqCXwUsjQS8tlDbGqdMHZU/fNY=;
	b=S9uh/dE4tbAITPFAPSI7k4JmJhuo1+KUuWm8S1ntdYvWr6TTMJZxEwBHKw+zUpKei0w/
	 9fDR60PBgnAVBEzIIqTwF6TAth6o1oiWLnG1/NVzhXDw3dOJ+0axeZpoLdqnKDAs8H0fL
	 RRdqcAqiNUDOS++lgwNfGI1+KBd2zQ8cg6+tRphvfJCy9wRa8QHSCF8RHSfKIrU9VDSO8
	 QIgvLHt1qOf1Ly2+4agdlB/S1D8sIvkdrV8t6sB+uIwjQ83KNd+U3QbpPqnLM2ShNIhW5
	 cSNLI1M2JIwr8jle9flcWUlQPGBunBEWdaFRStdRXd3mE0NYDH+1nKlXpBXuwUccAMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAquH30K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF7606D2B4
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAquH30K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350DA1F000CC
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661654;
	bh=O67Sld1N23xdXCx6gIqCXwUsjQS8tlDbGqdMHZU/fNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iAquH30Khmvacvb33iblyujUgHVesD/yt9CYr5SmFcp1ApKO7T+J37/AyKkyTaSv/
	 EsWGut9q7KWd2gVEyBu/nITBODZA6MEasZBNx0yJah9iOvv4l2nbwnsrsyIklDiQir
	 vnJynlk0O1pmrm7PPFcunHu4Gq+bdPIoQO27xkEZwUlpTj5PAYVzwUf7vDdSUjZ2tn
	 pi647oQyFJF/9n5Oi3H2MjRredHD7BHUm5xS5M2h6NjsyuRzK4q3SlYuiPx3dSdoYf
	 XzKGmiMpZXUPQQCApGxPkLf1MaAmTU9qLoLldT34MGOwd3AerJ6SvgJ51qV1vY5qb9
	 XKyABiarnAsdw==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so1286838f8f.0
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 05:07:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGSpNbPCGbSwMLr9YsFzUhNsVbVrWTUO2TqO6NEDQoUi84eJqQDQ6k5sPeyr0mSCCKlq/N7N75UfXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8seCeBRFdVAX1nYRJqvdK4iYo1e+DUmnIcViWCNunaO5NyKXhx
	/MY9hAPaEhURL05wMA7YBJi820dvPpqE9T3z7edb0cEFISJE5mvR9LUs+p8OQkkNbenglBaF0zU
	M0iXmAlandHkkHzdbd49lFEBbR/FWOLk=
X-Received: by 2002:a05:6000:4202:b0:493:72f7:1d5b with SMTP id
 ffacd0b85a97d-49b03217678mr21427286f8f.29.1794661652676; Sat, 14 Nov 2026
 05:07:32 -0800 (PST)
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
Date: Sat, 14 Nov 2026 21:07:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCtecm6LsuEy_s2rS0hAFzjN61FPRkhdPXg9Vh+xqNpw@mail.gmail.com>
X-Gm-Features: AclHuK9gMmE7_2DKOWkhqnjhaQpkVZ3vMJCR5skQAuEE5nkS6qc3opH65-HdPes
Message-ID: <CAJF2gTSCtecm6LsuEy_s2rS0hAFzjN61FPRkhdPXg9Vh+xqNpw@mail.gmail.com>
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
It's allwinner,sun252i-v861-plic in the patch; please correct the commit lo=
g.

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


--=20
Best Regards
 Guo Ren
