Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE136C0CA;
	Mon,  1 Jun 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314020; cv=none; b=CF7SQMiMNnazj1udLfHvNYCTv7g/Tn1ad1QRBFTZpPyrR/qUy2h25EsaVkTGevwKk0WUL/hllokSZaXkObOvpUaxOGgmYViXwHWeUPEp8XxNtwnqj84IvxzFhnTtf2hb/Crs8Ub8MxNvJHfL3XWKLCRx8IKCOlGmHEUoZJB3ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314020; c=relaxed/simple;
	bh=g5n+pNpfqd7ObkQPa0mLolvaWZlGhlLZ5dvu3tVOjo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9m8UaoyRsIYt8fX4ebMmVFRtgDsjpdcFig1fJpNabwrTQH1d9Bkygrlsig6N9GBk6gkrnWDeDFDIxpCW4uZIm6y52gjYvwmesJ6NfRuCPsvgaZ7f36MO+rxsjpw0UNCjdadDNxFwQlCR4nmrc0qUmGPsuGyY4ppcluxqsmnUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlSgHH3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlSgHH3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9892B1F00893;
	Mon,  1 Jun 2026 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314018;
	bh=vyO2Y39ojBF2Rd5PpuF4upTFPXdvxVq0+p7BtDjiWjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hlSgHH3Ssq0wt13AoXpWDUx2wFK63ZYexLOEWgB8YgbERbReMXKi8qgbNEettabIB
	 QeYg+4RLzI6bfBLxwxadQHgajwLKgwsHXHmBLxrm0Ay8mCuvTctcH+SbtZIyrC++BT
	 zyDzMUijidysVHB9b+PEVMImEUK4ijkgZY70o7thpj9nzRJzF6IsprUAzvtY4JuDQM
	 ckgIVtpkK2bt4lykPl3wxHyj+N6YYz3qo9RYZcwUGl0is6bwCEz6DGDrZGQ5Zhhwlk
	 C4V2p4L/MVU6nDSAKoSG6p9IbbLUM24tBhR8xDuhHwIYOGykekdxP77PDt6YYrPBW+
	 IaN25kRDO5tUw==
Date: Mon, 1 Jun 2026 13:40:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: alchark@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: clock: via,vt8500: Convert to DT Schema
Message-ID: <20260601-zealous-loutish-termite-ccfc8f@quoll>
References: <20260531171041.4149-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260531171041.4149-1-challauday369@gmail.com>

On Sun, May 31, 2026 at 10:39:55PM +0530, Udaya Kiran Challa wrote:
> Convert the VIA/Wondermedia VT8500 and Wondermedia WM8xxx series SoCs clock
> controller binding from the legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---
> Changelog:
> Changes since v4:

My comments from v2 still apply. Almost all of them.

You a PMC binding and preferrably all this goes to that binding.

Best regards,
Krzysztof

