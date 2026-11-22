Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368148;
	b=Pa+zd5afsVEaCeiAZC6P99BVfm0rvdE1MBJYh6wNsgz5kVxFg1lyCzJSivsTnuahEglX
	 5qketAWMmCmvhZmg+mwR/w6aVHqLWpCh1w6n2SoiLU/3sxpPGbzWgjxlSAme6zD+dC6+W
	 O9GVVoSBxVwQ9gvrCDX+9ogs8qLBe6amk5NFs97FjhwgQ6PlLhlwDbFiZ8jsgLrxqLT60
	 PjmXahAIJiDaMgEp2C13wsBTJkf2wujO8POPBAVBBO4fJxURoMI4TwN326tDIeL7SgCkQ
	 59ke4CoN/52WNBCAR07RW0qsKf+K8yHHfE8RnKM/qz2rKPfpYRnHLwp6q+FEnezuVfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bsJvZUqn+Bb7/gG6ywuV/4DLp7NmQEDZvD3R+5g2Jts=;
	b=hY9Vp/Jqe5VvzfknvnKJs+6B9scsfFENLzpo2/kRasl2iGIDN6SeG5DwExMz8xTugTzZ
	 MUWfqYo4zOJ3Itve9sqxYD4o2BDlM9RsvCcqFVXNPxBsGAi3u4xwwTtSjXMQp06MRZSfc
	 zr6hpYJ4NxoKLWk7/T2D5gzuAFzOSCiHiAcEIWTIqRvRyBnxN1n+htzbc8lVD/HYZPW2x
	 8SWrAG7CbuUPMLtZSejY/o6jUg+QPquMcTMsI8Z9HnppGiS8MfJYjLaEx9ETV9NK6Qfv/
	 HTe4AbkYY32nxQaJDxGS7knbIASv+JPMid0fvq/S0az7lfp/cUlfzdBRz69kEUWms2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBAzZYcv;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F4606A33D
	for <linux-rtc@vger.kernel.org>; Sun, 22 Nov 2026 17:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79F4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBAzZYcv
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1527266a91.3
        for <linux-rtc@vger.kernel.org>; Sun, 22 Nov 2026 09:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368147; x=1795972947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsJvZUqn+Bb7/gG6ywuV/4DLp7NmQEDZvD3R+5g2Jts=;
        b=XBAzZYcvI0UAjxnxRcreZ2xa57tWzsBIk+xJyJfakPnjZQLRqB7gnVTc6Qn5CdjUbO
         xXTqI9r+rGRXSGvF5d9u/Gnt8cBL/N5/xf6tBndcQ9TnX3hHeuD9tSzX8sNkkbj7vhA2
         NeZPxacRSsaOBC0O3QO9DSW6vT50WIL7fgQmtZa0YNtC+iyBs2ZZbCtUEdbBWGXZZsl3
         XzMwvQ4v9H33vCd27VDcugFyzLDIPGo4nIjz28dfG3CtbzZTvpHODKvnyuNs3l4NIsgV
         rmrwLL0KqwTgCr+ubLcXoPp9NBBDnxFxRbDWkoQYlII4OMLRVrvsRiSieYn+T9Gsvdjr
         irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368147; x=1795972947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsJvZUqn+Bb7/gG6ywuV/4DLp7NmQEDZvD3R+5g2Jts=;
        b=K1jbfiRZhdvv0Vb9NpfheC2xyl9R+64rSjtKZ42ggIGufm+HBmLXYYeVt7eLiOJF8G
         ikJ8L8v8OUVT6hgbJX3HH6P9WDG9UfWiMCXiHsKw4CBOlFyGU2pqPLQEhBtdkfgDmSHT
         YrUJctK7HFFBW3xJTUoMIbrtzY4XAXmi0g2eKwCDijp3V2tqsmA4FvQg6rRxU3cxMLs6
         Ja41kGPedikaaNLM0wroQGgr+QNdBR2SMVrsKjcdmIUnBhNLCHzi2jyBD+8KdajDEMrB
         vG5yu8NyySX56jjBs5jdaNjVKECdUvunnpslyLMnj/JKKGqyW5wScAOH4KUycORfilSw
         7l5Q==
X-Forwarded-Encrypted: i=1; AL+hErEcy/CJht6BBg7BqQbLe/O2csHyf7hfO/gGEirB3Kb3WGKgv710tLY0qZfzSRZ5I/nMWfoQMuIo8KI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nOzBdCyQHjxqjONpxS9RaBd4kIL/WX3h0z8OoaRyzhCKYmYE9
	uq9O+/rcmKR5CP3l6R2Sb9Ec+c4OyOReEldeKzXZAuRxlm8erd2cqmXc
X-Gm-Gg: AZFdTZcajKKXmhyLsZGez5KcpIBNqyORihhCv2oOW74rZZ5kV//vIjqvHGa/88VLYGH
	az5P7KDUXuoewM7FCKIMVEbKFITsC2cSwdGXAU4yR0Q+WNCUpfpaDG/4KFt/cxxJ0RPwsrycAIY
	FJ/gyVdCIgIToensiYDmQJds6G48qZnkUtasKvjV27v7JNDV4ZSt4E/NlvlDVZL/Rtj58ShDvXT
	K6Tvvq3PACegwGXEMuxdJSwxEd8PTpsTcTPGbuGkQOrDI1WyZj5wTvQPfW1nnjOr3jx1mJoUXCn
	vGIpa2ozIiy0ON2uo/ODjcAgyCyewrL/UQp/D9edyr8f6HLFQ410Bd4nQbCll+dZD4Eixs792fW
	cphvRqiz5c2VFcbsSOXA1qKEuNopd5PMmR/W7slCGzos+pVvPO2/jUdq+3bdw7zQjRf/oWU7coV
	gR3xiEwtb27Pp6R9+0ViECPFnv2ngdKPr/1TqEIGtQr50bDOXMeoaejDvHxelHwO6ymNdGVd+zw
	iW76NcHag5JPge9HHDGTQXBg2OnEVg5NKGBju3ZeuItZu1++jDKCPcJcdiHVZ2SEDC8LjNr3QlK
	N9xt1gQOx7f0+8WyW4zYGTFFQSUar6yPHeSwt2C7a655ne8rOVDaXchxSCUAHcNMl2DkK7Fuyr3
	D3Og=
X-Received: by 2002:a17:90b:3d4d:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b41c905a3dmr8081661a91.27.1795368147033;
        Sun, 22 Nov 2026 09:22:27 -0800 (PST)
Received: from localhost ([2.27.148.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm13471136a91.4.2026.11.22.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:22:26 -0800 (PST)
From: Han Gao <rabenda.cn@gmail.com>
To: =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/19] clk: sunxi-ng: add support for the Allwinner V861 CCU
Date: Mon, 23 Nov 2026 01:22:15 +0800
Message-ID: <20261122172221.3552455-1-rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c8OwiyQSR8ivEFULfFWNow@gmail.com>
References: 
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 15 Nov 2026 08:31:11 +0100 Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

> Dne petek, 13. november 2026 ob 23:33:32 Srednjeevropski standardni čas je Han Gao via B4 Relay napisal(a):
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

https://github.com/RevySR/linux/commit/bb06380bc2e5a02049cd01e0b10cb3c3c694b750

BSP code

> 
> Best regards,
> Jernej
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

Sent using hkml (https://github.com/sjp38/hackermail)
