Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664295A985D
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577615; cv=none; b=e57UqXPTTWKlp2SvNNHym/TUv6efFm9piRPrY3iuqy5+3CmrhMUI3WqNlgDLw4tNjSy25QWuexscaKtwzvYNI+fRJZhkGwCacLinexPobfttijW9HX7EdMj7owGel/CQHtCfISmn4GAmr3f3EW0dwpoaGPI2jvCeMQvfkLUzmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577615; c=relaxed/simple;
	bh=A8OUnScFkntcgVv0El+XRQhsZJJugzhrkrqucm1xVqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwAGUtt873b5hRb6GiLbWVDkuFVASKTLhxK9cQ02hsD2WbP3amh4ofsMsxfLt519rz90r/SbwuSRXjbK/e5hnuKpyoh73RIcJnHLcPT9arm3Q/Vcue8/jzvmAXUEEhoE+10Rf6QzZb9e5FtHzWxpsfOq9GRjDwEB/vqollGizZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ//Aepn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ//Aepn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6471F00901
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577606;
	bh=A8OUnScFkntcgVv0El+XRQhsZJJugzhrkrqucm1xVqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JJ//Aepn20JwNBvgjPe2RGPw3W1TnzMJZL/1hbP4HXBkwn7oafbEKxyAkD242zIlA
	 mxiFlxtkmChee+seVVxgSwqzTw2/2qQK0we0712tsN07f4SxhiZzdIQV4fEFge8P3/
	 eXve/Ikiuca0hD0ksm1quV6jvVcfQKngvgIPch06kggcScyYBReWU1BZQ4w+BDChhO
	 cGkgQlSSPeS1/dDsoagEKEc13m+IpOu4TIhAfls9D/+S+C/kUAOQgOb9jAwOjq10Cs
	 9vCLGY4l6ToWfXsrjRRPyQjen+4pYHsH5KDYWCIGz6+YqUeRWbKAAdd7LHAkuCR8Qp
	 yDeQXu92KeBiA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso1244157e87.3
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 09:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByoe7X74Znb3zfxHZMnf/lDug7SLd7uWjRXbtxO/Ud5xQrzqKQ0d3GXitfReDztN0N5fRnQUdjfGy4=@vger.kernel.org
X-Gm-Message-State: AFuF++kAI8sG9jlzDzWfL8sd3+Z3eiPE+ZwQAMzIQ+M6eq7d9xJmzCuE
	edaqAKobPheZspjIwu4Y5Y6IolUKfG3UPmlLabr4A0l8PFZpFJoMK8MHGGrvJ0ssBVrzrHyBFon
	/MEuS53TSxTdkDEtmafiPrf4m50sdx+Y=
X-Received: by 2002:a05:6512:3e07:b0:5b6:95e:87ce with SMTP id
 2adb3069b0e04-5b8b660a94fmr1957280e87.2.1789577605581; Wed, 16 Sep 2026
 09:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-15-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-15-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:53:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLk-e58uiZ5JfiKtW+4tKoVyCXrEz9n4W52PnmtKLqQrEA@mail.gmail.com>
X-Gm-Features: AcwNN1UPBZKZl1X4uCVkQyjhp-cH_klICrLDEiep9UNQdzrrNpZtksTPMzubFl4
Message-ID: <CAD++jLk-e58uiZ5JfiKtW+4tKoVyCXrEz9n4W52PnmtKLqQrEA@mail.gmail.com>
Subject: Re: [PATCH 14/14] mfd: remove unused iPaq micro driver
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

On Wed, Sep 9, 2026 at 3:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The iPaq support has been removed from the kernel, this driver is
> no longer used anywhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Also delete the header as Sashiko says, with that:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
