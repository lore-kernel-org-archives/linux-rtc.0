Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8233F8CA;
	Wed,  9 Sep 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966911; cv=none; b=ZlNVH/kKeYh+NaTCaZFowo/l+mwIZbZjeIGK8RTP9OmnY8lmK7mTS8luUoKgJTA0rIgEqNhpjw0BCbH0C9+Z2PlERtlcbKEKJU8dLrZP5hoxuSjH63/n7CTe8id8yCphA5yvZdkii5MgUz0lwupiZLCwHZ8aWBtxltsOFgT1fKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966911; c=relaxed/simple;
	bh=88t2KFUYEG1ls7SLqreKfx7a/sqi1kIjDcCRwnQG8Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J59VTxjfz5exMGO2OBcSjuPXb7a+FazF3IY1pAHZt2vAJGupQhHNxP+ZWo+t0L0u5hTASjl/msrYoAfCtww7/Md6jlOE+gGy6J7ai0OxqYxX5qU1oAU/IJSVpKKzbdGew/fELzwpXlZgj0wgCkJ317oOcHiXQ9OswxFhCf/5gtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vpfLvzpx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vpfLvzpx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B48B14E415B2;
	Wed,  9 Sep 2026 15:15:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CFCB60448;
	Wed,  9 Sep 2026 15:15:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A542411C7AF6A;
	Wed,  9 Sep 2026 17:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788966904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TKIumftg5isbpXQKzme3lvhBlw9M5ic7cFq7rPAt2L0=;
	b=vpfLvzpx5PQf+lAopJKrbF3xSa1LRWSHkt5cfM1tozXsgkzvX6SwdKT0KlJBDJT4vhS5HG
	LB2m9WyL4EjcTSdHqge+XyY1dWAeLsHDaApXfulQaDuaKE5/hNszu9s65P4WWxUIKmvZCt
	2oLDiQIUykAc6fW59LAXZCsrZz2S27dlQ0gbH7ejBtntAy5pjPLnUlfkfZEdt685uCCGS4
	oKB4wgGYMoNVhh9EkLb2caDvPtUiUPQUxEw0ImIPGwgREYRrTBTaDIkV7Q7yzV9QG0PlMZ
	zCqZVRJ7arpdaM1JYKzEPsvcbX5FcnFgFxNpGJlb93pHCp1l8MTvtuDEWMc+BA==
Date: Wed, 9 Sep 2026 17:15:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
Message-ID: <20260909151500e29e65a6@mail.local>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-2-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909141300.1368790-2-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 16:12:58+0200, Sander Speetjens wrote:
> Add device tree bindings for the Raspberry Pi 5 RTC.
> Located in a custom DA9091 PMIC and accesed trough the firmware mailbox.
> 
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> Assisted-by: Grok
> ---
>  .../bindings/rtc/raspberrypi,rtc-rpi.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> new file mode 100644
> index 000000000000..e9bade7f8c91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/raspberrypi,rtc-rpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi firmware RTC
> +
> +maintainers:
> +  - Jonathan Bell <jonathan@raspberrypi.com>
> +
> +description: |
> +  Raspberry Pi RTC from the DA9091 accessed through the Raspberry Pi firmware
> +  property interface.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rpi-rtc
> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the Raspberry Pi firmware device.
> +
> +  trickle-charge-microvolt:

This should probably be trickle-voltage-millivolt

> +    description:
> +      RTC backup battery trickle-charge voltage. A value of 0 disables
> +      trickle charging.
> +    anyOf:
> +      - const: 0
> +      - minimum: 1300000
> +        maximum: 4400000
> +
> +required:
> +  - compatible
> +  - firmware
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc {
> +        compatible = "raspberrypi,rpi-rtc";
> +        firmware = <&firmware>;
> +        status = "okay";
> +        trickle-charge-microvolt = <0>;
> +    };
> -- 
> 2.55.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
