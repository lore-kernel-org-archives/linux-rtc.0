Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84024A8420
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719849; cv=none; b=sI8xpdgxj9tycDDgQzeNHc7gmp+5tpyaOAUAOGxRE1iKAA5dvO0u97+1hmRyOr/OXLcS7q6tSDgG7/qwyBHjcOqOvsfsd0wfrjv7w73M9xDThqwQ9pV34cyFszMCbwpdgT9PJ9PW1NVndAgVFj84fzvzA/dn8BP5a/562J6/FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719849; c=relaxed/simple;
	bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0TbBVNStekREDm5TwIXFbT6BczN6rBUuVTDwja7/gRi+44Yo+nHe+2fAL4GkXcrYlDmblVX38qaPcWBKWHKpm+RoNss3eBJYogeT2Ab2iU+Obhy4o2erJGODYLS+T3JUJxUqlXFB4RmoIu5FnhE/yaU94m9Fme4GJrJvSISl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5dN5UKT; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5dN5UKT"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so77554966b.0
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789719846; x=1790324646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
        b=r5dN5UKT5wfIItQgqltovZCKdP6Usucx4w7xOge6GyKE1gyKIanLqslLmo+QYJGN5X
         3toO7A6j1iBDwk1wOzoaucVHVP2c4OH6bSqnZ5RQwySz89ev0tu8c5kzrcKtt/6jL0C5
         yp+AyhidBLMOJE/V8rTQ3DI+pZPXUizTfHiLmFBI4vC1V6V/WFh9jSIFWuPbMPo+5e45
         1FtScQH+giAYlCVU8PRqHBwNNEQotbaNdPab0hoD6r+jlHJB/iz7baVIfGSiVi5qMIb3
         FazHilzpnzSXPDlV3sDUoSBzhl27hLC8feqNgyc0Jf0zLiQX5X7KcLYAVhyy7HMT18D/
         Dl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719846; x=1790324646;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
        b=jQCyQciGQMGOLCiqAxNJ1vu49rJHmd1KdsS3K3b5grmfI2vLPhqpH80/oysUsKGRPC
         RzjZEoWcyEU5fa4iERBSapGMTlnR5YJC73vTzCMb/xeJ2feIlyTN5/VsMHZ4usydnTF2
         BmWrsTsqSv1U9107qPhxH3o+X+ApzKJJe7i97WigsV0eBfymmo5Vd4/k/xAFTAcA0Q/5
         GoF/SkE4KfyAPCHVTprXq4IJLb93WnaP78pm+C6URwwuwRqQgGz4r5jGxAKDbc3BlZ3k
         6u2ZWq6929XvH7cSry2sGcnALepElTwUH31RH84pTrIqoPkjf4ql2ES+ZOOCa+QoG+aq
         iQfw==
X-Forwarded-Encrypted: i=1; AKwUvBxl2xXuyTy2XX7mmTqzCAS7sEVkQh/aRMmtpy3OBRKA6toahMZBfIMD3cBtl2nHryE536IvZYLQKns=@vger.kernel.org
X-Gm-Message-State: AFuF++lK2fqx19os1dZzYICJaRMdaodeZCyaiTYlJPjSJ2bpdnyJNmyg
	heqGRlk33AUzr18moKvpdsSGLLNhDBnJySMHGXOx6wO2DBat0Yvs8x0scI2w98N44AY=
X-Gm-Gg: AYBFou3I+T6UGJDFAlD6Qx4R4VvWk7J4UUPXocWHWxqEAyjK/+erEA80fgvPY3u0kgH
	VrEvfRbWYI+WfRjfyzTgO9jAZD0Keckju1S0a7og1/UfP19nj+EfuAX2y1lp/0zVHIdB94dAEk0
	McrajJ0ClbtBwSq/d+jslVZe7GipJgS6c5BleYM6+t4ci/ZMZ8Yithjj9dvenXGv8mRiHUXuzWM
	kRJS9UR/CtoroCZiovVnW11eWXEaWFuzcQQ+gMTMs3X//g0rOUwi2bkT5a6MsnvRWGmhQCXfqNP
	sZp7F5drhb+E86FDWTK0uidMeZcaywHLhLbkdcLtRxqVaes71BPPXen9zI/2pdYxhZoM1WdVmUl
	+ChtdiYQQLO1Te5JxjNiD8lBv+Vf6q6+d7M2OmTco7SOVjMm1eK7AYz9aINaFXg+v87KqaV1p41
	DQ83hk5xy0TCX/3EIez537uUFMXo/c6R30YvAQ0P2xZ7fDlDK+k4f7MnSE8bjOeEwYXPXENl1as
	8Y=
X-Received: by 2002:a17:907:72c7:b0:c26:3190:296b with SMTP id a640c23a62f3a-c2a15e7df89mr192409366b.48.1789719845848;
        Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6aafsm33384266b.51.2026.09.18.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Message-ID: <b567cb05cf1508be7474e2874d267d8e8a09e49c.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>, Miquel
 Raynal	 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman	 <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller"	 <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Bjorn Helgaas	 <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ray Jui	
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,  Vinod Koul
 <vkoul@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, Jonathan
 Hunter	 <jonathanh@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown	 <broonie@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Ray Jui <ray.jui@broadcom.com>, Scott
 Branden <scott.branden@broadcom.com>, Atish Patra <atishp@rivosinc.com>,
 Shawn Guo	 <shawn.guo@linaro.org>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding	 <thierry.reding@gmail.com>, Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>, Okan Sahin <Okan.Sahin@analog.com>,
 devicetree@vger.kernel.org, Paul Walmsley	 <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley	 <conor@kernel.org>,
 linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>, 
	patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>, Chunfeng Yun
	 <chunfeng.yun@mediatek.com>, Eugen Hristev <ehristev@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux@analog.com, linux-input@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Date: Fri, 18 Sep 2026 09:25:27 +0100
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-17 at 17:40 +0300, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>=20
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
> ---

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
