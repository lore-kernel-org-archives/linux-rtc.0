Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795652958;
	b=Gr4fg/WcgivQTMh5f6v9+BDzqp337Q+g3GHHxrUhQS6ZizYO6q7+EVZ6OiJASEZ641Hn
	 FdnlXu7X+l/u+ky9kEPcuU7aXwGHCRDovXWbn/zFydHc1eIX+RrAvjb4nogEPYBw2fYBl
	 mTSSQTLdCjwXyxC6MJMwjJ5B43AKW+X+vC3xnxAi2B1JSWMx1cJDYlatKftJ5tiKSB5pl
	 J/2uFecwImHkoSdEdNFe6hg9Et/iAhEmHjoyTeaD/2nbCX9jB75Xl6OI0g5/Bejt5XYhI
	 +kszGt/Ed2iAsjBuAT2IZkOOr6ObHeP+GtLS4p68c64asOpcQGg4OnF7BNshHBOGgDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ica91CLq/2YhNsGz5gWhVwzBtrOD+YGQQy5zyrqi82Y=;
	b=1Fr6Tnv8AVUt2o72Z4GaoVGdL8gV7en5tfsnIEC5tXhfhESIYKNC6P5qaVdjmYFOQDOW
	 ifQM+3B3I2WgoHVOGA6gvHMfedbb7naQVZlaq2RHNiqFAklZLxEs86tLP/WeaLLZotA3c
	 Es7dxgecbeRFMPz6EXLxeN1rLWIZheX0ILJAOP1bkVkRfz31e6DBUUZiJ9v4aU0fxmcmV
	 6GzXEuzGi5rmrzr4u2w9IFc7bQnOH3YeB7QZCF4EHnj6+Pb3VB8Gu8hFca+CCG/2guvuL
	 qznf4WM5QUDKIioukpH2C2dIqJXMTxNeUkojivzUsvNFn7mcJKbOKgdGWHc9dmE+mNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ub5+Ywzd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DC606A321
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 00:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ub5+Ywzd
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae58d17cd9so7078699c88.1
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 16:29:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795652957; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke7o+sjOB6CE8tXus6KImHI+9m4Wea2CodE72itowu+foZCmQu8VVh7iDUeKQLyaPa
         5DU15CCSItv6XUW0StSraQ6aqW4Eiz0VekiE3pVcclYvUTnBJLRBLsP1w0ZsECSvgXZ5
         BG0SfK23XzyOys5aUSrKmaUZFOztMonsNQUM2dJ3nbzcyMQ9u1lVL+hpsES2oq/LvxSu
         QETw8K2zAW2dEQlMjkDF58A7ftDQWso+uuZjf9AhwsHxg9Di2WUEVM0OwlE1VelXVt5u
         UJOtdJ11uD1m1gSyRTHX3oCkkmGL/wO9YRw/uAYV1y+m4vD9zvgF4U12w6PiPY0y+i4F
         gemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ica91CLq/2YhNsGz5gWhVwzBtrOD+YGQQy5zyrqi82Y=;
        fh=+lLEYqApO9kbaJPvjDqMiAGYZVO+t6v+Zp08TYsDLcQ=;
        b=n0dkbgjbVv6zx7tGGFePqFCqEua2gZnmKB2nmEe80OPmu/u8yJu6lc959z+zzyqii2
         mBHUTqbKcSdWx2XsT6sVh5oD86U29Mqo1eD1CE36V4ckEKpgBsuAv7t3RFhwc2ammQtV
         e7JjcaexrHxfmKsgRxg/0KpMovx14Je3caFw8mNvRZCgucS8yGOrREESgd92H6rFpHmU
         Y/tuBbAaG14GOB1rRH2KFAsGOHSJCnASTM69bLhTmPj1iNkNAqPPXUX8M1fPwL7lNs2j
         R0Tx4XdkVgOg2BiERDQvuAMlNcN6hpOoPWRM+VQ6wrpYhO68CgfMsu3rIJccJoEJ3IAV
         VRzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652957; x=1796257757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ica91CLq/2YhNsGz5gWhVwzBtrOD+YGQQy5zyrqi82Y=;
        b=Ub5+YwzdiuUN8y2thMXw/sAFQdoXSSYjGpdKeJT6yudZpa6OQPF5A5pOG0YOuQyTOz
         UO5l1qOYE48beCTfkdndGsGv9b56Pq0zCGsYdGmNnEH0NrLN11jXldzWodGidVN/lVIM
         vlJ4cIhsgtYNu050gcL5H1l54B0bPnt1ZNLQUdFrTpOGhNMcoQIsq/kKPMVs1pzJViCK
         4zlrbc/Gz0v+dzhyTavQHdklHOnI5M5AVrOuaNiO3G9zb/bMAtv/E28wXsMpd7p6VVPt
         nNn9jXivYJXPzS3bYIt3xhQurVGJZSF2tDjaodfFawCgpCYxRAXebA1U+SXVJly/SooP
         YPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652957; x=1796257757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ica91CLq/2YhNsGz5gWhVwzBtrOD+YGQQy5zyrqi82Y=;
        b=ngbo+kBUClYYmDBisfxZ2TSGM6FcHMquDZ9h7Txf0pu2zbaqYDuk+45zkJ+FGr6SRD
         gQwznmQM3/1jWj8BqBhuMRQVGfOHdjZ3/Amc2qJTZoOBiqdkv4b9RfJUXSks1jDG/YXj
         2GZschWeqYr33jBiIXNlKmChKSNhHEEfIbuEqqAS/viV6OAcPblm76kxNTjOScoVCdPO
         0n/cbsYTyQTNJA2djPNNF0t4ZiNPQm0XXd5hMEC4Q/B46haUm49L0xJA/yUNnmsGtS5a
         MiY6t0Wo7EfoF9SIm1tjHcgkz3rY/Wi7wqWeA6zE2+pIxlfWmENwEqgC0YLtCtEZ2mNM
         bcJA==
