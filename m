Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24858396567
	for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610065; cv=none; b=AY7QPTMwzgAsOuxJO4J5gZMJk/3k6394AwC7ek36pWksVijWDejpqxO3MK3KSX+ILmHbgBGd/Nl3qWNDelwaMyEfhyFaTdHl4gf7bLIRZy+B0dpHWErYjb5TdHRal6Va+AThQNsC/2MoSb2k+YVnsieuXc5iYt6tn+sZRcFXbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610065; c=relaxed/simple;
	bh=Et8yr7T4XI2QiD9tHPH6gogO1W8MVDfDmWwZXyvssoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ9R93oqHFgiHXUr8eeYdbAUItAGkqB5GSNLuCIK54QmzE7Nw69sXYhbsSzle1NC5kUUExJiDd6fcsXeZjwtH1kDnN6Byldu/Y57ZQLApg71Esw0rjQZFs4J4Kzgl6QL9eZf5nE8xo5sy26iHyCgmoGswgDdPtIpyuuYWwi2as8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRySEaGe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRySEaGe"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so15148001fa.1
        for <linux-rtc@vger.kernel.org>; Thu, 13 Aug 2026 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786610061; x=1787214861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUlqoelOp41/qPHMuXnll43fbi7+sd/XaTpVYDwo8o4=;
        b=rRySEaGe33GGD3rDArMTqpneiUzvS6BHFzj5YOcZyvbNkwUj8ouVDd5CmMG7ODCX4q
         V9PSxwj/pNhYWS7enXDXJOOKUUSTkXWPQ1i/ub67BYC2xAnLz77u7lOQX0zUevnPUEZB
         ruACOMxfJrs1H5YJABBisQ/2+oMQ7uaKAhW79YpIvY8eO+KB6DdnmjWPMdGshk/cmwPx
         inqKF9qxNpYIWrI1ydZ+GF73F3XsR/dR2Nqv2nhBj2+4enluMOjDUdyC2+1utCLtf/hB
         a4clU4OCAHrVL8uLZT2Kxw+h+mQNZeBXKpuOTtaNNMRoWHPQaodnng5w+d/gjhZU1Ugl
         rD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610061; x=1787214861;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUlqoelOp41/qPHMuXnll43fbi7+sd/XaTpVYDwo8o4=;
        b=Rtx5TsiRIiWT+THNXNhOzr2sci75qiX7bzxNzkR5Odo8ENglQgWcsOY3C0I0/eklj8
         4tVpFQKFaFroPXJMeukkvEduw7rwlzc+meGmIlknT17FN+uyEjzLScAWFpHo2niuwZB6
         SBwdTEUBDSDc+nJCsv/Nvzg6C2fYxbr54Pk4r/7qYD7U2hWV7FU8zYSfxZstWXZujCOo
         qU9AQafB/KNFaiirja47p4tZN3xojDLJrceim+nlCWJYGhWS1w2WOklEtU7Q0BauoqPL
         lT4NTN8Jy0TRkTXeA6httt5+ssKTvkJ/tVDDpnX1i4k3w40vXmtemKdriASJ8OJgfZK8
         zCOg==
X-Forwarded-Encrypted: i=1; AHgh+RpX8TUE1FGZwmi8s2yW5ZgZZTxTUSAinHEfMTcgiJOV+GwhsUNt/1gclbNbTKapNJlpm0kO3ymqWVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgYVnDcoMuyznHBe+CJ+D1qfsiN6d8RrdoQ5a4VYGr3UVLlDs
	x8uGPrlFLKe1qbG9nj6zO500h99AMixe8R3lOAijns19mdZ2slw0J4tK
X-Gm-Gg: AR+sD11cKbd/uKSw6t31DF8VmUhiC3xV1ULZNNYXLAVtWJ4ZmovDK2n8osdgVmpHH1t
	5DTohqhSWDEt6UPi0+en/lERaSeFzsEXFV0Q7KIux+4LpjET0oMIYululRlUNi6a7Hq1zbZCpov
	81wv2WMATOHQTTwu3Him4uKmYKmiCX5bPYrrav2g4z+VtrdXt4nVoec9WGbvatSY9ry4FSkjVv6
	GTd0XusG0lm4vq3URkHjM809mp2Fkf51lrugiGImi17Z1B9eEjPNzzG2Uwj10rtFm3X+6Ixzrn6
	dAVQQH075+k5QXl38mrViG5z4hBBCAA2DShf7/KjAR2UTD2MrHKqgpgNknkz3iApfS1ByEd4q41
	ixuIBmz6ncF2IkVgbBCbj3JC13XizYTfE0//3ne7cxg1pnA2YfClCaW8HAg69GChWtYv6dN0jrV
	n8RAJkrJoGuF8Er/KmOqzUNAxiccdOBCFzFmMlxEsX7epFgugdijAYSLQGRbC2DhdlxL/CM0JFG
	R3yeWfu6c7rxkX+cS2soFhDe6GT3vAhDj0elOS/UiaidCPhwfttwdyPw84Ccik1J8xn
