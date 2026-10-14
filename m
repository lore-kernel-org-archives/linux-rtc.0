Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDD562607
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998930; cv=none; b=p7jQ/GAu2OtWwXvz1y4viRg7FHwyb3RSDf1ldKZqBdvAWOOK7IQ+WxD0KVRbidQxkpYCIzR/1iGqgzuLSEHLwYktQb8E3ViWAksU+ut297c9Gl8z9b/d9hq9BO5iajrnOtXcUCIq5J5QeSJ/G2uw9ObczNwivWKPI2lzlZaqJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998930; c=relaxed/simple;
	bh=gSA61Mgf2DFOEHdMwc8cdAsNuXu2u+S0kL+H+EjY5/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiCGEZZB7Ef6T656lPJWHQF7Lkr37Tj9FJgGx2+fo+uw8s6dalhybW3IRAKvgZal9ujKVD0Ng6g3PFXlyfH0dr6F6pgarxCOrF2pQ/udbsNza533grxqVFcwOEejU7SZ8U/IeHJUBB1gPu6p5pjcg183SK3EHYKuzOXYKxUt/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DZTjr4rc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DZTjr4rc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D5741A122D;
	Wed, 14 Oct 2026 17:28:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2AF360368;
	Wed, 14 Oct 2026 17:28:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51E38103289C5;
	Wed, 14 Oct 2026 19:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791998921; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9drWIXfr1DDCei/MMFdnXnXQjS0PR3I+D9u3gYliR1s=;
	b=DZTjr4rcD+U5hXiQ9kZTaTOKC2GXTRTIsMAo+WCZcrT6F3sSswagtAMUmWEUX12H0lBz8N
	xxd1/ThZHjPRScs61HupWe1i4jhO43uMK8JPmPScISePuBcl2XiFX5GHOTKmKVrOqrDRI4
	gERKpF9ZYqWmpBwtxonAeZnudDPMuAvCrAdnfrZWwsXd2YdD0Nf7rX0h4+/4k53Y6xk6tV
	HC8E8EL9m9E1bYVdRFtk6F5tfhFQnEYtBDfBGTv6oyLBwJcTXAd77IJzZ3w3YyD3G62O7D
	MdhwpTjrIdq3O/DiyxTYrHAhjZvDfKqdnv3xud/gF7Cciq2oz2omThfldbc1ZQ==
Date: Wed, 14 Oct 2026 19:28:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v11 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Message-ID: <20261014172835a731fd1b@mail.local>
References: <20261014083016.332338-1-sander.speetjens@gmail.com>
 <20261014083016.332338-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014083016.332338-3-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 14/10/2026 10:30:15+0200, Sander Speetjens wrote:
> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
> 
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
> 

You are missing a comment from Krzysztof:
"Commit msg could explain that you do not reference rtc.yaml due to node
naming rule."

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
> V10 -> V11: No changes
> 
> V9 -> V10: No changes
> 
> V8 -> V9: No changes
> 
> V7 -> V8: No changes
> 
> V6 -> V7: No changes
> 
> V5 -> V6: No changes
> 
> V4 -> V5: As discussed with Conor Dooley, the reff to uint32 is removed
> and a PR is made on dt-schema adding millivolt to property-units.yaml
> 
> V3 -> V4: Add a reff to uint32
> 
> V2 -> V3: Fixed the firmware property naming
> 
> V1 -> V2: As discussed with Krzysztof Kozlowski, this property is folded into
> the existing raspberrypi,bcm2835-firmware properties.
> 
>  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> index 983ea80eaec9..dc71fd57834e 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> @@ -133,6 +133,11 @@ properties:
>      required:
>        - compatible
>  
> +  trickle-voltage-millivolt:
> +    $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
> +    minimum: 1300
> +    maximum: 5000
> +
>  required:
>    - compatible
>    - mboxes
> @@ -144,6 +149,7 @@ examples:
>      firmware {
>          compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
>          mboxes = <&mailbox>;
> +        trickle-voltage-millivolt = <3300>;
>  
>          firmware_clocks: clocks {
>              compatible = "raspberrypi,firmware-clocks";
> -- 
> 2.56.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
