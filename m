Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A12F7EFF
	for <linux-rtc@vger.kernel.org>; Sun,  5 Jul 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287514; cv=none; b=EofigHMWpXpAkdwrBX7JKCc8fYNw3fnlZ4DZIW/Ms5BS0QHPJIYygM2tQDfnICyg9sGI06LssjKyfw/IRKwnwAxd6MEQnhPuHJdZOQPPgTEU4nOv8N34IJK8Vc1oFldP24EDItsE0NnMhJjT9RgZgza6Un+iR60oSfCkQnojp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287514; c=relaxed/simple;
	bh=AudKt1V8+KDEu+V2vDgxJisT/saSektGt1MIpi1jEBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXVMWLX+jU2nK0PVPl+uf+4MCFMDiCZPcTlPYYdPiKOoM/hap+Yi6y5tnooNDSvGT79o828kW1CZSS84B3/8u8nb5qIY5IqOwnCz8lwbsuclXOGoywMkqh6vyXFZ8u94H92WyEI0y5kbVITLuKIAlap7ATzevIyZXR9EK988Kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f1C3e1rN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f1C3e1rN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 08F8DC8EC43;
	Sun,  5 Jul 2026 21:38:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35EB0601A2;
	Sun,  5 Jul 2026 21:38:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 568AF11BB95F0;
	Sun,  5 Jul 2026 23:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783287510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Y1UXtT8BmOoe/s7y9k9MbPlbWZSkBpQj1qefN9muTjc=;
	b=f1C3e1rNwou+Okt6VZ8A38DgopxU0B2JHBR8wohTm2+ApRM9tmAnvP+BNoCh8yQeySo1Nj
	E6fCAYJ7JhR2CYLH/IyvaGs/RzFCzaSfyDYkkMhKjy/w3VyAuVQ+ylvTL1Z3nKmTP+TzF4
	qGA4X61SG1NCHMBbRQs80q/WKHO8l6RheElkrckh2+SvlFJCOQv1O0T9JrxXgjNDQ7G/Dd
	kAqulb+mG90oXfQdlJazkq6pSjj+iElLLCqg1nCcItjF0CsBhUAU6lTBFLQYrCWjrKV/XM
	S4L/rWssIMrEblxnfGpiwc36B20dxvOs1MSDC0vtxv/RY9b+r2C7M1jYdODFuw==
Date: Sun, 5 Jul 2026 23:38:27 +0200
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
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: rtc: sun6i: add sun60i-a733 support
Message-ID: <202607052138277aa6b793@mail.local>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On 02/07/2026 10:10:01+0200, Jerome Brunet wrote:
> Add a new rtc compatible for the sun60i-a733 SoC and new IDs for the
> peripheral oscillator clock gates of this SoC.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 1 +
>  include/dt-bindings/clock/sun6i-rtc.h                              | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> index 959a012c626f..f2b91186ed37 100644
> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> @@ -33,6 +33,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-rtc
>                - allwinner,sun55i-a523-rtc
> +              - allwinner,sun60i-a733-rtc
>            - const: allwinner,sun50i-r329-rtc
>  
>    reg:
> diff --git a/include/dt-bindings/clock/sun6i-rtc.h b/include/dt-bindings/clock/sun6i-rtc.h
> index 3bd3aa3d57ce..5132a393ca4b 100644
> --- a/include/dt-bindings/clock/sun6i-rtc.h
> +++ b/include/dt-bindings/clock/sun6i-rtc.h
> @@ -6,5 +6,9 @@
>  #define CLK_OSC32K		0
>  #define CLK_OSC32K_FANOUT	1
>  #define CLK_IOSC		2
> +#define CLK_HOSC_UFS		8
> +#define CLK_HOSC_HDMI		9
> +#define CLK_HOSC_SERDES0	10
> +#define CLK_HOSC_SERDES1	11
>  
>  #endif /* _DT_BINDINGS_CLK_SUN6I_RTC_H_ */
> 
> -- 
> 2.47.3
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
