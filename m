Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA74252BA
	for <linux-rtc@vger.kernel.org>; Thu,  2 Jul 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980233; cv=none; b=ehVsHXJKjecSSzd+RZLUzuatvlwF3EdqvVcNfR79RmFmTEBREK0CRJJN6Ald77lnUC9OVL574GPY0Z9nb+OVUvRH2I+8u4z+VqEcTMmFgPWawHwDz4nj0vpNczG4KT93cKpoAb2c9KjUNyBcA88PGRIrrhTNDS6Go5pNmg9O7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980233; c=relaxed/simple;
	bh=6XdmpY/pL+fHXGQV3gmPke5aow2UPDrA6F9fwFoc5OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDSmPR43QpOkK9oqrU6FO9BgCmplMp3JUilMIRMGrwGdcRXXbuY4SYiaPzvMidJfr+zCqYykRnG0AmFVtNhKI93GU98WzU7+JzEx5npmG2n0/dqa5VHUogbuidGN8naWx62FgzTh71VTweEyAORJiMyH5TJa57qtGKHsLPP+0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ERANWzcF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ERANWzcF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F1CDC4FED4;
	Thu,  2 Jul 2026 08:17:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B62655FF03;
	Thu,  2 Jul 2026 08:17:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90A3F104C96A5;
	Thu,  2 Jul 2026 10:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782980225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gJc2ZXFFVkna7QBtpQqQx1joA9VijE2aSoSY4AV7Vrs=;
	b=ERANWzcFm1uj6GQ7c2DRm/HlQFI9/dQl5lNS9uP6do/bkXXYKUsaLzW7s16mpLsWOXhgV1
	gEpaCqZ/FI9OhjNAw6x14AdwKSR09BJLxabLEvPQneiA5h40NVu1QCtl4Zj4VMGA11qfZ8
	a8SRokCjPigVA2B5U3fQW4Fl8Z1xs1Pn/GvxN1FWTu/B7B3LWjqivUN3RDR+nOMRRgY6AX
	HM6XWG467tElfQGSE68i96OLTXCd2+S8nixInDL2Sz9f8PHwdpYuA8Tyn7y/3PAdtrIG8t
	APMseIuMqQdwAgeqvRK8b8Jg7u4PhXh7pDlpJsWDc535X9J8b1j0734RdnWmNg==
Date: Thu, 2 Jul 2026 10:17:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
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
Message-ID: <202607020817017cde494f@mail.local>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
 <20260630-rtc_s35390a_int1-v1-1-1b2239e16be2@posteo.de>
 <20260701-bronze-jaguar-of-perfection-028bac@quoll>
 <45e8157be53c3d8827fcccece7f706968bc056d3.camel@posteo.de>
 <7de66163-369e-4118-af51-6913b565fa4b@kernel.org>
 <d06dd0726aa3795ae99df5fa8a9c05d6e2001efd.camel@posteo.de>
 <20260701164821b7492eac@mail.local>
 <74b32ed0a700e3900c0f34d730b2b5b69eb2ca19.camel@posteo.de>
 <187099d0-5e09-49c2-b67d-8bd4366ff1a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <187099d0-5e09-49c2-b67d-8bd4366ff1a0@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 02/07/2026 08:09:55+0200, Krzysztof Kozlowski wrote:
> >> Then you need proper wakeup-source support
> > Wouldn't that break existing devicetrees?
> 
> How?
> 
> > 
> > The current driver allows to wake up the system, even without
> > having wakeup-source set.
> 
> Anyway, wakeup-source is already there in rtc, so this would be done. I
> don't get though, why there is no benefit of routing it to interrupt
> controller (interrupt controllers do wake up the system). Additionally,
> if you do not connect it to any interrupt, then how does it wake up the
> system?
> 

Some systems are routing the interrupt output of the RTC directly to the
PMIC and the PMIC is the one responsible for waking the rest of the
system, including the SoC.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
