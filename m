Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC2356772;
	Mon, 22 Jun 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120163; cv=none; b=EuT6SDtqR8xG5rYP9sKajdxWcuFS/aNUmB4xcchEIMC4UFR8MpzUuqDQDeYMr5f68rOWwzfcJs03+3TVImhqsYBYcUWm/YjhbiioAYeGirIXXYfIxSPdTcUVSlG/poIER5Hr/7t2J4O1R+/nPe/gWifGJXcT+Mi1SsYivNU2EMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120163; c=relaxed/simple;
	bh=VKNFwSytwg74VUYpbdu2qFD6MyWo+H28DrktbXAWX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA6DWLQ7md9d4Q1R6NN2HgbFkDQrbaxQqM9NOGtCcGpQWp7wExTIkJc9cV1I5VInyDuUSHLZoTz1C8NoUlw9ATkxQ7WbKaPgUDlofK7Ni4pGGrJosB9I/anBjLWflB0nOk0N0rQpVrbxqAZXSIzJKokQH+CAR4x9YbTYJJhgKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjXT3x7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjXT3x7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFFD1F000E9;
	Mon, 22 Jun 2026 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782120160;
	bh=OX8Qg3owLQqMtg66YL9Ex7vWtY9tEzIXqaglPZAlISY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CjXT3x7rSKIiqvA3AVVBrZ+UUCxxdQNYctgtGv31HzQ10kzjfaqN+y3oGEgnPKvBo
	 5JmbkNIDKeLWUbWo+Jn4yJwUSc65PTui0NrUUOncgXjoeGlvFMiHhl3hw0A8sjOe9r
	 ldM16SemJ/YdbVI+sf2rDi28xDW3Mcbb0xHM1CDtQjlBFZzOWKAwPl7Lefm5nIcrxz
	 TKT4jDqb4EqSpnKuCBWiIOHQEk9sv3/Mu3OA/GW6s5gTqtng+BpBcPtXx2cg7WNQUR
	 F4uq+AcrNYONLd60zyiH0iRBgdBdv1duzQjpRbdBPaFFqsBwj+WLQYKy2S9/VBs54A
	 S8MBb2RWsSvgA==
Date: Mon, 22 Jun 2026 11:22:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
Message-ID: <20260622-ingenious-finch-of-fantasy-7bafaf@quoll>
References: <20260617101009.148851-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617101009.148851-1-challauday369@gmail.com>

On Wed, Jun 17, 2026 at 03:40:09PM +0530, Udaya Kiran Challa wrote:
> Convert Microchip PIC32 SPI controller devicetree binding
> from legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

