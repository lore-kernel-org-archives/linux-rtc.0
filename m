Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76E38239F;
	Fri, 14 Aug 2026 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748684; cv=none; b=CRHOGPe/DejcQnvAUQjIdYvXFewiGYEkDTKwKciTyPZR5QoQzxA6/DlwTemspQA4Qa2IejLybpYh0xQgwxEyWj51Iky6mkLIlObzLcCo76/XmE6jO/7yxM+zpOfteiJfpCVK3eyvKnZEOWGtHFPhlduuOfr1OuQscilZMJwF+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748684; c=relaxed/simple;
	bh=woi4cJMO2YEekiltXYPBkNedUPclVCl+HhM/LeTnCWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T20htP1Srh7D90l+XZJTcOgGGPz3ChMneJpxvsMpfn45KVCHFXTybYWhVsTxm8/tfdDVfKkLWLC2eqHVUe6/jJ2rcGinOtyalU+N8LjGzKcZhGfW4cL2aZjuwbofq5YyxvQdgDoEJoXPvg839UllhdpnZ2hCr6s5Iu4Itn4HPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQNDCy0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQNDCy0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6451F000E9;
	Fri, 14 Aug 2026 23:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748683;
	bh=Y7V552TLJTCIfvGBCrVluyvysvr7AsPrJcyPCSkU5n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQNDCy0qCXhqGro2JNF6XHCup3Pn/zKQqiivWSQMqSuAtfp7MH5GgZirfCTwb6RgK
	 Vm9CK0ZusQeVrgh2QfmOtFl/gISKDbj4NvC4DoubJAFHkNRP0AXFNEYKy8lbxAJvJu
	 vMZqrDHjunjGvdTgyxCUPsLbU3vtobkALllL+6hV+QkLIOw2WIS/bRu+duoiLtGpl/
	 wic5yRF3d1CPtxjdZPmJ+yTLYpfmUpz9Zk8aP/wZpbEPzB1w7oaTIs20BPHNbcVYT6
	 2oSjXbn0Fnobd/xmkl7YH7jlT6X1XQZh/sKhh9AmqSAypqHX+dslUt06/uSR7L3TgM
	 uzurzjjq+LOqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260815-rtc_s35390a_int1-v4-1-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-1-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:04:42 +0000
Message-Id: <20260814230443.5D6451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Invalid use of the `wakeup-parent` property on an RTC end-device.
--

--- Patch [1]: [PATCH v4 1/6] dt-bindings: rtc: Add pinctrl for S35390A ---
commit 58cc609a743d62ad0839cf063b2bd4bf9603a2d0
Author: Markus Probst <markus.probst@posteo.de>
Subject: dt-bindings: rtc: Add pinctrl for S35390A

This commit converts the devicetree bindings for the S-35390A RTC into a
standalone YAML schema. It also adds properties to configure individual pins
via pinctrl to allow the interrupt signal 1 to be used for wakeup alarms.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..d9da3abbbd518
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml

[ ... ]

> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: Supports up to 2 interrupt lines via the INT1 and INT2 =
pins.
> +
> +  wakeup-parent: true
> +
> +  wakeup-source: true

[Severity: Low]
Is wakeup-parent appropriate for this device? The wakeup-parent property is
typically defined strictly for cascaded interrupt controllers to specify an
upstream wakeup-capable interrupt controller. Since this is an end device,
should it only use the wakeup-source boolean instead?

[ ... ]

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

[Severity: Low]
Should this example be updated to remove the wakeup-parent assignment,
assuming the property is dropped from the schema above?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D1
