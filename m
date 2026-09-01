Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F641DE08;
	Tue,  1 Sep 2026 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257132; cv=none; b=X+ktUD4diru1OhQn0ADbUMN5TyHuH7RL46qCfm8ZsrNVz51jQbLvhvq+L4Jzu6r2Y+xA8gF+txYv+phRdQhtLzr9DlcLNlhNQaiBSDRx6RfhOv4xaxj4aWA3+JgNIxIbV3ZnuxvB1jwBW9LUXpldaXoTFctLdadhoQszlHUCSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257132; c=relaxed/simple;
	bh=7+m+iuaplCMK2WRosgxc4zd1kWJKHb1IDiwZ8radkV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toRmQvQ2E3zzviAgGptLPjT0pEHJe6ferFJeB2bhJnPuJZm5cPhJEqCp0c9Gx/5j/obPbOlZ2O/U2bo03N+aHYKVNQOsIa6y7cuWDm2N34/DGmmJ1WubkgChYsn30rdnlwbUq28ZWXnZFxun1z6Mdg171NdzXbiz63P/5AMmdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD0xZAu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD0xZAu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8C1F000E9;
	Tue,  1 Sep 2026 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788257130;
	bh=G16mJgiGGsS4pp8GycAQb1G+YaBLkP+xLI1RpKwUZGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SD0xZAu77WmakhKvsElwMocYyHV5VONv5alRC0gmvFAt65Z1kw7pNLGkzYgTgLTJi
	 Dc022miruNpzUJqtHq6YlgTiRSKg8X6ty59O5GagI/lIOUbZuWEkE2nKbMh9SUgTsQ
	 Vx+cyZYI5TJ7brZpjMDdPUV5FqytTgj8IL8p18jr0SGl3fEIImCG3FIFlSqTZmurX9
	 RC/QckIOjqfRG3wsTxM5QtscJmq/Nrh2zrO40ubwOV5/0AZQsjhREEQkL94xQHYlUI
	 GoLn+pWWZYrFnR6tIHoT3qLwnyagHQjPj+OB9QZdytZgtWS2SofvlIV86k43akrxZc
	 i+pMj7+fEuAqA==
Date: Tue, 1 Sep 2026 12:05:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Michael Langer <michael.brainbug.langer@googlemail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Message-ID: <20260901-proud-furious-bison-0edeec@quoll>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>

On Mon, Aug 31, 2026 at 05:42:22PM +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
> 
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 117 +++++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
>  2 files changed, 117 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 000000000000..dfe632c4b2c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: S-35390A 2-WIRE REAL-TIME CLOCK
> +
> +maintainers:
> +  - Markus Probst <markus.probst@posteo.de>
> +
> +description:
> +  The S-35390A is a CMOS 2-wire real-time clock IC which operates with the
> +  very low current consumption in the wide range of operation voltage.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: sii,s35390a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: Supports up to 2 interrupt lines via the INT1 and INT2 pins.
> +
> +  interrupt-names:
> +    items:
> +      - const: int1
> +      - const: int2
> +
> +  wakeup-parent: true
> +
> +  wakeup-source: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^pins":
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      "-pins$":
> +        type: object
> +        additionalProperties: false
> +
> +        allOf:
> +          - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +
> +        properties:
> +          pins:
> +            minItems: 1
> +            items:
> +              enum:
> +                - int1
> +                - int2
> +
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
> +
> +        required:
> +          - pins
> +          - function
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@30 {
> +            compatible = "sii,s35390a";
> +            reg = <0x30>;
> +            pinctrl-0 = <&rtc_pins_default>;
> +            pinctrl-names = "default";
> +
> +            wakeup-parent = <&int>;

I don't understand this need. Device does not generate interrupts - no
interrupts property - thus how can it wakeup?

As explained in commit msg, the signal at int1 goes to the SoC, right?
So where does it go? To which pin of which device? &int?

Can you show complete upstream DTS using this?


Best regards,
Krzysztof

