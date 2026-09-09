Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABF46D0AC;
	Wed,  9 Sep 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946736; cv=none; b=PvevA/bCan1sVbmg4BBGTBFe//tX/IWZBLUH6tItO5MwBHRKcXxuAvBeg/OMOwlri8cmf+DmkwGbemMCDAQM1l+BPfNkksgQNRinDGmk5hEdoZMtzd12DFoXI0T7Lsdl5UV7yzaV3Kf9PuiG+lUiPqjACJIDQLG3DvCGhPgSU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946736; c=relaxed/simple;
	bh=dtvU6hyQvLoT3ygSzF7JKzFsqUKPn6y04wbSG+3qQ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBJjdcCP3mhIRTMIMAxosTt6kFlKfeBVkA03TdTaF7zFgd3wShEOME138wnAolHabMKiCasiSSQrzr9hH4HBN3B2rErydxHa6Wd6n8f6Q62k2wiBcTek9qPv5WZqiliPvH09/4lkgImaib9kAwE68jXfJHpYSpk6fyr+MRxUkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZdPCF1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZdPCF1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754741F00A3A;
	Wed,  9 Sep 2026 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946729;
	bh=e67L0KczgwKtpJjX0XHZNFeOkmTiXaUASOr4nN501DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZdPCF1FDEzEhnhUAPihmpsGNSPH/8nXhTKqOYwBsa34v8ywYqTRX4r3fhINtMXld
	 lMZToeYzoUDaVY/KxLaF3ny2/Ly+Y9lE0/zf1sTRU2aXA8KrPIu30nmNqpyvJPmAs8
	 2yUZzxC4nAm+GdpzKL1t7JIiMiMYAlXY9FhK+YvSLsMe8n6l78mIVbGRbjrc5r0Z+w
	 XmaZYeRVOIEK/Vgb1YflfO/Zwh1NpduIc14siQ8ITOOR3M4rjuNH93mbBH+J6yNkGW
	 Bk1Nd/sY1k4/4wTxTgPc++5aIHh18f8Z6NTHdUMyIg8tEaHfsU8y0pJ6cS/T3oZfVk
	 pOL8b16bNF9JA==
Date: Wed, 9 Sep 2026 11:38:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sudheendra Sampath <giveback4fun@gmail.com>
Cc: alexandre.belloni@bootlin.com, ynvich@gmail.com, 
	devicetree@vger.kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 - dt-bindings: maxim-ds1302: Convert to dt schema v2]
 dt-bindings: maxim-ds1302: Convert to dt schema
Message-ID: <20260909-lyrical-magnificent-mosquito-98bc1e@quoll>
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

Where is changelog?

And more importantly, how did you figure out the address list without
using get_maintainers.pl script?

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument, so you will
not CC people just because they made one commit years ago). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about 'b4 prep --auto-to-cc' if you added new
patches to the patchset.

Best regards,
Krzysztof

