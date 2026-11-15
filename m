Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727926;
	b=OW0mc89WzOMRfkvLNx5S8I3Psf3VaX2NFjYWorh1mNHK0S4tasnBfIbvoQcCAWpZB9wp
	 zBX2fsJ5PfQoYeywPPtusi4HbK3eIIL3FSn3LaDfv0R8b3ASdmNDEZTT6CcZLauBSKM42
	 JQAjL5ny5fjUo1cJIsbkSiTvGSeFPR1dXYKeRtAB+F0kuGaNhG2eW4+Xv9MdkLuYsBjHy
	 1HH48Gmk/p3z2P451WEsmGfWmCW+D/UvLccBZSAlkykdIQEvW8kJ041yOaISksMZTivsC
	 XV2dfjx4bvj/Zee+fAG3+3p5KjDJj9JrODo8kchg67AUCbFb+b2Yta24gbUU6p+vNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=WZJNoA9PE/aFpJtYQV1Avlq3zZ1+tFwplbGmb9pSnGY=;
	b=IjJIAs97fkhFnxdSCw6sVH7yUCmAwKVxaMj5nM4r75MkzcCt4O+ITVD450GW3W5c0kQY
	 3urlm/lQVOE/iMudn0+IklJHZwQktZAOjqedmSeMwFvPJiJKw/E3v4ABAvG014Jq84R/U
	 /jtHjnGsVFabST5PeYwwgzMwyPgsv1gBJUDlOUv9QpagPhF/SQMLw5WgH4hJkkO79+xLN
	 t0rL5rtiSJkLxgCeOMhlR4hsVIMKiTL5PI+K51VgD/4RFfRMY6T8ZRSjDfyNJ7GAtgaUj
	 0Qz3xKTGfTjbBRdDRcTYBnCqlYiOs7lJ+xBGQk+yW4ERzM5Ngm1TmE/ap3c3eWV2wEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGLp07qN;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02070606A31A
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 07:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02070606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGLp07qN
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490a0e72588so1007622f8f.3
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727924; x=1795332724; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZJNoA9PE/aFpJtYQV1Avlq3zZ1+tFwplbGmb9pSnGY=;
        b=zGLp07qNJvhQ6+u0soNSdE4zISfLgteQxFDtiLB3+MHdU5R8cLNayQpDOu9z6E8HsN
         cokgnkhAr/wayCMP5a5YNMbrz8W4SjZLOU5BRZvRdWywNx6ylkAud+eGM9IO9xu5mMW7
         vNaai9gq6sOgHH/Plv7KLPJqtlQ7SNQhP8MwbOsiVY9oebQhNkQHqvTKMcZy20gw6VyG
         k7ZCwjq9cWqbqhlBhjXQDv7h88lCfGgbi6MypmIx2cT/mMVK282PdLi8Wwi9Md6f2p2U
         0P0GPJt+gXIMzGs33ytfrKjlEGV7t0Pg95zZC84eG54l5hQ2KUyeWmzxrEwtZdsEBCOn
         OqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727924; x=1795332724;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZJNoA9PE/aFpJtYQV1Avlq3zZ1+tFwplbGmb9pSnGY=;
        b=WWjAOst9pl2fONJTQGNqiQdb5RS7oKXrojGe/X0zVtaX22vgmEs6yrQvgY1b2nJwy6
         ank0mefo/Xswjyejjzn55e/UuYZKWyqdhdLp4JqsfmJFqmVl0NTo1wAIm1YloqHaFbuK
         WAZJWwKTMhDlqONgCQsdxNa2fADRCd8hPaxE23itIpcWEPZBFMWDfbEUAdzEtHq9iA4W
         TKqgUDGAF2PbZdn1vH0vB9rRU81NkrQ3pzrqks0QU+E9t0EHCJpKKLLgRBx/AKkuQIf3
         jhEhSlLpWD1ZyVT+Mdi+GvtdYFgISSjBXDl2dQOU4oi5fWz2vC5w3IINxVYvnUuDXjRF
         /qzg==
X-Forwarded-Encrypted: i=1; AL+hErGCK4apyY9fOtO4jo67KWcJ3DQ9mnyqA++3D/BUw9lgBTknES3yFI2f8w0Y2Fo0fvKS4d1uwqwbOfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gcodeYFQhyMMsNDH8+wRtFLEewfgTYHfMm/3Nr+l0reZvhwKE
	bhH8gZXWW6xFZP18/DgpbB0q2N0TltuJktVDYvCj/AD7M5XJ3lrY9OpO
