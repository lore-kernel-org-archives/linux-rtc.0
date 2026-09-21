Received: from mail-wr2-f31.google.com (mail-wr2-f31.google.com [74.125.225.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7533E35C
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981024; cv=pass; b=g109eVtCmwvpka7CIXVyLh0aj/f7iCCExj+/66DAxfas7j2BWb+PwyBmU8QRHYOMiBMi49jAevBzvw6PVfRRrEBc5DouxXq8yzZf7OlsTabTWB/l1b6h/RiEjLBu0xGA4YqcdzQH87v8+hyO0pxDvEBtPtMsNBTwc/O+XtY4Af0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981024; c=relaxed/simple;
	bh=LIMisOFGt0qIn1CPMIveMR4IC+rDqNbpmZfUtuIDlQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH302jQjc6bG02tkVpvvrTwHshVwTxBiwuhlFTgbq4CZwp1wNOI8nccgTQEPcKeydDZrO2nw5VBn+F5C+DF8K4KNDBJ4xzbVN2eJ7PYSN6Xl+Ux8ZaU361yHDNRLVlAR2HIVWqMyYkz/MyoSExrks4UG6ryJNXhwgBTI2v49gZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9SmA2aW; arc=pass smtp.client-ip=74.125.225.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9SmA2aW"
Received: by mail-wr2-f31.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1602076f8f.1
        for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 01:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789981018; cv=none;
        d=google.com; s=arc-20260327;
        b=IqX4B7mQDWm8JQsLKEKlU+z7bUy7uTJ7hBgOD/t7j2XC4n/i5nZ/93Ljsr4NK7yzRN
         fsr3dZ1OLkZU1vPPc6LyWz07zNKfXbRxXVuTczZ3rqoVD4eiK2a+ATYNl5C+u+NbGG+C
         8+FmIieCHi7tAHdWSLdtCoxrVKpcw5zdcBAfnXbNuaNKOer8C0dPaiMEXMQd843JcUPc
         ON4ogyEyNuV50GV3jTQvs1JsnkdHnHtQmMGsJB/hqpBDXzXU7i15Hwx2cihUychSiOiL
         2kP0uifAz4de1QX/6c5sA8Q4kZNE2+OnNL0SrsQHz60l/wk4KoKlb39VZs+iKTiRtljO
         fRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qON0nZ3j82CiOmvFqun6r6qqh5dkAemGnmHmfUfUMgI=;
        fh=g9eoOTH4d0YKB/W+rDO4KGbYFW9lckUu1b7vYQdkvlU=;
        b=r5hPxVyAa+vJlJ4Ucd7/GuN/O+La1MHCumhdbQlzxGSU+c1TsBFjmrrqJFV778E8Fl
         KK1TWaHEnhzFIkKmX+jzTas2PSeoe2s+mrQXfDHBrQ1HhShdb3uBYiRkuzHiVigpZ+c4
         74mjiYo8hamAA0Hq9O/YJL6SCY/xNNJeTV5p0Hk1KVxMh+sJYgNwA9YlDB2wyF4wvEsw
         I1jp4q7EnaZcK+qKuDfpRLGWHYp1kG5+68NPxNtZBB19PCtuWRrW8GmxQLaGbQpHIibw
         rbUZqt90SOewX5aDLAHDLXoDdg7YGmlSvlZyOyd9VUhpdwVuhGT+vou6IekBw3qdR9wT
         E3TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789981018; x=1790585818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qON0nZ3j82CiOmvFqun6r6qqh5dkAemGnmHmfUfUMgI=;
        b=r9SmA2aWbdtQDOK50ymPvhTVeRUUSayv17P+1q+tWz8l7VTadUph4aJiemMhWNyVHn
         o9CDznKLNQ3j/hmc977Rg404wDglH1zk9pPC8R7Gyp5q+xq2R8g31HYyXDZkNwGDhiF5
         ixhHx4puuB9dHflPVvnuIu6Hw1fJKAPrL3fwXKSbBusz06/3GpZYYNCFzo5ginUlyahJ
         ua/VQW6RaxcBgynx3xaLd5Z+34VZ8Fl7anAK9ziZlugRJFseCBJEj9a6gWDeSgfGLK7q
         j1FKgDkq/KskJHhoOSwFcVf0GN7iwgdTtmJ6V5GMHu66khVnaHPf5wLL12ZIoCCSDczS
         XFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981018; x=1790585818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qON0nZ3j82CiOmvFqun6r6qqh5dkAemGnmHmfUfUMgI=;
        b=NMFmODJBjCOJw1k6srapu1LHasORiwZVtGWk6FhBc1V85PSqm6WkiDcM3zu0Zpfl0I
         up/5jG/2B7jA+zYCysUaaimNAxa3OSAG8Q1irfpDGpm230+Sml5d5pupJwi+g7iavHoV
         HdEHu50IcTb3hJIVS90DXfqyn723vlyjoUhIkJo78eFKcRWrMyz2mDom9Zmjjx/T/6Zt
         QUByaUxN8H9w1nGtEcStLJ8BAz9MqIlfh9NxfHUvx1dgmWLrtp8mjnGtcCAByZd5n1PS
         pOu1mT6X6X98zX18IQ6iAQPK3KWho0HJ41p9JhJoCn8hpamGru5SFy1cFavfyhncCsqe
         Hy+g==
X-Forwarded-Encrypted: i=1; AKwUvByhlHDYzJifHlGeTGcbrTaqSo2fhSt9YmIXAAxRZth3eClSy7dmtabLbQZWYdOwLd77Vl1q3kh/tCg=@vger.kernel.org
X-Gm-Message-State: AFuF++ljVMTxOgNsh9x96pAzQIjXnE+an/3X7+JBBZ5+prCPvfaDH6Fu
	tK1fMKi8s6gbs87pCB1U25ZCzyZ7swFM7B+i2fYOsz3oGCxh6wLrZJqUfMCMIq0CvNrA5UO6zLB
	aqoBtgyUMY+5jxQtfocWxuxjhjcykoUU=
X-Gm-Gg: AYBFou2BPBxrNE4DZVr/eUWr56IY5cFSEB35B7YdtMNz2Ew5GEAVCWlSwNmUJlBHHOW
	PSiQWKzV8Och9u2AGkqeQXI+EilHWYi83rkcO8PRj2GYJ4ReGuLHwo7FQMwt62+lYP+EmcEYfuu
	EYwSvckTYzLpA1t+CeuzJ+gz8x7C3w2AZk/wCUVTjmH0VDEkG9AXTvU+A5eOnJAUxlNKNUvEE7l
	R/t8TTBQP/bALLxnfqRxLWEFCJCElh72DzStFAGwSiAUR9tvmJ0M2dlZYbYPZPNWzKPL/U/CVoB
	0z2yF0JysWuTePgzfvj3vtGQv/fLA5VhEwIbusniyK1TJ7ACG7Idl6l1zhv1Tq4eNTzOoig+KqB
	68Ny5aGMojjNGk4qVdjnMCGhGtDDnCjS5x4eJOjPFBxALhmS9aiuuOmKaAbmwnHpVhcFqpu+r
X-Received: by 2002:adf:e001:0:20b0:487:21a4:f617 with SMTP id
 ffacd0b85a97d-48721a4f785mr12067196f8f.19.1789981018022; Mon, 21 Sep 2026
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com> <20260917185903.61253-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260917185903.61253-9-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 21 Sep 2026 09:56:31 +0100
X-Gm-Features: AcwNN1UuhHZT5-lbDJzHKCaC457x5CxrktdfiOsZEU2bG1XndBnc3Ogxq0Q1bIE
Message-ID: <CA+V-a8vdkeOP3uh-jObET1oCEOaEsyW4LJ9mxE0tOTqe81Rg_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:59=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes since v3: tag added
>
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index 7ea77cd0bee1..b448725671ec 100644
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
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.53.0
>
