Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5744163D
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134212; cv=none; b=KfduIG5ql197blE+PDlCrzZu0UjU7gENsphz0GGYOTsQL6kNl+uJ2CvNZ89/nBoBJfbqiv6b5um2NnMN64tE7RGfJ4Nua59EoRXtd30RiFI3Ine2Ek7gP0Tu0CiuBOsFddF6zV9fCuvkXKVLs5RHOAayzZXV6ZScrVP7NXXjsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134212; c=relaxed/simple;
	bh=jxcH8eZGKIgBbAGtXktUmTUcGx6/TN/TNRYvri5Tjq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKOi1rlX/upJVevOJ1dR7quJUxGdLtlvtgx3JeWVr8w83I6A3DiPm0DQS01hXXAMjw0beb+BexFcTTKKsHsFB8xgLJgLDZ5HuW1QUGJfF9jgNu7Q7ytfdbalRLMdlFPgR9kyKhguA+kFqOsJ+LPOhbhP98TOXaJAgi9fk/AcDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXQvUrvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXQvUrvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB041F0155D
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134210;
	bh=Jwrr4lVLGS11GjYrZqe6FfMEjh7fA/X3L7gVPhE5eMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IXQvUrvEBQpVKfIxZLystaXIqW7iTRokJfB8X8FxrNtvQwt3gJfSOSqfMPV+m/zt2
	 dwsgF1VMuVbr8frMS6k8oyVuZ49RBcBeT7yGfJTXgQVtGAOZWB5kuCg/Z0zTexgmsa
	 CmYN1yFyruBG970nfZXJ12dIXteHFQDh8MI9/Fn9qqZMfxSw2MNEDPliW9Le+O2lOk
	 ZicCqxJILGu5B9DPN9gKgatCF/BN7M4ywd0fm5PBjyCQD4HaA1f9DMXG2zfZFU/ihE
	 Q723bOY0jkGeS29A4fp0voiNac9d9n334yYf4aGdryBLI7kxfbTqzYLtyRKStsu75o
	 UuOlduR+wX+TA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so3938187e87.1
        for <linux-rtc@vger.kernel.org>; Fri, 07 Aug 2026 13:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbH94WVVJ14/vb7ucBIa5rMDP82vcTDoP3FmFK3GPbcoyFpfId9oDGETM8B29h2RYSXVlAtfbvpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzArs1wxJZNfmj1vDUpMt9a2+zJKR0hKiedCQ3cdA12Zw8kgJv3
	Veng5XOazXRN8b+LwlEUypHpXUiBDkF7Rwg1Oe+juDb3hGZQrxWjlZMmgvZEVw+ZArOwmBAZqc8
	LSKe9HBA3bagmfGGLcjYc7ns7WZ3QzpM=
X-Received: by 2002:a05:6512:3d8e:b0:5ae:ba8f:f9fd with SMTP id
 2adb3069b0e04-5b30b728f72mr381168e87.9.1786134208666; Fri, 07 Aug 2026
 13:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785838584.git.mazziesaccount@gmail.com> <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>
In-Reply-To: <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 22:23:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLky237PRXNmyURjNEOPPgFV00ox1HBeBev=qADxKM3nWQ@mail.gmail.com>
X-Gm-Features: AUfX_my1uSeJQFZWOjjbDePuT4j3HCVXBhkgikPPCovD-qQ5-mA5ffWK5vqmoGE
Message-ID: <CAD++jLky237PRXNmyURjNEOPPgFV00ox1HBeBev=qADxKM3nWQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: mfd: common ROHM PMIC properties
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

thanks for your patch (and the other comments in reply to the
old review).

On Tue, Aug 4, 2026 at 12:20=E2=80=AFPM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> Sometimes the existing properties aren't 100% what reviewers would
> prefer. When issues are minor or just cosmetic, changing the existing
> properties is not feasible. Reviewers can't be expected to know which
> properties are new, and which are existing - and this can lead to
> unnecessary review discussion wasting time and energy from everyone.
>
> Adding a common file for re-used ROHM PMIC properties should make it
> clearly visible that a property is re-used, when a new PMIC binding
> refers to this file instead of (re-)describing all the existing
> bindings. This will also help keeping the common properties identical
> across the variants.
>
> Add new file listing commonly used ROHM PMIC properties.

I see the upside of this, the DT binding maintainers will decide
on it. It has the upside you describe, but it has the downside that
new components will always (ab-)use the old properties maybe
even when there would be a good opportunity to modernize
the syntax, and then the reviewers will not catch it.

But well, maybe that is not a big deal in the universe.

What about patching those old bindings:
Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml:
rohm,clkout-open-drain:
Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml:
rohm,clkout-open-drain:
Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml:
rohm,clkout-open-drain:
...to include this file as part of this patch, and delete the old defines f=
rom
those three files?

Then it is clear what is going on.

Maybe this happens in later patches, but anyway it should be part
of this patch I think.

> +properties:
> +  rohm,clkout-open-drain:
> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmo=
s"
> +      a.k.a "push-pull".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 1

Yeah I see now that this is already in use in three other bindings...

Today we would for a new component use something like
rohm,clkout-drive-mode =3D "drive-push-pull";
rohm,clkout-drive-mode =3D "drive-open-drain";
reflecting pin control.

I do understand the idea to keep using the same bindings
for all of Rohm MFDs. But when a completely new design
arrives with many new properties etc, maybe we can think
of something new?

Yours,
Linus Walleij
