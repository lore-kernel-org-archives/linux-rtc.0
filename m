Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71640B100
	for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692382; cv=none; b=dFtw48MAtXuVdwCgCUJ4F1a6NwUJ9x83/XtJUKb6qCPUTl5yDgr4+13tuCvubxcjWFDzW1rgQJigca5XIblhmlahVHKsxhBhjNVZhvEc1olL0+DSK09RoFa/M+yJgcCd5/xK5BfcacL+XPADcvzAB6pfzaqDRx699davumoiRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692382; c=relaxed/simple;
	bh=XUQT37v5nndWRb0WlzDNA/x4ySUuWCY6uRQ4HzaiAOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoPstOupHVah2ED0wyn8/3+N7etKJt3xFFctIkZRv74lqNSFlH117laqM5w2NLaJa4lePUavNxsYfZkT3NqHKnX/Nh9UESb10WNqb55r3HRx9sP9XFsyjyAWO4RaSKi0hWnHv7c7RLTEOPvg35kKMC519bMJ/Aowzbm+TpYRdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiACllOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiACllOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6999B1F000E9
	for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692376;
	bh=XUQT37v5nndWRb0WlzDNA/x4ySUuWCY6uRQ4HzaiAOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OiACllOFO8QIAhf7lvLqsh35TAFyWvCe2xq2GXnZDpaFdAjecqBiw4YZwYFskiXjX
	 /d8gLs5hZuR3Kq357/4oocJQCGu/IQ/pYyMzccY2/vfFsVN/3m+96EusRCT+RpsYmr
	 sGL2dn4xdPbeEC+GD4CWZ6I5SLa6AKx6yL5c6SldwZ7KNFuhtbrgQvhzsoYc130sRI
	 T6+Ud+WZbVXy6WGydsDXWMbs4HbdeEiSU5dVgPq+7+D1If1tyLR797LO+bqv18Ez6g
	 hrfRD26wtoqXLuim5hUZPNJPO9cl9GfO4O31Ny5vQXr0dwoCBARnKmjZtNL062XH5i
	 n8TAKAFJ6fsuw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so489215e87.0
        for <linux-rtc@vger.kernel.org>; Fri, 14 Aug 2026 00:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpyQf7drE3wHFibzsE9vyOsyf4xoPARXG9mIaLzarG2EOOTMDGW9RGrASi7DQbf/4FtN+rhj8VlAdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhB81o9PQ6M+58ypOlsGEd2Qjr98Fo4x9AZA2U4b/v+TPMuxv
	SarzIe9btnu911HwNmRIofnnSVuTEW7ckKBWr9fNmu2P3ULimBwEDoIO0wQRhNbE66DMTmIofJ7
	LdtRUdSU5dXOuHHBMT3Wj86nvGVdA7/I=
X-Received: by 2002:ac2:51d1:0:b0:5b2:a328:cdd5 with SMTP id
 2adb3069b0e04-5b45919ee31mr544880e87.49.1786692375262; Fri, 14 Aug 2026
 00:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785838584.git.mazziesaccount@gmail.com> <d419dcf8776f7ea88e4a66b9a0f0087f11e6622c.1785838585.git.mazziesaccount@gmail.com>
In-Reply-To: <d419dcf8776f7ea88e4a66b9a0f0087f11e6622c.1785838585.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:26:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzLiyBsDi2zeR13_95hpip7i3fOSwMbMXD7KYeJj5X=w@mail.gmail.com>
X-Gm-Features: AcwNN1XqzgmqVA0UuXzJafrByAbtpxUiXy_C_XbrwJ4yAGRJ9EaFb9OIaRI3WXM
Message-ID: <CAD++jLnzLiyBsDi2zeR13_95hpip7i3fOSwMbMXD7KYeJj5X=w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
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

On Tue, Aug 4, 2026 at 12:21=E2=80=AFPM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The commonly used ROHM PMIC bindings were added into
> rohm,pmic-pins.yaml. Keeping commonly used properties in one file can
> ease both the maintaining the bindings and the reviewing process.
>
> Reference the common bindings from rohm,pmic-pins.yaml, instead of
> declaring them from the scratch for every PMIC using them. Keep the PMIC
> variant specific information (like supported pin functions) in PMIC the
> specific files, so unsupported values won't be allowed.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
