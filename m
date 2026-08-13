Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34677415F35;
	Thu, 13 Aug 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618803; cv=none; b=AmWP/BBx6zz/0mXZElLRMo3YbPL25QQQQRfIBY7Y+GLtzahaJK1K+pe34NBTxaledtN0/xnCVIkWQWhqpHBgVa3bjRV8opvmdEbRFYsfgBw9XHGPaNRzDET3+inUEHANgF6ee0rEqRPbc8r3mFSikrAvbqek/k9emCx+CQoK0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618803; c=relaxed/simple;
	bh=nAgYORfhm1lxIxC4ei8CBKHTkJ+UAmIGOgZd5g01V4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPTvrfBcgLMpfvjdCSRMZbxTUapT9uCCBu1en+iyCHQzpHrPsbYv4EwCqV9BJRVq5wbRl3KGP2FsC+uv+sj+Rhb3eeq1TJjaM3zRwFvtU9F2QsvKJfztxpwJLtzRnCMm+ZbA5TyhlvQ+25bx4ugPRm2h5XwdOUI/o5RwiNJr35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymq+n4Ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymq+n4Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A823D1F000E9;
	Thu, 13 Aug 2026 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786618801;
	bh=zF/SUSiiP/uJ2s9U1l64S4bk18A2SuMRPB4CkEY8pP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ymq+n4JuCPCF/jYthcOHmQO+kQJC9AtqmL0kiNOKTZ37YAy1CG42+ozJR/9AzETyG
	 utLM4htc5tNTDJxpBzXI1mQI7Gzni2iq6TcLPMYitNpCUMpFef+uh34ocIh0yPp67Q
	 CKKd6gtHAUOgKmOC2IRzYPOHcuJ/1gKq+3tWounfcbyrR9Qi4xPYo/jU0LttTEE1K8
	 9ysztrkQjjoJ41JJ0rYdPy49cmEe0N50necRqeOWJ2rbRIyJwJlKNh6oVUL71BY8Kg
	 mASQm0aLELkSm39J7XmY9R6M1ZAwjgdiiQMQBUtXm7pLn0lBJdU5fhVF3cy/QeRFFu
	 yi0oHEWNIJC/w==
Date: Thu, 13 Aug 2026 11:59:55 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v2 05/10] mfd: Support for ROHM BD73800 PMIC core
Message-ID: <20260813105955.GA1820248@google.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <2aff89e15aa5b03c955760e5dc50b5e2f17081e3.1785838585.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aff89e15aa5b03c955760e5dc50b5e2f17081e3.1785838585.git.mazziesaccount@gmail.com>

On Tue, 04 Aug 2026, Matti Vaittinen wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BD73800 integrates regulators, ADC (intended for accumulating current /
> voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
> 
> Add core support for ROHM BD73800 Power Management IC.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v1 => v2:
>   - styling
>   - update copyright years
> ---
>  drivers/mfd/Kconfig              |  15 +-
>  drivers/mfd/rohm-bd71828.c       | 147 ++++++++++++++-
>  include/linux/mfd/rohm-bd73800.h | 307 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-generic.h |   1 +
>  4 files changed, 462 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-bd73800.h

Looks okay to me now.

Doesn't apply though, so will need a rebase.

I'd plan to apply this after the next merge-window.

-- 
Lee Jones
