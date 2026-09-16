Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8444D7962
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579891; cv=none; b=OfBbYNo6rOm211tkVnuxo55YDwCC+qXtMZqhzfJ5SkEj5+zX+rdqS8WHm5Q/YOL6I0sh3rByUTSYos8L6Weh1qv82NEwEMneY5zzF+lcsAQAVuTEk3g+uwB0gcGExu2Dlt9NwMZ0Y9F19cgqYhIUCopOURj3ogzAxrosd3NvPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579891; c=relaxed/simple;
	bh=4h7CNgUTqPbXfiRuvyW7wmuQ+iQWLkvSQv8cBspOfWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH7MTS7/c2ZVGjzAg5Y4iPJDkGSzNFSD4NFgBeVgVYG5nb9nkouM5QYlVXlzrGXzrTmT2Wz3YyP/TvUrIIlT+mrl15paRtYVWq/UBxdGvIXn14oKSZ0A9ia2lxmto+67yEditVj2vzBOCGeiXZRiwyEoMz6wZMPC4EMOZQmreEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAF9f1rQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAF9f1rQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF31F008BC
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579881;
	bh=4h7CNgUTqPbXfiRuvyW7wmuQ+iQWLkvSQv8cBspOfWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UAF9f1rQ3RvSfZjIEqrlyW9dpvtTHzRlQsqmgoLfqbBKfdJE7bx/9Xbh6u24HkdJ6
	 MO8I4JRR3WNK8FS95CzQN6qdgKxWqm4/5n9yn7RhbtGg9Ynq0W6S6ZP+pCswZQdkoy
	 CytIJJ4vLyXKl+QhsSETsZaq3SKk5hFj4HlEy3fyVj16tC3Qv8hXGU6ugvw5Zc1zXV
	 JU2mqnPMMc8h7dFG+cj+uqqpBCIo0RiVuoTjPGi6knnpN0nt2Ouh5htwMCbducer7F
	 x/DYblxIKrXDArxzR69SXuBV+0IO5fF8z5yvpuwi42+3gUP4wm7Oki7MUKJz/MVKRP
	 Awxp3goEzwOHQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74d0133e0so1162079e87.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:31:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxcKwoMQQlW0nbSYlY1iQHKZbSyX9YyrpV/bFbivS3D+L8Sr6e+kTax4Wd1ILRhCQ6tRP75Mc17vW8=@vger.kernel.org
X-Gm-Message-State: AFuF++koCXUlSB3PU+CWwD7gxgvtP6/76Uo5AtYp2TeYabhIwg3aStrO
	Y0TKZ5dGd5+8v9VAVOCTMITAI1dbIYp369KqOk+8gV7v1GgeNwzD6yWmYjdSc7JGE10SO5N3LSl
	7l/TRn4GuM30tkPot+pVz5BVf6xziZH4=
X-Received: by 2002:a05:6512:39c7:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b8b65ffbecmr902064e87.9.1789579879753; Wed, 16 Sep 2026
 10:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789538455.git.mazziesaccount@gmail.com> <e3e6ac712519326cc25fcdd0a0c8e3cc42ef55ab.1789538455.git.mazziesaccount@gmail.com>
In-Reply-To: <e3e6ac712519326cc25fcdd0a0c8e3cc42ef55ab.1789538455.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:31:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=vZr+naVBaixNkDbgx4_EpL8MosSyXYb9jg2hgKu+QNg@mail.gmail.com>
X-Gm-Features: AcwNN1UIPEmUSS-eZ1VYSwu7-QImd7lzaWBhLtT17uVLR3LAyc5U_ziRVEemM5c
Message-ID: <CAD++jL=vZr+naVBaixNkDbgx4_EpL8MosSyXYb9jg2hgKu+QNg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm.smtp.subspace.kernel.org, 
	Alexander <alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 8:12=E2=80=AFAM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The ROHM BD73800 PMIC has 4 pins (named GPIO1, CLKOUT, FAULT_B and
> EXTEN_OUT) which might have been set to operate as a GPI or GPO when OTP
> (One Time Programmable memory) is written at device manufacturing.
> Support the GPI/GPO use-case via GPIO framework.
>
> The default OTP for these pins is to not use any of them as GPI or GPO.
> (The GPIO1 defaults as an ADC input regardless the naming). Hence the
> driver assumes none of these pins is a GPI/GPO unless explicitly pointed
> as GPI or GPO via device tree.
>
> Furthermore, pin's direction can't be changed after OTP configuration is
> done. Also the default drive type for a GPO (CMOS / Open Drain) is set
> by the OTP configuration. The BD73800 has a set of undocumented test
> registers which should allow changing the drive type. Access to the test
> register area or the test registers aren't documented and so this driver
> does not support configuring the drive type even though it might be
> doable.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Looks really nice now!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
