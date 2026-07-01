Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD597224FA;
	Wed,  1 Jul 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924510; cv=none; b=L+muGA4OSdvbWewa/n0Zo61pamptWjOkDdpewj11Cga6TnwTM12qhnJHVzf/VwTW59uSVmwKuWzKI6mf2f1m99hjy4eGcDnTwE7pmqq74rdLE2ll1ix9ujens47A5p56lPX/18onQdFQIwqb2c/WZMIabWWyIP2LeR3G8mRBm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924510; c=relaxed/simple;
	bh=So/MCmm5KX3SWRRGF1/C9UEuaHtoVYdP+WKQe1ziy1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIWAQ5o3jE6Ai8k7suQ6MJ4c0jcWlgiorhr0cKQkSIDBt9qr52Mi7SyF+g6MLL1acmiebJnIc0iyYXFu7KA7pvDIC9K6IElerzg5IEYrR0uoOsZX6UDzoUOPo21rTn6tikSUs/+moY0ssNPZWO3GhwJN1ndly4sNSu71cjLcMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PwApHo/8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PwApHo/8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 223A0C4FECB;
	Wed,  1 Jul 2026 16:48:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF9515FD9D;
	Wed,  1 Jul 2026 16:48:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 612B9104C948E;
	Wed,  1 Jul 2026 18:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782924504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qxtFhLzSHt+nahGfRB9UVm+Cbn4C6aY1wYx6sp3xHJA=;
	b=PwApHo/8B8Epz4Vt7aF8WpSL7rgkO6iJ2++Z5ARi/DD2CMEDZchzNpLSF+DlHBO9cH4qME
	K54lB9odaBwrcVe6ZDujZvDh/vnWlvDxtRxIa95VXY6b7rabchl5Jy16rlch6Qlgt13c71
	XjCn5pVC2upoxr4VDY9fDxkDYPJfDaKpK4A+lsYlm8WUoboO7/uNZf6ZCafdtNHXj7d8QT
	e3rHiScXuYFxNGxECrUnB78L1bco6nedN9qZ95hnVZ3Xwiqth+Mt+Yju2oI6rx13iWc7J8
	9B8gnokziJEoxfxQKkrZ7GJKDKmn7x7i8+NuJquh7LwajrdbGBL9So5/z/ATsQ==
Date: Wed, 1 Jul 2026 18:48:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add sii,wakealarm-output-pin
 property for S35390A
Message-ID: <20260701164821b7492eac@mail.local>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
 <20260630-rtc_s35390a_int1-v1-1-1b2239e16be2@posteo.de>
 <20260701-bronze-jaguar-of-perfection-028bac@quoll>
 <45e8157be53c3d8827fcccece7f706968bc056d3.camel@posteo.de>
 <7de66163-369e-4118-af51-6913b565fa4b@kernel.org>
 <d06dd0726aa3795ae99df5fa8a9c05d6e2001efd.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06dd0726aa3795ae99df5fa8a9c05d6e2001efd.camel@posteo.de>
X-Last-TLS-Session-Version: TLSv1.3

On 01/07/2026 16:43:07+0000, Markus Probst wrote:
> On Wed, 2026-07-01 at 17:14 +0200, Krzysztof Kozlowski wrote:
> > On 01/07/2026 15:25, Markus Probst wrote:
> > > > > +
> > > > > +maintainers:
> > > > > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > 
> > > > This should be someone caring about this hardware.
> > > He does have the majority of commits on this driver (excluding merge
> > > commits and commits not exclusive to this driver), although most of
> > > them are pretty tiny.
> > > 
> > > Who would you suggest instead?
> > 
> > Someone adding features for this driver, maybe driver maintainers. But
> > if Alexandre is fine, you can leave him.
> > 
> > > > 
> > > > > +
> > > > > +description:
> > > > > +  The S-35390A is a CMOS 2-wire real-time clock IC which operates with the
> > > > > +  very low current consumption in the wide range of operation voltage.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: rtc.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: sii,s35390a
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  sii,wakealarm-output-pin:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [1, 2]
> > > > > +    description: |
> > > > > +      The output pin to wake up the system.
> > > > > +      Default will use the output pin for interrupt signal 2.
> > > > > +        <S35390A_OUTPUT_PIN_INT1> : Output pin for interrupt signal 1
> > > > > +        <S35390A_OUTPUT_PIN_INT2> : Output pin for interrupt signal 2
> > > > 
> > > > Does that mean device generates the interrupts?
> > > Yes.
> > > 
> > 
> > 
> > Then I think you miss interrupts property.
> From what I can tell the line is used to generate a system wakeup
> event.
> 
> There would be no obvious benefit of connecting it to an interrupt
> controller, so this property would be obsolete?
> 

Then you need proper wakeup-source support



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