X-Received: by 2002:a05:651c:2108:b0:39c:f58e:5c5b with SMTP id 38308e7fff4ca-3a11a6b4a36mr4705651fa.18.1786610060867;
        Thu, 13 Aug 2026 01:34:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a11b43f7fbsm2860831fa.37.2026.08.13.01.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 01:34:19 -0700 (PDT)
Message-ID: <f5c241a2-00a8-4a32-bad5-3c89fb204b25@gmail.com>
Date: Thu, 13 Aug 2026 11:34:17 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Linus Walleij <linusw@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <9774b8d6663ea55b1682b32f825ec5689be3e1d8.1785838585.git.mazziesaccount@gmail.com>
 <CAD++jLmatJFfqhNWfgx=qUW2fEwuatxmJR7NyJLAv45LfLHZnw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAD++jLmatJFfqhNWfgx=qUW2fEwuatxmJR7NyJLAv45LfLHZnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2026 23:29, Linus Walleij wrote:
> Hi Matti,
> 
> thanks for your patch!
> 
> On Tue, Aug 4, 2026 at 12:23 PM Matti Vaittinen
> <matti.vaittinen@linux.dev> wrote:
> 
> 
>> +static int bd73800gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct bd73800_gpio *data = gpiochip_get_data(chip);
>> +       struct bd73800_gpio_pin_cfg *pin = &data->pin[offset];
>> +       int ret, val;
>> +
>> +       /* Only pins configured as GPI via OTP can have their status read */
>> +       if (pin->state != BD73800_PIN_GPI) {
>> +               dev_dbg(data->dev, "pin %d (%x) not input. State %d\n", offset,
>> +                       pin->mask, pin->state);
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = regmap_read(data->regmap, BD73800_REG_INT_5_SRC, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return val & pin->mask;
>> +}
>> +
>> +static int bd73800gpo_set(struct gpio_chip *chip, unsigned int offset,
>> +                         int value)
>> +{
>> +       struct bd73800_gpio *data = gpiochip_get_data(chip);
>> +       struct bd73800_gpio_pin_cfg *pin = &data->pin[offset];
>> +
>> +       if (pin->state != BD73800_PIN_GPO) {
>> +               dev_dbg(data->dev, "pin %d (%d) not output. State %d\n",
>> +                       offset, pin->mask, pin->state);
>> +
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (value)
>> +               return regmap_set_bits(data->regmap, BD73800_REG_GPO_OUT,
>> +                                      pin->mask);
>> +
>> +       return regmap_clear_bits(data->regmap, BD73800_REG_GPO_OUT, pin->mask);
>> +}
> 
> These can probably be handled by the latest version of gpio-regmap
> helpers (the version in linux-next).
> 
> We now support both input-only and output-only in gpio-regmap.
> 
> Latest <linux/gpio/regmap.h>:
> 
>   * @fixed_direction_mask:
>   *                      (Optional) Bitmap representing the GPIO lines that
>   *                      make use of the @fixed_direction_output list to
>   *                      enforce direction of the GPIO. If this is NULL
>   *                      and @fixed_direction_output is defined, ALL GPIOs
>   *                      are assumed to be fixed direction (out or in).
>   * @fixed_direction_output:
>   *                      (Optional) Bitmap representing the fixed direction of
>   *                      the GPIO lines. Useful when there are GPIO lines with a
>   *                      fixed direction mixed together in the same register.
> 
> It seems you can set up the fixed_direction_output mask from OTP
> and just use the library, right?

The BD73800 uses different registers for 'out' and 'in'. So there aren't 
really "GPIO lines with a fixed direction mixed together in the same 
register".

I, however, see some good stuff being in the linux-next! Finally a bit 
of flexibility in a form of callbacks a driver can register is getting 
in. So I am somewhat hopeful the usability of gpio-regmap will finally 
increase.

I think the BD73800 can indeed use the gpio-regmap, by keeping the pin 
direction information in private data and adding a custom xlate, which 
errors out if get is requested for output pin, or set is requested for 
input. I am not sure how much of an improvement it is compared to the 
patch v2, but I'll give it a shot :) I believe the new -rc1 isn't that 
far away, and hopefully the gpio-regmap -stuff from the next will be in 
it together with the regulator stuff bindings depended.

Thanks again for the pointer!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
