Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819435A5131;
	Tue,  8 Sep 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894384; cv=none; b=Ch5C2eQiM1/DxGp6HAIJ7IwmTm81H0mAOp/Gir0bTfmGuvgDef9GEnW+EB7azMVmrCThYaZEnl/FmwNa8LEZjCO9AUXhrPI/OlOEBp1yN9C9gMI+tVZfysdCl5RjRsN8BfIeQUFjgID0xN8Mkr/MfzSsZgAkNWS5uuJvxuZ4EGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894384; c=relaxed/simple;
	bh=fViLGx/9MvVKD74qWjWa0+YbBrjhT8B0nMMeb53Z95E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIcQVJd/7JsrgvL7eT59NVe0USzGPZdJia6VICqaiuTqElH/o+oxLmQeXY9AFxTE0rz/K2CmwrkyAgob2+HLZkbqHBTF/H6QjVcEvU+qWop02ccc03ioKzn6pXuoMt/iGjL7Jd8XQ+IZiHzMA3o69HwKx+B2We075fi+mUzSfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP2UYmI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP2UYmI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FD61F00A3A;
	Tue,  8 Sep 2026 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788894383;
	bh=YIqTcSA+AXu0Tj9KdjRHU1rvVOzldf73AMr/cfV9FB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MP2UYmI/CWmr5D4BBqLozzvkc+oQf/cjgnqaZYMlUeH5VQF6M7PCb6804rvI5J1LN
	 9+CwAKwQ13EWsSUWQgPXRhQcX4cWVBYQJ0G926eb7wtH7ZWaiZkeNGIpm2TSr+fsdC
	 z/D9IDIiC0/mwrHl9tqJZEYCNKiILPrjjh1Xu7Gdp/bU78jFmknE8u8hmpi1ZwNjju
	 H3Vma5ZZUPiqyoiGVb/tT0paDhFunE04Gixt0vRN5iAC5MbCyf1DmASLaZ0814xuc7
	 0ZFsxPDDmjCGTy+RY/rr4tPSZhwhwCxhkzghSDo96i9YCuOpFd+mFBzSJwQy2ZStiY
	 RFIO8NE7caiog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 - dt-bindings: maxim-ds1302: Convert to dt schema v2]
  dt-bindings: maxim-ds1302: Convert to dt schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sudheendra Sampath" <giveback4fun@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260908190137.1168904-1-giveback4fun@gmail.com>
References: <20260908190137.1168904-1-giveback4fun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:06:22 +0000
Message-Id: <20260908190622.B6FD61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] spi-max-frequency is incorrectly restricted to an enum of exact =
values, preventing valid lower frequencies.
- [Medium] spi-cs-high is unconditionally required, breaking setups with in=
verted hardware CS.
- [Medium] The binding defines an SPI peripheral and RTC but fails to refer=
ence standard core schemas.
- [Low] The YAML conversion silently removes the device tree example sectio=
n.
--

commit 4b0cc4e2d5ae6befdb10a7457cde3f6698ee83c7
Author: Sudheendra Sampath <giveback4fun@gmail.com>

dt-bindings: maxim-ds1302: Convert to dt schema

This commit converts the Maxim DS1302 real-time clock text binding to the DT
schema format based on code review comments.

> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Do=
cumentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> new file mode 100644
> index 0000000000000..54a2fcf7f8e7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> @@ -0,0 +1,50 @@
[ ... ]
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: DS-1302 has 500 kHz if powered at 2.2V, and 2MHz if pow=
ered at 5V
> +    enum:
> +      - 500000
> +      - 2000000

[Severity: Medium]
Does this restrict spi-max-frequency too strictly? Schema validation might
fail for perfectly valid device trees that specify frequencies other than
500kHz or 2MHz (e.g., 250000) to ensure signal integrity.

Should this use a constraint like maximum: 2000000 rather than an exact enu=
m?

[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-3wire
> +  - spi-lsb-first
> +  - spi-cs-high

[Severity: Medium]
Will this unconditionally require spi-cs-high and break backwards
compatibility for existing setups?

The original text binding noted that this property is required unless inver=
ted
in hardware. Forcing it globally in the required list might reject legitima=
te
hardware configurations where the chip select is hardware-inverted.

> +
> +additionalProperties: false

[Severity: Medium]
Does additionalProperties: false incorrectly reject standard SPI peripheral
properties here?

If a device tree uses properties like spi-cs-setup-delay-ns or
spi-rx-delay-us, dt_binding_check will throw an error. Should the schema
include references to /schemas/spi/spi-peripheral-props.yaml# and rtc.yaml#,
and then use unevaluatedProperties: false instead to properly inherit stand=
ard
capabilities?

[Severity: Low]
Is the examples block missing from the end of the schema file?

The original text file included an example demonstrating node placement.
Without it, dt_binding_check cannot validate the schema against a concrete
instance, and the usage documentation is lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908190137.1168=
904-1-giveback4fun@gmail.com?part=3D1
