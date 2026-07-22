Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7535C696;
	Wed, 22 Jul 2026 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750987; cv=none; b=ukflgcxy1Gn+E5oFWhPfqalQAxP4YxK+ZL9U+iwu8v7jtYyW16XGpwe/GZ4XPEHXPOV9fuk29LdM929OpVe4GotAZg31VHQf/1UBr+AmvNZpcXVTCaVIdriBpSMbIftTBOsTlcSBqJurUFpeHbT3STNufgRHckhiF9iU6PLpwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750987; c=relaxed/simple;
	bh=WxIHhbTLAwMsi4UDM4t6jNqvpn2LuFwFku824rJeaq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fOLVYsEz9slUpweVncIgieyCHQOimsWuU6JVCaKnJQqJPmZl9l9cBDiu72fxFIems9yJe1rpzKL2Ol+/nmriBl5OvLoX9S6hxK6gvz8zOCfTKutWruo/L72G/IYYDF1lp+FhaTMkLOf3GuFHU/r5UMF14UHLJDIDFlKhtQEXzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnQfU19M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnQfU19M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8891F000E9;
	Wed, 22 Jul 2026 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750986;
	bh=orLTheSCcqAw01rrtKMnGCWeN/sWTmKnKAkHSRwjtjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnQfU19MTFWkTvqqFnLjPS9l0TemNWUfDPRFb6A3GblCZCqIsXGsshl+QNjef3Hp7
	 ALw9IL77hmIBzOXLBrl5/iR1tto2UOgA7yIxGixKY1hbdJcfobxMcbV/1k/JsFF2J5
	 9c7xzpWoN2+1eslo5o1WlD/snTcorUebVrELhTz/9tmupi9l4aY9jghiIdKBiGNenh
	 ogO1hj1RTgsihT4Nx7PMnSxfMGCNfFWm34Jc/Ohague50TLjXJH9MU1MNdgwXhsYon
	 hFcYnUGrKr44boXVWwRydOCjfM/NmDrI1PHDyIxUDeUcp66UJd+wbJr/lw8/r9GAg2
	 Zw58KgvmQbdaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260722195814.298552-2-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:09:45 +0000
Message-Id: <20260722200945.CA8891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The newly added SPI compatible strings `abracon,ab0815` and `abraco=
n,ab1815` were omitted from the `if-then` conditional block that restricts =
trickle charger properties.
- [Low] The schema explicitly introduces SPI support but fails to reference=
 the standard SPI peripheral properties schema, causing common SPI properti=
es to be rejected.
--

--- Patch [1]: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs -=
--
commit 74ad54b7ffcb981494fb52031a1edb5415b809ae
Author: Antoni Pokusinski <apokusinski01@gmail.com>

dt-bindings: rtc: abx80x: document ABX81X RTCs

Abracon AB0815 and AB1815 are RTC modules with SPI interface.

> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/=
Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> index 355b0598411a6..234a103724b56 100644
> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
[ ... ]
> @@ -21,10 +21,12 @@ properties:
>        - abracon,ab0803
>        - abracon,ab0804
>        - abracon,ab0805
> +      - abracon,ab0815
>        - abracon,ab1801
>        - abracon,ab1803
>        - abracon,ab1804
>        - abracon,ab1805
> +      - abracon,ab1815
>        - microcrystal,rv1805

[Severity: Low]
Will the schema validator reject standard trickle charger properties for the
newly added AB0815 and AB1815 compatible strings?

Looking at the conditional block later in the file:

allOf:
  - $ref: rtc.yaml#
  - if:
      properties:
        compatible:
          not:
            contains:
              enum:
                - abracon,abx80x
                - abracon,ab0804
                - abracon,ab1804
                - abracon,ab0805
                - abracon,ab1805

Because abracon,ab0815 and abracon,ab1815 were omitted from this enum list,
abracon,tc-diode and abracon,tc-resistor will evaluate to false for these
variants. Should they be added to the list?

[ ... ]
> @@ -96,3 +98,14 @@ examples:
>              interrupts =3D <44 IRQ_TYPE_EDGE_FALLING>;
>          };
>      };
> +
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@0 {
> +            compatible =3D "abracon,ab1815";
> +            reg =3D <0>;
> +        };
> +    };

[Severity: Low]
Does this binding need to reference the standard SPI peripheral properties?

Because the schema adds SPI support and specifies unevaluatedProperties: fa=
lse,
standard SPI properties like spi-max-frequency will be rejected by the
validator.

Could a reference to /schemas/spi/spi-peripheral-props.yaml# be added to the
allOf block to permit these common SPI properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D1
