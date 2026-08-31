Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4C41F5C4
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199882; cv=none; b=M/+FupKdo8yxfMCpSg5jdyMQoUlLWgnV1aU0ChMVwD5dLuob4mq+lwDF3N87IZnZoFztP51pJxfvJs+PHndGAZzqLBG0k5DYF9DF9mzo2GAnjk2PwdQCA3DkeegvTkzYEFXNzstvaIsjrvTMqfbYEzOFJAa5RBARcMwbpBJl/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199882; c=relaxed/simple;
	bh=7M1s0xF0BcSaXgsX1yy+hfw6UoE4A+irlTuRhWvHUWM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RbGY+hUo6kP++h5nkCxsxZaxFlNdp1DeQsfD6p+hh80mmPzjvTVobYACxhS/dsZy91fCHd6nulq3fYZ+sfxe3iAFmgjADQvlOTth7LjnJ/ibTE4tPyoSItYZQ9mThIUNMcmZ1r1L550ExMYrAHUPwo8J5K059wNS69Zdde5bgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HylW1t2L; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HylW1t2L"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso4042837a91.0
        for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199880; x=1788804680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Uhie3yrhdtsyaXSLpjZz2IifaCmtgudsPqCCc1ga+c=;
        b=HylW1t2LQIaV9lJlm+kdFCB6qUQz2daA/Hit5L+cBbYZQYDPrSE91v5zcMS/CSDHbx
         YABmNIBQ5lhHZcs1PYDXFOMOmrkboGKBSK+3KktGfDXcnb9JPr63U14uaoyfjqjp5agS
         Dj+p/AGbc8LuPeYfpz1idawTMIcIZnKYuLs0rrllJPvYvi0YKIh+JTGVudUL4XLuZttf
         c7bNoIhRKh87gRygPVNxUDtmSrYFSKFOzojxsKZn3GX16cefYRbA9iLzVu5LbeGJkY/R
         jbZLKjvYFeqJpO8FnaZVTLls6E2E/e7E92uoL63mFeBU2fWvc05fOw8OlXeBx9b2XV53
         LfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199880; x=1788804680;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Uhie3yrhdtsyaXSLpjZz2IifaCmtgudsPqCCc1ga+c=;
        b=X5+JKmZewxGqxpaW0trPJWAu0GKXuhS2Cqax9kggr3Qy6LDbE+dffRkVvOxLXP+dyv
         VWKrVRgqNnG85NFEf7tsfjpStytu3NCfcy0UjFMqaJWaiiaGFHvekEhqc/Uq0r7U+RvH
         S570Xn/z26aLRwDrkU68NAWoZ1SQ/j4vbQN1Peq7LK3HXMlsqN3MUaDz82V7VYFbmIZH
         K1kLTOXKxYM/i8+CxLtZZkXW1OzhJ36lJysBk81jGEburXHNK3FuTH0zARtn1+gF8SXQ
         irhRy85hv0Lo8lmxgYpU9iF7fHFYyYMA3eqkQXCAY6o5QSTZB3oRg6cuPLYfwrTF7e4F
         ojTw==
X-Forwarded-Encrypted: i=1; AKwUvByHo7d0icwbiy5rAoPKvP546cSApDnALBrW8CX59YEvNJHV/9PAmY55bDDs8WK1/cZQH4qeqnclYnU=@vger.kernel.org
X-Gm-Message-State: AFuF++lnkGU3qut59a0vOogZOwkoEkiWydGG3U7r+IMJrNuAC8uNQEW8
	lj+Sd1QVtf88bsW14aYnAAiAUvi2ZQUMkrN/UK8BBD2rCELfQT93pR7UF40CATIh1Ws=
X-Gm-Gg: AYBFou3QnrJXkN1s04gn4O5MQujy++PhLycgUeAQcE49fphNhPR3+Y7X8WBoGZ1gn/y
	xJxlzG4Eod83Q0PUu96x8x7NYiXveTal43X9eWDaPYNYJynjxImvKUtcpJzb5lFXbfyXS//tZ3C
	DK+8N9MYrNTZndN8DEtQDyzUlZ2w3Y4kPitsGC0izIEylopWF8t8Tj97O9SfreKThQ+sfbzA8Im
	OJw+VA4jBA52OR7YGAal6dSunFSBzM/frrp8xbNP/F77K9xsmMQ3cUtlEwbalgk+aTknu7wLeds
	2MbRLO9KI0hQs14tHwJHUu9+Hvr0zuXP5pTGgXolxkV2Uri+PNIydwxbG7X2xvFFByjaSk4kr5L
	ftY+7egpq0j0k69myWKZsTMLeYdd44lpGhvxcIlwf1c62l7PNBVCa7AO5JQgwTDw2kkBKFw8Wja
	kGn9yXe6pii/DI/xqBl/AeOqK9dP9JmrRVqnujC9hRs/Vd+VnCy08RaoE9Fw==
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-396d0de4c19mr41311265a91.6.1788199880306;
        Mon, 31 Aug 2026 11:11:20 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d4f1bb8sm953382a91.14.2026.08.31.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>, 
 Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
Subject: Re: (subset) [PATCH v3 0/4] dt-bindings: rtc: ti,omap-rtc: Convert
 to DT schema and cleanups
Message-Id: <178819987948.2869653.8611872287361321385.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:19 -0700
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Tue, 04 Aug 2026 22:35:04 +0530, Bhargav Joshi wrote:
> This series converts the Texas Instruments OMAP Real Time Clock (RTC)
> binding from the legacy format to dt-schema.
> 
> The am3352-rtc is compatible with the da830-trc. Update the compatible
> string to include the ti,da830-rtc fallback
> 
> Two legacy, undocumented properties were discovered in the upstream
> device trees:
>  - 'ext-clk-src' in am57xx-idk-common.dtsi
>  - 'ti,no-init' in am335x-shc.dts
> Both properties are completely unhandled by the rtc-omap driver. Patches
> 1 and 2 remove them from the device trees. Patch 3 then introduces the
> new YAML schema.
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: ti: am57xx-idk-common: Remove unused ext-clk-src property
      commit: ff94c2d480faee28000d0a4c4f23147f15a9d1b1
[2/4] ARM: dts: ti: am335x-shc: Remove unused ti,no-init property
      commit: 7b300285a4af35396df237ca6bb4ce24f721dcec
[3/4] ARM: dts: omap: dra7: add da830 fallback to am3352 rtc compatible string
      commit: 008e8fab68d8b33929686c2f71ff92675ec515b5

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

