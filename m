Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240D581221;
	Wed,  9 Sep 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963837; cv=none; b=VcsGFXh0l4snudy3FxsAL7I9uu9zUmRBDWDc1sfKPcd/9L5uynCMixlw/+9GFZty/zlW/jAeYxqoAe0wR4KENLujn8Aw2EOUr8UEK106WswGCbF5u/Y6GkP+Qsd23RW+147Ch1973pJiDj0SeaMvi34Rd750rdCD6pFGLlrRa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963837; c=relaxed/simple;
	bh=4fKzO26/DXaoFcqRpKkVT4WzcAtUofxQPMhPWJLPH28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cdPavF+kHQFhvhoF2MYqu+qIflIYdLPBQMII57pOmumOeuAXr7Oao9qB3s7QVjBkulHNiLFepBZYuRErQY/dbk5a+LYRhdLOvj3Uc2DNNs21tEKbR4dcFR62fyiYlI10Bjo1Yjc5smPtb8yV+Uul4OxL7vBaEYfiQLTc7DoQ+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzVnvyIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzVnvyIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7B1F00A3D;
	Wed,  9 Sep 2026 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963835;
	bh=EwEJ+GRjqxejQfZU0Yavr7Ed90Mmv8ee9kgNW4K6QuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzVnvyIHim8yZzeRzjrax1IdyyFShOZio5ztGc7X+9e3xOldNzHV5BOnNFT9IahiR
	 T+bkYqv/9o6ShdKFSSz8VhFBe1CYaVGpjGQDMoKYDnXX6ddBTEM7hYpj+SJyRWoEfu
	 3E3ImNYpY7Rxu7e6lOM6dZHmtQ8QUAJMZCceRC/J+rPD+Ra78EjtY86QX9TP/ivx87
	 CJf1NyEhRu/FxYhkfQsXWUShqiYrz0plfOXjaaIgnTNwCGHQoUTmtK//atUG42L6yC
	 smDugRXyqf3b7LkEEc3ejcpn/RY3O2VllgCxMfVTCT8+5LuK3qw5/gWzRebYKRCZoo
	 bbstVPCATVwlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260909141300.1368790-2-sander.speetjens@gmail.com>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:23:55 +0000
Message-Id: <20260909142355.73A7B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The binding introduces a custom, un-prefixed `trickle-charge-mic=
rovolt` property instead of using the standard `trickle-voltage-millivolt` =
property, and fails to reference the common RTC schema.
- [Low] The YAML filename does not match the primary compatible string it d=
efines.
- [Low] Spelling errors in the commit message.
--

commit 425dd29b0a89a2c3ccab5825c325cf7042fb52e4
Author: Sander Speetjens <sander.speetjens@gmail.com>

dt-bindings: rtc: Add Raspberry Pi 5 RTC binding

This commit adds device tree bindings for the Raspberry Pi 5 RTC, which is
located in a custom DA9091 PMIC and accessed through the firmware mailbox
interface.

> Add device tree bindings for the Raspberry Pi 5 RTC.
> Located in a custom DA9091 PMIC and accesed trough the firmware mailbox.

[Severity: Low]
This isn't a bug, but there are spelling mistakes in the commit message.
"accesed trough" should be "accessed through".

> diff --git a/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.ya=
ml b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> new file mode 100644
> index 0000000000000..93430048355a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> @@ -0,0 +1,48 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: raspberrypi,rpi-rtc

[Severity: Low]
Does this compatible string intentionally differ from the filename? The YAML
filename (raspberrypi,rtc-rpi.yaml) does not match the defined primary
compatible string (raspberrypi,rpi-rtc), which goes against standard binding
naming conventions.

> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the Raspberry Pi firmware device.
> +
> +  trickle-charge-microvolt:
> +    description:
> +      RTC backup battery trickle-charge voltage. A value of 0 disables
> +      trickle charging.

[Severity: Medium]
Should this property use the standard trickle-voltage-millivolt property
name instead? If a custom property is strictly required here, shouldn't it
have a vendor prefix?

[ ... ]

> +required:
> +  - compatible
> +  - firmware
> +
> +additionalProperties: false

[Severity: Medium]
Should this binding reference the common RTC schema? Setting
additionalProperties: false without including an $ref to rtc.yaml# will
strictly reject generic RTC properties. Any device tree developer attempting
to use standard RTC properties (like wakeup-source) on this node will
encounter schema validation failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909141300.1368=
790-1-sander.speetjens@gmail.com?part=3D1
