Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3652ED28
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577406; cv=none; b=pchB6mlS4zQ3a7hQcp7bVkZxQAXrVYl1kUAX0vIlFSgxMda1z4thMfbN6cPkiPl33g0CuKYG8syP/4m9mlEtKgvKBLdYOUTqhAxTGf5LJnjMf944y/Lbz0LhMQyQ0WGGch5FrwVUTBCw2SZiNxXOsDJAs1KcmgAA/5LyTA+mB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577406; c=relaxed/simple;
	bh=Ggb+PcHRJDo/Cz5nvBOFJMC2dQF5gLYbmIeM6Iqn8Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZwPjdmQaCVv+Tg59qlOYhyCVv4TVTy3BQHuDae5mQd94AN5U+2OUPDz/gtJJFB069nR6cppalNPJI1jislbMIzqF1YHu1EfFgWQKBrMKKNoNoLR9lERpKw0IECXWdZTzXYuUBkMOce5ACk9kxsW+PUJQBh5m1swJonGRfsX1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd4r1GHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd4r1GHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A31F0089D
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577392;
	bh=Ggb+PcHRJDo/Cz5nvBOFJMC2dQF5gLYbmIeM6Iqn8Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cd4r1GHCl9wIrSqnqjtWDezktEP7YxzsTF995HOslNxGGx8emoYeghjU88ngoQ8la
	 ODIi7iiXnwbLDy8NJzUKHUppA/yjwI8DTg4k6INkkeC/k5tkWXRtz8SF3iCERMkKnq
	 NJRgf58SYKgDnJEvzG835+jYXRNfIaOA4gUAmk7WEAfG///8y94nPPLFEzOWOxFLJU
	 P6VzaI7S9n7heLTKA5eMBQiy3AsnTOvEaiacnjt1UmASV9EM88p+9yquXHLKwLs4Po
	 YqwY6p5IoBFOHSIzZDdhx+dmIDaP6H0oeP3LS1r0cUjRkq4oJLBsys+oQQPvYQSEMw
	 tNNcU+93CV5UA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f12so1219546e87.1
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 09:49:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy7FBXVjqOhI4LJuHIWclB2AnKwRybCimx1oxCPvLl/WQ22stGgMoOG0eyfJO0S5P+Ef4kEL2QklHw=@vger.kernel.org
X-Gm-Message-State: AFuF++m5759HCAhPzkOP58NeObHawDC1r7YbBsv/vInNElzVH4AJSSQB
	6yiPO05RpRkQSupJSgCx1Qq9Ylrq0Nimzxg6pCN9K1PWp+pfccE/3c8gjdna5M/UKhs1TDmOJeJ
	3NCCxKhC2YOPX9nlFBx+1aUfsgGX8oDg=
X-Received: by 2002:a05:6512:1595:b0:5b6:422:a61c with SMTP id
 2adb3069b0e04-5b8b666eb43mr1907989e87.28.1789577390371; Wed, 16 Sep 2026
 09:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-3-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:49:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLnHa+1e0N8V0znwzeTZSX1Y5YDAa=cVKSYjeFpZM0o_OQ@mail.gmail.com>
X-Gm-Features: AcwNN1Whb6PQ06lQN_GxsWNtotsS8LqxjoSrqgaYpOWlLWlGsW2D5EFYiCtujyY
Message-ID: <CAD++jLnHa+1e0N8V0znwzeTZSX1Y5YDAa=cVKSYjeFpZM0o_OQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The rdc321x was a 486-class SoC developed by RDC. While RDC's later
> products closely resemble the DM&P Vortex86 product line and are still
> sold under both names, I checked the datasheets for those and found that
> the GPIO and WDT blocks on them are incompatible with the rtc321x.
>
> Remove this driver, as there is no way to run Linux any more on the
> older chips after i486 support has been removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
