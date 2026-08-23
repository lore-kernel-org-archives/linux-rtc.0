Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A802798F8;
	Sun, 23 Aug 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523610; cv=none; b=pFy3wpGfM5+QZ2/wbagZk8Hdik11o37gvcdfD/cvOQvCYKBQKSln6f0OVpoTqXJmoEySjfUw6WCNUDxbXg5QnLXQfY88r1Z5vXG0Dn+H4EsjbNjiBjx+KddV6GghlsH9nQx5mtYGDgYiofvnimm8t8mO09bdNCBvWMdezvVWc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523610; c=relaxed/simple;
	bh=oe3uxbueFnOxXn5DyAY4bff4mjmkD52AG/Wm/vEsMq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eh8ZOjvll4nrsFRYuae6ptMndEdT6VhQ9nxTrQ1b50pfvHLpqzbH+E3yZrF1hGRoMM02sRI5vuhHB3qDJYEK74rNgQ+8NmGlDddOadV2BUY+85+zvERqnk1KK+IeRsHxB21EUXWI9+lkzzXePSpSpV5FdrQomTNnQFB8lVtst3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYJPLhJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYJPLhJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C182C1F000E9;
	Sun, 23 Aug 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523609;
	bh=3wjth4t5+rG70prfNgDMRjKRpkAMWVpBAz+H9G+zNvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYJPLhJWURcrQ0FAsKSJyOlDC/nKKUOyY8+vVdIfwAqExvwSDddNP139OFAHUmXiv
	 JTrsAipSyEG42cX53X5Q+Lcdr/83NOwZHZSEnafTbIxO4oFx4RF79x7vlGexGy8F1i
	 xjKnL4tXokTvRGdvHmXcmTBXKPlCp1cQTaxhZbfPcuW5rThEO6yHk7KrsR7WSp3zIi
	 lpdBF4e+mwPbmY7jlvQgtHWb64vOOVG/yq260aO1tFCMxqLA1jSwhCOvL+BVcuK/o6
	 czgYlA/35/szjDpwFiv398GU9Ul/NKsaLoMLwiKAN7+2eS10AZbswOUv+Lnr0/HgJ/
	 soLPYirUB/S6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260824-rtc_s35390a_int1-v6-1-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-1-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:20:08 +0000
Message-Id: <20260823222008.C182C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The binding adds a clock provider capability (`#clock-cells`) bu=
t fails to list it in the `required` properties and include it in the `exam=
ples` section.
- [Medium] The schema fails to enforce the documented constraint that the `=
pmin2` function can only be used with pin `int1`.
--

--- Patch [1]: [PATCH v6 1/6] dt-bindings: rtc: Add pinctrl for S35390A ---
commit ed4fe5fd689ace047dd6fd7d73cbfef4879078ec
Author: Markus Probst <markus.probst@posteo.de>

dt-bindings: rtc: Add pinctrl for S35390A

This commit moves the devicetree bindings for sii,s35390a into its own file.
It also adds properties to configure pins via pinctrl to allow the interrupt
signal 1 to be used for the wakeup alarm.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml

[ ... ]

> +          function:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description: |
> +              Pin function:
> +              - ignore:  Preserve the previous state.
> +              - disable: Disable pin output.
> +              - wakeup:  Output wakes up the system.
> +              - clock:   Output clock pulse.
> +              - pmin1:   Minute periodical output with 50% duty.
> +              - pmin2:   Minute periodical output L for 7.81 ms.
> +                         Can only be used with pin int1.
> +            enum:
> +              - ignore
> +              - disable
> +              - wakeup
> +              - clock
> +              - pmin1
> +              - pmin2

[Severity: Medium]
The documentation specifies that pmin2 can only be used with pin int1. Shou=
ld
the schema include an allOf/if conditional block to logically enforce this
restriction, preventing pmin2 from being used with int2?

[ ... ]

> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Does #clock-cells need to be added to this list of required properties?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@30 {
> +            compatible =3D "sii,s35390a";
> +            reg =3D <0x30>;
> +            pinctrl-0 =3D <&rtc_pins_default>;
> +            pinctrl-names =3D "default";
> +
> +            wakeup-parent =3D <&int>;

[Severity: Medium]
Should the examples section include the #clock-cells property to ensure it
passes validation checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D1
