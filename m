Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD277333730;
	Wed,  9 Sep 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968844; cv=none; b=NNYL2nlvMO2JQsqznyB2Wb6j36Nxp2fbAA3Qqeh5I8jSKjdoQNsfEid68ESNVILIoLsuPa467AbjPqB7y0BzqNiuTfTjxALVNLZOt+uoiKpP+3u04YpqiDzIQ/I6xCNUSL7TFrM49zcO1KBt6e92UsXflxKDGxm4kYoIH4HJbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968844; c=relaxed/simple;
	bh=Lmpxt2DgHMmZ314xE4SydvV+vhJV7LS3vLTiDsnCKkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iM2WtbTw/dvANJfpr7aZJOsUbQOoiw/VIdWBsca5FLesD0z3FjW8uE1SMw43WxwYprLcCsuqLsGqVU0Ppzei/iDSimTPYHhefOwmY1hf3J2E4Cj+4w1A4dyouV95IsXV/J4dOpQqWL1WKKphMO6Efv5WjSZuPxUNt/bGE6zGltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDz6tRXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDz6tRXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25F1F00A3E;
	Wed,  9 Sep 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788968842;
	bh=ndQgKoNP+6jHjM+F1z0rnrfMrkxtCKJrB6NamAMcBDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EDz6tRXarPlyAfYlmhn7iGZ4IB2+T3nMMKZjM++ScEDoSIedQd9uAGsgWFI4iGuPx
	 PqkAFJpKAKCDqYI86HaLN4SVAO5KS8at3r8vKqnRdqSMgKl58JGfNTKhOJB5iyZVKE
	 FoBPBmTzABRw/uUF5NXprsrrL923Al6SRzFfig3/qLwBiTg1oRBmWMAB1Ba2uRHmIf
	 LLUX+vaIV6T5DJHjxzF0+ayixoQyhuqtHPuGY88sW35IPreaGrmqRuCBQqMbZUxWHG
	 c7+MoOhv593RPGDC2tRcPVl2ZvFvf8Z1VzMIBWZBUDGqlsRykwTqcNUvRYzlQvXKmd
	 deyzAXdoygGyA==
Message-ID: <4c237cd8-024f-405e-a00e-e22ff9529d08@kernel.org>
Date: Wed, 9 Sep 2026 17:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
To: Sander Speetjens <sander.speetjens@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260909141300.1368790-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2026 16:12, Sander Speetjens wrote:
> Add device tree bindings for the Raspberry Pi 5 RTC.
> Located in a custom DA9091 PMIC and accesed trough the firmware mailbox.
> 
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> Assisted-by: Grok

Your tag is the last one.

> ---
>  .../bindings/rtc/raspberrypi,rtc-rpi.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> new file mode 100644
> index 000000000000..e9bade7f8c91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +

There is no blank line here.

Please instruct your Grok to follow existing sources, not come with
whatever it wants.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/raspberrypi,rtc-rpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi firmware RTC
> +
> +maintainers:
> +  - Jonathan Bell <jonathan@raspberrypi.com>
> +
> +description: |
> +  Raspberry Pi RTC from the DA9091 accessed through the Raspberry Pi firmware
> +  property interface.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rpi-rtc
> +
> +  firmware:

There is no such generic property. You need vendor prefix. Wasn't this
already discussed for Rpi? I feel like every time contributors send
downstream DTS ignoring what was discussed upstream.


> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the Raspberry Pi firmware device.

You said nothing more than property name and type. Explain what for.

> +
> +  trickle-charge-microvolt:
> +    description:
> +      RTC backup battery trickle-charge voltage. A value of 0 disables
> +      trickle charging.
> +    anyOf:
> +      - const: 0
> +      - minimum: 1300000
> +        maximum: 4400000
> +
> +required:
> +  - compatible
> +  - firmware
> +

Missing ref to rtc.

Honestly, at this point you clearly did not take existing bindings at
your starting point.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc {
> +        compatible = "raspberrypi,rpi-rtc";
> +        firmware = <&firmware>;
> +        status = "okay";

Nope. Again, take existing bindings. This looks like LLM slop.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23



> +        trickle-charge-microvolt = <0>;
> +    };


Best regards,
Krzysztof
