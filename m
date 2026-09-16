Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EDA3A255F
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560868; cv=pass; b=f+CsDRRLYR8q9zo6Zgdb4cVrwaxRoUZ6WEB3iXvi639Qx9p5HRu6AHcGLDBtLXMF762HT+0bYAWoyeX/91vGR9jYN77h52CpvkqO2JU4hd+SwyxaWR86FNpYM9eMEk8JFMfekA8rwiDy9Gge4+B2ECf/ERnOsyvgyZnh3Ly+cUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560868; c=relaxed/simple;
	bh=6OhSXpLL6yyCsnTcd/u+qyxR41s6OtTwu5yFPz09Fdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCW5JpnRiBSP3wDIBfNTLGSlGDLyq5O+VG8/lxJ+oVk+pOK526VLLI2spAqjBhU6BCcKydaBpN7anD+ZI/D0Sk8mOgAu8rVMNeGz7UhJ/wJtvEvu1Zyy5D2tZVCQQHPRKNrlGbCSlvUDcN6mZQrVRuX97KXiNNKJFAZjizZ2clE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMvzOKYs; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMvzOKYs"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so410161f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 05:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789560864; cv=none;
        d=google.com; s=arc-20260327;
        b=ayspAlpdqGIxyG52wIXA3O7si/SHSCJCS+lpGBTkq9cRTF7XTLp8Ld24I++LfGpmPf
         3+4cLVaFxWxlt0VXvx7cIW9/X2QqmTFt+oTXJ87ZK/0mBB2rqa2PQr9IOvWx6mBjcjLS
         vCAntpYe1LwzvCpYleaj9zP8VBkbjoBKj1dTa7WVjnn3sFfI1sML+SkqUkbiD8xyD5jh
         lBL3IGs1Fa3z00PA62gwR13xSJ55ykczlD+O7ZXw34iO6g+fwI8itUk8syzvAtAs25lj
         HY938WkKy/mjaZmn9kSn9PTNA5M4rWMCZvfwMYIQc4Z1ydv9oFFxNaDMGK1+hix2qLbf
         a+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W8tnBP32THpsSvPeT4SZBZeDx4xVbPtQq5N7CZKdDSE=;
        fh=ZtsX+yeKdEoSLi18AosBEuySR0vVSJFqmw+TazXM1dM=;
        b=py86CQbxMae873KQO3pZR6vA4ndKOqVQdMbBTndvouznl/jlZmgjKTz0VNobHmUD/4
         3Yemy8y/Eu33c6f3dA3fIrY8yBMW6aSMw7sqZYpagoSJAL00piMd1SYicEAO9rMvSAGj
         I1RQETQBneufwmjneC4EuTJ9fTlI98GnPm0ln9rz4btbKei37YwSD0IQNIISdBqH8kZC
         c5stICuf4VaPkXQGOLBAKH59xq4911fQ8RgEYgPT0eZXysUjSFYMV+4hIm0PRccKEJg+
         mo5HG3Cvu+9VEBoZ5nUS4nvW1SgxFkMzXSik+tq1tUu5FEBiEIPfU9KUDHY4kzQkWwuh
         rEBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789560864; x=1790165664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W8tnBP32THpsSvPeT4SZBZeDx4xVbPtQq5N7CZKdDSE=;
        b=YMvzOKYsg9wM5p6c3O41r3I33IFH0fjAtZlxtZdvKulG56+iaCCWLoh9AMKOLSIdYF
         em8d2uJ+aEB4Cy7pVzy+IIbQJHkCYfQmY87syE2EEPkDrG8x1f60+Hwv23IISDZirSyb
         0EJAQs2lK7sGQW6l8CUZivpIUSeV6FOgNkZrvjI/rMQjDXUPby23HcVWzkucccoGS+0B
         Ohg6G2vBPsqgAqBFaAIPZzy/PW1Mp/mVrMdHxzy3lSawtswzqd2w+T+uXCwgk7cZdr51
         iS5A7mizim7YPUWU7IQH1xpsHw1QblEcKicczmYCQt7axCtz2eEhAxb1v8/Y3HC2mJy6
         emRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789560864; x=1790165664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8tnBP32THpsSvPeT4SZBZeDx4xVbPtQq5N7CZKdDSE=;
        b=suc9Xq1/tzPjGdcKqiMCQHy0fx+lgrRGRU5dsQZlSEIXyJdO5CypLlscNuSMnmxsnF
         BY/kdXbrli3ngdBpiFriXoA2q8elXier5Rqwij/BPA0/lHcuiHmCz2K9CNWXSdFRZA2L
         ZnDRBYqKaYSPLBivcfPwgdR4aKGlKTrxrJz1bMeMy2IIQWp+KXrfn2bwbrXwtJVf4ND6
         2OA5VeDe7PinkNU/S5qlnlRwMYdvh59tS6IVUzILnPdo54dfPwlK/WKBXIUzsa99SRNE
         fm8xnzK3J2oukyBmWwFtH0+jkI9JgasZASdTITCSeBA/156fZga4g4+YelbfBHpAcvZu
         hQpg==
