Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945E23BD1D
	for <linux-rtc@vger.kernel.org>; Fri,  3 Jul 2026 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111601; cv=none; b=ZZ0zVZ8FDMFSFURKHt4ZcqZHreIaEo5SGYPsXnT16KSIcffthq+1gGm0rNcqWOERKrPb4xzFt5544+faST804azQZk4LX2zCerSXbcZmKcAjQqWKiLRACG5UF13GEVRvevXaSzORKGlcbjzoGFFVKpeWYg+dzZA5aXgbldLBNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111601; c=relaxed/simple;
	bh=RrLlukxBD1h1NBSB9MXmLLKZMaRUnwb2D0vqnP16fyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYQ4rN/12ptd0N7ER46eahG2iimuRouxcXNjJBZAEvGNeENkd8hI+u58gQ4iIaCzRvJ/4KUYRkhfnKzFZRsDBuN9A6kUXc43Edl8t8PWFymNYKw4C5wLVkwFkGhzFnK6akqpyY9RGuHTHJkiDFe1aeLnftSfjcOzGNh/c8phLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVpP8JT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVpP8JT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEA51F00ADE
	for <linux-rtc@vger.kernel.org>; Fri,  3 Jul 2026 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111600;
	bh=j1aLSIyk5REh/r1kwHvSqeP5++R/SPhdVOZzb9nfTiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SVpP8JT3I9EQh/qgqiQ1MVKhqbP2QPv+peRU4as5t4vHnbByJ9K/miRyJ7PMIoMON
	 soFru0OXS7vE2aLLiRrbjGLeEGXfYp/4+hjoNPtwXBrb6/A2eRgYINULSDV1BXYWU/
	 hRtWXeye71TvX/9s6lQKzfkBoW5MVS1RUHU6xBmXv7l2HU5tEBqpccDuosSy8UaPBG
	 itKIlfx5TOKdJ907Iqz7/xUSObvkJ94nmjASLI6+0hlo+CSLXEJv74tLv+a6DV+EMI
	 ZDcMFOddYcbvtNxXLMWN73fLrkeq52VuCs4bSGZt8cVg+MTevy56GM6QH88+WlEq/s
	 uRu9EO09xDrlA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebfa21c62so1127109e87.3
        for <linux-rtc@vger.kernel.org>; Fri, 03 Jul 2026 13:46:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpg6n6R+IccKeftpCbepw48ZCUs6P5G+bipUo14zSTNtZPBU2aaZR/BQIMKWjtYeCz3NaXwX+j091w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztyUqpjkjRvWHDHt0g1jstklIzoXPs8gGLiNNxMvaPUZwrZah
	wFIuUlqm2sbEb79sMBnm0XpWZMvRQmMyEvUg081ayoSz40n9gzdw9GMTmzMWeD5JlHNIBAphhcw
	cEW50PWXrbhxZH40DjARMHLtZe7Hme6c=
X-Received: by 2002:a05:6512:6887:b0:5ae:a9ed:24a0 with SMTP id
 2adb3069b0e04-5aed50a0457mr34817e87.65.1783111598830; Fri, 03 Jul 2026
 13:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782909323.git.mazziesaccount@gmail.com> <3e700a3fa7872a96257ff25a77670ec05cfd239c.1782909323.git.mazziesaccount@gmail.com>
In-Reply-To: <3e700a3fa7872a96257ff25a77670ec05cfd239c.1782909323.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 22:46:26 +0200
X-Gmail-Original-Message-ID: <CAD++jLnaOOoLsLxzib4d1XXLxRpWBPrqCdRwqVVEUmKYS4ad6g@mail.gmail.com>
X-Gm-Features: AVVi8Cda-_9zqWRXvuICvKpqlTILSjV5ilmg1ISZe1-qDyYHxd_AS7D-LvVUxRY
Message-ID: <CAD++jLnaOOoLsLxzib4d1XXLxRpWBPrqCdRwqVVEUmKYS4ad6g@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: mfd: ROHM BD73800 PMIC
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

thanks for your patch!

I have some inevitable pin control nitpicks!

On Wed, Jul 1, 2026 at 2:41=E2=80=AFPM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> +  # The GPIO1, CLKOUT (GPIO2), FAULT_B and EXTEN_OUT pins can be
> +  # configured to interrupt pins by OTP.

Maybe move this helpful comment into the top description: instead?
It's kind of generic helpful info.

> +# The GPIO1, CLKOUT, FAULT_B and EXTEN_OUT pins may be configured for a
> +# specific purpose (like ADC input, 32.768 clk output, fault indicator o=
r
> +# delivering power sequence to a companion PMIC when multiple PMICs are
> +# used) - but also to be either a GPO or GPI. (When used as a GPI the pi=
n
> +# can also be used as an IRQ source). The pin purpose is determined by
> +# OTP (One Time Programmable memory), typically during device manufactur=
ing.
> +# The OTP can't be read at runtime so device-tree should describe the pi=
ns.
> +  rohm,pin-gpio1:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the GPIO1 pin has been set to GPI or GPO at manufactur=
ing.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-clkout:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the CLKOUT pin has been set to GPI or GPO at manufactu=
ring.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-fault-b:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the FAULT_B pin has been set to GPI or GPO at manufact=
uring.
> +    enum: [gpi, gpo]
> +
> +  rohm,pin-exten:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Indicate if the EXTEN_OUT pin has been set to GPI or GPO at
> +      manufacturing.
> +    enum: [gpi, gpo]

Can we explain what "GPI" and "GPO" means in this context?

I read it as "general purpose input" and "general purpose output", but...
you just describe the exact purpose? So what is "general purpose"
about them in that case?

I would re-use "input-enable" and "output-enable" from:
Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
(I mean don't $rf that, just use these strings).

I suppose:
enum: [input-enable, output-enable]

> +  rohm,clkout-open-drain:
> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmo=
s".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1

Here I would also reuse the generic pinconf properties,
something like;

rohm,clkout-drive-type:
  enum: [drive-push-pull, drive-open-drain]

(Push-pull is what is colloquially referred to as "cmos".)

> +            rohm,pin-gpio1 =3D "gpo";
> +            rohm,pin-exten =3D "gpi";

If you instead use nodes with properties you can do this:

rohm,pin-clkout {
    output-enable;
    drive-push-pull;
};

This collects the clkout config in one place and make
it obvious what is going on. But I don't know what the DT
maintainers think about this idea.

Yours,
Linus Walleij
