Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7367322749;
	Fri, 21 Aug 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321143; cv=none; b=jmKKoYoPByBC/t5YgCLv0pPJFjITxsSyP7mgK2gBXRD0uo2auhcrdNGWzlwyIMByxYbyJ/AJej6I5uEPLnDt5116fFfsu4ouqEs6Vp5tw5QfstrOa+LgTnT76W+F2WbgUva3cKH8V4LU7YL7IQUOIDEuVh/TQk8Dtn2cRzZNOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321143; c=relaxed/simple;
	bh=rpqBR+MCp3mU7MAR2EAghykBxhEyFZYQrhOUUFFPP0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o09z/TjDPHxbkkxJFkdlIBndeAKW3avMu3QgW20AaccIqTY9Wpjb3PkGHwhIUryhEgKc5FJ82rID5KKmNIjifihQESkS2+O6VpBj4mql4W3/7hbel+5Y0u0HJWDlbEhmKeaefChOYLIwRoB8ET4FRkA//PaiP3p4sq5xZhljwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMQtJWjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMQtJWjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1297B1F000E9;
	Fri, 21 Aug 2026 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321141;
	bh=A05ElDWF+438DuXIMRqkktigDzpG8p2o7bO5sfrJosI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FMQtJWjD7lIo0GdX+jGgHvOgC6SAuIGkcXnUdICH4Gql21Dt7ax+mmvCu7ujyayID
	 T0VQzuriRf9xhAjW7hHpmvryicwrvlkCG9iDN6MVQdAD7uG80cy0PoptPRhQuCw9QP
	 SNpWo8x28SZhhRbAvkayXrDCXKLLqDkUekagZ5LN+qM4zg/I30mo3O+6ZCRkgrDW9O
	 8zKh0QB/J4Vg7+F2/zwfpan/ikn6x+gaFcHULWy7L4cpQCV30RI8YUFM0fg4z7r71s
	 onSZoDJxLnIdS7XNpPdCBQXs1z5SsE30T/xhEvybW9ltWtJGxfBlmSz5sTZjBzwL3+
	 9WtJ6foyipHUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260821135608.275233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:05:40 +0000
Message-Id: <20260821140541.1297B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The RZ/T2H variant introduces a clock provider capability (1Hz o=
utput), but the binding schema omits the mandatory `#clock-cells` property.
--

--- Patch [1]: [PATCH v5 01/17] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/=
T2H and RZ/N2H support ---
commit 61200b5bfde6a5793e723c5af2c3129b5a618eae
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support

This commit adds compatible strings and clock requirements for the RTC=20
block on Renesas RZ/T2H and RZ/N2H SoCs. It also notes that the RZ/T2H=20
RTC variant supports a 1Hz output signal on the RTCAT1HZ pin.

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
The commit message mentions that the RZ/T2H variant supports a 1Hz
output signal, which acts as a clock provider. Should this conditional
block also define and require the #clock-cells property for this variant?

When a hardware variant adds a clock provider capability, the device tree
binding guidelines expect #clock-cells to be documented and constrained=20
(for example, #clock-cells: const: 0).=20

Since unevaluatedProperties is set to false in this binding, if a device
tree node attempts to expose and use this 1Hz output by providing
#clock-cells, will it fail schema validation?

> +
>  unevaluatedProperties: false
> =20
>  examples:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
