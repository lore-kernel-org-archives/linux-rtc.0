Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF93B47C6;
	Wed, 30 Sep 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782882; cv=none; b=gdNM2bEkQs+awnIS3R1fnwM9Xse5qPNA18F37idQHPqQIxStYHWrSQ69ubyHYt7zxBfu8+euvMSptK8xOuy0BQoW2atkT6t2ykKGIb5HEuN+hAMpw5KJDuSwlb97d8XIkYeqxn4fuuoZjgSWcM06mceyte+rnX0+MOLDvwOC/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782882; c=relaxed/simple;
	bh=EXbTVKjqVp6inc2GwKKHp1xEjM5Td6bVCbIk/XiR2M8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ga5HVNxMg4KE2fxdd7LwJjh137PpIKFuHUMngOs8yqiDdNbKKODfLggiWgfDmX1uAvNPeFKaGfF+50a9q64GC+MboNTW5NStYYnzSFIx4BTElYVXlWhH+xJLbExz9lWGFo2gIN0AAcNPT1AnGvrBkIezT9a6xIpGv9u3osBlIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhXTKxS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhXTKxS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6D11F00893;
	Wed, 30 Sep 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782876;
	bh=BmM6L15tMKxC6bKDRWKo3iN3FNEmBaJ/CiNP+06O88Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhXTKxS25WogFLr5xTByC53lNlTzfmdJ06eGGHL0+zmTwrBf5J+uPXgrh0xsmSpEd
	 yFO3q2lsQKRFUcj8fIwfO4IlSnk1JM9EbksKyi4rUfox0Dj6NNonHKBxVdgWhHCbYw
	 dKgPqGsbID5g11EIG+uIwYVrSPN+KgkueNMAyxwr/uTneCOkKG7ILOagW2nGf2W+MZ
	 uDRo4tZMU8nSugG7xzUTOTSw51L940I49+VmMgRhtV/sLJBBmU91M39WUYD+tBm5AW
	 g1jkrFwDdUtvN5Qo+2ILsPSMLXFSNBRsD6nvJsbsVlVaIfO7qezEqBYshdoqJ9CzB8
	 7z4QPCTL6W11Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260930-rtc_s35390a_int1-v10-1-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-1-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:41:15 +0000
Message-Id: <20260930154115.CF6D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing #clock-cells in required list
--

commit 7dd7db3e76b5a02a9adebaf8cfe85d348334a1ca
Author: Markus Probst <markus.probst@posteo.de>

dt-bindings: rtc: Add pinctrl for S35390A

This commit moves the devicetree bindings for sii,s35390a into its own file
and adds properties to configure individual pins via pinctrl for wakeup
alarms.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..f86572e9faffe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
[ ... ]
> +  wakeup-source: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +patternProperties:
[ ... ]
> +        required:
> +          - pins
> +          - function
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Looking at the required properties list in sii,s35390a.yaml, shouldn't
"#clock-cells" be included here to enforce the clock provider constraints?
By omitting it, the schema allows incomplete device tree nodes to pass
validation silently, which might cause drivers or dependent subsystems to
fail at runtime when they attempt to use the undocumented functionality.

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
Does this example node in sii,s35390a.yaml need to demonstrate the
"#clock-cells" property? If it is a required provider property, the
example should include it to properly pass dt_binding_check validation.

> +            pinctrl-0 =3D <&rtc_pins_default>;
> +            pinctrl-names =3D "default";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D1
