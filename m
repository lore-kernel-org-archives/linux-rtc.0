Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820E388394;
	Fri,  4 Sep 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532487; cv=none; b=FoZZHCH4LWJGWMyIXctk24lH9HBsDdCYeB7hH3UQ1S3fjfx/pru0Vpq715ZTaYb4CpEudEKj0AYg6zF2lkmTIbJQHJRaCuUbbMUP6sKeBVteZeRYQ3ZhpHbtrp5x62jnVFgeykQLXKzBQq2yTdX/KXEqYdGFrFEaTld0VaI552w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532487; c=relaxed/simple;
	bh=ZOcJz4VKgIaZSVrxwJdB0NWRdBJxpHxtdZulu2lUDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2/ZAZLnQ5ILJDtBRaZkj6aerYmGPgBUKLWHw38PlODr9KGRccUTvxmM6Yb2+u6emuhdpjbQznLJj7YPhjpP0jxc9Vn+KNcO9fRdlEi5yQr89FhUomyKTdAbX+Sf9WookBpThwyPmI5W60u3Sld3trW7KQ+5628d3ULPsXekILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmLxy/1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmLxy/1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598861F00A3D;
	Fri,  4 Sep 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532485;
	bh=7EcoNj1/sml6UkFlH1RlyQKOpRweCfdT6OyMJP6hJyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DmLxy/1k79Nfua3ef6ZTn95wacth2XlZbtZnE5iSZO/i25jEmNxtF/0Wk16HMzDpF
	 30l4iwgUC7CA72oxecl+ZpZeGX93Uhq+273iT7yOgvTU+9Pg+dazczZhyK88OJfVCO
	 DpgrCGIZp/m2dGzWMlp+XmXMErTK6wotUJ/xKbGUVak+LV/9SCxoABTq/jLFqaoy7/
	 6+obgYyPpWbbxSZyx9aYf8vzrPOwh916wIrqqCkhqBjeBNgHG/fqXM2TRGgerXPvDZ
	 uDPvuHCNb81zrkfc2/evIx2EaHdCkoJvuFu0q3v5+wC66gsnK/P6vuAkX6nwajuiPt
	 S3bVGsf3DCxLQ==
Date: Fri, 4 Sep 2026 09:34:42 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH v3 04/10] dt-bindings: mfd: ROHM BD73800 PMIC
Message-ID: <20260904143442.GA516529-robh@kernel.org>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <bcb75af1ca9c030df83846528e896640f53eaa5b.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb75af1ca9c030df83846528e896640f53eaa5b.1788346553.git.mazziesaccount@gmail.com>

On Wed, Sep 02, 2026 at 02:04:30PM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
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
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v3:
>  - No changes
> v1 => v2:
>  - Reference commonly used ROHM bindings from a common binding file
>  - Simplify compatible list
>  - Move relevant comments to description so they can be shown in
>    generated human-readable doc.
>  - Allow other clock-output-names besides "bd73800-32k-out"
> ---
>  .../bindings/mfd/rohm,bd73800-pmic.yaml       | 218 ++++++++++++++++++
>  1 file changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
