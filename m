Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668845D5D5
	for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322202; cv=none; b=k3CIio1Q1YboQsU2XHT1eoD7xDj69UmIFbJXZzSKGzIN8UNrsfooPo/CEiQc7Sgaynijh72iU2aGs+d7iY2VVziMV9AORXqBpt9JWNlNN61aOuy8ropwTmczYUQN0wvH7xaAay4gQxFcZ2Evm/vg2IZCbqYxoHn0wWE3eZk+z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322202; c=relaxed/simple;
	bh=LdmthTFaZ6Cx7odqrAcqzO4dhbSuBO/RNeKUn9ozC/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unIv459agbkBUULJNEv7EstGKUwo1/6c9slMkhKMfbJbLfhGxWPT/Jgc2Ptofo/xaouSPRwfw7+OfYa6LF6nEwXT8puDd/s7/S1F68NbD0leYnOwDBWjkBCuoCszwq0H7/tTL4jT/5b5QEPephvxT15rsQhgbieMFLBGnY2/zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-98536aec408so677784241.0
        for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790322194; x=1790926994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OHrY14evUZl7TkXTojoWr/b2Uu7Pe/dQ0XVSo++s0Jk=;
        b=UAr+7tWGyGsa5LKwgfK3hdmiEZAFGjDRrsmJfGEmkxIE/MsfXiHCxMto4QPELvyMfb
         z85+4ygsZPoIQRteSiSgiCIM/FOaEdR/Wr29xWK1rEZqIz0zIYE8yQN1eE1FJyAlwA1w
         I5rlTlx53hlj0JKZY+QGjhTktrDdGjgrW7sB00tx0e617hAzNF5g5sXFDGTlx3ku7QH5
         37dQ0seFmj/kgQGrPUK4t3K1lUoEfBRP1dsI9uB7/K7uGVybuG6LSbN9KLlubQauV/Lh
         R8qV8i6rjz1iXYO2XcmT1cIxhWpxvN9B/Pg85Isbg2Y2koiFKQ73v3op4hS6tX74LF6n
         HsdA==
X-Forwarded-Encrypted: i=1; AKwUvBx4XJsFu3r2X7QHoSc1FQiaoqxRNMYxhyR5BNQpnUstvQv7sRazNv0pJKoMagUjc3joLEii6DUmLGk=@vger.kernel.org
X-Gm-Message-State: AFuF++nKdr158KDFrP6fc5mbFRvZMPV0Zm/mEFkVEJgiClHs4bo0mEmK
	oEKUpyqaxnVU5ZDwxmdzV2prh+qT8XwAX0XeOQ2U0bWDA63kxzfFa4wtCunWlZrD
X-Gm-Gg: AYBFou2o4CETAYr9R7aQGS5Nkk/lmnVoH0Kaj6ymgCwK2hFbcpG8/TrK/f6KB2+VyLU
	bPD3ZZxsstk+UZE1+5uBqiZtW+DDZXJx4ZA+/WK/M3i5xcsnarRjwnsBuILHlMMFfoyO9uCgeF8
	1rttRr2RufvRzZq0LMw4uU8G/B732+l5ZnDTqe9UqUbc785K7T9LogEMnkZoaE2T9h5eHtg9Bij
	lY64A7if4WbKdfUxqeg7xT6coMXr5gq/wqFBpmFYVNS0yDpTLeCSA+RnEkWcc2GNJUSk9ihlZNM
	1sywl0Ok1NuVB19i8ZvwA2SMVXGMOGnz1ncG5aYObYajHhQRYU+/kV2IKrJwkZf67mfDwPJ307y
	TAKCxuHp38Tjv+SOsmt0KmjXsHVl4T3+zm2d4WxlgBx2b3KloIk9cxLCb0CIAj6aMeKXs8oKLzP
	smJ0VCTqVoytzyhXXtn7vuyKqBfFCoz5JMVC82PEb4MtDSPqivX+8yaYrPXYzDIjf1vpeCOWcie
	Fg58vnBF326RO9qUgCRVasCl1mXlW9VhzwFUnxQ
X-Received: by 2002:a05:6102:1a02:20b0:7af:efe6:2bbe with SMTP id ada2fe7eead31-7afefe63c7fmr919654137.16.1790322193813;
        Fri, 25 Sep 2026 00:43:13 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc66536928sm1775382e0c.18.2026.09.25.00.43.12
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 00:43:12 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c83fbd23a5so1593835e0c.1
        for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 00:43:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxGV8ihgSLwnYRzTilZf4ooRLnS96XS0SvvqmSLyVhbLbsoAop1FXbZPNnc7r8SCnpOc/nIGaY2o7g=@vger.kernel.org
X-Received: by 2002:a05:6102:3246:20b0:797:c1fd:9d87 with SMTP id
 ada2fe7eead31-7af1c68ce3emr1738158137.2.1790322191996; Fri, 25 Sep 2026
 00:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com> <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Sep 2026 09:43:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com>
X-Gm-Features: AclHuK85B8akfPcq7Wm9lfgYaHe65iE3-4i39ONPSyetOTvniQxGh_v7KkpSaOQ
Message-ID: <CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Thu, 17 Sept 2026 at 13:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -23,6 +23,8 @@ properties:
>            - const: renesas,r9a09g087-rtc  # RZ/N2H
>            - const: renesas,r9a09g077-rtc  # RZ/T2H
>
> +      - const: renesas,r8a78000-rtc   # R-Car X5H
> +
>    reg:
>      maxItems: 1
>
> @@ -52,8 +54,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
>    - clocks
>    - clock-names
>    - power-domains
> @@ -66,6 +66,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - renesas,r8a78000-rtc
>                - renesas,r9a09g077-rtc
>                - renesas,r9a09g087-rtc
>      then:
> @@ -75,6 +76,20 @@ allOf:
>          clock-names:
>            minItems: 2
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r8a78000-rtc
> +    then:
> +      properties:
> +        interrupts: false
> +        interrupt-names: false
> +    else:
> +      required:
> +        - interrupts
> +        - interrupt-names
> +

Sorry for missing this before: the "resets" property is
completely missing.

>  unevaluatedProperties: false
>
>  examples:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
