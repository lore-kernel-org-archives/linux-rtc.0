Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF92366045;
	Wed, 12 Aug 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500527; cv=none; b=c4MwjRg50kUPISEr7P11poIEg6FuE5D1wCn32uT09YVFETYkzydl3qsfF2Ttm/pyOiiZAK91XAO58RE7vVEMryPrOknX1vS7i7k1ouftexUPwOAEkvG4PcZCUKb4SE4CiEWUtBSJPiCUxsqRDDj7swayL8DH7mJh3tck7z8RJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500527; c=relaxed/simple;
	bh=zuAY5sGnax7vbTOE3qK3+Djt4L1YQTypycBHJ/2hfqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsYXD+pKlo6z2oeSh9PxMzk8BnAmq9mRS9bkKBMVnRjHQEf3+Ff4SQ1POsAd1ljPmCT8IF9MM4684uyK34JSogTvaazPiVC0MFdSZvMiIP6CSje6emWFqSc9TLIcUPdDXskuNC8KpSwrH9V+WJLx0+MhLHk5GytSU41aRqbPOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+lSZ9Ga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+lSZ9Ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720EF1F000E9;
	Wed, 12 Aug 2026 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786500525;
	bh=nVgFwLKZ08mOWlcHPlqu5YKlBl/DsPDL5zxH+opF2WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+lSZ9Gagy1Q+bTDShS7BuLvLVi1e78bIjRifse9h37GvSWYZSt2OB/WQQfKBPhoz
	 oRan2ZXk8BLRK5PZ81ma2jVjBaOPex9wb9iMZ1EF6wMAimSkfqjIz0jjk5ev70G8Lp
	 bja5cIITXCmBHQYoqT0VZk/UvJ4ksUKXm6FIG/2oXBJv57SeD60DLKHU3RE7f7gHE5
	 EFRekL6D3ggDu9dhcnxRr07AXk1MGDxMwG2LL1tEWvUIda+dmHvlMFb0zlMYNdmq7h
	 oHMDRSthd98pxcZgfyDoLPk/GPazfym4ut9ZM1q0YYP4Ki9IIuaTvPTKwWjDbEwkcU
	 i6ejE5FkDp+9Q==
Date: Tue, 11 Aug 2026 21:08:44 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Message-ID: <20260812020844.GA520945-robh@kernel.org>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>

On Wed, Aug 05, 2026 at 07:32:27PM +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
> 
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 109 +++++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
>  MAINTAINERS                                        |   1 +
>  3 files changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 000000000000..0355f17f233a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: S-35390A 2-WIRE REAL-TIME CLOCK
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>

This should be someone with the h/w, not subsystem maintainer.

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
> +  wakeup-parent: true
> +
> +  wakeup-source: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^pins":

Do you need wild cards here? Wouldn't just 'pins' for the node name be 
fine?

> +    type: object
> +    patternProperties:
> +      "-pins$":
> +        type: object
> +        properties:
> +          pins:
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
> +            items:
> +              enum:
> +                - int1
> +                - int2
> +
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
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
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
> +
> +            rtc_pins_default: pins {
> +              int1-pins {
> +                pins = "int1";
> +                function = "wakeup";
> +              };
> +              int2-pins {
> +                pins = "int2";
> +                function = "disable";
> +              };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> index f4d0eed98a08..7b3f682ef4d5 100644
> --- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> @@ -81,8 +81,6 @@ properties:
>        - ricoh,rv5c386
>        # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>        - ricoh,rv5c387a
> -      # 2-wire CMOS real-time clock
> -      - sii,s35390a
>        # ST SPEAr Real-time Clock
>        - st,spear600-rtc
>        # VIA/Wondermedia VT8500 Real-time Clock
> @@ -105,5 +103,4 @@ required:
>    - reg
>  
>  additionalProperties: false
> -
>  ...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..4c8bc35cfe55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22695,6 +22695,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
>  F:	Documentation/admin-guide/rtc.rst
>  F:	Documentation/devicetree/bindings/rtc/
>  F:	drivers/rtc/
> +F:	include/dt-bindings/rtc/
>  F:	include/linux/rtc.h
>  F:	include/linux/rtc/
>  F:	include/uapi/linux/rtc.h
> 
> -- 
> 2.54.0
> 
