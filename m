Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921A38333F
	for <linux-rtc@vger.kernel.org>; Fri,  4 Sep 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510250; cv=none; b=rv3S5k/9U81Ms9Lhhiq++DavrKXrXbfIx+oH70+WtdDmnLz9W2WglXbGm01MDHkN9Ek6Z66St6vb5nLwrVlAGSm2APQCOV8ewi0Ro9a+MrLvOLJGk8d3874+HnwAy8bKJYxzcWniKjb0pPOEtqoKPGO9Ofx9JsUQrExHQsBz4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510250; c=relaxed/simple;
	bh=bOFX6B1cMLWK/8rdWZyVjQRxmhZreHCtlJQd0747/0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=td6X3IZCrD/VydsgizD4/F+1ify2bV+EqumDBUdQ0DWC/KQZbw74nh3Agg+sMmRBK6+sevAtYJf+360RbmEr8oY/UIxApNQeipzfsJXNYOr4BESEIc0I/o1aXIgkMTr6HgINyFcWdFE/NrpKwQEqWXO2VN8nKs6ohBq3ng6D54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RZT2XFGa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RZT2XFGa"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso5614965e9.2
        for <linux-rtc@vger.kernel.org>; Fri, 04 Sep 2026 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788510246; x=1789115046; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOFX6B1cMLWK/8rdWZyVjQRxmhZreHCtlJQd0747/0g=;
        b=RZT2XFGabeGVMYnYuvbApCELKeWCwlHJ7lJ6KrQziN9fgyhdIvkR2XBo8FB+9O/j9K
         txor+j0jFmjyAs51yleBFwGr3x1C53w2WPWPpZUK5tphVzsn6ty8xAz54bkohQgLzxgr
         gzQzpiVnhNF6Ckntq5i2mdVGVxuUPUHg7iO+CCstjqAO6U+xeoJwsrov1RlpSVDc4JId
         cYDPl+BppRR12QBd6HVdiAPWBVguDj+/7xRZZ+UawR9CudjeTm1NCxPj0jAVjDNvPcM1
         1pcg0JE+xooZ1PI1wjH/8cbUB/XMO/yyqsnllSQvJhvwEjMOHlLldTLUw4D0vofurr6N
         aQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510246; x=1789115046;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bOFX6B1cMLWK/8rdWZyVjQRxmhZreHCtlJQd0747/0g=;
        b=p37PPAMmXVvi6aTl+1iZdegTF0OsSNWFJInaZA8nhfIVD3GJJIN0rDcA7hlvWM5PTx
         fP9Y+6cq6LJDrujQG6Lrq9Xj8+GfCvQBap1QDElV3CkIxrvCYIsvE5OvPf6IheKTrn6+
         QQf0u5K+LZ+BQE2Ah0p3eJBIjWBH7pinbBIQR+zTEU1YTKGs3l99IZ7HrFStftFWGNWC
         4fPeJC5hjqo2dzObLGuTG0p1XE8a8PAMNhkt3P1q265v9icwRL05xkrOOnoFxtE5W3B7
         hum3qAfabRNnewAmAebFO0KitTA0So+B0R1JGWERsxHEnPQu7PUL1Ctan3cckktSoDdy
         XQyA==
X-Forwarded-Encrypted: i=1; AKwUvBwupopwA0w+1IMo2IELIuyORKcHNjwhIHOCVwlmDH6iW0ivS+uhkpwWxZMV6hy1Ott1n8kz5D5Z/8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kSc1KslXQLnd0oHNykVoYw1grkwnAHLcVBh9G7ZAqwdC/Ifzxn
	Rl7ISWGgEIQmg4uKUJ/w4BqnwAg/s2EeWsafwzixE5uWKTJ+HXI2lzwS5/AYjwwzq88=
X-Gm-Gg: AYBFou1kbFVqJnIHYeu1HqYNoBpBh3ulwP6kf6XHDgbKVey0FPg0jc7fphhy6US679/
	U0wOmNLeuS9wgWwXzcMXgkzsAc6qi5uEUdxrAxo0uNDWFyxJj7QncFME4JrhjNVALxbVKboncem
	Q0UveDy252RWKlWH3ny2ipoXUZJW/tCXAPbuadGcyKRN+o75PFYOzAQBBriIMDY7VYk3Cpannrz
	qXjWJNX8t+F+mc0I9W+uhv3g2afQhmfJEUQYAtp2Nn5w2uAm+Vr/QqS5TxJKunFg9qqcBzx4P4O
	wJ46OyDkVKHL6KHrK9ZCGICqtyKSHoNq3L5gPHhC/+BYvPCx3EqvX1rs7TQreqV6zRTlZmlQrBt
	35mk6DbSIWOCtsE1EI2vgoLMMRE0zHuFdPScGz5zcfFyVD6UJjq8725p4AUfWk2eykiCFXLVYon
	IfO6H6+1Edg/LHx8CPOQPTTe00QrHabMISYcrrDFSGL6HaNs0FnHFjGnMlpisAgNwBANtHGMnlH
	8Lach11zfhchElnEA==
X-Received: by 2002:a05:600c:a44:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49cf821e7a5mr40764145e9.8.1788510246002;
        Fri, 04 Sep 2026 01:24:06 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm4632933f8f.35.2026.09.04.01.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:24:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Matti Vaittinen <matti.vaittinen@linux.dev>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Michael Walle <mwalle@kernel.org>,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 08/10] clk: bd718x7: Support ROHM BD73800
In-Reply-To: <2a74fea679420d147ab1029943ff071628dc8c5a.1788346553.git.mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <2a74fea679420d147ab1029943ff071628dc8c5a.1788346553.git.mazziesaccount@gmail.com>
Date: Fri, 04 Sep 2026 10:24:03 +0200
Message-ID: <1jik4ll90c.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mer. 02 sept. 2026 at 14:05, Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The ROHM BD73800 PMIC has a 32.768 kHz clock gate. Add support for
> controlling this clock.
>
> NOTE: The CLKOUT pin can be muxed by an OTP option. On some OTP
> configurations the CLKOUT is not outputting the clk signal.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
