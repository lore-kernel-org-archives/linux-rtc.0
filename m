Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1793345CCA;
	Thu, 13 Aug 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648700; cv=none; b=WfE3rpvQzwPKXmvI1RJV3iESrxYfieOjDVRu8V7YUwT8kNe50C1Vis3WouU5RXHq34cCZCPPJNPyJuQPBYw2GVPtsbGc5epklMZ2cKEIpUhqHgPXAjFmugTFtnVFrPbBen7pmJyHZhO/ZyJ+L/u4LcjRhtMnFstfk960c4jAvUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648700; c=relaxed/simple;
	bh=lO96tskk4BRZZKnOmL+tML8sLIREpAWv5tloB5iZl9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD+RZNFBi0ui14x72o3MeaP2rPLcfXiio4bLh4Ygga/DxSAayXR6jfs3OX+eTx/ss+QNDpd1t6jqKRU+2CaRzdEeVsLBcrSCw8FXYMG04g8Y7XuCs4w9oB9V0MuDbY2Ux+nhgQBIK/6hWTe8h2AJXdiZGrIavKk8soYXXgSKlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enTLiGGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enTLiGGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F21F00A3A;
	Thu, 13 Aug 2026 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786648698;
	bh=/bRmjgXu6JV/Aqm2iw8eY+RCx0tb3c4XDGxLtOQPdvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=enTLiGGslO00jkvvSL897un/xaf5Ugipgm1k4q21z8leNO/t+FA1impndQ7jkZ73p
	 c05iaf16umL/qe8WW7utfoNK9aHburZNBOIipCbYIpjnZzXvVMxrg25NZoF7NfBiIx
	 TtFJyKMiiBav8CdmFVffaniQ/0cDg5ggn5ocb+XVeEnQXo3wWpuXJxqS7C+yy9rtec
	 ge8XwuqLDyWMnsHCCVfvJ1fAMGtjliH37S1MSpEs9fCd52npgogQQtJA9C7oNDldEI
	 6ApBp6nzqqe9NqHIrgPRT7jhFFXC1y7gUiUKJAc3nbOGDeUXT8aAIwgQGgejvCkbTi
	 kB5WUcWIewOrg==
Date: Thu, 13 Aug 2026 14:18:17 -0500
From: Rob Herring <robh@kernel.org>
To: Uday Kiran <challauday369@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	skhan@linuxfoundation.org, tsbogend@alpha.franken.de,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	me@brighamcampbell.com
Subject: Re: [PATCH v2] dt-bindings: watchdog: microchip,pic32mzda-wdt:
 Convert to DT schema
Message-ID: <20260813191817.GA1981719-robh@kernel.org>
References: <20260624055648.127399-1-challauday369@gmail.com>
 <178406687202.3036881.4468660016404184803.robh@kernel.org>
 <CAAj-GBnn8rGD6o5HmVfYtEksXsL8ZPKcc_AbfKUEHtTsN1pN-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAj-GBnn8rGD6o5HmVfYtEksXsL8ZPKcc_AbfKUEHtTsN1pN-A@mail.gmail.com>

On Thu, Aug 13, 2026 at 11:17:56PM +0530, Uday Kiran wrote:
> On Wed, Jul 15, 2026 at 3:37 AM Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> >
> > On Wed, 24 Jun 2026 11:26:48 +0530, Udaya Kiran Challa wrote:
> > > Convert Microchip PIC32 Watchdog Timer devicetree binding
> > > from legacy text format to DT schema.
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> > > ---
> > > Changelog:
> > >
> > > Changes since v1:
> > > - Fix example indentation
> > > - Correct example clock specifier from REF2CLK to LPRCCLK
> > >
> > > Link to v1:https://lore.kernel.org/all/20260620172354.155565-1-challauday369@gmail.com/
> > > ---
> > >  .../bindings/watchdog/microchip,pic32-wdt.txt | 18 --------
> > >  .../watchdog/microchip,pic32mzda-wdt.yaml     | 44 +++++++++++++++++++
> > >  2 files changed, 44 insertions(+), 18 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
> > >  create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32mzda-wdt.yaml
> > >
> >
> > Applied, thanks!
> >
> 
> Thank you, Rob. There are similar microchip, pic32mzda patches related to spi,
> sqi & rtc which are reviewed/acknowledged.

I picked up watchdog only because watchdog DT patches have a tendency to 
get missed. 

> 1. microchip,pic32mzda-spi.yaml
> https://lore.kernel.org/all/20260622-ingenious-finch-of-fantasy-7bafaf@quoll/
> 
> 2. microchip,pic32mzda-sqi.yaml
> https://lore.kernel.org/all/20260625-omen-stark-6bb827ebcc43@spud/

You missed sending to linux-spi and/or Mark B on these. You'll need to 
send another version.

> 
> 3. microchip,pic32mzda-rtc.yaml
> https://lore.kernel.org/all/20260703-identify-cringe-ef88079923cd@spud/

You missed Alexandre.

In general, use what get_maintainers.pl gives you.

Rob
