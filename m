Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640E39EF30
	for <linux-rtc@vger.kernel.org>; Mon, 13 Jul 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930615; cv=none; b=CqWH2vQFav9kJ+cBFv8fYZOvryXDMi7T3t8yrv/MuKtjNYLJL5bB5cm3OnwwvBo15kFxJ3hZpXZpxAytIcovmrgojQ1HexavzbaVqeEU6/6YY+dMgE/Cy5zEzImwcAlSLxKMSjX9mHeFBljSDRKdsk6cCFVm+6K2RqZzJcpq3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930615; c=relaxed/simple;
	bh=9+3Sww1C+uYKIwyUcbIIOb42X2ECv7xamrybHeNLRDQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRWCI2HqYW3E3Rc4kAEvMy1xDU1Pqrbr6N0j4qdPGSRJLJYqNxK9emL0IJjn1JW40H6A6mMtqFMHwbi6FfkTHQBRJNMeg/58cnEPsZKqPKhJtdUmA+mTPcAQrZ52LNFpQlIFmdMM1mu54TQqlUDW9D9wqUUU16H9dTx8jRosyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvirtr+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvirtr+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9241F00A3F
	for <linux-rtc@vger.kernel.org>; Mon, 13 Jul 2026 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930614;
	bh=m5F0084nQCC/QhRXj90Uv+t8Z3rbI8iJLW2IgXjNKdk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Dvirtr+1Ru0jx55LjsZRFcmWDXDLldQ0A030RudZy6rYxe2N4W/UZ0UvwF4W9KDHm
	 fJLxw6HyEQYLDhzML215WQo4PWKZdHRBuGgEYX4eViR9xDilYz/R9pvLNsmn5XDVFF
	 OQZziqazFDqDRiohOECkNpqIGeFxKdOq36aKTQGpilxXpLluIHw2ffjwb8htvdpBsF
	 Wxeh3/Vob3pS07O6toE0vsSOMgrNqxmCvgdVfvXFxGWq9dK+I/IeQ2BardntupAQqM
	 p3peqmiViDs7PQgzN89DQ6ciQb33DZg0vIqAZhQ3/qVVhV1uf3nhXxy974dmT9acRT
	 V8VpOe5XPcQlQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c86945164so22006161fa.1
        for <linux-rtc@vger.kernel.org>; Mon, 13 Jul 2026 01:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqooJh1zH4abbOV8+OwnmvMk4U6gHJJBBS8a2fYCX1dvyBlKGFXWxNqIwptS4Pq9vOnNFLbYdsXk0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxroF88XLleIKSYu/0HHnN+oKRHvTEOvcuv9a8uA2yKtaBQDwQE
	gW9EpQ4jARiUkFVE36m3thERV7hGpkNCpFGbyppU4V0AmKWWrTSZ9bi1yyzuXi9mB4/rwtww3T1
	9iSpbIVrC8k8ONXYjYcRN0zC7gyhhxXLsdyxWI9/1iQ==
X-Received: by 2002:a2e:a9a5:0:b0:39c:6f89:c9b3 with SMTP id
 38308e7fff4ca-39caa13ca2amr17346001fa.14.1783930612774; Mon, 13 Jul 2026
 01:16:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 01:16:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 01:16:51 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CANhJrGM9ciyBfgGWBwOM3kNmcXGSq4QVM6a6Js+wtbr9ANtSJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <27fb93d0e61704d495e3adf4ed614edac1642267.1782909323.git.mazziesaccount@gmail.com>
 <CAMRc=MccLRKb8ZjChcR7WK3TqV3=waSnKX=UX9LR=5hOT=_tsg@mail.gmail.com> <CANhJrGM9ciyBfgGWBwOM3kNmcXGSq4QVM6a6Js+wtbr9ANtSJA@mail.gmail.com>
Date: Mon, 13 Jul 2026 01:16:51 -0700
X-Gmail-Original-Message-ID: <CAMRc=MedLP3XBqoUv_zUr5gxBVc+gqwY3ozAyXagBhc_70Kykw@mail.gmail.com>
X-Gm-Features: AVVi8CfyQ1TAFYvyEQ1X0jI6L1cKq7pX3giTRDhFSopr0iz61Po6th7LT6u3Xr0
Message-ID: <CAMRc=MedLP3XBqoUv_zUr5gxBVc+gqwY3ozAyXagBhc_70Kykw@mail.gmail.com>
Subject: Re: [PATCH 7/8] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Jul 2026 17:42:17 +0200, Matti Vaittinen
<mazziesaccount@gmail.com> said:
> pe 3.7.2026 klo 16.11 Bartosz Golaszewski (brgl@kernel.org) kirjoitti:
>> > +
>> > +     if (!g->num_pins) {
>> > +             /*
>> > +              * The BD73800 may or may not have pins allocated for GPIO
>> > +              * depending on the OTP used at manufacturing. Free the memory
>> > +              * and go out if there is no pins as then we have nothing to do
>> > +              */
>> > +             dev_dbg(dev, "no GPIO pins\n");
>> > +             devm_kfree(dev, g);
>>
>> No need for that, because...
>>
>> > +             return 0;
>>
>> ... this will still leave a bound device in the system, I'm not sure we want
>> it? The correct error code in this case is -ENODEV.
>
> I am a bit uncertain. This isn't really an error. It should be very
> much Ok to configure the support for PMICs with GPIOs to be compiled -
> and also very much Ok to have a PMIC with no GPIOs. Returning an error
> doesn't feel right. Furthermore, I am afraid that returning an error
> might hurt the system start-up? Do you see some really problematic
> consequences if we return Ok without registering the GPIOs. I'd assume
> that wastes some bytes but I don't see other really severe
> consequences.

But -ENODEV/-ENXIO error codes are meant to do exactly that - tell the driver
core to assume this device legitimately cannot be enabled on this system. There
will be no error splat in the kernel log and the probe will not be deferred.

This really isn't the first device to need this behavior. :)

Bart
