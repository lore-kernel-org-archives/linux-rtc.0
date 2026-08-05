Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C23D5C1D;
	Wed,  5 Aug 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961315; cv=none; b=EoXcfGlb+5rndHE7lNTeRCdWLham3/Wt9eSSsbJrYHurFBxhitbhDvS4NuRJu0MLL+nETNRxfbCC+RJ4YygWW2/5iU4rtbHoi9BaePNi7/wz7PGf8OKQMr7Km6KDBCIWhbPWj119oY1BuB2pZ33ueshQGcT5Q6sCiJRooPGVbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961315; c=relaxed/simple;
	bh=8Mfxap5lqW7Ju3VkSEBr+nvsS4Ro6CGI8Oqmyd35DX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGVEiLKLiYwkvj9oTQFCnUtAgF7Grj1rKllf+D0rq00HXEMKsTY+4xwbyTdqYzaeThANVYxAD+ctFqKes/nKNKbr6ofhaxCvizcc6z8ecd49QJMffLdBS4/unl0CllkDn+jhe+ZsZoo+lEkz1n/YirELiPh1nJ+tWqyfT1/ELko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvkC63W4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvkC63W4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0C11F000E9;
	Wed,  5 Aug 2026 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785961311;
	bh=52jgknewQ6XRcAl774U6I80F6j56uTFEuZ3fx2KjIyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvkC63W4hIY6HAGRDB57zVUPYIL1FDrKXpkQfT32jV/TxaLoXh26sG/9Mi6IWvo6t
	 /la2XXIa4xvyfm/hBPhurMxBDPdvDcLFJhdUqN0zww945fPysYq+m3nOGBqSXWwFNk
	 I4IeWvtPCi4ZW7xrk1Gg8d5559wa4YsLTjLYnx9I4JyK9IQCSUY7EdcS59Y6Hx8OEU
	 jSob0hhZCm9ORsslQ3Ghyhfoxnn5ttTuTcumc6uIrbCn8LltkXMa7rJxWTOUuxZJPN
	 tf+zkOQ7vlss7nZPuGV2yUxwgGGspUxnf/7dNAPCMHInbdhIHVSKV6iO8Aa5eMcBFC
	 xEQT2n++0kodA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:21:50 +0000
Message-Id: <20260805202151.3C0C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The schema describes a hardware constraint for the 'pmin2' funct=
ion but fails to enforce it programmatically in the YAML logic.
- [Medium] The patch makes an undocumented, unrelated modification to the M=
AINTAINERS file by adding a non-existent directory.
- [Medium] The pinctrl child node pattern `-pins$` requires the `function` =
property but omits the `pins` property from the `required` list.
--

--- Patch [1]: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A ---
commit 7fb91877359a278935b0893edcef6e5ae7d9c6a2
Author: Markus Probst <markus.probst@posteo.de>

    dt-bindings: rtc: Add pinctrl for S35390A
   =20
    Synology NAS devices use the output pin for interrupt signal 1 to wake =
up
    the system. Move devicetree bindings for sii,s35390a into its own file.
    Add necessary properties to configure the individual pins via pinctrl,
    which allows the interrupt signal 1 to be used for wakeup alarm.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..0355f17f233a3
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

[Severity: Medium]
Could this hardware constraint be enforced programmatically in the YAML sch=
ema?

As currently written, a device tree specifying function =3D "pmin2" for=20
pins =3D "int2" would silently pass dt_binding_check validation despite vio=
lating=20
the documented hardware constraints. Should this be enforced using conditio=
nal=20
schema logic?

> +            enum:
> +              - ignore
> +              - disable
> +              - wakeup
> +              - clock
> +              - pmin1
> +              - pmin2
> +
> +        required:
> +          - function

[Severity: Medium]
Should the pins property also be required here?

If a developer creates a pinmux child node specifying a function but omits =
the=20
mandatory pins identifier, the incomplete node will silently pass=20
dt_binding_check validation but fail to configure the hardware correctly in=
=20
the driver.

> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
[ ... ]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a99..46a19a0873e06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22690,6 +22690,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
git/abelloni/linux.git
>  F:	Documentation/admin-guide/rtc.rst
>  F:	Documentation/devicetree/bindings/rtc/
>  F:	drivers/rtc/
> +F:	include/dt-bindings/rtc/

[Severity: Medium]
Is this addition to the MAINTAINERS file intentional?

This introduces an undocumented and unrelated modification adding a directo=
ry=20
that does not actually exist in the kernel tree, which may cause maintainer=
=20
scripts to fail or behave unexpectedly.

>  F:	include/linux/rtc.h
>  F:	include/linux/rtc/
>  F:	include/uapi/linux/rtc.h

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rtc_s35390=
a_int1-v3-0-e836faba3e25@posteo.de?part=3D1
