Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F140E8CA;
	Thu,  2 Jul 2026 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979523; cv=none; b=A2TKG9eMt+YUhg5kbbgNWuQCuNIF96kMpu6HfdtXsmqAiLHcm+5YlTVIkzoHNVNRUBtKksgbGonCzfwlPlD861YxwLrWD+iaPNLfX0DU1BQyALtEdgrwBXVDL8losjtR1E0rwKX2jIyP/z9tvSLqlwNHY5Pb3rf4pqHquHEI+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979523; c=relaxed/simple;
	bh=lIGdA+N87kLAaNftQNzuYOuWQ9CkU1HJ9/YY7IXJCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emgaPobzDDN1U1HPCHejxBVZpelphgHzhnKiGgCg5/YP0EBd+b0VV6lBhf2SBKAI58WcdhjHPWLPT0ULaAn1HOye1PK6nRaL92bvOEzQ8nDCUfid2qcrO0W0j8Ofj3EeORDD9FGQGktAytn/mxbQzMdZ1or0aSOdplJSVUwcppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egutJy/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egutJy/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8B1F000E9;
	Thu,  2 Jul 2026 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782979521;
	bh=huzjTih/oMQnqYJQsq5M5ph36hb9my807TEq3W+gvR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=egutJy/tPCJB8rJprKL8ATQYzX0Vz3cjGxj5lhnEo+wBXJXZKhhTRO0Z5+fgPQJ9p
	 0BZgC/L+K+sKJQfnl6eP2OtGyKgtn7YeuZhwgHW9K7W27Q3h3l3D3qskiHCbuRy4SF
	 pBGuSCIGRELz95fzPKRLKfyPkRsblEHoYXJwwgPvYykji3qg9UnLXkIhre9yFExij+
	 W4n52J9AU67/Fh7fwCpc6pY7i20w71q607iHKzEnnsAhl2hK+Wgn3pgMugKqHLnUy1
	 RIYAcd7hudTqnVhKkiK0H5E4SInwG9tSza9OL6X/+l2SGF6Ht2LGzUj6Ic2iID8DwG
	 HviFMshouuJ5A==
Date: Thu, 2 Jul 2026 10:05:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: mfd: ROHM BD73800 PMIC
Message-ID: <20260702-refreshing-terrific-tarsier-f56ada@quoll>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <3e700a3fa7872a96257ff25a77670ec05cfd239c.1782909323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e700a3fa7872a96257ff25a77670ec05cfd239c.1782909323.git.mazziesaccount@gmail.com>

On Wed, Jul 01, 2026 at 03:41:34PM +0300, Matti Vaittinen wrote:
> +description:
> +  BD73800GW is a single-chip power management IC for battery-powered
> +  portable devices. It integrates 8 buck converters, 4 LDOs and a current
> +  sense amplifier with ADC. Also included is a Real Time Clock (RTC) and a
> +  32.768 kHz clock gate. Depending on the OTP configuration the BD73800
> +  may also have interrupt controller and GPIOs.
> +
> +  There are also different variants called BD71851 and BD71885 which are
> +  almost identical from the software point of view.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rohm,bd73800
> +
> +      - items:
> +          - const: rohm,bd71851
> +          - const: rohm,bd73800
> +
> +      - items:
> +          - const: rohm,bd71885

items:
  - enum:
      -
      -
  - const: rohm,bd73800

> +          - const: rohm,bd73800
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  # The GPIO1, CLKOUT (GPIO2), FAULT_B and EXTEN_OUT pins can be
> +  # configured to interrupt pins by OTP.
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The IRQ number. 0 is GPIO1, 1 CLKOUT (GPIO2), 2 FAULT_B and 3 EXTEN_OUT.
> +      NOTE, A pin can operate as IRQ source only when the OTP
> +      configuration for it has been set to GPI.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +# The GPIO1, CLKOUT, FAULT_B and EXTEN_OUT pins may be configured for a

Missing two spaces (indent) before the comment, although this should be
put into description. I understand it applies to each description - it
is fine to add to the first one. Descriptions might be used to generate
user-friendly representation of bindings (PDF). Comments won't, so
comments are only to explain the binding/schema syntax choices.

> +# specific purpose (like ADC input, 32.768 clk output, fault indicator or
> +# delivering power sequence to a companion PMIC when multiple PMICs are
> +# used) - but also to be either a GPO or GPI. (When used as a GPI the pin
> +# can also be used as an IRQ source). The pin purpose is determined by
> +# OTP (One Time Programmable memory), typically during device manufacturing.
> +# The OTP can't be read at runtime so device-tree should describe the pins.
> +  rohm,pin-gpio1:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the GPIO1 pin has been set to GPI or GPO at manufacturing.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-clkout:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the CLKOUT pin has been set to GPI or GPO at manufacturing.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-fault-b:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the FAULT_B pin has been set to GPI or GPO at manufacturing.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-exten:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the EXTEN_OUT pin has been set to GPI or GPO at
> +      manufacturing.
> +    enum: [gpi, gpo]
> +
> +  # The CLKOUT pin may have its purpose overridden by OTP configuration. It is
> +  # possible the BD73800 does not output a clock signal. Hence the optional clk
> +  # properties.

Same here

items:
  - description: foo bar

> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    const: bd73800-32k-out

If this is fixed, then drop clock-output-names. Otherwise should be just
maxItems: 1


> +
> +  rohm,clkout-open-drain:
> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1

Best regards,
Krzysztof

