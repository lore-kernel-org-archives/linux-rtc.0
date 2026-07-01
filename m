Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764543BB12A;
	Wed,  1 Jul 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891329; cv=none; b=G7ZN/Y4ypbXqNy/Xhj8ZTNo+IHgL4fHUzTppaZ7oUSPdtjx1YbtLKJtLY3VXZacnmOCeQhPXmqdpoQucf9GGvHUwVPuy+6u5XebtN8bgkKphc+5ceHVj8buKSRuPBE+8yuBFLjMA/wjR4iTaf7B3+F1Ji1qKc3Rpt/Iqh96IR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891329; c=relaxed/simple;
	bh=aZI7U+7BKjZ+n1K9QeKPUeY9SHGVXloJko2JcFomq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KULmUvPXY8umYN11vTh6T0SPibXcrXsxX4tZd+hnQp6GM8A2yih65EYCY0d6I8IKrcm3bvCsje1n5KMNv10UGX1HsxFRhK4v0YqDovxVXYz2QFBH0NEIKE4cnsD55O61FKZlUj6Gd/mMNcLuMJ6VrY2tWo4dbP3LTeOTjIr/MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6dXafSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6dXafSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACC11F00A3A;
	Wed,  1 Jul 2026 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782891326;
	bh=PWZJoeJoNohkFigQwsvNlPCMXb9v9+Knd2dj3qEQhCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6dXafSUTFStFuOmQ9Hlh8cWTlu/uF8OU2bnz0hnFaE4kQ0BcAsdvY+1s6751nMc9
	 7LtVFV7eDmbyqrN2lxVQpefZsDQxlNjGB6RQI0aLNt+bxt7rHApl9XJRP/VLixDSpe
	 YpKdRW8XTGReHDQmywiVDtKebmgNtEh4pQpWw4edbxan8nx/2VBpEK+1VDc/RDgcMI
	 RuReQhGJRkXvorgYbnezB5fUr/vwb1CtZtEDQQq1d8R73SLaf1v2u98vb6C4sSWKEs
	 lqksyGJHJZDhQEOwurGU9/7VSZg0t9R2Qma7tWBg5A6qscjF3zRaKTeq49H1oHW75O
	 ppjneriYIgHpA==
Date: Wed, 1 Jul 2026 09:35:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add sii,wakealarm-output-pin
 property for S35390A
Message-ID: <20260701-bronze-jaguar-of-perfection-028bac@quoll>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
 <20260630-rtc_s35390a_int1-v1-1-1b2239e16be2@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630-rtc_s35390a_int1-v1-1-1b2239e16be2@posteo.de>

On Tue, Jun 30, 2026 at 07:22:21PM +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
> 
> Move devicetree bindings for sii,s35390a into its own file.
> Add sii,wakealarm-output-pin property to enable the use of the output
> pin for interrupt signal 1 for the wake alarm, which makes it possible to
> set an wake alarm on Synology NAS devices.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 54 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |  3 --
>  MAINTAINERS                                        |  1 +
>  include/dt-bindings/rtc/s35390a.h                  |  9 ++++
>  4 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 000000000000..31a578673870
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: S-35390A 2-WIRE REAL-TIME CLOCK
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>

This should be someone caring about this hardware.

> +
> +description:
> +  The S-35390A is a CMOS 2-wire real-time clock IC which operates with the
> +  very low current consumption in the wide range of operation voltage.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: sii,s35390a
> +
> +  reg:
> +    maxItems: 1
> +
> +  sii,wakealarm-output-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    description: |
> +      The output pin to wake up the system.
> +      Default will use the output pin for interrupt signal 2.
> +        <S35390A_OUTPUT_PIN_INT1> : Output pin for interrupt signal 1
> +        <S35390A_OUTPUT_PIN_INT2> : Output pin for interrupt signal 2

Does that mean device generates the interrupts?

Best regards,
Krzysztof

