Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75A45562D;
	Wed,  9 Sep 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946663; cv=none; b=F4A7OCiSaALWzLO9Z56ZpdYAkBuNFvHipeM5Y8ZJx/Kvl866n0rpdkC70Fda4yFO6+2w+rvDrg+7KsNjhB0yqpwxV+Eh0tcGWiI6AEnW8atAJGiz1/T+McV+qYqCsvSnKnZKmUMrPcjx6lDPZuZL3uMeUwPlGkyLeNTYE3aeXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946663; c=relaxed/simple;
	bh=XLfiaUN+IsoblzHsO0Rd8fDCWzeG9H+ooBzq4gcWhM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHlidnb76Td1KgjQXKRwFNlMugeW0Xs+MIY6DFORJlE3kClK9PzwVyIXuI8JOaUpMnuE8uraNTFmMCfGCeUl+Othbf5/vGUXjBh7Kro4fSqdvQ3KsbyjQD5HVaIMMsuK3gxVsoiGQtHv1cJwsvydAz4h9D8d5uUo5tFGNMeroyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUn0wz/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUn0wz/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E861F00A3D;
	Wed,  9 Sep 2026 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946657;
	bh=XLno3g6uhiwWTum5jTYIroUE3LdxlAsOrOGC6V+6vCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mUn0wz/gZMvzsv0+SmKyPTQtB5x1jf0j4O6OGGdSSKpAI4sIMbPAngKjsi92eKrmo
	 7axdOQPFskm9PlRZBa+V47rjJBs6e/SX5ZMcKpZw+TBJks2lXZhp/2eta5OQccqdiA
	 Z4lfxtyLThxcBvShFJH1rTa7F6DUdRa96QilUeLpwggaxHv1Vy44BwL+Fhw92JnMqM
	 9GIT8yj3w7t3M/64OnHsCIg3+Pfz5IizVQGj5Qv3/D7hUiCr/mF56dj2VB/Rf9kZgc
	 trj+OBLADE0FwLODEmbsXQYjVcEO9MoYTqr5YlMCZ0pM7hEclXwVKEGtOU25qTBkX/
	 6RbHd85cNfH+g==
Date: Wed, 9 Sep 2026 11:37:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sudheendra Sampath <giveback4fun@gmail.com>
Cc: alexandre.belloni@bootlin.com, ynvich@gmail.com, 
	devicetree@vger.kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 - dt-bindings: maxim-ds1302: Convert to dt schema v2]
 dt-bindings: maxim-ds1302: Convert to dt schema
Message-ID: <20260909-pastel-dove-of-mathematics-1ee5f7@quoll>
References: <20260908190137.1168904-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908190137.1168904-1-giveback4fun@gmail.com>

On Tue, Sep 08, 2026 at 12:01:37PM -0700, Sudheendra Sampath wrote:
> Convert Maxim DS1302 real-time clock binding to DT schema.
> Changes based on code review comments.
> 
> Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
> ---

Your subject PATCH prefix is odd. Please use git format-patch -v2 or b4.


>  .../devicetree/bindings/rtc/maxim-ds1302.txt  | 46 -----------------
>  .../devicetree/bindings/rtc/maxim-ds1302.yaml | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> deleted file mode 100644
> index ba470c56cdec..000000000000
> --- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -* Maxim/Dallas Semiconductor DS-1302 RTC
> -
> -Simple device which could be used to store date/time between reboots.
> -
> -The device uses the standard MicroWire half-duplex transfer timing.
> -Master output is set on low clock and sensed by the RTC on the rising
> -edge. Master input is set by the RTC on the trailing edge and is sensed
> -by the master on low clock.
> -
> -Required properties:
> -
> -- compatible : Should be "maxim,ds1302"
> -
> -Required SPI properties:
> -
> -- reg : Should be address of the device chip select within
> -  the controller.
> -
> -- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
> -  and 2MHz if powered at 5V.
> -
> -- spi-3wire : The device has a shared signal IN/OUT line.
> -
> -- spi-lsb-first : DS-1302 requires least significant bit first
> -  transfers.
> -
> -- spi-cs-high: DS-1302 has active high chip select line. This is
> -  required unless inverted in hardware.
> -
> -Example:
> -
> -spi@901c {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "icpdas,lp8841-spi-rtc";
> -	reg = <0x901c 0x1>;
> -
> -	rtc@0 {
> -		compatible = "maxim,ds1302";
> -		reg = <0>;
> -		spi-max-frequency = <500000>;
> -		spi-3wire;
> -		spi-lsb-first;
> -		spi-cs-high;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> new file mode 100644
> index 000000000000..54a2fcf7f8e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml

Filename should match compatible.

> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/maxim-ds1302.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim/Dallas Semiconductor DS-1302 RTC
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Sergey Yanovich <ynvich@gmail.com>
> +
> +description: |
> +  Simple device which could be used to store date/time between reboots.
> +
> +  The device uses the standard MicroWire half-duplex transfer timing.
> +  Master output is set on low clock and sensed by the RTC on the rising
> +  edge. Master input is set by the RTC on the trailing edge and is sensed
> +  by the master on low clock.
> +
> +properties:
> +  compatible:
> +    items:

No need for items.

> +      - const: maxim,ds1302
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Why do you need the type? Please look at other bindings.

> +    description: DS-1302 has 500 kHz if powered at 2.2V, and 2MHz if powered at 5V
> +    enum:
> +      - 500000
> +      - 2000000
> +
> +  spi-3wire: true
> +
> +  spi-lsb-first: true
> +
> +  spi-cs-high: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-3wire
> +  - spi-lsb-first
> +  - spi-cs-high
> +
> +additionalProperties: false

Missing example. Please follow standard rules, expressed in writing
bindings and writing schema docs, DTS101 slides or just look how other
people do it. Otherwise explain why doing this differently?

Best regards,
Krzysztof