X-Gm-Gg: AYBFou11to4UnPdr1zUwlOpp+pftBKYjaYET6K3VeotcRr2x9RxM45FCaksyAzwDPzu
	RrxI5K8C8XBGgNCqHZXs2HwRd1P+32elpKHmxsAYh2gaye5ZYsDx5eY2vYxc1ECoKmg4sHBrpp1
	C5/k1+UgMv3pClVPrfwLmn0Gt3oMgVc9+hFKdb3XIbt5WAPKLiO7047YGeXKUAow3c5R7gliY/X
	c2cqg1xI2yTwOHzO0PY1XBLLOQ5r9kkTkm4Y7HCF2Iojmrt8rbc591O75grPQSV4SA1o+qEBURk
	7Xecf9p5UsaAheZCz62r7EgnmD9R8uPK+zKt4LkBIivtGbUyAa2QaJlW3TfERUBIY7YBfKpn5HY
	W1FzQ8iK+JZItPAMHJonzkPLELcwpzQFdmRctXkzL4lSfvuEuo83vUj3+0UqIhUlUUISlQ2zcgV
	dgtTImcGlBWkugjIb7oSziOrqN1kqfcyVnpsOGF2XBs7Ir71rUw+P4trmaYr08PKOXAAj2M8JxA
	LJTLZhPt2K2/0Ymk4UFSC/8lQCyC38qKMwrc+4u98D1jzLKlPIkOBB7V+ShlUTla6HwY4DJlOiX
	pyE4BnZ/VTLK9AJhDhTigrCIoOPzBtdnPUi0sSCKUXRKb0Ra+p1Z1V2C9hc67Y6KENBo8+pwFaf
	gS10XbIAqHM18mU0wt4WjyaNn3PJtTIzY6R57+E1gsiLHb1DEGcHs7iAAAUP8YMQARf1lNfnFpr
	pj6KzaOwVOuCHiO9W/x2mhYMhfZvIREt5sLkWuM7mspT3JdxrHkTr98n6i1vLB42i3AHwzQtCOE
	JHZNTm8Q6L5eh4rAf4vabnXfnvuNKZXwDSUt/cnD2Dr/U0=
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr146703185e9.21.1794727924403;
        Sat, 14 Nov 2026 23:32:04 -0800 (PST)
Received: from jernej-laptop.localnet ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm183982925e9.2.2026.11.14.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:32:03 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: gaohan@iscas.ac.cn, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Anup Patel <anup@brainfault.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev
Cc: Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-gpio@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject:
 Re: [PATCH 19/19] MAINTAINERS: add an entry for the Allwinner V861 SoC
Date: Sun, 15 Nov 2026 08:32:01 +0100
Message-ID: <G7_h6i47RcuqvaGeHxw_dw@gmail.com>
In-Reply-To: <45f41ca4bcc76a6c5d0b9180c6492308ec3e85c9.camel@icenowy.me>
References:
 <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-19-eb71ec3ee523@iscas.ac.cn>
 <45f41ca4bcc76a6c5d0b9180c6492308ec3e85c9.camel@icenowy.me>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 15. november 2026 ob 06:11:31 Srednjeevropski standardni =C4=
=8Das je Icenowy Zheng napisal(a):
> =E5=9C=A8 2026-11-14=E5=85=AD=E7=9A=84 06:33 +0800=EF=BC=8CHan Gao via B4=
 Relay=E5=86=99=E9=81=93=EF=BC=9A
> > From: Han Gao <gaohan@iscas.ac.cn>
> >=20
> > Add myself as maintainer for the V861 bindings, clock and pin control
> > drivers and device trees.
>=20
> I think traditionally sunxi do not add maintainers for specific SoCs.
>=20
> Maybe you should patch the regexp of "ARM/Allwinner sunXi SoC support"
> item instead.

Usually no entries are added at all.

Best regards,
Jernej

>=20
> Thanks,
> Icenowy
>=20
> >=20
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93abbb315065..dfc300dc1eb2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24031,6 +24031,18 @@ F:	drivers/irqchip/irq-riscv-intc.c
> >  F:	include/linux/irqchip/riscv-aplic.h
> >  F:	include/linux/irqchip/riscv-imsic.h
> > =20
> > +RISC-V ALLWINNER V861 SoC SUPPORT
> > +M:	Han Gao <gaohan@iscas.ac.cn>
> > +L:	linux-riscv@lists.infradead.org
> > +L:	linux-sunxi@lists.linux.dev
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/clock/allwinner,sun252i-
> > v861-ccu.yaml
> > +F:	arch/riscv/boot/dts/allwinner/sun252i-v861*
> > +F:	drivers/clk/sunxi-ng/ccu-sun252i-v861*.c
> > +F:	drivers/pinctrl/sunxi/pinctrl-sun252i-v861*.c
> > +F:	include/dt-bindings/clock/sun252i-v861*.h
> > +F:	include/dt-bindings/reset/sun252i-v861*.h
> > +
> >  RISC-V ANDES SoC Support
> >  M:	Ben Zong-You Xie <ben717@andestech.com>
> >  S:	Maintained
>=20
>=20




