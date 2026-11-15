Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757401;
	b=zG/jGeG66qLX56ywSnoQ3CXpaTW7oa08AZwtccjU+P2S/l8Qw+BJnpyuL+Out/hBuv4H
	 TkT2xxTzdAVNTDOGr8T9ALpsPTSHCAJffyjwJeqEAEpdgFM1rAryeR6ahk6B7UgHXqA+l
	 sfg/9QnSjmSdQ8JJWO/CvGgDm9hXwKX0NVClvwdjbWFQ2++5dZnYeWENXsZlTK6zyjMI5
	 apCuzObjPdGoHEtom9B5WdAty8/SZKW4YUvmLCl1s3pfH766BSesq+uDFztTvv9Y3c2RI
	 ZiMk7Q7RuCaIUxD+KiVQQJP0fDjy6o0AHAq/DXi+dscyeyGaqvNfO8204RyFsoTy5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hziuiiMUYFT/Qu2Fwgb6Sb0cIY/xqbSxPRQl/HG5KA0=;
	b=qrnG8WsVMeEMofbJI/zDTxiYKT27HJOnlvPzazZ2bi7y3yTGH0I1Yzv3vEv4i49SNSc7
	 IW3RLK1JTAWU7kYcpKyjXCyD84TnZ3cDwtr0KygjKEopK+r0ocDdE73HkHJ81b/N18LGq
	 3zjdDSMs9ng2DKP/fbDeNNVv8R3pbJlV/JZ+j8FU0wnYE0qWmvwrWV2o19eF7KWclclce
	 +aSLLkxk/OEP2NZy69NHTXGHTVQqRBWY16jagM92SjIQ81kq25l7fC3bxDtg6qP9gQopp
	 3fThXlQ80xa+Y2Hl8dw4cnM/EyMbKciiR8UHSRVfkXw0zB81XwReqTmxop2uo91XUEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HBYr2ghe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47C606A886
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 15:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F47C606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HBYr2ghe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so11973265e9.1
        for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794757399; x=1795362199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hziuiiMUYFT/Qu2Fwgb6Sb0cIY/xqbSxPRQl/HG5KA0=;
        b=HBYr2gheQUl7c26Y3yfqksOaTOYrIFYUyEUzlZUZhWSZy+HAESqRcXZrP+TZZhM8z9
         75y4g55klpFlA/Qulr9Yg7kYDWq1+w93Piu62izk5f8edZNdPTqmw53yQIcVZJ8POpjR
         FCFDGpFCG+XXUQSOtyP6WZHieYuBpqKKanKZ3wnDH3I4OGAaLXxf7XH2XvGb65akJdzr
         QUEsYnB0UF1WTP5FCzRnWQED5TK5P0HAm0HJ7Hpeq/wgtIM84HN+PLhoAeYrZah9RjSs
         zqZK2w+ADZMGUpKyIfEL5w7Zfqyz1Z40uP2rSoJOgyF58OsUuKjbbaFJV/9eOLQrvgqB
         Q1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757399; x=1795362199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hziuiiMUYFT/Qu2Fwgb6Sb0cIY/xqbSxPRQl/HG5KA0=;
        b=VCJhKJCD1Nk+QPAYpEYCt3CH7DkfmTwsNXAdGdLmhWzarldkKMRVF3qbr03k19e3F1
         T7JDnUps7+APNkyS5m/UKgD1BHzIYz6zaNhjW+mlt7G8BscjP/TL5feSmRc/4hR4vhRW
         23NmBtT3jOcGNxxBzTEQE+IVV6PaNWg5wHsUV1kzU3cYTS1UWM73zXMTT4VGpzAISjmF
         l6bf1kTsV8Kpb1APIbYPgglHYkWoteVTwrUTbuzZmkJeS09nbx36lUkTvESoFvHXWtyT
         24nFa674Wlifozyr6GAY1TmprqZbDvImPcBaMGTIwz+Re9GHCPkjocUnrKA5y6X84gBd
         y3QQ==
