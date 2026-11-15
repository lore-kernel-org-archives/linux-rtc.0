Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727877;
	b=qpmQJgnY3DM8IxBvAKysNhd9alFvHTVqYdCkNxvSV8bl3B1Z1/bjjUE0zx1L3uzDkd6M
	 YClxu/t3REemZkMg9LrM0JywlJDrO3Ba2SculMBvbAE1Z04SxJVIb3PD0TlSMaQ5v64lG
	 e0O4ObnxfeN3l/nExux/ZaNQhwn9pk8U6WuICacTFtIiQbgjbxv646janmDZqFkZ50s8o
	 fGyFuuuH1cmyFV9tFge15HxNCFBIo2HC4VhY1jkDXBbNDfzMPQMQQ2it0OaDlFstU/FK1
	 ZTAc2d9xG1Yr5W58tzQl7R0inYPyjNYXUF8fV79JBect3dusyU2NyHKUaKwZyNThQyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=qI3xoqr08MTqFKH89OHdawFy9+IYpxgrM6eMy9hh1r0=;
	b=okaRAdV/LrVscf/bUfyBHGUNdmIhXv58jHkXCsVsdl9pJ7cFvkKHHmXmZjT5tO1MRR48
	 /Zfie0G3xzo3HJojs+4GI3Ds57lwyX0yXM5ZtolNFjuCO7vdEZ8BEp+BrRETzdKwyQET7
	 jajwjJfm2eEEEEAn89JeMvPwa8t5dJNeMQSuRXhPSYIFPBcW1DSYpyaIUb7L0SN4nWL+b
	 bWEmHBzmMJU2G6KaqlYeV+150221hLADeLDE0IEhsyu81KNqz1G93EJQ90luKzwICP6mW
	 NhuK2gtYcuPrXrp5relf7oTHfY4MZ1ms0X7LoqQn8CY1mL8ylRb2xtsbtHCIUA2JLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfHX33b9;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C551606A327
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 07:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C551606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfHX33b9
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491971ac844so2232581f8f.2
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 23:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727875; x=1795332675; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qI3xoqr08MTqFKH89OHdawFy9+IYpxgrM6eMy9hh1r0=;
        b=sfHX33b9HzNVq08BaSf4y0sViK/MK0chzVBJ0Q+gvrAe9T8wXjtDwJMVvfNxxjvT9l
         SEWTWE0sZtcsNwKWEFyXzvLZNe89AQsVdApUgEXQBL0TJsoj+jbScFkEv+3jRZ1lB8vf
         d/rISxDPp+F/K0bJHknHkk8CXnGYEM/127Yv2NeUvCKPhYO+eTU9rpQmEU6Dd62/EQvB
         fz0HUNzeHXC6U3b4kz52ODEk3D6rWUXeADFYBeeqPtDrSrS3EHKV1D44l3N4ZEbUKSDw
         GOdF9hL5WuF6stzHu5B4BcrufdthWBPcUDcNVZnPgxjB1MxYoePPvR2o1eoXKeb9bMzV
         K9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727875; x=1795332675;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qI3xoqr08MTqFKH89OHdawFy9+IYpxgrM6eMy9hh1r0=;
        b=ScEeEW5VhUSyUebkx1kIvrAl7E1d57f0PH0R8+z2FGHWgbL+1GNlbdxUaUgnTKhvZD
         jxV3EgbkKHPexiTRUjfrq0ULj/cV6QipgyQPkdtC5DgL2XJyf8O19pv38buIfZjToFDx
         ZOT12rnEXmojMPmC5naVXBzi2az33Xh4hDU/+WDMRyuXwsmaRPyjG1E3P/GjX3GFbEeZ
         XQRjgSk+yCzjRNIc6rZgfd454Ir660/SdQogqBdB50bxbNhxEaWhLGL7RbsCU2bIlIU7
         ACVLsAr0CHHUcMdzl+PfpSMlVh+4OBXRWBSvtQ8CV+OLixxXGP6BR/9/qv1e9wHutfV9
         hOqA==
