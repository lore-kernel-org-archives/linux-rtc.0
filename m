Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CC33936A
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565323; cv=none; b=u8mUbQLKjSk0+/sLdhNfmnupDzEYYs5sTWO8cbpAyrwYSa1ogj3gDI87RZyEgTdTEjSOZYKG1fGebeVep1lpMP8js13WI4LsEDMIlafCSeLOw3kQVOvc5Kr7Va287rVK/qosCEvRiLQ+2ygz1ThoYYWxp9uZjKU02nmPM6s+LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565323; c=relaxed/simple;
	bh=LzoyAvXtOW79D7k60hO8Y0fmEyA6rZBKfdqsZ74qXdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQPNjxnShlqj5d5T4B80kLEVgIVM7/Jp5qv6km5UDq2zBvEc8GntV9fiELNcBuFmNAZDORFpCAdRLQiGLmO9FdiApK2ghSnGH+OQcQF92H8VaU1A7OJ9hYjB0B/zJFSRSXVA1HGebhblnN6isXTz9/mTjOcfuOAGrhW67rxb9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20a32so936467d50.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565321; x=1790170121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VjFBIrCXQf4je5+QLhXlwhCeUMvFdhymcKdGZkZgOg4=;
        b=dQx8ITMALYhPDOoOR5SeeLSCV+GW6fdSLg6UmZvKqHAo+3XoVN+T+5fAoFe6FcjyEa
         9E60k+WPTBZFcTK3wsKRboW/QXsTccWkBJGZmpX+Kux6k/El5FpQ+4LPOsH4p+tFlx4+
         ZtMbH2DBcBKE+h2hzj58BQPsjiMYbc7hduD9fyneIRftWP3vNx4O00LmL5HMcXhtVTSy
         YEMYX2ReQ2TayHJ6UxQseXqlKHgfcGKfm4NZftqv25o3+QpvGIeSgyyCflhBKUSMpkDV
         JES8cKtmvwXX9Q9ESYWe+TcqgEyViUNKJH0CDvs+TgH1Z9j87tD8BVDOtgNVnJOVs5A/
         H40w==
X-Forwarded-Encrypted: i=1; AKwUvBxRu/1xbD916ve1c3/8RzH3Mm4x3eukoiAtcD+7kbj8ZKqr0C7Rgk7eivPaqaQyHb7Y/VGMh8jp/rI=@vger.kernel.org
X-Gm-Message-State: AFuF++n8EVqAdcKKIl0zfqsvoR1ymhOI9Rc0fTjwiETFsjPVa44o45sL
	S0huurhxub5mTceFh5iRyRbflrrCb/ErCgYV7Dpk938snNVSbzrcm/XFUDA9RE5O5lc=
X-Gm-Gg: AYBFou0q2XTwA2dzmFm52Db6tOLjZ6ZueZO4ip1FlbNmlmDwyWJlCdGlQ3TVCPqkClR
	yNQzNzOZzdq4Svtmwvg8z7hpe+zU9vkJxEOlYh5n5wmcOtfnzzKHH5qF2q44Ra9X895sbCeEQeQ
	ev3lHtEq+Q+BS+VEd87YMoUyvJw7YD0k2PdN2gD2rITz64AuQMmhZfv8w20csAGaFloBry5M8Zt
	EaNDfvf4ASwwZ4PhqdzGWC9j1kmm8PL4SV46MDYUbJEEZTpV10n1S4TKLlLJfzzpGgzspvfg5/u
	lDChtjTrP6ZOUECtZ9sPcAAGIZw/acj7h6BHTTpYudS2IejKouPp3odkpjMh0yU/kGyj840AWKF
	ckHo212SOR4bgU69yS+wBz/ZNT0qVg4OiMesWZGi07vvV9eKEDWqyHwfSyZwAZmbP+bBARAFHdu
	ll9qJ6N8I2JmeKPKdodCqVCEHB4hETjQwTGxLxDdUFp+bJZlRN086Mp6lSRo8MLA9Eu5kR4qT7P
	BLhJRbEjhOdNsGnBpvHtXQUsV7Yjo0RM/Ve1A==
X-Received: by 2002:a05:690e:130b:b0:671:4db0:90b6 with SMTP id 956f58d0204a3-671632b51d0mr917429d50.62.1789565321028;
        Wed, 16 Sep 2026 06:28:41 -0700 (PDT)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com. [74.125.224.140])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891f192d6f6sm6984207b3.44.2026.09.16.06.28.40
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:28:40 -0700 (PDT)
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20a32so936446d50.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:28:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwEbd2kNg2YDu9wO4JaW3RV2PcuEInZRlGC4t1k5hYM2Ttw0VBqRed0OMkc9M68fRokK1jK4SwQkj4=@vger.kernel.org
X-Received: by 2002:a05:6122:8c5:b0:5c7:a3a3:a4bd with SMTP id
 71dfb90a1353d-5c99abf1d57mr2593491e0c.4.1789565009279; Wed, 16 Sep 2026
 06:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Sep 2026 15:23:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1Yad-jV9z47ivY02WAYtOcgnCWVfjynv=zNy+Xcw36A@mail.gmail.com>
X-Gm-Features: AcwNN1XUKmQ2TuuLF52Q7gsi4LkQkjc8o93Y7AoWlIWPEwf6hN5sIOrfKevHtU4
Message-ID: <CAMuHMdW1Yad-jV9z47ivY02WAYtOcgnCWVfjynv=zNy+Xcw36A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: rzn1: drop unneeded 'start-year'
 from example
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 12:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We don't use 'start-year' in upstream DTs because the driver does the
> right thing by default, ranging from 2000 to 2099. So, drop it from the
> example, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
