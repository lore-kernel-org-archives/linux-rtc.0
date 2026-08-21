Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345882D9792;
	Fri, 21 Aug 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344828; cv=none; b=d/213u23EsbVWiOU3DeMx3moS8eDgHaM+BbvvbXK8OT3Nmmc61reFc24isw8226wR27dBmAgT6ZvQ4i7H3J00KUF7ydihTTePowkLt+BRj81TVnjHe9KPo7v+AYR4y6EeP7lwyi8Pv3TxkSTgy6G1i6sOsLIpXlY7BgZR4vZ0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344828; c=relaxed/simple;
	bh=N0mi1uhxvbxdUOmuq5vDgSLr+dix+DJ8ZktmZTxFgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SagErBaRXv5QS9UVz90iFaL/SqZiZpFEkke1ts6Zt8re/OrKF3oRzeHIuQKAZAkdtAuj+Kbr67DcNWUAG/CZJfRTANf3YVlEr7P6feZcKOrjvoP1KL8/VFPDyaAmL8rIppACZ3vi9dQfkMbAKkOtpEd5zZcJLYqtF7CwmIDOvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=maz2Jp1f; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="maz2Jp1f"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 862751A178F;
	Fri, 21 Aug 2026 20:40:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 51983604AA;
	Fri, 21 Aug 2026 20:40:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDBAA11C77621;
	Fri, 21 Aug 2026 22:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787344817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Du/OHwRRnpO7Kwc7OdFAk+NUHL3Ni7jIAm98ev/G3Qs=;
	b=maz2Jp1fZpxdzBb/YbVmr6mH4USFLU2INuNwzoxM+tnNfJUdac0RlP1yUQysM6tnY3+DaF
	dmn0ESZjwtF0v8KLdrLHPRzo42jrhunoZvShaK1S0v6POUKMGENFoF2pDUQv+myXSxTUKe
	ahwy3xDFIEuH8V6u88Dvh9NZaKHHEucGRF1ZZ/tX5t+fRZeGz8i7vojf05GLzUEg2TURU4
	zWcHZVORtWClMo+IAdTwBPmOupnVhPSzWNJ98jRzM62AXWEgt9Xd+w3SR7CWML8m09JFgi
	HqOM9v4Xi2z41RC1uEIZAV2fhBMdEPBgtRWPNHFFC58twCXVCzdwSOdIwpca2Q==
Date: Fri, 21 Aug 2026 22:40:14 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <2026082120401422dffad9@mail.local>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821164050abd3ceed@mail.local>
 <CA+V-a8tp8EEJw9NLRfpiM5pve8GBc41iL_s=5=MqZaSHssOzbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8tp8EEJw9NLRfpiM5pve8GBc41iL_s=5=MqZaSHssOzbg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 21/08/2026 21:37:43+0100, Lad, Prabhakar wrote:
> Hi Alexandre,
> 
> On Fri, Aug 21, 2026 at 5:40 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hello,
> >
> > On 21/08/2026 14:56:06+0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> > > is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> > > or when it runs at 32768 Hz, the driver uses SUBU mode.
> > >
> > > However, the RTCA0SUBU register used by SUBU mode is not present on all
> > > SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> > > mode on those variants would expose RTC offset operations that access a
> > > non-existent register.
> > >
> > > Add OF match data to describe whether the RTC supports the SUBU register.
> > > Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> > > variant without SUBU support.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > > v4->v5:
> > > - Renamed rzn1_data to rzn1_rtc_rzn1_data
> > > - Added a print message to indicate that SUBU mode is not supported
> > >   on the variant.
> > > - Added a comment to indicate that the xtal clock is NULL when SUBU
> > >   mode is not supported.
> > > - Added Suggested-by tag from Wolfram.
> > >
> > > v3->v4:
> > > - New patch
> > > ---
> > >  drivers/rtc/rtc-rzn1.c | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> >
> > This doesn't apply cleanly, can you rebase on rtc-next? If you do so
> > today, I'll include the series this merge window.
> >
> Oouch, I'll do that right away. Hopefully Im not late.

Not late, don't forget the other comment about the sentinel from Wolfram.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
