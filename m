Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8B41D20E;
	Fri, 24 Jul 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885183; cv=none; b=MAbo6MZMT6zTQIAmvIBqxbjBKuVNPvZaxcgjat3LW17YC2MoewN7MgpaM97CC105TqY0ZVoq7CtHfm5odYNWVJunzytvPtEb5wAJnAwyN16WrGVSlKq5czKM3dhG46wbL5H/XqelJXvlfp0h42CWepeDvtmjYIVo/G0Rrd//sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885183; c=relaxed/simple;
	bh=YHDEU0sCn5sv5ZLLRITsCwaYF4WVXeaOC8u/ncuhpRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7XFP9gQKmyfoo1ezy/D8/S5ncWnRW/M/rmeBfFNU37yqF3vfLpGYTfhnSIKbexFGY1QZInITuWhKowPtcbD47P38c+c+GM3XQugFKUOBYBts0gXRKYbgXsspwJ4oLqXTtRD6lwoQ5MrnTg6eThLNTLiOtgbmQNCe5N2To8NQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUUxbupp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUUxbupp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DA91F000E9;
	Fri, 24 Jul 2026 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885177;
	bh=rVkQWJdxeGEXUoFmYL6K47M7buUaWNJirjSNuJEvmXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUUxbuppcCRNX9Q5x9y4pYQnmPIOYn/cvSjwoORjb33bquDzGZxumneNdHPax1VXX
	 Ijd6a+4mdZbSUfqstTZgPf3R2QsIRA3yJYHuuJE+cWlc6D7xRsSqvcdUrk6hqr46GJ
	 czgKr6m05JnpvfTJAnsKV3D3MTEkPxJuqZRIzADzIJqjvTSq9jjL59jkfoYtjTepCy
	 Kb5RSFCApOD+j0BCVDdh/LwV08OTvATRM1igcyAGe1c5nnPXNB2uHPb3AXu1anuI8r
	 adyEz/smgDiE5/LjiC7pvZSrgNa3n6NLFpipIdlpV1opzIW9r8QqfGvyfSjzZcwKsC
	 sEW2m9BT3d8TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260724-ti-omap-rtc-v1-3-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
 <20260724-ti-omap-rtc-v1-3-ffef78853cd6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:26:16 +0000
Message-Id: <20260724092617.22DA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The legacy text binding file `rtc-omap.txt` was not removed during =
the conversion to the new YAML DT schema.
- [Low] The schema unconditionally allows `system-power-controller` and `ex=
t-wakeup` properties for all hardware variants, lacking required conditiona=
l constraints.
--

--- Patch [3]: [PATCH 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT sch=
ema ---
commit d0c7ea3e6873301494678b3cfd1db8646ed9ff66
Author: Bhargav Joshi <j.bhargav.u@gmail.com>

dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

> diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Doc=
umentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
> new file mode 100644
> index 0000000000000..eeea1bab65309
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml

[Severity: Low]
Should this conversion also delete the legacy text binding? It appears
Documentation/devicetree/bindings/rtc/rtc-omap.txt was left in the tree,
which leaves duplicate binding documentation.

> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

[ ... ]

> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  system-power-controller:
> +    type: boolean
> +    description:
> +      Indicates that this RTC controls system power via the pmic_power_e=
n pin.

[Severity: Low]
Does this schema unconditionally allow system-power-controller for all
hardware variants?

For instance, the ti,da830-rtc variant doesn't appear to support PMIC mode.
Should there be an allOf / if-then block restricting this property to
ti,am3352-rtc and ti,am4372-rtc?

[ ... ]

> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Name of the hwmod associated with the RTC.
> +    const: rtc
> +    deprecated: true
> +
> +patternProperties:
> +  "^ext-wakeup(-[0-9]+)?$":
> +    type: object
> +
> +    description:
> +      Child node describing external wakeup pin configuration.

[Severity: Low]
Similar to the system-power-controller property, should this subnode also be
restricted to variants that support it?=20

Without an allOf / if-then block, it seems device trees configured with
ext-wakeup for older hardware like ti,da830-rtc will silently pass schema
validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-ti-omap-rt=
c-v1-0-ffef78853cd6@gmail.com?part=3D3