X-Forwarded-Encrypted: i=1; AL+hErGO5QxztVaN71WhMqr+pOSoWI+UMwuoNHpL4t0FOFJkRUau7kMh9EgP+wK3jS8js28W6hUpzjiPQa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kzo7NhiYI4ADZwGfbADeF7s1jmlaxbgIZDCLxQn0ALfXqzYp8
	HQuT8/R0XVmESkAt52sI8kUHDTslw9GyoFbKOdHO3yxh0p8IIXzw8+ReZzRCBGRn4y+PDjFRYNF
	Empwhnk8WeXYIlRqu8sj/jGHi6g6jtx8=
X-Gm-Gg: AZFdTZeqr6q8B4z8E0AIZ3ZIQlSFghtNL2GKnaDUzLUuCItB1ibQ9A0PFbAw9lcK/gq
	k7JE8TGcAf1ACPL2B/SoNY061zltRQUeJme4Iud69HmeADls8bwJ+4dH2WNE9rGRJGJkzpkg9VO
	qf5fGXISs7YHIYH1wK/WDxcjiuohEHjMdU0OLviq61BA1+3UGyDbnDhh3b8JXALahR4r40KX2Ep
	KwvRA+RpWxZ9aJ/1L+tC14Ch9nLZ7W49Os35IWLChTQGDcGZQJTCA0JHwOXQi9/eDoPhUiCCOby
	p91fxE1AWNoU7sJQTef/TaFkVGkmNziKd1SJzfVDxHAqkr8gNL4E6YBRplCTisDCRzoxo5FKeTe
	WCn0xYwiLrKfGvoNaTlyfAj8mZ2Cmora8HIPuzk0=
X-Received: by 2002:a05:7301:dd8b:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-38571510675mr21743896eec.33.1795652956755; Wed, 25 Nov 2026
 16:29:16 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-5-prasanth.r@lineo.co.jp> <awdYin-gfFlMzm5K@SMW015318>
In-Reply-To: <awdYin-gfFlMzm5K@SMW015318>
From: Prasanth Ramesh <ragaprasanth@gmail.com>
Date: Thu, 26 Nov 2026 09:28:39 +0900
X-Gm-Features: Aa3M54ppWwPKU2GXBN__reMNMjMzYNk4yHpP-osEJU5EF1y5sgVMcffyz3AkPvI
Message-ID: <CAG7eodGWsRtuQWgN5=7c7b9E7JKhLXAhZxRGgbDW9JpkSzhX2w@mail.gmail.com>
Subject: Re: [PATCH 04/12] rtc: mxc_v2: clear the wake IRQ on unbind
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Support Opensource <support.opensource@diasemi.com>, Paul Cercueil <paul@crapouillou.net>, 
	CL Wang <cl634@andestech.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	Prasanth R <prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

> Needn't it at commit message, you can move it after --- to tell maintainer
> you use AI help.

Sure, I will move it in v2.

> all devm_*() API need check return value.

Will be fixed in v2.

Thanks,
Prasanth
