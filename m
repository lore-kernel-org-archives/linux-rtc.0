Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE43343888;
	Wed, 17 Jun 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681761; cv=none; b=CbxQZPD3JCAR3sQYhc3vX8CXWyq7TQgPHJavCX8jmCilrFs6ZJx9ZCNJF6rkEgBkxinUEpZwZG9b2Sgzucf6MjhJjb0KkOYw/NxAEbRv+wfeo79HsmL5jouPF3wNypZmN5UB0R2X4TcwQtq11ccKUVnJKF4GlIs4l/bBn5FEo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681761; c=relaxed/simple;
	bh=q4q1F0NNpI77rXiBXg5zU6lXgWiTEcYn1LrobGbCeT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7hXi1gghIi0KlByAv2hOrU0KYBfDFoHzxfvQucnl3kvbJz0K+juLleeSRxobnp8/WEpBANkkGbDoWxCixzKmT5PUlBskeb/Tf5hiVLkDwWEdMuTDSLR+cEDzDEEbuGDlONSSQrkzW3MJNd/xkV0dl2TYTdm+njmNbu17LccEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMY3aLD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMY3aLD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1B61F00A3F;
	Wed, 17 Jun 2026 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781681756;
	bh=o7nW/o13W7aX/64mvZuviZ5KnGOMo+uuiOYrlIZO+ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UMY3aLD8K0BbqTJyqZYJ7BoEeT0KK3JJECqpdBRCxM2Ysbyk1pToRl/GfLqRw+9Ev
	 GLStl8TyTcKx2Sn6A/kpLxn4QgyYUkPH/3BbkCAkzPo2BxBrWvcLugRKMyJbwdxj+S
	 W4zF+ekff14WcMH5IbiT1gwSa1qAabVmLCiR5i7a05U3S8bSoJxKWjT4qakBjK0q42
	 6tIJhId+NuC88RIykxR6WPjV+v63Upu5SLRHLg83gXFaGn2dyCKby4ibe6yVMiXlz7
	 8XRd1amdbJxAbKl56SLLZDfo4B0bEUI0bB8VwhxvJuET3fUaKHElN5ns5dSus7po1R
	 c1AgASXbJyjqQ==
Date: Wed, 17 Jun 2026 09:35:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
Message-ID: <20260617-sturdy-silver-bison-bfb6ba@quoll>
References: <20260615115311.515404-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615115311.515404-1-challauday369@gmail.com>

On Mon, Jun 15, 2026 at 05:23:11PM +0530, Udaya Kiran Challa wrote:
> Convert Microchip PIC32 SPI controller devicetree binding
> from legacy text format to DT schema.

Please mention here that you dropped requirement of 'cs-gpios' because
it is not a mandatory in hardware design nor in current Linux driver...
and then CHECK it actually against drivers, which will lead you to
conclusion that maybe it is wrong decision...

> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---
> Changelog:
> Changes since v1:
> - Rename schema file to microchip,pic32mzda-spi.yaml
> - Update subject prefix to match SPI DT binding conventions

Best regards,
Krzysztof

