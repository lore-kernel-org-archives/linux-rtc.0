Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F9340A52;
	Tue, 23 Jun 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204699; cv=none; b=fvJYuzqXoIGJZLJWR37x5uvC/vUBqHQ2eluHt1qhOLz8Vx53gtSVYNhCt7Lm/CryfceDmKZaDZfAwVzFHBerY7rWep4n2ttBUs/mvJ2dD+hcPUj4h7XbBtZX/yO6/koTJYojHPr2dfswtq8R4/JbSN5lkdHXQpLuRiPi4XqGlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204699; c=relaxed/simple;
	bh=zx6wkNEXy7nabLL5CN63qNZLUh17QaT/I/QukUuwlLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGQ8co/T5nCOLrNm4q1lJTUPKTFzRvuVirUZ0bBB+XZiYqGJy37lW0Hv930ovuekNOr5/OaCXQD1U7lgEJErAO8a5b6foCmAWyg+H3EMrzm4ICQZqIC2c1PMPDuC7uBeN4BLA/YF07EfiRLGosApUkeQpqiIVZP4aMqRtZ3saI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr3CyVo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr3CyVo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89B1F000E9;
	Tue, 23 Jun 2026 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204698;
	bh=4gysAP1S+0hzuOBim35EG8H2R8ov/qExOI6IXgApNZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dr3CyVo9ouL9dLX/ZDOwZ2VhneLHcFdlzqrZ1e4a1sK6gxdq+rXJPjh3FGEwjhBw/
	 798fAAVVrAFuE5tEZqVlo03qf088GLr3fK7HcQYsMYgjXJHU2ofiiTCm/2e1iWIAbL
	 jpZoR3wA6bO03+mJHDBS54TgrLyslxij7rXmeRLnw4ZSxqUY6yxFgTLta6qTHKWyLH
	 zt41nbp15pqbFPiCTyo+SFx8E3Z5XqvUvQ6ppN1vNoGtcDHvfA+wqNU+sDEe9JlC+W
	 ridoUO7qyWlVMdv9ayeS9QzXecYhbwWyrEbtrht3DJ/qfUam96M7ZvLmR7jjCCrcuV
	 cxI9xDRkxngpQ==
Date: Tue, 23 Jun 2026 10:51:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: microchip,pic32mzda-wdt: Convert
 to DT schema
Message-ID: <20260623-small-roaring-bullfinch-b20baa@quoll>
References: <20260620172354.155565-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260620172354.155565-1-challauday369@gmail.com>

On Sat, Jun 20, 2026 at 10:53:54PM +0530, Udaya Kiran Challa wrote:
> +    watchdog@1f800800 {
> +        compatible = "microchip,pic32mzda-wdt";
> +        reg = <0x1f800800 0x200>;
> +        clocks = <&rootclk REF2CLK>;
> +       };

Indentaion needs fixing.

With that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

