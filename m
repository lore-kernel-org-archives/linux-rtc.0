Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056644AB3CD;
	Wed, 16 Sep 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574852; cv=none; b=EPNf3vyqQdiKyxzYouUKRDNK+/WKW+6ymo3AJ+vZFQYGCui28fq8INCXCCI27L5oz17Hf2P/dFKxdD0EkIrr8L4xK6Aorb/BTjRTZpZDMpZjR+1kHvIDSpo+yhMZtFpzztczBecT8PVs9peuTdbYW2nCw8mPz+N+riBoSzX91Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574852; c=relaxed/simple;
	bh=aGzuLYPDCpXK0M5HfGSJxNfFipimzq4mYLNze+ilki8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OjYdzFPPRbZtAUo2VvWSI/tcKPB0CefSji7cEk7jnu8S/clPoZUhCF3Bof9o9ZFvq0cyFvXxgwYijf7LWX1Kr3RKDYi/CYn3DxfUDkZ3pcLctUJYJkEd9GQ8uIaly0FGaxQEdYEBprPkRgkGkApX/Z1Va7ZoWYB9jp3u8evgLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmI4FiQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmI4FiQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578441F0089C;
	Wed, 16 Sep 2026 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574850;
	bh=l6UMESz1jbAJCven7/MHBVmDoywo/JuZk2FkkYPxzJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmI4FiQRE84aQvf8JtfzvVpzWaJi84xS/5L4+iHjlGfSVxMaj2Omxlx+N+p8y5MFm
	 dGB343MoARYULmYXQOnFCjy7nOYR5guNHK3BeiznaWfo6opn84C5H86VBbHaovzZrC
	 gW/jRzZLz1pYNhOF2JdvzO718A3oTZKDcdGrKa197SSmrTQogWG/7vc5rzylpgkcEQ
	 V16NkCMTHXMLe7ltnuH+JCtaVU6lgBwTePilI6JnE2e9uIsCy/qPhzguHxmat49AQL
	 tdvX7+TDrs+6ivvklueqVLITCrEgjEnQ3cXSvmhml9WbTVzILO1clTCpzL6vnZ4LfH
	 bRxgjORc8iXVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916-rtc_s35390a_int1-v9-1-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-1-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:07:29 +0000
Message-Id: <20260916160730.578441F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing #clock-cells in required list
- [Medium] dt-bindings: undocumented clock provider capability
- [Medium] dt-bindings: missing constraint for pmin2 pin function
--

commit ee787a668e377f31a7722c1acf8927b88011aa60
Author: Markus Probst <markus.probst@posteo.de>
Subject: dt-bindings: rtc: Add pinctrl for S35390A

This commit moves the devicetree bindings for the S-35390A RTC into its own
schema file. It adds the necessary properties to configure individual pins =
via
pinctrl, allowing the interrupt signal to be used for a wakeup alarm.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..f3bf5900fb3ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,121 @@

[ ... ]

> +  wakeup-parent: true
> +
> +  wakeup-source: true
> +
> +  "#clock-cells":
> +    const: 1

[Severity: Medium]
The commit message states the change adds pinctrl to allow the interrupt
signal 1 to be used for a wakeup alarm. However, the schema also introduces
"#clock-cells" and a "clock" output pin function.

Does this introduce a significant undocumented capability (clock provider
functionality) which is unstated in the commit description?

[ ... ]

> +          function:
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
The description for the "pmin2" function explicitly states it can only be u=
sed
with pin int1.

Because there is no conditional allOf/if/then block at the pinmux node level
linking them, will a device tree incorrectly using pins =3D "int2"; functio=
n =3D
"pmin2"; silently pass schema validation despite being an invalid hardware
configuration?

[ ... ]

> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
According to the dt-bindings subsystem rules, when hardware gains new provi=
der
capabilities, the corresponding standard properties must be added to the
required list with appropriate constraints.

Should "#clock-cells" be added to this required list to prevent incomplete
device tree nodes from silently passing schema validation?

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

[Severity: Medium]
According to the dt-bindings subsystem rules, when hardware gains new provi=
der
capabilities, the corresponding standard properties must appear in the exam=
ples.

Should the example device tree node be updated to include the required
"#clock-cells" property?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D1
