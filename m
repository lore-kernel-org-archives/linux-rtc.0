Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54D488219;
	Wed, 23 Sep 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159991; cv=none; b=i1sT4f49Efvr+LPGeXrUaYmYNMswiR+RQzmWEujgCtFyfCZB4WVEX7joFmnsxa2yU2S0dikPYJOo9s6opcJ5doJIDU7pLonV1hV7esEj/LvZkj+uLx9PvtPhFh2N1BMB51nUFKLgZRIlN+CGvHypHL/cCKnoHo0y8znZc4bzMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159991; c=relaxed/simple;
	bh=Arr+Pk9u0SVocTQl36TIpT5nBRaI/Dor+901/hmgntE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM68Bt/Hh3OXLaC4hIVL+9bLCKU8LqM83kqcXIacL1NjD47po728L5lU+guuLrJCb+pQGb+Gahtdg2DtNvA0ki7bdz7omI6aBRCNis45qUzIGxyKBz8brl5Gnz4JNJB+WTbi202RV9VFQPpZOs7vPT4oYEyqG+qn1CULFqPXq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WclJHvUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WclJHvUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A557D1F000FF;
	Wed, 23 Sep 2026 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790159982;
	bh=CdtSV7I3S4GXARJ/MlZ1vIM6v2y5jBRNYiU1hXIa0zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WclJHvUmj4JaeLSZXU6G2I811z9PScGQEaqEdIvnudw3Em11lTy8TolUK1xlmmlty
	 clcLY6nH7W6e874RFQP9V/HT1jvpE/FLk1o3P7ZmYHd84/MRYOYeBe4gEgHDy3cs4C
	 kwri9987LqOubeHiEl7xZW0ok6KEI0mglu+7Ls07EfdpIbBRQaHQaRAZJJlxnB1L2Y
	 tFZcUI6kUHGjJJf9GHJd/JiTiTav9kQsgtOubBONsHmwmHem7bRZ2rQqOoGDuxQQsq
	 lsNRojaDXgDSVEugssk2Hvaeq99XVz6vZP+OSD9HSornC5CbTMCFWzf5rOn2d2mRc9
	 UOPRc9/RvVU8Q==
Date: Wed, 23 Sep 2026 11:39:36 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v4 00/10] Support ROHM BD73800
Message-ID: <20260923103936.GD3864833@google.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
 <179015978363.3959854.12736921200463465317.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179015978363.3959854.12736921200463465317.b4-ty@b4>

On Wed, 23 Sep 2026, Lee Jones wrote:

> On Wed, 16 Sep 2026 09:04:04 +0300, Matti Vaittinen wrote:
> > Add support for the ROHM BD73800 PMIC and compatibles.
> > 
> > The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> > LDOs. There is also an ADC and operation amplifier intended for current
> > / temperature measurement and accumulation. RTC and 32.768 kHz clock
> > gate are also included. The PMIC can be customized via OTP and it has
> > options for operating as a main PMIC in multi-PMIC installation. Some
> > of the pins can also be used for GPO or GPI (including interrupt support).
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/10] dt-bindings: mfd: common ROHM PMIC properties
>         commit: 8204b924c6cac2d77af0d000985593d58b8c2ade
> [02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
>         commit: f6a6d948c2e0bd35aa31f635ec5ef42ac7f804c5
> [03/10] dt-bindings: regulator: ROHM BD73800 regulators
>         commit: f08afff0ddd74e2edb11d4be9cdc7b4919d68ee8
> [04/10] dt-bindings: mfd: ROHM BD73800 PMIC
>         commit: 579eae348f7393f14cc864af8c99f7c675e5b1f2
> [05/10] mfd: Support for ROHM BD73800 PMIC core
>         commit: 6f6ebfdd38126edc6cd3f1427ee261d57a83fff9
> [06/10] rtc: bd70528: Support RTC on ROHM BD73800
>         commit: fcf132b701bc8efdef211588f64434b5fea5750d
> [07/10] regulator: bd71828: Support ROHM BD73800
>         commit: e2be91507689f46f973d3ab83901d5e31dbd650c
> [08/10] clk: bd718x7: Support ROHM BD73800
>         commit: 9dd502dde33c60274e1b4962f05194bc16006d7d
> [09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
>         commit: 03888668ce533f948a1de975523e2663d723bbe8
> [10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
>         commit: e8e8d60fe8cc35340f6110ff70ef7959de1c3c0b

Submitted for build testing.  If all goes well, I'll get a PR out shortly.

Note to self: ib-mfd-clk-gpio-regulator-rtc-7.4

-- 
Lee Jones
