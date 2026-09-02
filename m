Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A7449B37;
	Wed,  2 Sep 2026 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392614; cv=none; b=X3OXxeMSkq4Kdw23IvaRhmxUK+rHzqNsIX5U9szl77ylKRb4vStrQ7qqWamTF142JzRvDiUE6GfZUzANs6jiWvcKhTzD2k/vAJfCQZXjN9eTEFPUr/NwnWVGrtYL4z+VK3SR5DcfDOCf37iRVEPUGGgcv/3tVUD4VCx8ZuQC2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392614; c=relaxed/simple;
	bh=44iS9n1vi6cCGJLNwLORWF0hm9jKH9Abl5XSP34RziM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMCV3DCGeEBhVCK/PCFVGuHImU7IHyfBLfWTDF6eaN+qZPyIwiQI7VyKVXXsd3uh36Y79tv4v2NlAiQfSzL23p5JfZlRy/XT1+PxrsoCiOaCr0+8HH1j3Li9k9IJnYNUkFzPBiWE2ush79rUoOhGxkSeyRGEP7o3jPLr4nz1/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLHvojR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLHvojR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD321F000E9;
	Wed,  2 Sep 2026 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392610;
	bh=gMkgeZNIDmwFAT56Kno/LIy+gJsM92PD2UmdEOa5dHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLHvojR8gmKGDU7YzH44FGfNXXAHTHuC8rEYuhoCdFc9hx07qZ3akadQAWc3nizbU
	 cv1BfE+SHMmtNiJ15vc/MWGebpPBhvPbGAJhosaZK70CkhOfVvyGsvYY2Ka4jISIUA
	 tNdqnFtLbzfc7yvL5KYKR0JnhW9g7V7jaUPta/j8xK5/zx9+BzPnFtZHxG0LCtZLPV
	 fosyRH4ZmTeYHEv0MQiWzAqVnmMvId+ckvRe3vx+6G/qskNM/MUD87gX7sGQ84IviV
	 yuaP59tOsvN02BwzokT9NZ6rmeeJMOX3tMOEtq5h4En48PRHm+xf/XqC1e+QgkMe1j
	 rF3vKEwgG2fAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: maxim-ds1302: Convert to dt schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sudheendra Sampath" <giveback4fun@gmail.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260902233550.947218-1-giveback4fun@gmail.com>
References: <20260902233550.947218-1-giveback4fun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:43:29 +0000
Message-Id: <20260902234330.5CD321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `spi-max-frequency` property is improperly constrained using=
 an `enum` instead of a `maximum` bound.
- [Medium] Missing `$ref` inclusions for common RTC and SPI properties, com=
bined with the restrictive use of `additionalProperties: false`.
- [Medium] The `spi-cs-high` property is improperly set as unconditionally =
required, preventing validation of valid hardware inversions.
- [Low] The examples use non-standard SPI controller node names (`spi1` and=
 `spi2`), which bypasses core SPI validation.
--

commit e10f1c2655e1a3223d9a66b7e63edd49395f0177
Author: Sudheendra Sampath <giveback4fun@gmail.com>

dt-bindings: maxim-ds1302: Convert to dt schema

This commit converts the Maxim DS1302 real-time clock binding from a plain =
text
document to the YAML DT schema format.

> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Do=
cumentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> new file mode 100644
> index 0000000000000..3e6264464e109
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
[ ... ]
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Maximum SPI clocking speed in Hz.
> +    enum:
> +      - 500000
> +      - 2000000

[Severity: Medium]
Does this enum restrict the property too tightly? The spi-max-frequency
property typically specifies the maximum limit the controller should use, n=
ot a
discrete set of allowed frequencies.=20

Device trees specifying valid intermediate or lower maximum SPI frequencies
(e.g., 1000000 Hz or 200000 Hz) will fail schema validation. Should this us=
e a
maximum bound instead?

> +
> +  spi-3wire: true
> +
> +  spi-lsb-first: true
> +
> +  spi-cs-high: true

[Severity: Medium]
Does defining these standard SPI properties as just true bypass their robust
type validation from the central SPI schema? This schema appears to be miss=
ing
$ref inclusions for common RTC and SPI properties (like
spi-peripheral-props.yaml# and rtc.yaml#).

[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-3wire
> +  - spi-lsb-first
> +  - spi-cs-high

[Severity: Medium]
Does making spi-cs-high unconditionally required prevent validation of boar=
ds
with inverted chip select hardware?=20

The original text binding explicitly stated this property is required "unle=
ss
inverted in hardware". Forcing it here would cause valid configurations with
active-low chip selects to fail validation.

> +
> +additionalProperties: false

[Severity: Medium]
Does using additionalProperties: false without the required subsystem $refs
inappropriately reject valid common properties?=20

Standard SPI and RTC properties (such as wakeup-source, spi-cpol, or spi-cp=
ha)
will be strictly forbidden, causing valid real-world device trees using the=
se
properties to fail validation. Should this be unevaluatedProperties: false
alongside the missing $refs?

> +
> +examples:
> +  - |
> +    spi1 {

[Severity: Low]
Does this non-standard node name (spi1) bypass core SPI validation?=20

The core SPI controller schema (spi-controller.yaml) matches node names usi=
ng
the pattern ^spi(@.*|-([0-9]|[1-9][0-9]+))?$. Using spi1 skips core SPI
validation for the example nodes, potentially masking invalid SPI property
usage in the example.

> +        #address-cells =3D <1>;
[ ... ]
> +  - |
> +    spi2 {

[Severity: Low]
Does this node name also bypass core SPI validation? Similarly to the first
example, spi2 will not match the SPI controller schema node name pattern.

> +        #address-cells =3D <1>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902233550.9472=
18-1-giveback4fun@gmail.com?part=3D1
