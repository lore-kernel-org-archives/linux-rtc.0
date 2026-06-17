Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE238398F;
	Wed, 17 Jun 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683956; cv=none; b=EucRGaUdcLbe+tUNZk8v7i9ip0XEoLvdj/ksoF7L1/jYAbHy9Anr3+cNKGJHw9ZpZZddxzLeqBXqFYvSgDhnke1P8bAMaDVkHTFbMPYKjBOPHRHVIw0ACG4Kw1Z5r1taKXYSHpUxMTMTDlpmhRW1VNRVUWnd/r5agIhyl102M5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683956; c=relaxed/simple;
	bh=xquYgklU+rATdCmZd5DdC0DhayIkYy1d3BFfzdZxBgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBryKbZh7uiMhXADcc8ojwnHJ62fy3IJkxftKhT0NorAYKecY5xTuR6MxlP/DTel9kaBcVNfZuSUf2HjY6I/TxuGdyX4YfzUo4afvZXo6946qt35buk1G5JM2oiYW2pHK7anP6SBmxP6A1aL0ec4F6kS6Tthgawa21U/DOTGpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huxdnGkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huxdnGkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666B21F000E9;
	Wed, 17 Jun 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781683955;
	bh=h0V/anAz/uLvj+D8TDeyvY6nZjIPCaaCNAXIXvi1mBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=huxdnGkk/zlz1rL8vQIDnrlwtH1G/X5bKGSEL/z+U7+YKQriBQCpdgqC1iP9ulgCm
	 KxHPwxtaxs59P1h9posismk9QeIGmJBb+KBUTTtAqw4qNt3MzSDZTQ0ymvU0LvzEgH
	 haq1T6HayIwVPFF3zra1QBj3G7ygvYsNku5La52k7iOlGCcmLSuKAWkKXuH8QWygRI
	 3nnAXSGxcMyIX1pkwNgg2k9ooMAShTo4OO1vcaF2wSMyOC2+vd8m3sj5z3F/qw/hzM
	 I/X/t8KPmODmxbdDtTPoDmQlUuHaJc748OJ3TuT96u54szC5j27XnpQKZ7aQl45Uhn
	 9k97cP+HZB9QA==
Date: Wed, 17 Jun 2026 10:12:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Teja Sai Charan B <tejaasaye@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: Convert rtc-cmos binding to YAML
Message-ID: <20260617-devious-furious-hummingbird-c387ba@quoll>
References: <20260616085659.12809-1-tejaasaye@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616085659.12809-1-tejaasaye@gmail.com>

On Tue, Jun 16, 2026 at 02:26:58PM +0530, Teja Sai Charan B wrote:
> From: Teja Sai Charan Bellamkonda <tejaasaye@gmail.com>
> 
> Convert the rtc-cmos devicetree bindings to dt schema.

Subject: s/YAML/DT schema/

> 
> Signed-off-by: Teja Sai Charan Bellamkonda <tejaasaye@gmail.com>
> 
> ---
> 
> Changes in v2:
> - Allow intel,ce4100-rtc compatible used by existing DTS files
> ---
>  .../devicetree/bindings/rtc/rtc-cmos.txt      | 27 ---------
>  .../devicetree/bindings/rtc/rtc-cmos.yaml     | 60 +++++++++++++++++++
>  result.txt                                    | 17 ++++++

Stale file, please drop.


>  3 files changed, 77 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-cmos.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-cmos.yaml
>  create mode 100644 result.txt

...

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-cmos.yaml b/Documentation/devicetree/bindings/rtc/rtc-cmos.yaml
> new file mode 100644
> index 000000000000..ba4812778115
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-cmos.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/rtc-cmos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola mc146818 compatible RTC
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: motorola,mc146818
> +
> +      - items:
> +          - const: intel,ce4100-rtc
> +          - const: motorola,mc146818

These were not in original binding, so you need to mention it in the
commit msg and explain why.

I understand there is not 'rtc-cmos' compatible, so basically the
filename should be set to this fallback compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ctrl-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Initial value of the control register
> +      (also known as Register B).
> +
> +  freq-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Initial value of the frequency register
> +      (also known as Register A).
> +
> +required:
> +  - compatible
> +  - reg
> +

You should $ref the rtc.yaml schema and use "unevaluatedProperties:
false". Or explain in the commit msg why it is not applicable.

> +additionalProperties: false

Best regards,
Krzysztof