X-Forwarded-Encrypted: i=1; AKwUvBw+/IcPqQfZwVRiEuxRDoEFD3i0SVBznTui9lnlLcWC253s4lcin4wIuYSNW2drpWQKnmTfeBbrdNc=@vger.kernel.org
X-Gm-Message-State: AFuF++nXXiKIWfSDkOOYopHSoPCX9mS6hIdgHVV5K7GUFipX3/0HNRTq
	UhqhUDuH029gaiHHdpaXOsSMo79yKUCK4VY7OHodw+eKaNUyEv1yHjywy86byrc6lAxJRibNK+h
	eFKALcneNYvmzkX2+QLQRZSf08X8Op8o=
X-Gm-Gg: AYBFou2KR89ETPOk7Ggx1pgv+TAKiWmLZgga88aamdc0NtXdyM0BrwIdQ8Exzam7NTf
	21txWN946VmjfC6+z26MSf7+BrvrYtHR/LrmI5b5DF21F5vhbjeOkwJVHMWSAy5L4XVMyiBE4h7
	vMwRcEu6ArpemEY6mJTHDi/eGdZ4jEXlEv17YXrb0XHHMYlNPIMCWyS7FjBQbOsf+f9kPm6Tnja
	9z9wmkTFTWb8f5eJHTzQxi6UQgmtcY8SjvYRCwZE78FyG/OonndQEVrbVf0rdKtAyL3wUBwUi25
	8i2eJWT/zF5u40NmGkm9R8wGbOPAWmZXLERe+dbvI4EVpWULrAu9MDp78U60S36VDXVmOPnM8w4
	1oZWOapZeQBncYQGJLIbvpJIN7dyN/H63ojtqD/59
X-Received: by 2002:a05:6000:4681:b0:487:fa6:7335 with SMTP id
 ffacd0b85a97d-4870fa6741cmr1533422f8f.36.1789560863947; Wed, 16 Sep 2026
 05:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 16 Sep 2026 13:13:56 +0100
X-Gm-Features: AcwNN1Vmfjvs1Y6IvhLzPsYLsvLUYulxTJnuWGWVyBNab4QaFnHHBImQf8BVKrw
Message-ID: <CA+V-a8sRiKX6SRsMdkDFoRMmUCYZHYfGkX5_P_j3xuV1u73xjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: rtc: rzn1: add R-Car Gen5 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index 7ea77cd0bee1..186d0076590c 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -23,6 +23,11 @@ properties:
>            - const: renesas,r9a09g087-rtc  # RZ/N2H
>            - const: renesas,r9a09g077-rtc  # RZ/T2H
>
> +      - items:
> +          - enum:
> +              - renesas,r8a78000-rtc      # R-Car X5H
> +          - const: renesas,rcar-gen5-rtc  # R-Car Gen5
> +
>    reg:
>      maxItems: 1
>
> @@ -52,8 +57,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
>    - clocks
>    - clock-names
>    - power-domains
> @@ -68,6 +71,7 @@ allOf:
>              enum:
>                - renesas,r9a09g077-rtc
>                - renesas,r9a09g087-rtc
> +              - renesas,rcar-gen5-rtc
>      then:
>        properties:
>          clocks:
> @@ -75,6 +79,20 @@ allOf:
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
