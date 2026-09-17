Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5334F796E;
	Thu, 17 Sep 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648235; cv=none; b=uN2OT9Wr6MkWcDjkOTxCTiAT3zaNFosM/CNY0mcZP22eb2RRv/clTfh7adI4geXUEnJj1dgSrPYeF9EOF+qPVqDo4F8SUQ2ArLeiEC4sGLFAaZ5vsgxwQuptpO9v6zDhjpOKb6d4MyWbilEyJvJDROyjMv+FlcSDSOMLKoYLMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648235; c=relaxed/simple;
	bh=y9E0qmad61ygVXko/4eEsX+dGJuPi9CSBZCPY1d+/C0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WKC3w7ykzhQY+DJ08h9fXJvboAu7IDVfW7HQCSALLtDENGzYU8njtDzxnNYz/sroVoAsIVJaVGU+eE9vA3ozcJPdqXeTliPcMSDdjjf1PbUo44NQ8LwJHjDEhZmpo0bjS3Vgi6tD6Ue1uOPdunlyeBG4zjqfXYiPNqI+OtDU3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjmbypyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjmbypyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D81F00893;
	Thu, 17 Sep 2026 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648222;
	bh=Z8hQc7ksnCitkPyzg7DQ/pKlfu4nSKoWUgZDmOnIZRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjmbypyU1WuGM17XWDEt2PqgzIHaifLpZmyQPw1pBmGh+V+ai8TGNVaV/JSIrCOie
	 NbXlManmUjPUTVAvyTZ5JuNWspV+YV/OjhP8q3jrMh+fnuWHJt6j4twWuQfshkRUUT
	 mlt1Twk9igQIkSGBjHFef4wg3++Xg2yWpsbvwYQtPpI/7GEiQnHY+FmYnrbG8tHS2P
	 +Wcsr1BLsvPKnD1gfbtqQn5VW9ulaVP5+bMOaczTzNhCxuUZo5xCDWFoEU2NpKCJiW
	 t+iiy2p95sQn9bEVK49dqsiGfnKJPP7/AYXZLf0DRgNXTDomwT/UcIlp0h5uICPODV
	 4hE6yGfXD7XIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260917122144.703221-2-sander.speetjens@gmail.com>
References: <20260917122144.703221-1-sander.speetjens@gmail.com>
 <20260917122144.703221-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:30:21 +0000
Message-Id: <20260917123022.150D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: invalid $ref to non-existent property charging-volt=
age-millivolt
- [Medium] dt-bindings: undeclared property trickle-charge-millivolt in exa=
mple
--

commit 387f082415e97ddf81bc4779459443584085928f
Author: Sander Speetjens <sander.speetjens@gmail.com>

dt-bindings: rtc: Add property for Raspberry Pi 5 RTC

This commit adds a new property to configure the charging voltage for the
Raspberry Pi 5 RTC within the bcm2835-firmware binding.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm283=
5-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm=
2835-firmware.yaml
> index 983ea80eaec97..1a0432510beeb 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> @@ -133,6 +133,11 @@ properties:
>      required:
>        - compatible
> =20
> +  charging-voltage-millivolt:
> +    $ref: /schemas/rtc/rtc.yaml#/properties/charging-voltage-millivolt

[Severity: Medium]
Does the standard rtc.yaml define charging-voltage-millivolt?

Looking at the standard RTC binding (rtc.yaml), it does not define this
property. The correct standard name appears to be trickle-voltage-millivolt.
This invalid schema reference will cause make dt_binding_check to fail to
resolve the path and import constraints, breaking schema validation.

> +    minimum: 1300
> +    maximum: 5000
> +
>  required:
>    - compatible

[ ... ]

> @@ -171,5 +176,7 @@ examples:
>              touchscreen-size-x =3D <800>;
>              touchscreen-size-y =3D <480>;
>          };
> +
> +        trickle-charge-millivolt =3D <3300>;

[Severity: Medium]
Should this example property name match the one declared above?

The patch defines charging-voltage-millivolt in the properties block, but
the example uses trickle-charge-millivolt. Because additional properties are
restricted by the schema rules, the use of an undeclared property in the
example will trigger a strict validation failure during make dt_binding_che=
ck.

>      };
>  ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917122144.7032=
21-1-sander.speetjens@gmail.com?part=3D1
