Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FA3B5301
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686122; cv=none; b=gWehYl7eKANJnNzvZrsxxVQAd6M8X17YpWmkWvpNtiAoQkINA2NcT8FNt6s6vXVYzn/2gNP0s0RnEUEj7azal+1Ed69qQn3AGrBizlP60HTg9XyKUwy3MJnm89AHlBeezqtNERuUlj8kMKcLOug112oAaHcNOD553Wc7ag7CuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686122; c=relaxed/simple;
	bh=8GUp6d86wI0VQD9aAnfjigmWMDQOaZFbfmTLSRANTnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAKXoq+kZwBAvqnZSIFv+1gYWMWh6Ts1fI7O9ZMSuoFcsmvxH1ZFpZPD3nu0B09ALCNZ6Omu4pIrr0gQRMaVdWS8OlhGM/AkJImNj/9GCg30t2dexgg+HylYAmwFGYP5zi+Ezs7JY8dBycTGaz2SVR/SsjbMwkjJVIkFMnsZJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH0j4qpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH0j4qpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5B71F00A3A
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787686120;
	bh=GsyvyJiUEfgxmHH8Q/QyZdXbAFeDO+3+U37vMETvHpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HH0j4qpIw+01BWx8UyfXEdgs0+bKNg4lmVIJ7pEat86jmynoBVZx9x0WMbmaRzXS7
	 kWL4EEnw3X+qPMVAz5uycpjf/o0V1xDf0H2rpn8Zb3rCCuWIUs6ATuniELUgzDC9/m
	 Nu96fTXp56z3O9G2LJ3Fr3lWJYfVUdRVgt2U3Jz6PvlqiYVYeyvm5/qd1R7rPbLaes
	 Pjw8A7RxWiibMmh6rpEkaXgFwxozYQUe4kfxwfKEyYoGHoADbrvMwQ2VP7DOdJRils
	 6kEyYPPxZ+FSvgESpeMQfDM8CqhWO4Qi16e1Q5alr5mTwW2Z1uNpZIfonchZWO3IMl
	 ciepFnJOp76EA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b48ced973dso147757e87.1
        for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 12:28:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqmd9uwpKWouG/dwbl0FMM579mT0wZGWUrlcxOBzNa68HalxZ0TDYa3KxsiESoqSRMNhEB55inhbq4=@vger.kernel.org
X-Gm-Message-State: AFuF++nCzI6ZAMdV66L9+kpQA+wkdoJ1fzMfco3V0dhSjivQQvTQEiY+
	wiVqMTyVOfv9F2RtwcluSEoqJYyQ5JrmQiW2FAjDJ24c3D2a1Ugr8bHzl7jgedbW5z3UvX8cvvo
	45+vV+sy0u3a6r3ZXznJSSS13tMVhsqk=
X-Received: by 2002:a05:6512:6886:10b0:5b1:59ec:2452 with SMTP id
 2adb3069b0e04-5b4a90002c1mr109150e87.9.1787686119622; Tue, 25 Aug 2026
 12:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-5-df96569e3412@posteo.de> <20260823222611.B176B1F000E9@smtp.kernel.org>
In-Reply-To: <20260823222611.B176B1F000E9@smtp.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:28:26 +0200
X-Gmail-Original-Message-ID: <CAD++jLnpzMs5h-k49HQ_asppECRMm1wGQK8X+vTmiC+S70fZgw@mail.gmail.com>
X-Gm-Features: AcwNN1XULj0_OLH-0JRqQnHBHEobuAmsudZkSXfoy5Pvquc4aYDo9VbQeVhy4Bw
Message-ID: <CAD++jLnpzMs5h-k49HQ_asppECRMm1wGQK8X+vTmiC+S70fZgw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] rtc: s35390a: Add pinctrl
To: sashiko-reviews@lists.linux.dev
Cc: Markus Probst <markus.probst@posteo.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:26=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> >  config RTC_DRV_S35390A
> >       tristate "Seiko Instruments S-35390A"
> > +     depends on PINCTRL
>
> [Severity: High]
> Will this unconditional dependency cause the RTC driver to be silently dr=
opped
> on platforms without PINCTRL enabled?

Maybe just select PINCTRL then, it's a valid point.

> > +     err =3D pinctrl_enable(pctl);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "pinctrl enable failed\n")=
;
> > +
> > +     /* If no pinmux function is defined in DT, fallback to previous b=
ehaviour */
> > +     fallback[0] =3D S35390A_FUNC_IGNORE;
> > +     fallback[1] =3D S35390A_FUNC_WAKEUP;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
> > +             if (s35390a->pinfunction[i] =3D=3D -1) {
>
> [Severity: Medium]
> Is there a data race here since the pinfunction array is accessed lockles=
sly
> after pinctrl_enable() has made the pinctrl device available?

That's a valid concern.

Yours,
Linus Walleij