X-Forwarded-Encrypted: i=1; AL+hErHId91KOIJbSTCO5bl2GPDYNgzEZYXJrs/myB/L2pFSp9C+9ABN2hCFArUcPyWkMKt07b44dl9AO2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JEQvPlYM7UUPo7IW1swuQ83rA/XIGxkKcqcNeLqKw0TmaS0Wa
	Eo/mjLm9SzOUvih0bIhod+TFR4+6bL+m3Fa01WEOXowOPaP0EyngSNzO
X-Gm-Gg: AYBFou1a8AupgBMVbnXQvDtdI9WGgg5Y5n8V5DB3nYFWEJGYJ8tSesa0NLbKzt1dxgq
	OtB0SQmr8tgHUDtiTG//C9jkA1mcmsgIDfnXQN//w/F2z4CArbCin4iS25ecABl2Aq4xiqJzcvw
	LbX1B4p8p30JVJ7gJPnXn/gz/52/zRgLOfT0WNLHkaEM6g+vBSAyje7upP5dbaTkzKsBBL+zSdz
	CeZJFH6S84TK7P0IPThGyVuSuq4BqDYXuGQGpE+AcXBUjSHY/2LU2D5jXBXjImgzyOVy3UZK3j/
	ZZSH6Khivp5GeVSWcXilBmWjJvII+CB+7YczxArbT7YT22qJjPJh9h+bC6cP7DxhYNnTENlZGXn
	7aBARDJiyJVHJ6g+5oM8W/1fY+iGpdlELq7mGDOBUMDMEg+oRL0eJAisSSN/lyNhKOQ1a2pdOi1
	MbDcLfm6nhUML+ZNtQbMX6k1wpzyJ5fYzIVEdZwT43HGqwspA36tNBr93dhOgq1i1fayNSnpwOB
	ZE8d9EoHnqDUSX8W/mhper7R3wLEk/Wptvoz0NL8DfMMInsmr/e7gndJJXWU6YT3OCpXXDB3T+f
	q42KaP6GL9PcTdTWZAyqng/mk3SasU+U/oLwef7tOIwtXDvMU68CAtmzFnyTnuVuo+Tp+zdT+At
	V0saE34swJxGRkO+Ka5B07ocO3BpQAWajiNLZGyevLXUy7zeEQphLTLyFwYEzTs3RDgC8FXYeFv
	gyEV+FA0n8tHAfKSWBonyf9A5CGSLUz+EZRXXdSJx4f4xRbYXuzYtru1GD9atz0GHLp8Pp45SfU
	aIV+MN8B0AwyIfRsyOhdUD8xw==
X-Received: by 2002:a05:6000:25ec:b0:493:803e:800f with SMTP id ffacd0b85a97d-49c725e5749mr15660384f8f.29.1794727874441;
        Sat, 14 Nov 2026 23:31:14 -0800 (PST)
Received: from jernej-laptop.localnet ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0e31sm12992274f8f.19.2026.11.14.23.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:31:13 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Anup Patel <anup@brainfault.org>,
 Han Gao <gaohan@iscas.ac.cn>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, gaohan@iscas.ac.cn
Cc: Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject:
 Re: [PATCH 06/19] clk: sunxi-ng: add support for the Allwinner V861 CCU
Date: Sun, 15 Nov 2026 08:31:11 +0100
Message-ID: <c8OwiyQSR8ivEFULfFWNow@gmail.com>
In-Reply-To: <20261114-v861-v1-6-eb71ec3ee523@iscas.ac.cn>
References:
 <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-6-eb71ec3ee523@iscas.ac.cn>
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

Dne petek, 13. november 2026 ob 23:33:32 Srednjeevropski standardni =C4=8Da=
s je Han Gao via B4 Relay napisal(a):
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the main CCU driver for the V861, based on the A523 one. The CPU
> PLL, the CPU subsystem clocks and the E907 clocks are left to the
> firmware.
>=20
> Unlike on the A523, the second divider of the 27 MHz output is a power
> of two. pll-audio-4x does not pass rate changes up, as its parent also
> feeds the UART clock mux.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Do you have any user manual for it? Or at least BSP code? It's hard to
review patches without any of those references.

Best regards,
Jernej


