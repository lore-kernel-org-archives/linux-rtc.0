Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496A3ECBE5;
	Thu,  3 Sep 2026 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428118; cv=none; b=mXjMhwbNqQ74ancpjkTcXML8xXkYs9vmTm+LoxC435HgOtWyqAOG2Zw9lLXJWlCM7gBpmkM6Wyb7M58h9DvVvMuU8SOgvBfVmWq8GQ5uP5RTgvbhjJNmiqecT0GZsoSfV5xbMpLUoWx1APIECtMYRNJcqCeQ31if4SQc6X5KmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428118; c=relaxed/simple;
	bh=1pAFp0CsNyg9TAuh/LqWDr7GMY++gjQpVaVi0spcReA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9UZOf9A3m3DWn+wGiuvWPw+/cKN/WVkXLrxCwM61b5E18eEq8D1v/A5Pn6DpGtNQxIuh+wKI5LbvNnw8kUg5NJJWC7RxydV9CMna8PMAtc2+EwseGUVNg9m7Fr1Weg7e+9jsCSW+aH5U3OjKqZEylGlm8Ome80BLo+snXfpko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU/t6hzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU/t6hzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395BD1F00A3A;
	Thu,  3 Sep 2026 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428116;
	bh=e4MqcvwfSek3Uh8sK+hGYqBTyKKqy+6qL3osBo5IZyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UU/t6hzXnpRkQcrdXubrgSCptBhgXKgc89Lf2kykuVir48C9US3P0/7/+W3SyGe9F
	 IuuOBgoZ9R7nnsAoZwEhUOl9EcPWoytwnsR3RiwbPF1jU5ktFY96+nW9Y0XkSuuXFG
	 mpzijgIMLDeVkWyNJEtCTy44Vdus/P/9ijSfI4fQ78cA9/xQZQP1Al6J5FpLSh7ovK
	 89UDuaUaGDz6s7vrJ99mheOY7p5AqB/6ALgb/2nfqZH+nrkY3l2OkBH0P1Da8Ysjxl
	 eHwn2hZ1FFoiK9m5DNAlzM4Q7SA8YcxHcta3NLNnhTRYk57DqCR9JmjeuOFOR8sdkk
	 mSYpT7YQ5zVgA==
Date: Thu, 3 Sep 2026 11:35:13 +0200
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
Message-ID: <20260903-honest-pink-poodle-a3f64a@quoll>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
 <20260901-proud-furious-bison-0edeec@quoll>
 <c4b9b6c6033774a02be50cf07a6729a6b1e9e5ba.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4b9b6c6033774a02be50cf07a6729a6b1e9e5ba.camel@posteo.de>

On Tue, Sep 01, 2026 at 01:28:36PM +0000, Markus Probst wrote:
> On Tue, 2026-09-01 at 12:05 +0200, Krzysztof Kozlowski wrote:
> > > +patternProperties:
> > > +  "^pins":
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    patternProperties:
> > > +      "-pins$":
> > > +        type: object
> > > +        additionalProperties: false
> > > +
> > > +        allOf:
> > > +          - $ref: /schemas/pinctrl/pinmux-node.yaml#
> > > +
> > > +        properties:
> > > +          pins:
> > > +            minItems: 1
> > > +            items:
> > > +              enum:
> > > +                - int1
> > > +                - int2
> > > +
> > > +          function:
> > > +            description: |
> > > +              Pin function:
> > > +              - ignore:  Preserve the previous state.
> > > +              - disable: Disable pin output.
> > > +              - wakeup:  Output wakes up the system.
> > > +              - clock:   Output clock pulse.
> > > +              - pmin1:   Minute periodical output with 50% duty.
> > > +              - pmin2:   Minute periodical output L for 7.81 ms.
> > > +                         Can only be used with pin int1.
> > > +            enum:
> > > +              - ignore
> > > +              - disable
> > > +              - wakeup
> > > +              - clock
> > > +              - pmin1
> > > +              - pmin2
> > > +
> > > +        required:
> > > +          - pins
> > > +          - function
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        rtc@30 {
> > > +            compatible = "sii,s35390a";
> > > +            reg = <0x30>;
> > > +            pinctrl-0 = <&rtc_pins_default>;
> > > +            pinctrl-names = "default";
> > > +
> > > +            wakeup-parent = <&int>;
> > 
> > I don't understand this need. Device does not generate interrupts - no
> > interrupts property - thus how can it wakeup?
> It is just an example.

But examplep should be complete and represent some real thing, not just
stiched random properties.

> 
> > 
> > As explained in commit msg, the signal at int1 goes to the SoC, right?
> I assume.
> 
> > So where does it go? To which pin of which device? &int?
> For my Synology DS923+ NAS, I do not have schematics. I only know for
> sure from source code that INT1 is used for wakeup and I can confirm
> that this does indeed wake the device up. 
> 
> > 
> > Can you show complete upstream DTS using this?
> There is arch/arm/boot/dts/ti/omap/am3517-som.dtsi, which has the pin
> output of INT1 routed to a gpio pin. INT2 isn't connected at all.
> According to the public schematic [1], this looks accurate.

And INT1 is part of the interrupts.

What I do not get, how this can wakeup anything without generating
an interrupt?

Best regards,
Krzysztof

