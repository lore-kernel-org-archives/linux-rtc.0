Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124DC3655D8;
	Sun,  5 Jul 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287500; cv=none; b=Hh8zDR2IZRApCCwxzFhB1aeZD56I50cIwlbkkB3wD+p4vPPcoJUgAHMYDTNqAWizoyyCA8bhPrKU322sqB03fmZFTwDkofk3pOIRz4opnJmcrZq+wnhtzd1vlpjgRwXKrDulUIVIIOFVN+Ue0I+RXejFal34qPyTwFu+hBkdKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287500; c=relaxed/simple;
	bh=BZCFyvAp+Vakhg8GU/XUEwv9cpsIlKucQW0JPePX1JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr5clFrETdDeHhy5A2+cGAsUYEvPl4fcgDZtiDSCktlknFItDku6jYQ0y4di4Q2TD1Xva6FTIFezLQ0p7uKMaQBv+z4+ttP+KYARsJXnc5oLRi4WggyIGuA08exv/NQu5IpflwPBmDH/IlFW2+rlvqqB7TXI8g/4LiqPQ5VwIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=db7Tpjhv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="db7Tpjhv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B337D4E40C02;
	Sun,  5 Jul 2026 21:38:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FD77601A2;
	Sun,  5 Jul 2026 21:38:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9652E11BB95F0;
	Sun,  5 Jul 2026 23:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783287495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nbQNhdkctUVjCrWqgHp2lFDpL+jVLHEUAKKHow1V6ZY=;
	b=db7Tpjhvy2P3I3L5rVTMzVybDeO2oVAJ6F9StSi9s5nFSsC/5W0Z7AS2zs8aUchOxNKvfH
	E2jzE0Wl+ZY4LXuBm255wWh6DVqGt7aCa6fGgZ/kwybMWnt/EBgZlhaOYGFQQKk/iEcH4E
	PZw9Wk38J5V7BxP7hdgC8mBkNafEP78/kLIzw03WqTC+2UkYZjVSicubiKr3CAYt+ayWfH
	x+XHtA4ZNekVaVIP5T8/5Rcqm5fgo6sUDeJ4Ea0CdIMq4PZlLgHRn4Qy5JHZZVielPSPWk
	WzZLcis48TfAJo/eBRauaHM+y+GchH1cHDMX1zcBfvxwo+vw+wa+mepI3Xd9RA==
Date: Sun, 5 Jul 2026 23:38:10 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: rtc: sun6i: no clock-output-names on
 h616/r329
Message-ID: <20260705213810296b48ef@mail.local>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On 02/07/2026 10:10:00+0200, Jerome Brunet wrote:
> On h616 and r329 chips, clock output names are never defined through DT and
> are not meant to be. Just disallow the property for those chips.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: http://lore.kernel.org/r/20260629125305.0DF981F000E9@smtp.kernel.org
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> index 9df5cdb6f63f..959a012c626f 100644
> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> @@ -175,6 +175,18 @@ allOf:
>          interrupts:
>            minItems: 2
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun50i-h616-rtc
> +              - allwinner,sun50i-r329-rtc
> +
> +    then:
> +      properties:
> +        clock-output-names: false
> +
>  required:
>    - "#clock-cells"
>    - compatible
> 
> -- 
> 2.47.3
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
