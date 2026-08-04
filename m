Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93847ACF3;
	Tue,  4 Aug 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864620; cv=none; b=jEgv1XGWhY7km218EpuGDo0CtdelRQKv7wBzFR7zhjmi46+ND978DXaPTOMvOpm+AUFFqZD5xIKssqf/qDNzQkNmjGKQdc7qOaRj6p4Fo1xJJHFvoYiUR4XSMkNT0g6ZMiYCWJ1HA4Dj8s3YBsCMsThZconFuTUOXuOaDrd1Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864620; c=relaxed/simple;
	bh=Mfny0JiST4R9Ow5iXhf32QfhUpinnQlAH5LIParCe/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oEAvufnshCPJcKJWaNoZJ85BRx6dMs5H6fIn/5XgyNOphmEST+RN21Fgd1VtCyr2c+p2QlQiHRtrmVWKI95hpEjw2cp6FFHZr4lk3Wa2KiWf+mXDnuv2CYUZQZmTO4igijZZ38VQAHi1AW69s06kmlp9pwEa9HkkGCgCD0GE98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoaQIMkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoaQIMkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A501F000E9;
	Tue,  4 Aug 2026 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864618;
	bh=BAQHH67A42CkymJMFGbOdZWeVSRiv7mm5bsortsNozc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OoaQIMkjQkG3JMpps1llc7IxFYMrDbn2h2cid3/kD6fk+OxwTTPcBJlnBYiSwazkj
	 NwnTm/mFyVLe+KT/91563O0An+6vjgwK4wX4tXi+GYiV8Nl7mHXkzT6vWBcn9aBYf+
	 xeb6ufB5/Fs0IIY1hym5r4vr8x6EiW2zOANCRsrqR/Nu4UTPN4kSlgAcQby0KsaFUg
	 hYjVX+XRKct5XV5gfK0/C0I/MI6jTUhjQkNfh5zp/8+KVD/GBP1uASb/ITU8ozt4Z2
	 d88r7LR/0DzR1RmHpKlUQLDe0qmRjPZy9CLcd5sPSk+mVh0bDUCE4eeCqfxQ/aXaSR
	 Dy46hU9gVkj0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
 <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:30:18 +0000
Message-Id: <20260804173018.91A501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `pattern` constraint on `pins` is bypassed because it is applie=
d directly to an array property, rather than its items.
- [Low] The example contains an undefined label `ext_wakeup`, causing a dtc=
 compilation error.
--

--- Patch [4]: [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT =
schema ---
commit 37b8c1cde7af9ea6b7fed4b7f431ec999b775ef6
Author: Bhargav Joshi <j.bhargav.u@gmail.com>

dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

> diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Doc=
umentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
> new file mode 100644
> index 0000000000000..02b3c23cf4350
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
[ ... ]
> +patternProperties:
> +  "^ext-wakeup(-[0-9]+)?$":
> +    type: object
> +
> +    description:
> +      Child node describing external wakeup pin configuration.
> +
> +    properties:
> +      pins:
> +        pattern: '^ext_wakeup[0-3]$'

[Severity: Low]
Does this pattern constraint actually apply? Because pins is a string-array,
the pattern keyword directly on the property is ignored by the JSON schema
validator. It needs to be nested under items: { pattern: '^ext_wakeup[0-3]$=
' }
to validate the array elements.

[ ... ]
> +  - |
> +    rtc@0 {
> +        compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
> +        reg =3D <0x0 0x1000>;
> +        interrupts =3D <75>, <76>;
> +        system-power-controller;
> +        clocks =3D <&clk_32k_rtc>, <&clk_32768_ck>;
> +        clock-names =3D "ext-clk", "int-clk";
> +
> +        pinctrl-0 =3D <&ext_wakeup>;
> +        pinctrl-names =3D "default";
> +
> +        ext-wakeup {
> +            pins =3D "ext_wakeup0";

[Severity: Low]
Will this example compile with dtc? The pinctrl-0 property references
<&ext_wakeup>, but the ext-wakeup subnode here is missing the ext_wakeup:
label that was present in the legacy text binding, which will cause a dtc
compilation error.

> +            input-enable;
> +            ti,active-high;
> +        };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-ti-omap-rt=
c-v3-0-ba3bbd8af570@gmail.com?part=3D4
