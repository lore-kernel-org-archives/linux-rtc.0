Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F336654F;
	Thu, 24 Sep 2026 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288282; cv=none; b=WQAqrVfO/A8wLkreOTD7xmO+cQphF4Z1HNQxMaXhdNccmUHoMtJ8BrcRn2M80/3jZAYNQKVXpbijOvA+FmWHnRCUBL2yGRv0gbzSy4IK/nQ2B+B9Oip3axF9aMp+DDMQ83pUGniVbeSzlTQ0fJkkdtM6pEkGO4BYW/vt/0Xpt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288282; c=relaxed/simple;
	bh=Ly6agx/gm7eVetVJA2N/XQDufLGUS67WHia7a4jlC78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk4A+nrrzS8mwzxAy+VdjDHYWJhPfhc9PCi+Fs4K5+rEgvbDewUTm1BcPIQVVwZrrofJqNbhgN/0cBx1YLnGepQ0EauJPZ4Q85PEErkzMAmYwu4g+vGcJq0hGJIzYr74T2OalIoLWaMe5v9Vg/3hQPCOBK/VKJlbMbtAQ+HEyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPKjz0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPKjz0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD31F000FF;
	Thu, 24 Sep 2026 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790288280;
	bh=5sAlvWkSY5zpX/gytWhfTU2B0FkLVxFgi+cyvzeyzrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KhPKjz0tZVNGg06MPDzPBHxeFr7pVqmgsg9MNvEIvihTtC3w12kEeZUrzmQFdnv4H
	 vmLICNx/ny3UQ7vnu09gHk8YhvJDH6fM5Cpe26SpGNezCSDyNaxxWRCR2lXh4K/ZKv
	 /jsZXiMgrXAxkMVO5U7vJ4kwfoHSCzmh4NUOOCwwZj2vWkxd6bzj5V5UGyBacGm4Up
	 w7kfJ/NwxesGtUxhqMU+hj+vOTC4pgec+zIx1qwnX8a1MpeieDiZvS8hKc68Cygvmy
	 3gW3NV3kle5WdX2UZYE14MWv4apYmTL7SbFEJqbwrdAO0TjgrmZlJJILMN3sp+GzP3
	 Z0yFLULXfgBig==
Date: Thu, 24 Sep 2026 17:17:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Message-ID: <179028827857.2011428.11688710471932233481.robh@kernel.org>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111349.52250-4-wsa+renesas@sang-engineering.com>


On Thu, 17 Sep 2026 13:13:47 +0200, Wolfram Sang wrote:
> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v2:
> * handle only X5H for now and do not fall back to generic Gen5
> 
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

