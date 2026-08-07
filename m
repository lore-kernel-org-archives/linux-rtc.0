Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D429D27A
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134595; cv=none; b=GHDGwQwX1zXzYysxfA6U3ER3OVh5E+v5b77EWSAQAKbn+/8IsdkZQ+SRSpotySc16s7D8tX49rWpKMG4PxLs8F5QqMUHhqHgdvbc199zjVq88vB6/4A2Ufmg7XaxaqSNwqsA3Yzkbrz6qAIBaQ8zKt3o5JLoeNISdYxceYzg9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134595; c=relaxed/simple;
	bh=7kcrtJ8j+vZ43z9CeSYPxhIzZu+b2hH+4cPJzBtMKDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVAbz4t0MiV+m90910MF5soi9jWQ/xNxfHkhjTUeQUMGirWTvhWleYYGh5WrobTEgc6TD7rgiX290VcWW/wYkzzpmGcjBSS9FxZKnImgaX5Hb7039PTCZbzvW8Ck/zeP5NLDx5B/WcJGxptIr+JnKdbf3KxhVnebQhM7Nads1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epuk1vKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epuk1vKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A51F00A3F
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134593;
	bh=7BBfG8gvn0wfloVrzuTpVHpGFkIlfRzmb5mJzr8wSag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=epuk1vKEGC+zHT3nl1aPSBAD7SbaHJazafahrinpKdTNt+/S8xNx7Wl5EP4wQSlPH
	 i+GLDIaK/omzo/fXpCf4yQ/7dYVbCzldnCznd6rcXs+mlBESJ19DJlLgqXVcATWFN4
	 v1v5EF91OaKRvor/jyiNCgNno/f0R67Zb7PmTSg0HDXAVX6UatWBsi6uhv46sOxOUM
	 0/7TJMvCOZUlgq3P9pEee1jM6TVgVZTLHULAaAQmYwtnP+F/QCrwvusqdOSni0fUdC
	 ra383EpRZsCRbi5EkTgrO3Wuamp4AXtGUdpXPNwLklUo8MOYCxynpxLQbJGOxU/Ko7
	 owYx0QvcfSFjQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so35591471fa.3
        for <linux-rtc@vger.kernel.org>; Fri, 07 Aug 2026 13:29:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoDHznEDC70Pkgb/matY2yEpLb0+0tFQj6zw73iXtIQ3eXExkpAxUNpRT2/XyNPD5C7152YEOW5LvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTigpWu0ikBsWWXVl9yVpc9+Jx8yFwAP8guLae133k/F24/nS
	scbcykjbHRLhZeDuKop1hudzznkuH2T5SV6MHcRX8vcniZRQoyJUfdj8hx9EJA7PI+jhjWPqGa2
	jpPNNQWBRbkO9P9ZuQWTosvnewA5/YiU=
X-Received: by 2002:a05:651c:b12:b0:39c:6fad:2bc4 with SMTP id
 38308e7fff4ca-39fdf4c8d15mr7787011fa.16.1786134592653; Fri, 07 Aug 2026
 13:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785838584.git.mazziesaccount@gmail.com> <9774b8d6663ea55b1682b32f825ec5689be3e1d8.1785838585.git.mazziesaccount@gmail.com>
In-Reply-To: <9774b8d6663ea55b1682b32f825ec5689be3e1d8.1785838585.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 22:29:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLmatJFfqhNWfgx=qUW2fEwuatxmJR7NyJLAv45LfLHZnw@mail.gmail.com>
X-Gm-Features: AUfX_myHYbPtrP3S5L3hInuuhbJn2ygvTZZS9m3nHbXN6_wSEyPEOm43kiA3AKw
Message-ID: <CAD++jLmatJFfqhNWfgx=qUW2fEwuatxmJR7NyJLAv45LfLHZnw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

thanks for your patch!

On Tue, Aug 4, 2026 at 12:23=E2=80=AFPM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:


> +static int bd73800gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct bd73800_gpio *data =3D gpiochip_get_data(chip);
> +       struct bd73800_gpio_pin_cfg *pin =3D &data->pin[offset];
> +       int ret, val;
> +
> +       /* Only pins configured as GPI via OTP can have their status read=
 */
> +       if (pin->state !=3D BD73800_PIN_GPI) {
> +               dev_dbg(data->dev, "pin %d (%x) not input. State %d\n", o=
ffset,
> +                       pin->mask, pin->state);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D regmap_read(data->regmap, BD73800_REG_INT_5_SRC, &val);
> +       if (ret)
> +               return ret;
> +
> +       return val & pin->mask;
> +}
> +
> +static int bd73800gpo_set(struct gpio_chip *chip, unsigned int offset,
> +                         int value)
> +{
> +       struct bd73800_gpio *data =3D gpiochip_get_data(chip);
> +       struct bd73800_gpio_pin_cfg *pin =3D &data->pin[offset];
> +
> +       if (pin->state !=3D BD73800_PIN_GPO) {
> +               dev_dbg(data->dev, "pin %d (%d) not output. State %d\n",
> +                       offset, pin->mask, pin->state);
> +
> +               return -EINVAL;
> +       }
> +
> +       if (value)
> +               return regmap_set_bits(data->regmap, BD73800_REG_GPO_OUT,
> +                                      pin->mask);
> +
> +       return regmap_clear_bits(data->regmap, BD73800_REG_GPO_OUT, pin->=
mask);
> +}

These can probably be handled by the latest version of gpio-regmap
helpers (the version in linux-next).

We now support both input-only and output-only in gpio-regmap.

Latest <linux/gpio/regmap.h>:

 * @fixed_direction_mask:
 *                      (Optional) Bitmap representing the GPIO lines that
 *                      make use of the @fixed_direction_output list to
 *                      enforce direction of the GPIO. If this is NULL
 *                      and @fixed_direction_output is defined, ALL GPIOs
 *                      are assumed to be fixed direction (out or in).
 * @fixed_direction_output:
 *                      (Optional) Bitmap representing the fixed direction =
of
 *                      the GPIO lines. Useful when there are GPIO lines wi=
th a
 *                      fixed direction mixed together in the same register=
.

It seems you can set up the fixed_direction_output mask from OTP
and just use the library, right?

Yours,
Linus Walleij
