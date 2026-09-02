Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164947277C
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352810; cv=none; b=kCKrGB6Nua/0KlqH5wXz7I6qLxSoz1IAZLLiuhEg8Bo5Z7wekKwZE4CjlSANzs4havxXQ+K4t4QmtO+x0K03uyHN8Vq6xybt3jHkczhyMxsdGx5wVWJBBQfPu/yiJR8a4r2iZkpMuDRHbzAHHD+qFnox+kvpWgkCv8wuWVcpCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352810; c=relaxed/simple;
	bh=Klpe8gBA+2PNCx51bSzo/EuN3LxVCEYUTgBKdo6fIh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccxXFjj+YPGI76XVgBAfYCMpT9xfugHq8TLn/dlODnF0GwVdyy19BKmvmwywC2gsAu8hVp1gwgbB8DoTooV7dzwJ/f4TyeY0zhThRSJYr8G2d43u8QBSQPfhUIOIzVjL4wt3yeAsGAH1MEpaNH9NvZFhpOkC/hyZwLQgZd7KCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJz0oPUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJz0oPUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2961F00A3E
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352807;
	bh=Klpe8gBA+2PNCx51bSzo/EuN3LxVCEYUTgBKdo6fIh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MJz0oPUxfO3QSEwUNGtpXHy+HuBfTpqV/zHYyEX7j08CkMxlewomCO4Q3E2RbN1Wp
	 wEULcFHD710w/brCMoAevkIUzaZQIzAmn2JqiJ8GUKI8XPwwXQ+ZYbeJGczKCa7Ssp
	 AMyYuc4AKZ/PpLDJH4JzWPivCY5C9eE1wJNsE2AfDJ7BxB/zR0leoCMApSuFA0S8mI
	 JA0AEhQm8gaAW7SvhWlN4/Z2yt0Xy13B2JtwzI1s8fAslrUUp9e/XIW1ZQtMSI2KZG
	 Cgm1TMpNWaZgecR+SQvDHgVINgZYSPrR/A0EeQLFUDY9BjHmKGgxzVOVQvDhsq/KW1
	 I13nLOmrw4TJw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so903370e87.0
        for <linux-rtc@vger.kernel.org>; Wed, 02 Sep 2026 05:40:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykaVd4lK8CfdOwMHqPN+pul/FSPsv0hWWX4j0X1nBGYOhM09PFthRpfBytcAfw8mPNgDyRn9Nsrgc=@vger.kernel.org
X-Gm-Message-State: AFuF++lHN1G0DmsPeChyZihpSESYAd4Re2j24EME6qC62aHTAibLu8bt
	XnlZ3ZhauV7epC0jDD3tsxV7nGC41zdLdKJNESbwvl3flMVjhjING8tgSyjPE5W7nZBYuoSmW1Q
	FZUvy/4VvPjUp+mad3BXRYmQhZfSouJM=
X-Received: by 2002:a05:6512:1252:b0:5b4:ab2f:5bd5 with SMTP id
 2adb3069b0e04-5b608347bb7mr1568323e87.8.1788352806105; Wed, 02 Sep 2026
 05:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788346553.git.mazziesaccount@gmail.com> <5eb294e68b8d5d2c1d3a12b14a55dd2a9c075a09.1788346553.git.mazziesaccount@gmail.com>
In-Reply-To: <5eb294e68b8d5d2c1d3a12b14a55dd2a9c075a09.1788346553.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 2 Sep 2026 14:39:52 +0200
X-Gmail-Original-Message-ID: <CAD++jLkvELVwVD2B-OPF=mV8-F5xi7RZWJ7cvuyg2srnrJ2HLQ@mail.gmail.com>
X-Gm-Features: AcwNN1XLITgbm1aOFoVQnd28TjU_0cWWW0RJDEA68aIrbre66YkBVpUmqod9dXc
Message-ID: <CAD++jLkvELVwVD2B-OPF=mV8-F5xi7RZWJ7cvuyg2srnrJ2HLQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
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
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

thanks for your patch!

On Wed, Sep 2, 2026 at 1:07=E2=80=AFPM Matti Vaittinen
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

Pretty neat with gpio-regmap isn't it? :)
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
