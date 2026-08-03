Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DD2F90C9
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736145; cv=none; b=DFaGEuB3KIFit8Kw+5qGh8HScUjNWUX+WZ3rPZF9awl3ZUsrdEIZLP0QTJKr2xVFWn2REqrkJwobwinPzsTIhH3ymGmMn8rq4MOSkHetwB/Mpg0/NxcRxAZ76C7HqxyAQdMiiBQJRRtDiWswIPTRmFnbHN1avrhCW1Vzem0DsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736145; c=relaxed/simple;
	bh=x1Z4nUqvVtCWJiVWeGWzCEKbiZv0wMWpiYwZdmMU34k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5LTtrGILSgjCUHsmfAc84GnmZan4+4sb1HjLaB+CPOtPw9cMspEXtp2Yt2jGOLcTvO0zyl6JFJe792YqDUJEtyNtOvcmJQjQIIcrGdO4MsTy+jz/pjasB6eZXCDpxxsQ2JJ75FOsGmj1wlrHvsvMHhoXIqlGmShI91kk5FS5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcNL7HwG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcNL7HwG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so3219824e87.3
        for <linux-rtc@vger.kernel.org>; Sun, 02 Aug 2026 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785736141; x=1786340941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z8jXZAUhcjKTtPoIZ4/epKb5xdLnKYJzAnB3Lfizgk=;
        b=qcNL7HwG00+Ui84qD0786CouAT5q6Fwv392Lrn0nX8l4oULWsE1nbACCco/+cq3qnG
         Xm8t5vkQ9sl+ejHH7GQrZKy6HqAJwm/1AIA3hlgm0PbNBXdOss6HqMX1yCycRPPwI9kB
         uXxI5A0jcIJmm6Sj8AdsWe7JXT60dEen+yZN2DAfnmhufcDmu9Cr+S3d/QWUp0e1BsgA
         /CEDB55XQbpCI2lNU7+tb2PNon8RTqS9CtVyEVrKJLaujMBWl+BYZbMBO+0gs61wScdA
         Z4bQXrBz6SAeLz2T4eZ7Wuw3Hnsl1DQY6qItdbqwMyEnoqbnUCRAAyujN+nPI237XWkw
         mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785736141; x=1786340941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z8jXZAUhcjKTtPoIZ4/epKb5xdLnKYJzAnB3Lfizgk=;
        b=Jen6sFENi0u8ZKMTZo80bie0MbiyJoxjGpxK4h/Fev7laSjjnR6orH6sXAEz2ULrCQ
         dhv9JBVg4+Q/VbS05Hd1ZINBeCKMLo4c/VnL4Ms++IIpAeJJtWsoYwxuSz7iTk/1sIM+
         miKf7gqMoYDxgnmMS2qGDPpXZIlR78u7ru4ZwgjFjBSrR6EtpY5qvxuyP4l/3IzeMTM9
         +yBplvjbhPEMxNzk9CI8vOw8iKW4YAUCIZe7CrJSfuDkMevyqqdovMTM9v2YfWy84trf
         /N9/EvJhEbtea0j2wdFh+NzV1Q13uEAQD7QbgkpQORjmrDDOeyvGpoJbnHnKk+4PumrE
         Bvzg==
X-Forwarded-Encrypted: i=1; AHgh+RpaiRJIB3T6Bl9udzZgPymYe0gUy1AWog4R52F8zziPYx3Hz1C6t3sNoGNBsPgz5yGxQXdzIYRQ+Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIUEk5TebbKI3SLnMhURPje1u5yu6wRY1E4Ew9a9hwvDI43xs
	ta6SSUtniDLszh4+wgauRaFRXgoi6hQsA/t8CTj5WYt3/f1QOWkqnJfC
X-Gm-Gg: AR+sD13s9qjisiHN4b8L0Yks6VdQUGluiG0ikKD76dRqrBwi3j3IMNckUdgQ4C4TSeH
	eDbxnpp18BacDPRH+2ntjbCvoWKEiENEqyc2PtX+NVpv8dDSzvTCillbD+hYGaDC5WIy0qpfT0P
	OWdVNn4xX6F7Ej33pASU+N4wvMbjsHSIay3v/oadk3/iVe+2lbJxPpBnEaXJLPiBqQfzzYdyid+
	Npl20napaxzVllz90e+QihOY3bxAAewJvcpoR/1OFLeE0hNhZXu7OWWbP0TtyiOK/+IhmI2TlKq
	wcu4UUDkDxF02x6kqulVykUPktqFxYCHezxRgldMEpShVjODzfQzUr4XVWIS/s63LEjVvPGTtd4
	7xu4H6F7hvKtfSiKOnOAH/4Rz6bP9KtT70MTaf/WHBtk7+XpyTUlmUQdDxovHNn1Lv9N9hjmANi
	XRFF3zHiNbsUS60vmD+jACfp7W5xsuL8dquIH73ASkxtOntJDyPOkFNSHNJDMfF2whEqbHxYq7X
	si3d3KwnqwU9dV6gj52NYPIiyDJSpKfUW1sqIwsJxwApIqYxFO8OxLNSw==
X-Received: by 2002:ac2:41c3:0:b0:5ae:b130:1e1 with SMTP id 2adb3069b0e04-5b2e4f3b5c0mr1164615e87.28.1785736141209;
        Sun, 02 Aug 2026 22:49:01 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23cb4e6sm1832235e87.22.2026.08.02.22.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 22:49:00 -0700 (PDT)
