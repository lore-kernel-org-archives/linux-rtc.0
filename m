Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960023C4563;
	Wed,  1 Jul 2026 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933961; cv=none; b=apiPVKgYyz9o33LJFtJjBdu5xFio8piSR2ZetJjWT6sLInlHfVmIJ1mX/pAtItLrR/AAH10PBN3T+ClGkfTHpSO7ui+32LbTAyJ3/Dg1ozOmfNmEo/Fj88aRWfVNQznjsLGPYKGPGZrK/vFiRSZTwKgLvl5J7dpim8v5BOtuAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933961; c=relaxed/simple;
	bh=NjqY31L/hPR2GtxDdcR4BkPlGk4IZewA52wrGFx68+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gISMtf8pC6mYO7B+ylavCS0GjYkP94JmO2I4ffsp5Lx7QQRxETCGkLV8ffXxEPC6CmLShdN9b7Ow3/B3zHradknFafodUa0vGvXV4dMieszeFGquHzlXJ8KMd9CQnbg7cyJtBkjK+5WwnxBQG+4d11hSZc7FMALGRqs0I5/FCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtmfAsP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtmfAsP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F7C1F000E9;
	Wed,  1 Jul 2026 19:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933960;
	bh=Hlt8HcuxzVdXceSeFSjgnQdhSfGtT5nYre5bxpszzqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NtmfAsP+p5PZJd/iqbrKLEsBa/u7Kt8ZrmkAPMdj2XhZoV+kSgHcVjFa3JNvHcK5b
	 TlPSCiNXyQ8v4i3+oKwMNYb4kqL18EmaRLJswzA5FsW+f2d8WMYIszjSepNZEOYb5R
	 /kdlp4CM/zKZ2AkVRyUgqB3UaWp0y9WujSTO7Uk7A8wjmBKk5gA/z2CQH4FMEwmVA5
	 LwgVLtFftGUkrpf3dm7veP8WNG7J+CnWb3/awxCCjwPnDyXy/mE/rwfYoNkWEshXcb
	 uVdIgpxYgXlmfFYluMXk/92PCdJJEN1okWe5P6LJXYE0SDW3DFchbqOj8WTQ9F+38a
	 B66BbiCK8O0zw==
Date: Wed, 1 Jul 2026 14:25:59 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: regulator: ROHM BD73800 regulators
Message-ID: <20260701192559.GA1313239-robh@kernel.org>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com>

On Wed, Jul 01, 2026 at 03:41:11PM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Add bindings for the BUCKs and LDOs on ROHM BD73800. The PMIC state
> specific voltages can be set in same fashion as with a few other ROHM
> PMICs (for example with BD718[15,28,37,47,50,79]). Same properties are
> recycled :)
> 
> The LDOs 1 and 4 can use different voltage ranges depending on the OTP
> configuration.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../regulator/rohm,bd73800-regulator.yaml     | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
> new file mode 100644
> index 000000000000..c427a04098ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml


> +      rohm,dvs-run-voltage:
> +        description:
> +          PMIC default "RUN" state voltage in uV. 0 means disabled. See the
> +          explanation below for regulator specific details.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3500000

[...]

> +      rohm,dvs-run-voltage:
> +        description:
> +          Set the default output state at PMIC's "RUN" state.
> +          0 is disabled, 1 is enabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 1

Same property name with 2 different meanings. Not a good design pattern.

Also, if these properties are copied from other schemas, don't duplicate 
them. Put them in a common schema and reference it here.

Rob