X-Forwarded-Encrypted: i=1; AL+hErFnfvbzywAfX5Syo0Z1Me3m56qR/5cxz+IvTC2wBX/5x9cF17faCSefu1wfeQIbvM8S6Szk8h9EHtI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s5JVW8hmZl+/SDw3g1X6iGQK0In4c9W7ghto1F+820o5aJbgn
	PwEczyKafaexUnCvwSw0/SMqXrFhHLfHUGp35KWRquZvvcBMw/Q3GnPMSMsfELzordQ=
X-Gm-Gg: AYBFou02GvG+PzNMUTG1ld4j1L/F1scAiPOXuGCG9BIohX2Qd1111dIb4wflACyVPwa
	JZLMohHcsQLU8IGoyUpL8c8lDnP803O8354hI7OxaqpdyorZZYPaYPiTuvZv8yKPeYlLA/++/TE
	/1uVQqsRTVftgZT6F/KWaGACJg4pN4gW08+1mfyhzqw/nDb0Zb44I5jiA31vHDdCEWW7xJ0VEbe
	b3yq0WkvtmaYMMzak4JV+L9dJ43Xebvv91way8y755DSaZef8QXCljIxmpkFuiOvZMgxDHS0vC0
	P5qcUj5lX1etNJot5Gj44kMYmDfCzxJEF16fsIzlXLiDzby9H7HTSCvK4vK6W4cWjZ1U3huNDTP
	my2LgmhYT7T3zZcsdqT4DTBkshByOS1cgA44Dgoc6VH5PlfFP5WRLtr9y+Cx8PNxKD4voDWHj0f
	V8y3A+kAb8VXQIoSWsG94olwVsA4c1Ngi4nx7BVhVBgNlNzv/C2XJ9KHj1/oGHnZUu67/JIeqAa
	0zL3bsChMnhm34sfr7OnbAH0s5VDP4Svc2t53a3Kfvn0B8OggkMa7czrG3I/ETKS+dHEczZDW4v
	7uiB2AnZysEf+RQYp+CuRXcENcsAG+ux+NTXv8OKwplTDi37Y0xl9dHu
X-Received: by 2002:a05:600c:608c:b0:4bb:680f:9a3 with SMTP id 5b1f17b1804b1-4bb680f0a64mr77590835e9.2.1794757398894;
        Sun, 15 Nov 2026 07:43:18 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb68c00b10sm52646085e9.0.2026.11.15.07.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:43:17 -0800 (PST)
Date: Sun, 15 Nov 2026 16:43:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
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
	Linus Walleij <linusw@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 15/19] pinctrl: sunxi: add support for the Allwinner V861
 R-PIO
Message-ID: <avnSl53KHJWGrBcE@monoceros>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-15-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nd4yu7xpyaelhc7q"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-15-eb71ec3ee523@iscas.ac.cn>


--nd4yu7xpyaelhc7q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 15/19] pinctrl: sunxi: add support for the Allwinner V861
 R-PIO
MIME-Version: 1.0

Same feedback as for patch #14: Don't include <linux/mod_devicetable.h>
and please fix the spacing in the of_device_id array.

Best regards
Uwe

--nd4yu7xpyaelhc7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr50xEACgkQj4D7WH0S
/k7FQQf9GMWHvRPfVzE3vnOHAT8nN1+INki1D4kL4uwlHr3JU4yutcwFkaHKLsQU
b4DbnyStL4d7i466zTUN7GaSuTfs5LByLE0hKNibeGI5Wa+bHdhPXZw6poTITVON
f2BwjcuK+Zq5YQKqimrjo/4tbchvvRaJ2tX4FrpWxIYNSEVPVDu3Ku1FTeQTjQiW
q3iSJsE9FH4VZAUg2tViVg4jIzTIj6ncm2+HvaOFr/vv8gwncEBYp0IlMVPyqH3A
a+UAaIoEVNFvPPDDjTGrnHlPAjkkKoP4p3OAxBnC1l6qyEx0qCChV2gqtkPof0ba
XuoM97TKUIIJOGjYertizBLa8GJ32A==
=5u67
-----END PGP SIGNATURE-----

--nd4yu7xpyaelhc7q--
