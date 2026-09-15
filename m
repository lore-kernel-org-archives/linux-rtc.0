Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610244921B5;
	Tue, 15 Sep 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471254; cv=none; b=RqZZaUb/O7Ltv1BYSXnzHTwE3+tPeqoAmbqlT/EKc45MA00onZ6+Xx0A9VSfD6kjJQNunimMDl294Ccv6qWDRsOoaNbWFoikknZ+DfaQKDB00P8JhZo5ssuNVeGZKjhzFAvyiFve2eW4w60twAwfgoQ8RaOv/+8IRvTnUAJXMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471254; c=relaxed/simple;
	bh=siLcs2ByTAF0pFCikkBYhH71z48AUdtdjGzM5szdd94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOeDQ8gHWotwV6iWexuXRBFQn0eUDFgGF8q46vn1MtcZnHRZmzWKQxi1x9okgxxSdhQVjNvk2YooH1pHiJRd1wZ3ENFvC/WEcRnCU6D6oRlo8nzRDUEAHER3SsHFKs4iLWXQ/hua8/UgMIO6XgYyWaHdiHnddRMBQ5jLPh796fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghkbHlFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghkbHlFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FEA1F000FF;
	Tue, 15 Sep 2026 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471253;
	bh=0Zur3awtpZNFBjj1RLFq6fg6GwhV7kj9X9hb3EuvsPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ghkbHlFq/Ea3fdGX7S6AZLmmMfkNDpQSYNtzktm+QTBPIaxJ/cnjN2Cftbpb5yMje
	 UT29lJA5gCNxKD2G8To7rxQ9N9LORJogXVgkERy3dJQrLV3SZnAvX69SrOlgmwcKvg
	 F6aaJ4D0vbzXkWT+nFvDgAMLfXeaNgZMryO7HLUjqBLG62ehVUzm/yiAoyIDDDDYge
	 MSr1+hVEVEqKHX5cXSCyCIlVy5O4ECEM+40Bitn1v5rDjEYNPWYUR+AdiR8LX0OB7b
	 IgGfioa12zxCJQY1dtBj+u4MGebgX3OuzjURs0n/ALBznU7pYY3gZo4VOIaHfLgzZD
	 +oKhhtMIhl+yQ==
Date: Tue, 15 Sep 2026 12:20:46 +0100
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
Message-ID: <20260915112046.GG11487@google.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <20260910160321.GJ1051768@google.com>
 <eb18485c-50db-4823-9e06-362b968699cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb18485c-50db-4823-9e06-362b968699cc@gmail.com>

On Fri, 11 Sep 2026, Matti Vaittinen wrote:

> On 10/09/2026 19:03, Lee Jones wrote:
> > On Wed, 02 Sep 2026, Matti Vaittinen wrote:
> > 
> > > Add support for the ROHM BD73800 PMIC and compatibles.
> > > 
> > > The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> > > LDOs. There is also an ADC and operation amplifier intended for current
> > > / temperature measurement and accumulation. RTC and 32.768 kHz clock
> > > gate are also included. The PMIC can be customized via OTP and it has
> > > options for operating as a main PMIC in multi-PMIC installation. Some
> > > of the pins can also be used for GPO or GPI (including interrupt support).
> > > 
> > > There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
> > > the SW-perspective, similar to the BD73800. There is only some different
> > > default values and OTP settings. The driver should be able to handle them
> > > just fine.
> > > 
> > > Revision history:
> > > 
> > > v2 => v3:
> > >   - Rebased on v7.3-rc1.
> > >   - gpio: Use gpio-regmap as was suggested by Linus W.
> > >   More accurate change-log in individual patches.
> > > 
> > > v1 => v2:
> > >   - Rebased on regulator/for-7.3 as it carries dependency:
> > >     f29a8bf6fde1 ("regulator: dt-bindings: ROHM PMIC state-machine voltages")
> > >   - dt-bindings: Various fixes, split generic stuff to own files.
> > >   - gpio: Styling, return -ENODEV if no GPIOs found
> > >   - MFD: Styling
> > >   - regulator: Simplify dt-reading
> > >   More accurate change-log in individual patches.
> > 
> > I assume there will be one more revision?
> > 
> 
> Hi Lee,
> 
> I thought everything was acked and good to go?

I just saw the nits and commented before the blessing.

However, you may as well fix them and submit.  I'll apply the set when you do.

-- 
Lee Jones