Message-ID: <db4a8ecc-65c2-4965-bb53-bd637e3765df@gmail.com>
Date: Mon, 3 Aug 2026 08:48:59 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: mfd: ROHM BD73800 PMIC
To: Linus Walleij <linusw@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <3e700a3fa7872a96257ff25a77670ec05cfd239c.1782909323.git.mazziesaccount@gmail.com>
 <CAD++jLnaOOoLsLxzib4d1XXLxRpWBPrqCdRwqVVEUmKYS4ad6g@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAD++jLnaOOoLsLxzib4d1XXLxRpWBPrqCdRwqVVEUmKYS4ad6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi dee Ho Linus,

The way too short summer holiday is now gone, so I am back at this :) 
Thanks again for the comments, I am trying to improve for v2 ;)

On 03/07/2026 23:46, Linus Walleij wrote:
> On Wed, Jul 1, 2026 at 2:41 PM Matti Vaittinen
> <matti.vaittinen@linux.dev> wrote:
> 
>> +  # The GPIO1, CLKOUT (GPIO2), FAULT_B and EXTEN_OUT pins can be
>> +  # configured to interrupt pins by OTP.
> 
> Maybe move this helpful comment into the top description: instead?
> It's kind of generic helpful info.
> 
>> +# The GPIO1, CLKOUT, FAULT_B and EXTEN_OUT pins may be configured for a
>> +# specific purpose (like ADC input, 32.768 clk output, fault indicator or
>> +# delivering power sequence to a companion PMIC when multiple PMICs are
>> +# used) - but also to be either a GPO or GPI. (When used as a GPI the pin
>> +# can also be used as an IRQ source). The pin purpose is determined by
>> +# OTP (One Time Programmable memory), typically during device manufacturing.
>> +# The OTP can't be read at runtime so device-tree should describe the pins.
>> +  rohm,pin-gpio1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Indicate if the GPIO1 pin has been set to GPI or GPO at manufacturing.
>> +    enum: [gpi, gpo]
>> +
>> +  rohm,pin-clkout:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Indicate if the CLKOUT pin has been set to GPI or GPO at manufacturing.
>> +    enum: [gpi, gpo]
>> +
>> +  rohm,pin-fault-b:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Indicate if the FAULT_B pin has been set to GPI or GPO at manufacturing.
>> +    enum: [gpi, gpo]
>> +
>> +  rohm,pin-exten:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Indicate if the EXTEN_OUT pin has been set to GPI or GPO at
>> +      manufacturing.
>> +    enum: [gpi, gpo]
> 
> Can we explain what "GPI" and "GPO" means in this context?
> 
> I read it as "general purpose input" and "general purpose output", but...
> you just describe the exact purpose? So what is "general purpose"
> about them in that case?

These property names (pin-gpio1, pin-clkout, pin-fault-b, pin-exten) do 
not define the purpose of the pin, but they match the pin name in the 
data-sheet. The idea is indeed to be able to say "the fault-b -pin is 
not a fault signal, but a general purpose input" - if the IC we are 
describing here has OTP configuration enabling this.

I am re-using the approach from the BD72720 here. I think I will add a 
common binding file with these, which can then be referred by multiple 
rohm ICs (in same fashion I added the 
Documentation/devicetree/bindings/regulator/rohm,pmic-states.yaml for 
commonly used ROHM regulator properties). I'll see if it looks Ok (to 
me), and send it in v2 :)

> I would re-use "input-enable" and "output-enable" from:
> Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
> (I mean don't $rf that, just use these strings).
> 
> I suppose:
> enum: [input-enable, output-enable]
> 
>> +  rohm,clkout-open-drain:
>> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 1
> 
> Here I would also reuse the generic pinconf properties,
> something like;
> 
> rohm,clkout-drive-type:
>    enum: [drive-push-pull, drive-open-drain]

As I mentioned in my very hasty original reply, this is also an existing 
binding used in quite a few PMIC device-trees. Changing it now sounds 
like asking for problems, for (in my opinion) little benefit. Yet, since 
it is used by a few PMICs, I could perhaps put it in a common rohm 
binding file as well. Then it would be more obvious it is an existing 
property if new models re-use this.

> (Push-pull is what is colloquially referred to as "cmos".)

I will at least add a.k.a "push-pull" to the description :)

> 
>> +            rohm,pin-gpio1 = "gpo";
>> +            rohm,pin-exten = "gpi";
> 
> If you instead use nodes with properties you can do this:
> 
> rohm,pin-clkout {
>      output-enable;
>      drive-push-pull;
> };
> 
> This collects the clkout config in one place and make
> it obvious what is going on. But I don't know what the DT
> maintainers think about this idea.

I believe you mean I could translate:

rohm,pin-clkout = "gpo";
rohm,clkout-open-drain = <0>;

to
rohm,pin-clkout {
	output-enable;
	drive-push-pull;
};
right?

I am actually not sure if this would work. The data-sheet made me to 
assume it might not. There is separate "OUT32K" register, which controls 
the clock gate. This, as far as I understand, is not usable when the OTP 
variant sets the CLKOUT -pin to GPO. The mode (open-drain / cmos) 
configuration resides in this clock gate register.

[Just to complete picture, when OTP is set to GPO, the pin output is 
controlled by GPIO_OUT register instead. When OTP has set the pin to clk 
output (or to GPI), then the GPIO_OUT register writes have no impact.]

Thus, in case of the BD73800, the:

rohm,pin-clkout = "gpo";
rohm,clkout-open-drain = <0>;

might actually be contradicting.

...

Now, I will make a side-note... The data-sheet front page says:
> 4 GPIOs
> - OTP Option for GPIOs instead of I/F signals:
> EXTEN_OUT, FAULT_B, CLKOUT, GPIO1
> - GPO Supports Open Drain and CMOS Output

I, however, see no register control for the GPO output types. I _assume_ 
the output type (when pins are used for GPO) depends on OTP again. I 
will see if I can clarify this.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
