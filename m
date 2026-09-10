Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E44A6CD4;
	Thu, 10 Sep 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056210; cv=none; b=aVi2Krj9ZPWd82TG2Hy0CnaCtcnrqLQEBciq0g3dzLo0x+I0HpB592Zy9c3MP1DvznU81SiWX6TYVChoaquJL4yOfDr90ju2T3735K2H2bMrF+wKIk16+J3TQYkwdvr9A3loAsq7/uI72btFF0EoShMnZMIdHgJfgOYBIwUaI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056210; c=relaxed/simple;
	bh=fI6G6zjHHCmLIfCgwiiWl/kAYe142xZw2mWnXl7HWxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmzT5y5kNZLEQQnXUG42usy82NZ8DtLwQH/+cjQqHdhUV704FQnb4I6+DZcSx86iK1v7aZgyfXQPC3DjGCZgSHy1FvlWmUqbBPEZT0mLvawfxSWUf4bbRU3iUvgSCeNRsSkXgHmRnbrW/whA5AW81IURxD/p4q6vDHU4hKlJIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+hQB9qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+hQB9qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5701F000FF;
	Thu, 10 Sep 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789056209;
	bh=84XiEDPDEJfb3cMvY9aHNVyDmD/qHaJoPbXcuirUEBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+hQB9qm00xBH0VI0ATKHMnBcyuiQhb+fA3ylUtmlYt05twQDwiFP3mQMljP+R9Xc
	 w9Sw4KO6rsd+3phMgQnIBIUQiCs3rim1iDSsUnBMY8DjWH607WahmfVyStLM5Q7x2M
	 NsjascqiZkBMrIQG1ZeN3slu2km9SUCN8U4sUgb9QVimBlPlK/DgrNfStNW8lKH3ah
	 MUI7VI8/1SggFHp/vlTxzM26kQN1Sijvw6p6r0HdbGIu8+5yhGsZq1a8lOwpz7HdGu
	 KsT0EeQ2P1VuL5YZGftSqOWnWrHMnFIUtX779C6pOK2kN054wPTgnu+4PW9tnaAhkR
	 Qv+epneQzxoGA==
Date: Thu, 10 Sep 2026 17:03:21 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Support ROHM BD73800
Message-ID: <20260910160321.GJ1051768@google.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

On Wed, 02 Sep 2026, Matti Vaittinen wrote:

> Add support for the ROHM BD73800 PMIC and compatibles.
> 
> The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> LDOs. There is also an ADC and operation amplifier intended for current
> / temperature measurement and accumulation. RTC and 32.768 kHz clock
> gate are also included. The PMIC can be customized via OTP and it has
> options for operating as a main PMIC in multi-PMIC installation. Some
> of the pins can also be used for GPO or GPI (including interrupt support).
> 
> There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
> the SW-perspective, similar to the BD73800. There is only some different
> default values and OTP settings. The driver should be able to handle them
> just fine.
> 
> Revision history:
> 
> v2 => v3:
>  - Rebased on v7.3-rc1.
>  - gpio: Use gpio-regmap as was suggested by Linus W.
>  More accurate change-log in individual patches.
> 
> v1 => v2:
>  - Rebased on regulator/for-7.3 as it carries dependency:
>    f29a8bf6fde1 ("regulator: dt-bindings: ROHM PMIC state-machine voltages")
>  - dt-bindings: Various fixes, split generic stuff to own files.
>  - gpio: Styling, return -ENODEV if no GPIOs found
>  - MFD: Styling
>  - regulator: Simplify dt-reading
>  More accurate change-log in individual patches.

I assume there will be one more revision?

-- 
Lee Jones
