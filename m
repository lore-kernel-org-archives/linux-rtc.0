Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D64F93D3;
	Tue, 22 Sep 2026 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091957; cv=none; b=JSGnWpozeoXNcIesNxDVKtLiUjPdfEld80Zu0/krPbftChytbk4dwVPirn2lRo0pZVse5mTm3NMm9G5MjjS4LpoYZgr9I6yrG107CPdszUHRKQz3cuXrYqY0RaWCN8xRU9/xFITY52ClsUZURQE3AXXnmrd0u4OXw8KZq+Fh/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091957; c=relaxed/simple;
	bh=VYFqxBIbyB8AcZseEeHLI4kw2vkZo4hD06tuQk0zeBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN1NPkVNaAsJuDreSIM8zOgoyjQvXkGDyrbvRDZUrMl750BcLtmxT9o6W2yYL15FZKtGOjUrJeki3DpUEIZs4A78tEiTYsIE//e/gVmD81Cm5nvBhoZSvcaQu5dgRJDY5rF4JmSck2gaWwUykQ4LnwI9cu20HicZui60WM5JsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZN0gVgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZN0gVgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30431F000FF;
	Tue, 22 Sep 2026 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091950;
	bh=VV+D1TTg+nypS71novJcWW8ckPVaKfjhtplAFFx3irU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZN0gVgqMvvffTKAv30e20/TZg2qTPisQ9G0Z9l1JmdgLcblHZpkPps5E3LSvbLut
	 ytiMNuEFPf0/3pcXVxjb+8Aob8HtErzgWRxyhVEYLmhYQ8vLG0TTbBMMkDxYbFQkwl
	 VUe4PrvyFl+CJDvBFNn+xSok3n2oRLwAKoFFFWiLFR+K+1Ao9Zrvof2xtWzOGIwcKs
	 Bhw4WEkx+2BSgH9n0smddGHx43kcd65aJ9sW41ykmDJrzWgyClpRD35WOcBbQfxXnf
	 Otm4k0kvOVtgsI8/a49+6+fmJniIOKIcu5spCMmbLV+F/Eycabeg0ISVzZ3Yc5c3yp
	 /KNSop71bhHGw==
Date: Tue, 22 Sep 2026 16:45:43 +0100
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
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v4 05/10] mfd: Support for ROHM BD73800 PMIC core
Message-ID: <20260922154543.GA3438784@google.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
 <3e3a25abe337e3f68cde585674019dca439ac897.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3a25abe337e3f68cde585674019dca439ac897.1789538455.git.mazziesaccount@gmail.com>

On Wed, 16 Sep 2026, Matti Vaittinen wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BD73800 integrates regulators, ADC (intended for accumulating current /
> voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
> 
> Add core support for ROHM BD73800 Power Management IC.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> ---
> Revision history:
>  v3 => v4:
>   - Removed extra whitespace from the end of a file.
>  v2 => v3:
>   - Translated this:
>     https://lore.kernel.org/all/20260813105955.GA1820248@google.com/
>     to an ack. Please, let me know if this isn't ok.
>  v1 => v2:
>   - styling
>   - update copyright years
> ---
>  drivers/mfd/Kconfig              |  15 +-
>  drivers/mfd/rohm-bd71828.c       | 147 ++++++++++++++-
>  include/linux/mfd/rohm-bd73800.h | 306 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-generic.h |   1 +
>  4 files changed, 461 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-bd73800.h

Looks okay.

Let me know when you have all of the Acks and we'll merge it via MFD.

-- 
Lee Jones
