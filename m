Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504250E5BB
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017889; cv=none; b=debQgjoCRC/CyS2RA5e/hPDYebC5hlJjIey6CHs+zTnXXwrqkhQ051z0YQG/CnfMPsX4X/B3QlVkJFNoClfLXop0ahvlzufaUC+j+AQ6rLnuIB2t+VuaxS13kC+fxYXW6Q91ZDkyrsGqvZeZ2JggndjyHW/ZQZc8XW9W9pAsJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017889; c=relaxed/simple;
	bh=WEAj10ZEs87gYY2qAkhw9t06wdwrhpg3Amds8V9RA8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3H+WWw3ivoEH0ubzKk4xEvmHKPQ4h2vxbkSy98EeaVPzjcIhLv7QJSsxEzrQkIdLFANkRAuYUKmeWLKNoDhKDRsUmDmuhpXtFs33hHt0G/BKaVg/PYiSWCmvnUYyz3ZUi76qlPf9B/P1m1OJbiUlR8UWzXYmUO1f/pq/fK082M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PtYt9lom; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PtYt9lom"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D5C3E1A0E97;
	Mon, 21 Sep 2026 19:11:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A29355FFB2;
	Mon, 21 Sep 2026 19:11:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB39A103291F6;
	Mon, 21 Sep 2026 21:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790017881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dewX2pr+tBAQH8D0s9SUEjbVC8fLT3dYu3csMq8B8W8=;
	b=PtYt9lomWlr+jUBbaDTWTFj8kj14mtSlnL/d707qwuTR+P/HioGV3kR7S1ZeR2l8DHk0E3
	qzkwQ75GuhMtyX/7wUbmZF3Aey86/xl4b3seWvB+O8Fu59Pn+oR5Ks2xsAvQYTtGGa7QUG
	4aSQ84UQrOdrXcZdQOUMlKgUgi4G9VAFxbc/+LGYqcc7q9isZ+9UN4+QlBlny78bRTGQkY
	+66aEXKHv7W+Y4Vnx59PMG1y+i2ljiRpDl1IS0Yb/JTB8epS3IZ/lYu/v9YgKa11+n6sfc
	3d1mhZSiwqTtPrizZWx6R8OWPsVKrSP9pd4j+PmIH83cMwvLUBJEJRK43DSbng==
Date: Mon, 21 Sep 2026 21:11:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Message-ID: <20260921191119118349f0@mail.local>
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
> BTW, it's racy, if __clk_register() would be called between
> 
> 	clk_disable_unused();
> 
> ... and...
> 
> 	WRITE_ONCE(clk_disable_unused_done, true);
> 
> ... the workqueue will not be scheduled. But overall it's a nice idea!
> 
> Maybe we just need to drop late_initcall_sync() entirely, this would simplify
> the things a bit?
> 

I forgot to copy you but Bryan asked whether this works for you:
https://lore.kernel.org/linux-clk/20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com/

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
