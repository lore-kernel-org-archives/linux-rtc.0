Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFF49B5D1;
	Wed, 23 Sep 2026 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160152; cv=none; b=hmlBTtjOy44rHOdm5aAqwCKAL3QXyaE9lEruOdtKiyHLSoVg95yW0ApEFqHa6PlykaZHzgYN8Et/ugoRdr6rfjFmv70obIdg0PoJnmgPVhnSG0R7oQzQsIhEVhQ2WdTqbewc4zogYvFRsE0UGgsDFXs2ZGtoTtQEj4+ibmbPUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160152; c=relaxed/simple;
	bh=wUOb2sM407JGfun8yuw61WHv31lhAKHbNzhn3hhvWQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLQrS5PW/O/sE1gMr9Ab4SLvUMCBEJVIdbRzIZ8XNk6ZouEOr1tLSHkk4BiA2RaAUYmcaoDJVsOvfFwLJHUw6IwD5kOaTmAHnSkNdVke4wGPJQJ/oL4clKLSujaR9kLTox6SgKPJG1Noye1LcIf0CU7ZN0r366f3RKhO+M7CRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4tDqV+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4tDqV+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FEA1F00893;
	Wed, 23 Sep 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790160124;
	bh=FK+AjmoA0TKnO1bUPeRO+p0QSIcNS1kcrkBYx1ce0JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y4tDqV+fHrrkQtP1ZBfkoYoF938u49QQf/JmSDYwxk/lf/axZV9U04VJSIWKHOuR+
	 gYrKLCAzy+2ewBwlBLrHYaRqWW6KabWXavGwrAsEaAqaYrB2Ggq3uq9SJs1fgFJSZr
	 5LxjeTbFhs4AbCdfLIoqWIdmSFaZWfzKKkKZypLRd6vsl+q5UydRpNxUByHKIyxhkj
	 y5K34k4Q092J7qjkp6Bj+vE06r47FgLtCuhpx+7aNxQ5RuYceIcPo5sSRRywT5KWnX
	 glrVGm9qd3t7dBuBNAOJDRn5mh4HBBQGPhB1jf4bzaRO8jlTp5YVD+GW71gDhBwlN2
	 ZcuE4RTuNxjGg==
Date: Wed, 23 Sep 2026 11:41:58 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH v2 05/10] mfd: Support for ROHM BD73800 PMIC core
Message-ID: <20260923104158.GE3864833@google.com>
References: <2aff89e15aa5b03c955760e5dc50b5e2f17081e3.1785838585.git.mazziesaccount@gmail.com>
 <179015977961.3959854.10449911449922087290.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179015977961.3959854.10449911449922087290.b4-ty@b4>

On Wed, 23 Sep 2026, Lee Jones wrote:

> On Tue, 04 Aug 2026 13:21:58 +0300, Matti Vaittinen wrote:
> > The BD73800 integrates regulators, ADC (intended for accumulating current /
> > voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
> > 
> > Add core support for ROHM BD73800 Power Management IC.
> 
> Applied, thanks!
> 
> [05/10] mfd: Support for ROHM BD73800 PMIC core
>         commit: 6f6ebfdd38126edc6cd3f1427ee261d57a83fff9

This is a tooling error - b4 picking up old versions.

-- 
Lee Jones
