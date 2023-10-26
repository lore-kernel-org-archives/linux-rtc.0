Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90B241FF
	for <linux-rtc@vger.kernel.org>; Thu, 26 Oct 2023 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgZFo7/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BC9C433C8;
	Thu, 26 Oct 2023 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698337004;
	bh=BFubqvJkHpLj0HpJKrGhUtfQbwT9TteI7Gx9CdXrw24=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=PgZFo7/Cdx7056LUPcwJJm0kJbhl3jScYrwfapVlKunTgHQ5EuGw3n9EWEsjfOqUe
	 FO2My5r3PzEREKq2sQFS9GS41rj4vwZeSl+NGNAlEEArva6e1yDkzTOCfuX88sNiNC
	 gBxLEQFKriVg0mlkl3fAf3iWrG7GgTrp5SndlMRmAwK+qP2+8AOJST4i5Pd1mWgL3s
	 W60R5Trt0Hjx7cIw2hVdrLj9L6gxS0QDwhfR84ZWl6ntMbC/4+zacKashrsuIvHUIl
	 FHE95doJMBun6Gp6kz0JFRGbSEDXck0TpGEXtLjTf9p9wlEq3Pxn/yYY+jZdwtEmZy
	 gm51JpLcJDy8Q==
Date: Thu, 26 Oct 2023 18:16:29 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, arm@kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] platform: cznic: turris-omnia-mcu: Add support
 for poweroff and wakeup
Message-ID: <20231026161629.wy4d54o3vy3oxpfw@kandell>
References: <20231023143130.11602-1-kabel@kernel.org>
 <20231023143130.11602-5-kabel@kernel.org>
 <ZTbMPcP7HmBvY4YP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTbMPcP7HmBvY4YP@smile.fi.intel.com>

On Mon, Oct 23, 2023 at 10:40:45PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 23, 2023 at 04:31:27PM +0200, Marek Behún wrote:

...

> > +	tmp = cpu_to_be32(get_unaligned_le32(&cmd[1]));
> > +	put_unaligned_le32(crc32_be(0xffffffff, (void *)&tmp, sizeof(tmp)),
> > +			   &cmd[5]);
> 
> Hmm... Why crc32_le*() can't be used?

I am adding a comment to explain this in v4.
Thx for review.

Marek
