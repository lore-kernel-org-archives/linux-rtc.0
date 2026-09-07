Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFB1A0BF3;
	Mon,  7 Sep 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776868; cv=none; b=tNx6PMRHbOxNpz1gn3KJBXNjKq1Nh6wncuIDwdAQQzZHblxLCIpnIslncTaCulo8CO+c8sogHxLsx2EhKbGgtbGFkldvMwURJo21BaeHaS52/LsuliFT0yEOdfnWTHXMfzf/XYS9v1xuLbDmuz6L0MikB5S81FeuIFxrBucSzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776868; c=relaxed/simple;
	bh=qgl+yjvUNLL/715upv9dM4TShFO11QdkEfrSODuAr3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQbfTps9IgYv7XOLkgpW2msdFrxTlO2BAnYwBc4mFRrVnQD3U6I5SWgS49U/M3/7DhDGXvjKJNbxl8Krdbm3roIp6nTiyhk7IHvBMHyoh2PDFrrotmBwRtmByweNVkZ2BkCjMRriX4yKx8owm4priRTfDsC7/Uint8+Ohg6s3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uuu4hdD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uuu4hdD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE57B1F00A3A;
	Mon,  7 Sep 2026 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776866;
	bh=3tScB/oAm06B65a86LyfwiEaJUuRShfZDr8vdKh5hKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uuu4hdD8Q6UZ2sdskRsEVki2nylRyySnFGsUns2VO+j2RdKwpF9YiUsN2+eb7Gc7E
	 ea9QWSIJENFnpgoAldvDNyg/PkWlJ/hZfIgJKDTjdFh1qz9dHCRGr7jZdl4Liyi9cI
	 lZbVA7mOiBm6ZHnTMYRuR5XF7aGUDxc/kD202gmozbL7y5OH8LNb7KFfn+iQZ6+oPL
	 dT4s988cLLxWzEjTy1mF6bBtmGd6BBF65IsInXxYbImLpm5rV/L53TAkgMl9ZqI+F5
	 M78TQRv6CngqXKgW8rzM7RTQEJb21KxT9LZioUsbdO2Bb4oVpz2UZTjFbiIOXP9+ap
	 Akg1zOp62STZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: rtc: Add pcf85053 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260907102134.394717-1-lakshay.piplani@nxp.com>
References: <20260907102134.394717-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:27:45 +0000
Message-Id: <20260907102745.EE57B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The device tree binding defines `#clock-cells` but fails to incl=
ude it in the `required` list and `examples` section, violating subsystem g=
uidelines for provider capabilities.
--

commit b13d4a07a31d804f2eb400ecaefe4d209dc9b4ea
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

dt-bindings: rtc: Add pcf85053 support

This commit introduces the device tree bindings for the NXP PCF85053 RTC
chip. It defines properties like multi-host interface roles and provides
examples for both single and dual-host configurations.

> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml b/Do=
cumentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pcf85053

[ ... ]

> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - nxp,interface

[Severity: Medium]
Since the binding defines #clock-cells for clock provider capabilities, sho=
uld
it also be included in this required list?

If #clock-cells is omitted from the required list, incomplete device tree
nodes missing this property will silently pass schema validation. Dependent
subsystems could then fail at runtime when attempting to use the missing
functionality.

[ ... ]

> +examples:
> +  # Single host example.
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      rtc@6f {
> +        compatible =3D "nxp,pcf85053";
> +        reg =3D <0x6f>;

[Severity: Medium]
If #clock-cells is made required, will this example also need to be updated=
 to
include #clock-cells =3D <0>; so that it passes dt_binding_check?

> +        nxp,interface =3D "primary";
> +        nxp,write-access;
> +        interrupt-parent =3D <&gpio2>;
> +        interrupts =3D <3 IRQ_TYPE_EDGE_FALLING>;
> +      };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907102134.3947=
17-1-lakshay.piplani@nxp.com?part=3D1
