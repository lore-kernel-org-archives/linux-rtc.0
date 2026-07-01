Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C9349CE2;
	Wed,  1 Jul 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916555; cv=none; b=JCJwtZViR2EKsmN7e3f5dtIs1/RfEirfAuYICcCW9F7m/lewzPsb033BkDeJtZoM7O7Qav4lKXdJkWhztyJ1winNi5EjhIvYGTP2cFdatNmvFAuRPs5zsUGcF8717475Q/eVP6FIuGLYP2J+5n61T1ae2LOX4WsFMcTlzHm01dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916555; c=relaxed/simple;
	bh=VF+s66Dpjk4SzXuEzMip71DFcHCYnDmKFhpbEPL86i0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ebvyIqQ23+SuO3Lq482igjRWMU9oDPaIpzIVGTmoqxRWQzr5aZapCNL5kZRfqozuTrYHvnIyiwgIN2fuam7h+dY9zNbmtsPUugUvOKJ0qxdaHf7JEkhKy7CoXe1kNaO8jm+U7TLYa/MQpr8N9LpZL1GRhdyk91GMFOQjuvzsXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM4WM4HX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM4WM4HX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6131F000E9;
	Wed,  1 Jul 2026 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916554;
	bh=jdBLgjpRkWMHuXfPOZuDJqhEP+sOPX0aJci0FCPENNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IM4WM4HXmQSZn8K5LINk3Cpv2+O1LCo7xZQd5BFDqFQ9JLfAIYI3aId115FyVjSuw
	 iSvVdm1mhjLfYJm/Uzi+NB3sqNgHl2JizidBpCwZJB0RYP54KWN+X8ditP2PtOIoIB
	 BfhQbzJkI5UrkyQDy7q37JnmLSTzo1JF+tUG5JwRkdrydTkzz7/OMGg/SUYRPkVZnU
	 jCgsuqme+mBp5qJXzfDfM9U200kBqBh7v4GAatxWWx4vqHw/WySfDZqw7TuAp0rE32
	 ZsrYSjeYn4AbiPUzVtyyh7uje1e26/qEaII5EpY9wJyQvAQj8n3AYERJNuWmpCznxP
	 C75C64bk2vJIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701142953.2014895-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:35:53 +0000
Message-Id: <20260701143553.CD6131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new RZ/T2H compatible variant introduces a clock provider ca=
pability (1Hz output) without defining or requiring the `#clock-cells` prop=
erty in the binding.
--

commit ab03f97b4f3eb2134c97b3b0fa5f6b60ca7a85aa
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support

This commit adds compatible strings and updates the schema for the RTC block
found on the Renesas RZ/T2H and RZ/N2H SoCs. It also notes that the RZ/T2H
variant supports a 1Hz output signal and updates the schema to require the
additional clock inputs used by these SoCs.

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index 1860f0e4c31a2..ea7b039a91e77 100644
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
The commit message states that the RZ/T2H RTC variant supports a 1Hz
output signal, which makes it a clock provider.=20

Does this mean the #clock-cells property should be defined and added to the
required properties for the renesas,r9a09g077-rtc compatible string in a
conditional block?

Without it, device trees attempting to configure this RTC as a clock provid=
er
might fail validation, and incomplete nodes might incorrectly pass schema
checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
