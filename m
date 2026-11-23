Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396868;
	b=eNkH0D1AdMvpUtqh1RhhA5B6HcfX3KUMBmPZ/Dtyh7kHHNFWxlUBi+rlgf6SK5ZPD/SD
	 cB5cm9/Z7c+r07EFCwz8aeoSAeRMYSb6O7Qiv1/p09Df/Fw90nvMh4+qvp3BIXq06EOS9
	 d7synmRXX0YHQYDcoCMt8uRm88S7a4ejUbGmdZllfUrx4lc1Ibbeo5ydLYG1JeNDHVsUN
	 rr1wpcVDSPn6pN/yekpfRYJB17XRxqdDflOi6+qmdQNjILX6asyxHbzuTAlKgjb7MPv6u
	 BRuMWWS3bNjIbCDr2DgegPcO4LSud7NSork26zDVuFLuByH10gZ3r9PeWmNCl8Xqarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396868;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mZqHayVGS1xgtvg32Na1JhcmVegYW+rmWEW78/lQ8ms=;
	b=1QX/MPlni+BhqGS6mIJHT0Dk9VqMs3X4f6ep+mxHAGRmzdOEACaWyvyxZXKu3I4sJzfA
	 rtLhX+TyvibWtQI6GVRP0Z18WoEh1tNxVquAVfbj57KbHyiAXGzeN9Y6m1unp2xP4shhf
	 +Caq93oLEYqrSiLype3x9iC33ur97Lw5ZX25Zm1hjioZiQW4GjjMNs8O+Q+jEAiU2ptnp
	 I5zdbIJUyVKaG3avRgzpzTp4jVxy8R4TY4Q2Zs95M89tqO2gFSbOPdB4nUn7EDI3hBt6p
	 JUWiY5RjtEvi/lbXg61W8F5IAQCBhItiItLxfU7j2En/c6CVyC0qxXEch1d8b7X40Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTrlzpYy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE20606A335
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTrlzpYy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640711F000E6
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795396868;
	bh=mZqHayVGS1xgtvg32Na1JhcmVegYW+rmWEW78/lQ8ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZTrlzpYyHkD37ac14SlODZm26rmfd5P6KaAGLQUT3po3WrrMWL3Jv3BGkIZZLTu41
	 mjn70k9dY70qj3+oxM/3JRPIXWHdOPXdrV3lGnPqPCPfXkxVa7mUjhBQs3dhp6+WJ3
	 L0sIY3L0i6zpSk2UjJ7VQmvFQdKGU9KDS36AH9wRMLcTyNZp1nyp63vxF/IiAR0q0/
	 2nVpXaIMpgoaaqVzrpTOIlrWkVBy7jOFmdIjVMSIwD39fnGFK2ftPthoAFJYtOuGJn
	 6mpu4YSfLgYUOs0xeUUMS5EUkr9zrcNSH86g820h8nW28DWBGcwVfnyYHDGdjp+ZLh
	 NvHCMHpjYF0rg==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so20220615e9.2
        for <linux-rtc@vger.kernel.org>; Sun, 22 Nov 2026 17:21:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFZtvJIOcSp4NXPtOL/LXd7xgiFtlTuKoOAMf/HhoIQ4UBGRfIMDoqJmikkE33XBX09fIqq1BS2v/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S0Rw5JkC259y/nEOmeZQBaaEdqdKlZGDbj0jRPrQPPm3N5OOG
	s8Ae3d5dNMkclzdwowfQQzgphqLYoVXH2wzJvE52g70VPuG4HiVdhBCLZEL0gMe+fcLfe/qy7QU
	llnVS6V+ELlMLp/kY5zUhsVjBj4Zsles=
X-Received: by 2002:a05:600d:600b:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb88815f1fmr209227025e9.21.1795396866520; Sun, 22 Nov 2026
 17:21:06 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-6-eb71ec3ee523@iscas.ac.cn>
 <c8OwiyQSR8ivEFULfFWNow@gmail.com>
In-Reply-To: <c8OwiyQSR8ivEFULfFWNow@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 23 Nov 2026 09:20:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRiDrhOTJ77nnHm_v3k52iz2JPk15zZVE0SS_w1KJAVeg@mail.gmail.com>
X-Gm-Features: Aa3M54ouhks5E3p4QI9taB6w48IYX-BM80EMc8-2bbL7hF7KLogcDmZQZpD8tBk
Message-ID: <CAJF2gTRiDrhOTJ77nnHm_v3k52iz2JPk15zZVE0SS_w1KJAVeg@mail.gmail.com>
Subject: Re: [PATCH 06/19] clk: sunxi-ng: add support for the Allwinner V861 CCU
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Han Gao <gaohan@iscas.ac.cn>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
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

Some references for v861:

https://www.cnx-software.com/2026/01/04/allwinner-v861-dual-core-64-bit-ris=
c-v-ai-camera-sip-features-128mb-ddr3l-4k-h-265-h-264-video-encoder/

https://www.allwinnertech.com/index.php?c=3Dproduct&a=3Dindex&id=3D148

https://docs.allwinnertech.com/docs/soc/v861-tina-linux/en/

Hope these help you.

On Sun, Nov 15, 2026 at 3:31=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne petek, 13. november 2026 ob 23:33:32 Srednjeevropski standardni =C4=
=8Das je Han Gao via B4 Relay napisal(a):
> > From: Han Gao <gaohan@iscas.ac.cn>
> >
> > Add the main CCU driver for the V861, based on the A523 one. The CPU
> > PLL, the CPU subsystem clocks and the E907 clocks are left to the
> > firmware.
> >
> > Unlike on the A523, the second divider of the 27 MHz output is a power
> > of two. pll-audio-4x does not pass rate changes up, as its parent also
> > feeds the UART clock mux.
> >
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>
> Do you have any user manual for it? Or at least BSP code? It's hard to
> review patches without any of those references.
>
> Best regards,
> Jernej
>
>


--=20
Best Regards
 Guo Ren
