Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7036403A;
	Mon,  3 Aug 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750973; cv=none; b=MGBbuq1VLZrr/T+xoIwKjeDxdj7uGUxywIgOJjKB24KLf0pSjeRszFxg9478Dav15gfNP1RcwpNoGXvh0D6uHU539GXmK1913PhUGPxhjap9de4qR10kd3YqTghcxnIBK93XY+Ewleo6YmDmPypH14i35tJqDYJ7cvQHNRwAHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750973; c=relaxed/simple;
	bh=iofpqrdqGxD7B/vi7lwImKJzxEFJD7KzwC1MT2y+g14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg/Rg1Pvy9co0P5dFBCkHH/VCGEQ7he/TQLautVMsOt0V76kYJGWIwb5bsw+gDjg33IFcdZ4YWo++0WjUcF0cSAAxZcK90vGtOyS8+6VlkmFWSX0WmUJdpn8uFDpdD09vBPMMxjDEZLMoLWEsb8CD/Lm0hS1zLx5rapcSjBo3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9TJgROj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9TJgROj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C491F000E9;
	Mon,  3 Aug 2026 09:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785750971;
	bh=n0aB7qGBLZyAd1fXd3wTUVGSroPtec55ZWHXPynR+mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g9TJgROjkZFESO6T8yl5X6xkRwQmBwdIoX748rbmcVPRlawHMV/F2UO11mBC/e9TU
	 Pr0vbB5es1YS11qONg8QWpT5WnTq1oVjPUqBULbZoK08477uJjbN2VMfQy3BnVi5Fe
	 sSqbhPqf3CGO6u6nC4h2HmTB2S3ynRgFua+RMIRhIq3j3+lWlagvSliEM1eYzLf5G/
	 BC7vXII39Oz8ucBxOp1FGwdt9EwuNvR6a97O38tYp38rp4iF1ohnZ7JlxSgMnGGPPn
	 ftU8r3QAzJINM5RqbuydnlR2g0yntS29vo/2fe2VCLXoLjFDrtb0JCKFPXvIJHB2se
	 rfeVWu9PDon9A==
Date: Mon, 3 Aug 2026 11:56:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Michael Langer <michael.brainbug.langer@googlemail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Message-ID: <20260803-mottled-pretty-sloth-bf7dbd@quoll>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>

On Sat, Aug 01, 2026 at 06:43:00PM +0000, Markus Probst wrote:
> +  wakeup-parent: true
> +
> +  wakeup-source: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:

This goes after "properties:" block.


> +  "^pins":
> +    type: object
> +    patternProperties:
> +      "-pins$":
> +        type: object
> +        properties:
> +          pins:
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
> +
> +          sii,mode:
> +            $ref: /schemas/types.yaml#/definitions/uint32

Use simple string. See pinmux bindings.

> +            description: |
> +              Modes for the specific pin:
> +              - S35390A_MODE_IGNORE: Preserve the previous state.
> +              - S35390A_MODE_DISABLE: Disable all interrupts.
> +              - S35390A_MODE_WAKEUP: Used for waking up the system.
> +              - S35390A_MODE_ALARM: Userspace defined alarm.
> +              - S35390A_MODE_FREQ: Periodical at configurable frequency.
> +              - S35390A_MODE_PMIN1: Minute periodical output with 50% duty.
> +              - S35390A_MODE_PMIN2: Minute periodical output L for 7.81 ms.
> +                                    Can only be used with pin INT1.
> +              - S35390A_MODE_32768KHZ: Raw 32.768 kHz output.
> +                                       Can only be used with pin INT1.
> +            minimum: 0
> +            maximum: 7
> +
> +          sii,frequency:

Frequency needs -hz, but anyway if this is becoming a clock, then you
must have clocks property and this is simply not needed... unless this
is some periodical wakeup call, not a clock? Then simply -hz and
property must be more descriptive (frequency of what? pulse?).


> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Frequency in Hz to be used with mode S35390A_MODE_FREQ.
> +            minimum: 1
> +            maximum: 31
> +
> +        required:
> +          - sii,mode
> +
> +        if:
> +          properties:
> +            sii,mode:
> +              const: 4
> +        then:
> +          required:
> +            - sii,frequency
> +        else:
> +          properties:
> +            sii,frequency: false
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/rtc/s35390a.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc: rtc@30 {

Drop unused label

> +            compatible = "sii,s35390a";
> +            reg = <0x30>;
> +            pinctrl-0 = <&rtc_pins_default>;
> +            pinctrl-names = "default";
> +
> +            wakeup-parent = <&int>;
> +
> +            rtc_pins_default: pins {
> +              int1-pins {
> +                pins = S35390A_PIN_INT1;
> +                sii,mode = <S35390A_MODE_WAKEUP>;
> +              };
> +              int2-pins {
> +                pins = S35390A_PIN_INT2;
> +                sii,mode = <S35390A_MODE_DISABLE>;
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
> index 716acfc3d7c1..c85be1eefdb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22696,6 +22696,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
>  F:	Documentation/admin-guide/rtc.rst
>  F:	Documentation/devicetree/bindings/rtc/
>  F:	drivers/rtc/
> +F:	include/dt-bindings/rtc/
>  F:	include/linux/rtc.h
>  F:	include/linux/rtc/
>  F:	include/uapi/linux/rtc.h
> diff --git a/include/dt-bindings/rtc/s35390a.h b/include/dt-bindings/rtc/s35390a.h
> new file mode 100644
> index 000000000000..dcd0ca15f9e9
> --- /dev/null
> +++ b/include/dt-bindings/rtc/s35390a.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +
> +#ifndef __DT_BINDINGS_RTC_S35390A_H
> +#define __DT_BINDINGS_RTC_S35390A_H
> +
> +#define S35390A_MODE_IGNORE		0x0
> +#define S35390A_MODE_DISABLE		0x1
> +#define S35390A_MODE_WAKEUP		0x2
> +#define S35390A_MODE_ALARM		0x3
> +#define S35390A_MODE_FREQ		0x4
> +#define S35390A_MODE_PMIN1		0x5
> +#define S35390A_MODE_PMIN2		0x6
> +#define S35390A_MODE_32768KHZ		0x7
> +
> +#define S35390A_MODE_INT1_MAX		0x7
> +#define S35390A_MODE_INT2_MAX		0x5
> +
> +#define S35390A_FREQ_MASK		0x1F

 don't get why this grew. None of these look like bindings.


> +
> +#define S35390A_PIN_INT1		"int1"
> +#define S35390A_PIN_INT2		"int2"

Drop entire header.

> +
> +#endif /* __DT_BINDINGS_RTC_S35390A_H */
> 
> -- 
> 2.54.0
> 
