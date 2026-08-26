Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0B37F742;
	Wed, 26 Aug 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726766; cv=none; b=Olhwd18a8uV80BiH2FjgmPHGwV6T+l97ihlvy0UfBY+6PMa5Oa53sGVXT+nw8A+UTn9e56pPuAuIWq4MCfS3g6ej+yZfSfURdUE6R7JYvVXgM3Kf/OeDNG5lOV/LtIbkSYDoKfDo2pKF9rfyAZQ1Ub1duxZ3sb1nmjdQ4Z6Z1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726766; c=relaxed/simple;
	bh=FV8nAQQf9XGAZ7fW/KRtDG/2KL8tonOaC4OTpUFNiq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9AKnnoc5SHMNbnG1GiNWzATq20T4/EfhIive3V71bNBHVhkj9kDBPSe+kjZIpZO+d2XKx6t6Kq8VR7bCFpFfqPL9tEvOjHiy7OIQAlmL2jPM5tZAOVFGYrf1LukMl+sGmOirgLQ+MREIA0V/EeCPyzn7ZQ65bgXv6J4X3Me0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lXnRxukq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lXnRxukq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E0E84E413B5;
	Wed, 26 Aug 2026 06:45:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01AE8604EC;
	Wed, 26 Aug 2026 06:45:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4150011C7935E;
	Wed, 26 Aug 2026 08:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787726757; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IB6/QwYl4GvFtzDIDE6HFpYYu3oj3RZwFwpdgGywhQM=;
	b=lXnRxukqEssFDprmV0gJ9VBaR9ipZn8lageBwU1nZVpTc9z3to4TSle35w9RiVO6KsHQE4
	nnBydW/MwFcaay1JVKPr1bLen5nBj3S4MhStvuC/UEIde0k9deuAHCx3aS0d1U6HBPYWI+
	3kqduTN3I8MzUFP//QvW996UGn5Zla3WURpd3s7FR73iDkmBJGf6RijUGDYjdFJmU3d7xd
	kNB1JjeQRc994STkb7JNR1vxt6M0noTlLXqMdpG1rDOY1H4LyfONAf/fqjZIXw8lDHUl0V
	qNtiM9+iX/g+QsAS7OWvMksSRLWHbQdBoe2ZM9PMOZTyqSCXcJloIaLSDH21Og==
Date: Wed, 26 Aug 2026 08:45:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Message-ID: <20260826064556dda469fe@mail.local>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
 <20260824082456e0edd7c6@mail.local>
 <2ce03d3b4cd9cce8e32fe1fe1ffbea5760bf9ef3.camel@siemens.com>
 <202608252107336920b1e4@mail.local>
 <f4ae12f3fba06fc00c74f76555d684c1fa706179.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ae12f3fba06fc00c74f76555d684c1fa706179.camel@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3

On 26/08/2026 06:13:08+0000, Sverdlin, Alexander wrote:
> Hi Alexandre,
> 
> On Tue, 2026-08-25 at 23:07 +0200, Alexandre Belloni wrote:
> > > > > The PCF85063 powers up with its CLKOUT pin driving the 32.768 kHz. While
> > > > > it's possible to request a specific default frequency in the DT via
> > > > > assigned-clocks/assigned-clock-rates on the RTC node itself, even without
> > > > > a real consumer referencing the clock, there is no such possibility to
> > > > > disable the clock output by default.
> > > > 
> > > > Are you sure about this? The CCF should disable the clock if it is not
> > > > used.
> > > 
> > > There is late_initcall_sync(clk_disable_unused) (marked __init), but for the
> > > clock providers registered later, say, via modules, there is no such mechanism.
> > > And I double-checked this putting some debug prints into the driver,
> > > nothing from struct clk_ops is being called without a consumer in DT.
> > > 
> > 
> > Right, so what about the patch attached which seems to work fine with my
> > rv3032.
> 
> The patch would work for me as well, will you publish it officially?
> 

Yes, that's the plan.

> BTW, it's racy, if __clk_register() would be called between
> 
> 	clk_disable_unused();
> 
> ... and...
> 
> 	WRITE_ONCE(clk_disable_unused_done, true);
> 
> ... the workqueue will not be scheduled. But overall it's a nice idea!

I'm not sure you can actually load modules before late_initcall_sync
finishes.

> 
> Maybe we just need to drop late_initcall_sync() entirely, this would simplify
> the things a bit?

I'll let this to the (new) clk maintainers.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
