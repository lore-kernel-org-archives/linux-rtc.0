Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C13AEB35;
	Mon, 15 Jun 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506391; cv=none; b=lB/oPMy3OUZsoodBwirSCqkQwuoQiY0epWl2E5SurPzMBrZb9MTP3if45TnJ3FTtIlQ/UCYrh261njenLST+RSm/T/ooMJRGKlxTQvkq7LsOaFfo0Es4PYhNOYLf5exv+gR+rQD7nt0MOXhfBDdB9tJWNkG3jJWpuEjypP1xPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506391; c=relaxed/simple;
	bh=WuWOWQLcMqD3MAAPyc10GpAAMuXdKLBL3a75DUbFUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp5B92IEfJ0/9EBRozPN/Zs0f4UpHBUrJmfIEKF6lvI/OtCz4Ycw91wRzBzK+TS7nWPi0qLZ9uxmbkuBkL1xkVzkzXTq35wEFqOR3RN1D1PxUIA7nAca7zPpYzBHkqV+0R20VOQudDfqH3fJA764xjIlDpRFGgeWqpwG6B+LCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk4eL3Ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk4eL3Ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD0E1F000E9;
	Mon, 15 Jun 2026 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781506390;
	bh=msvYM+jh62nYOOPLiym7I0H/fQwA3F0pcqrqbWIPRg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kk4eL3Ia7nnNCc3dRc1dUJpYWs4mFbx53bgG2vD9uumB5CTW7Sl15uuQ0i8jBQLbA
	 kF7bNGGBeJjXwM6YFOZBjAuJZW3ZAQCqmwwzmy/WlC6u7A1oeX/aNJgHPkgxAjxhNt
	 6pZwOfGFJ83Mxxic0C95TNdvu4yokEMpjmqGrk8EmirrtSNzrLhIhDQvjulmoMe3oS
	 Nv0cF/+vXeEjDD5RXwyqPeHB4Wl39ws2iZ0C4Q5/qe/sjaDNL+qkk0KWjCGVt7Usvz
	 oTO/q97awaKq0hjpvM35O72cMEr6WqvfR6jsxIeC2vZ8SpXN3odhh8xujPluEq6jWc
	 TVH1ncqnPulgA==
Date: Mon, 15 Jun 2026 08:53:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: microchip,pic32: Convert to DT schema
Message-ID: <20260615-vivacious-kraken-of-abracadabra-0a9efa@quoll>
References: <20260614175005.435826-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614175005.435826-1-challauday369@gmail.com>

On Sun, Jun 14, 2026 at 11:20:05PM +0530, Udaya Kiran Challa wrote:
> Convert Microchip PIC32 SPI controller devicetree binding
> from legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


spi: dt-bindings:


>  .../bindings/spi/microchip,pic32-spi.yaml     | 78 +++++++++++++++++++
>  .../bindings/spi/microchip,spi-pic32.txt      | 34 --------
>  2 files changed, 78 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32-spi.yaml

Use compatible as filename (and don't forget to test binding after
renaming).

Rest looks good, so with these two changed:

Best regards,
Krzysztof

