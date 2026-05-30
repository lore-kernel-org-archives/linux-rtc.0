Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF837AA83;
	Sat, 30 May 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138168; cv=none; b=iRaskkdb8ShlYg3Bw7p1hGhGOmbr4DPjzB2eNlcVdYbWeUyJ3ODEWF8eyXzCNeD5TfRr0PrCmE/idYg6QGTyV++40upntnw6elPi+DxYElb4oOnTvBu1nqy+1kDr3dJ/vARzZEhg4cySdNCg+jWiSE7+of/LzrdkBlsFph86+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138168; c=relaxed/simple;
	bh=X4F8MSJqz6FQxeXw4Sy6ntzkc40NdvEGJk7OS+A6tmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTFdHSJ2iagB6iMfM4zeiVWOqVp9jmUSe6aeMpedQZN71361jGxGkDPrCxPcxzQ/NPLRhsN0RTfzDyJ7hcw40JCrYqplzUZ2oJaVDxYOA1UdreRsZOVmFkZh1BsdM2wG1+zc3CSvemo8y7mqnIlyl7sQARm0eGX4g4WA8B0Nzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huX4gKlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huX4gKlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F611F00893;
	Sat, 30 May 2026 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780138167;
	bh=0ffSVxbGdAcaWLNMSqr2Lipz5ESbowsuXTzvAfqZyZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=huX4gKlUYZKFQFN5Pzr29SSOKWcH9Wqfxe5RGlIGGNpADeu4m/qQafXusSljCbihQ
	 wy1sRvloZzepQZkTPZPN74cZJD4BXDrPeQBqmP1W81HqymsS2qhpX8hynyf9oSf+R8
	 v/Y3gw3GboODKAa/vaf67PeApvsgHMERUSIcXGRhSMn9PFrqhpJThwp2l5cKjDwDMX
	 J8dxISmq9r85OZKBWmdMbtF8nT2WYEum2ve74S3/ukJ6xnqa2EEXep8eDILDe9yOek
	 zrjdAmECC/BgN8nYU6NmBkU1Dp/4awCpni8kjyY/yoIVrQ3tG9aV35GfssH8QVzH5N
	 Q5eIz3weOICJw==
Date: Sat, 30 May 2026 12:49:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: linux@prisktech.co.nz, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: vt8500: via,vt8500-pmc: Convert to DT
 Schema
Message-ID: <20260530-devious-magnificent-jackdaw-cc48c1@quoll>
References: <20260524110047.37590-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260524110047.37590-1-challauday369@gmail.com>

On Sun, May 24, 2026 at 04:30:09PM +0530, Udaya Kiran Challa wrote:
> +properties:
> +  compatible:
> +    const: via,vt8500-pmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    type: object
> +    additionalProperties: true

No, binding must be constrained. See writing-bindings or any other
binding. If you are unsure how to do something - open other existing
bindings. Do you see anywhere such syntax?

Best regards,
Krzysztof

