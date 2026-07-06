Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EA31CA4E;
	Mon,  6 Jul 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360728; cv=none; b=DTdUPotWJfMQbGUX9wNmwvz389RCiaJa576vBs5TEIsFURr3MrZBLClL6w+3C2eoiIj4JLNciG/Tenkz9pK0GqBY6l8qcdwXx7bP3VhfcYASZPWFraNgIlvWO7NC/ec8gmqF+eVpK3Ij2dR+lo4s36Xps5ykWqrhpR/0TR3Prw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360728; c=relaxed/simple;
	bh=+QNYWOwLzSisrGfPptUUz5tYb1gffbFIB+9Ed+1UpiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+9SOemlSscsgHWNdJX+ZmODcX/3KC9dSw+mAaE/AWYDyig/LIp+jC/CZvJBETC15oaVEed0v1NKnhuO2HLSFBzRs93dVdFjqxzm+f/cICY2KsoPygN2t6XMxh+lrGa994+ck5AtHWtUv8hY8rUaXAUTngYU7+Hl8hONKdMdTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsPJA/kJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsPJA/kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7964C1F000E9;
	Mon,  6 Jul 2026 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360726;
	bh=k6Aw+gFjaAU3z/n2LrEx1uR/UmC+dfOeVr236BcZI0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsPJA/kJ4GvsxvrNxbcJZcnvpGlixN4Nh1mpjOxCbljQvUAG55iUz0IdubNnI0Ah8
	 aOKYKKJ9gZhXqitr5v+SCU5reVXAQBK1zc9x8SQbvjJx7RQKgsqgtOnw6UPv2b7KNl
	 v8u+U4QTQcfMjvQKugiLONrF09dU6FZrYM4/9wf2vTJFHpElceR04xtMPG8oh5P5WT
	 8IBLTDoUE3vE1ZX2lZ3OGv+ozPxCYa9YWnq2ik0xweBBA+p35zEnlxwmdHaIbohmmb
	 hWRpsjkb3qXJGR5qeNp66W7SlfHlG5t692m3WwAFbuXwImy3B1x9oTDOlEnqg1oKQj
	 e10z9vS6z2aRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260706175138.12587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:58:46 +0000
Message-Id: <20260706175846.7964C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The RZ/T2H RTC variant adds a 1Hz clock output capability but th=
e binding schema fails to document and require the `#clock-cells` property.
--

commit 521c08a40b8b1ac0b30dec5219ca0271639457ef
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support

This commit adds compatible strings for the RTC block found on the Renesas
RZ/T2H and RZ/N2H SoCs. It also updates the binding schema to require the
additional clock inputs used by these variants.

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
[ ... ]
> @@ -54,6 +58,23 @@ required:
>    - clock-names
>    - power-domains
> =20
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g077-rtc
> +              - renesas,r9a09g087-rtc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          minItems: 2

[Severity: Medium]
The commit message mentions that the RZ/T2H RTC variant supports a 1Hz clock
output signal on the RTCAT1HZ pin. Since this introduces a clock provider
capability, shouldn't the #clock-cells property be documented and required
here with an appropriate const constraint?

Without documenting this property, adding #clock-cells to an RTC node using
the renesas,r9a09g077-rtc compatible string will cause device trees to fail
dt_binding_check validation due to the unevaluatedProperties: false constra=
int.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
