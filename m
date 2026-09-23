Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE249483A;
	Wed, 23 Sep 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159795; cv=none; b=SHy8jMMQsf0m7elmCHKbPHI5IpZP7B5EoTCjP4is1wl1dfyPBjyNZ7QiVhYtiQU45OSpTOZN3pjHHbhhJUaGkaEt7faurYrUe4Cnbu/xPZ6yPgeAbiULiV7FgQqMyll623MG/8QGyZCV1zhAp+OS3n9BwFBLYwqm2xLFMrNk9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159795; c=relaxed/simple;
	bh=BNlY5xjtHSj1GEaKqs7rlieTEQ43nPigzufnY7SmXXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=boxlFgEUYw1SYtV/5ozPS1+N3fdMdW7GadVQhSfjHDgrDiitnctk0ngvTeaq6foFw3s05uE5hLnhukxqRH1+HXSg6dM3J2TjCn93OFwR75VflIfgT46cAMLw0ufPfvhdUj1BsRTzerPkd+LGZIu/lt/gdriJvzg5n9+9b6wG7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUcE+u5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUcE+u5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5B71F00893;
	Wed, 23 Sep 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790159788;
	bh=Yorwe0EZnqCqSvsfpdyJVKhkzKAvOjuwrv5FciPTH24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SUcE+u5/Db/88k9SHmSzQ88Rl5almzeblDWCuZRUNoGlTtSkztC2w8BEBMSdk545Z
	 qeZ7UczVMu2vyeR/5pOHvTg5vfW3UTZtmjHBRpI1Vfbpzp9HTqjifadDVlfqszQSQW
	 1GL1A7KesWiPX9347q9s/slxahQ/sDU7hWVh8E83IYNPEREIpWZo6TpE0mGBpwbzzK
	 Wa0WuKqTkSaBtGoAprCoxEMLmGWOG28PEUVn6vH6OxnDcJhIVvR+9PuD0sx0dXME93
	 8CLtFBJhR3iaSkJrid85eph6ZiMzTf9tewgH0biVI2q+26jgIOhFWOVmWNLujr9BQ0
	 6LbxfQTkYwjjQ==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Sverdlin@mva-rohm, 
 Alexander <alexander.sverdlin@siemens.com>
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 00/10] Support ROHM BD73800
Message-Id: <179015978363.3959854.12736921200463465317.b4-ty@b4>
Date: Wed, 23 Sep 2026 11:36:23 +0100
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 16 Sep 2026 09:04:04 +0300, Matti Vaittinen wrote:
> Add support for the ROHM BD73800 PMIC and compatibles.
> 
> The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> LDOs. There is also an ADC and operation amplifier intended for current
> / temperature measurement and accumulation. RTC and 32.768 kHz clock
> gate are also included. The PMIC can be customized via OTP and it has
> options for operating as a main PMIC in multi-PMIC installation. Some
> of the pins can also be used for GPO or GPI (including interrupt support).
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: mfd: common ROHM PMIC properties
        commit: 8204b924c6cac2d77af0d000985593d58b8c2ade
[02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
        commit: f6a6d948c2e0bd35aa31f635ec5ef42ac7f804c5
[03/10] dt-bindings: regulator: ROHM BD73800 regulators
        commit: f08afff0ddd74e2edb11d4be9cdc7b4919d68ee8
[04/10] dt-bindings: mfd: ROHM BD73800 PMIC
        commit: 579eae348f7393f14cc864af8c99f7c675e5b1f2
[05/10] mfd: Support for ROHM BD73800 PMIC core
        commit: 6f6ebfdd38126edc6cd3f1427ee261d57a83fff9
[06/10] rtc: bd70528: Support RTC on ROHM BD73800
        commit: fcf132b701bc8efdef211588f64434b5fea5750d
[07/10] regulator: bd71828: Support ROHM BD73800
        commit: e2be91507689f46f973d3ab83901d5e31dbd650c
[08/10] clk: bd718x7: Support ROHM BD73800
        commit: 9dd502dde33c60274e1b4962f05194bc16006d7d
[09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
        commit: 03888668ce533f948a1de975523e2663d723bbe8
[10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
        commit: e8e8d60fe8cc35340f6110ff70ef7959de1c3c0b

--
Lee Jones [李琼斯]

