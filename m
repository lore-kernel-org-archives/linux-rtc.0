Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC563D16EB;
	Mon, 18 May 2026 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089077; cv=none; b=JCu7BjiHod9HgQBNxDbDQV/LeLOLN5qr55d1cJh6OMoAOpvoXSJYwwi/UThrBfZp+UTTjctxG1B6alUPeA6fS0+ejbsOEJf1ILMIQdRZNvBV88T57nMxq6zeX8kpm2bVP4kp1BKmCPX2KMS8TneIQBlTgZmlfkqucZ2tFNjdb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089077; c=relaxed/simple;
	bh=hixQLe8PG4T4h8LbMRcfKQX69jiNV3tNufb7ppGNWy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsVprcFwNjX+FHwle9sFQMAwzg1LpM4u36PNPMecE4cBHRI9F10llajggZglMDTg2vAmnQUYV6XQG6qBFz8/lXKL3uuYOfZd9o4hB0oTxSsgdCt7QQqDtzI4h4UTWxhw/BuIYH2ps5CRsCFHBamV3Mw2Ho8sh4FnRHopJkHbWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHuzrYDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHuzrYDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C8C2BCC6;
	Mon, 18 May 2026 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779089077;
	bh=hixQLe8PG4T4h8LbMRcfKQX69jiNV3tNufb7ppGNWy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHuzrYDWF6pr2XP2/HOqsC7xaj5d+a6156QlCRrdqMrckGtD+mMyM0/kHJ3ERBtYs
	 vnPalP+Nbpt/40OWkLjm8xBD9Q4njIkhh5eMKAXGMAcwufpKBCPIHCSms7MRARSduM
	 GghWRhfh0ZVd6uS68ZbLcw8lMTO6TLRTBLPGC0x2mlcsKv7wInPfq24zxq315oQxke
	 dQ+bPPrKzK/YG0u+QLMTSWWkQYq7StftQ+ldEcMpf5aQ8MRr0rVAJnrFfFxaSGPxdU
	 2TDEmFc90/uvmLDLe6fdfX3lSbQIJ18y4C1TbsCfQUskibh89yOt258t6EKSvwgclT
	 tmcbjEUhjGNbQ==
Date: Mon, 18 May 2026 09:24:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: rtc: epson,rx6110: Convert to DT Schema
Message-ID: <20260518-smooth-prophetic-ermine-3f5c8c@quoll>
References: <20260514173851.25088-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514173851.25088-1-challauday369@gmail.com>

On Thu, May 14, 2026 at 11:03:32PM +0530, Udaya Kiran Challa wrote:
> Convert the Epson RX6110 Real Time Clock devicetree binding
> from the legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

