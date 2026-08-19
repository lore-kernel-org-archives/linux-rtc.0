Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD227A47F;
	Wed, 19 Aug 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177496; cv=none; b=tFFxPiGnODAam9LGngj3JalCOKBjMLfm3iks2ba6yuEDUfC9IQw9EvOXdDHybEJYVuCbwQsyd6zdLxAQCQaOSKznoH0T1siMDe6mpfAFVTvygsiLhzVXRWTCZnf5/yZj9QCGpDUnNRWXsew2ZPaRZk+o+8yStbX36/VHi+aQQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177496; c=relaxed/simple;
	bh=pDaJD6fUxbUI/6CdhoOz/JQOGMWuUCEzE45T6qgmBfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nax2ls8SZczm5orlJsYdOdnvo6tyq0sWAJDBaCemHZOF0w9xE9eK/6XHr7cVU29fZt1o425snI9aDywm27lmwplQw5Q0vKbtXCe1u63CGbb1ybfUko5vv2uptKMtRcU/A19OwECq2Et5oHeiLhMP3ATAGPjUe21biPcrjw83F74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTmTNO0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTmTNO0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5C1F000E9;
	Wed, 19 Aug 2026 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177495;
	bh=Bqpj/X2aFW+Gh0FoEy31oqzmKWV3b54XeZlaw01eUho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTmTNO0sFg6RpM0K0g0eeJYhA//PiRwU9NLcAM6pRvLORa4ugSq2GVku35SvKmzbV
	 /fkf2AEREav27MxWuaG7geK0atjcVdmpb/WM+ihNyJIw19dV+ys5ZPNqx/N5B/k6Tn
	 4QbAJSWoMbOmBeFSrgD7tOVjfkI4A9r53D6zMUWmg4IF0QUD2k2Aiuo/EYUoYibdMH
	 WNzfzglnLvCCtFlT0yh4LQio9iP819JzJdr2hAdsB8LXfueL9qtjoyJF0lNx8Sni82
	 KqUW+hLnEJGLPe5MGcBVb58bsluUIv2pF0RLZJ0AIODIRhqLzBDc4KIL9uoHT3M9D1
	 EefgVVRmMYPeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260820-rtc_s35390a_int1-v5-1-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-1-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:11:34 +0000
Message-Id: <20260819221135.3BE5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `#clock-cells` property is added as a new provider capabilit=
y but is omitted from the `required` list and the `examples` section, viola=
ting subsystem guidelines.
- [Low] Unresolved phandle reference `&int` in the YAML example will cause =
`dt_binding_check` to fail with a compilation error.
--

--- Patch [1]: [PATCH v5 1/6] dt-bindings: rtc: Add pinctrl for S35390A ---
commit 9114243db5b7e36e694d49f9fc028e6d6ddd5474
Author: Markus Probst <markus.probst@posteo.de>

dt-bindings: rtc: Add pinctrl for S35390A

This commit moves the devicetree bindings for sii,s35390a into its own file.
It adds the necessary properties to configure individual pins via pinctrl,
allowing interrupt signal 1 to be used as a wakeup alarm.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..d9da3abbbd518
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml

[ ... ]

> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Since "#clock-cells" is defined as a new provider capability in this file,
should it be added to this required list?

Without it, incomplete device tree nodes missing the property will incorrec=
tly
pass schema validation, and dependent subsystems might fail at runtime when
attempting to use the clock capability.

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

[Severity: Medium]
Does this example need to include the "#clock-cells" property to pass
schema checks successfully and serve as a complete example for the new
capabilities?

> +            pinctrl-0 =3D <&rtc_pins_default>;
> +            pinctrl-names =3D "default";
> +
> +            wakeup-parent =3D <&int>;

[Severity: Low]
Does this phandle reference a missing label?

The "&int" label doesn't appear to be defined anywhere in the example node.
This unresolved reference will typically cause the device tree compiler to
abort with a fatal build error during make dt_binding_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D1
