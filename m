Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8C44236C;
	Thu,  8 Oct 2026 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498002; cv=none; b=myJ3mdghw33nRuAu2/Cu6sO8xqVgQWDmklHVM4U7HbTzBaGl5QuGH8JwP92o1PVNo2zFoczrT6QqR9eDjDQuam0bOgcb/lb92a5zp1qOmqKJO4EkYHio/D7BOVeJJhSAll0gSNmUiswpmMKs2Fq2UNWvt8DZBd9av9gM34oh5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498002; c=relaxed/simple;
	bh=c14MBtjHNc4ACORmN1vzES6FImHwToNLRblquggXvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLPS80N9gzPpTBRHcbgyU8vGgfbDRxk7gZzxJSDbJNNNMnX4jU05Nhi0aF/ezCBx1oOztuGczox5XPeFW8pxjxD6iMQHSlQR2lr44OIPEETAI/61vOV/07SJTaF8nmjbRTUMWc3KjfVTSSQy/zVEUMkXjqWcoZ4Eee0FV3SQO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=coJ70yLR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="coJ70yLR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 825431A1199;
	Thu,  8 Oct 2026 22:19:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3AD76074E;
	Thu,  8 Oct 2026 22:19:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D22E11D72422;
	Fri,  9 Oct 2026 00:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791497991; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8zuRPMu3NfvVMk5IGAQBKJmMiBz/C5HT/g3jm1/ORc8=;
	b=coJ70yLRBS6EwEUG4kiWRitMaygmxrxkfKCz/t7niN6G2SDRWemJJ28XwWIdRjHMbrQIK/
	946ZmiaGTHejjjadEGWfJ98nL7JtV2ELSM+uQuBokgkirm+JIamUHLoBC9n7Ph8psjxCVV
	u8q6x35ZHGq0u2Ygrvr2s2Yb/gCmEiTXJeUF2Rruy8alZw+/iEnNdNP2CQObEbyJaR8YvZ
	DAcfxMAOgC3OEqbOrEQrmagCWe4TocJAzKduCw4GD3qyCmIKmRuDe3+E0aN5IAvEJe2WBE
	m6722NVeKRvmsdUdw/MJmLdZ/+QX6kSIcdLmGHeDL7Q3t8JWtCiFc1VUuQ5A+A==
Date: Fri, 9 Oct 2026 00:19:47 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/3] selftest: rtc: rtctest: improve handling of skipped
 tests
Message-ID: <20261008221947733e6a69@mail.local>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
 <asfzfFuBFVKP5WQA@shikoro>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfzfFuBFVKP5WQA@shikoro>
X-Last-TLS-Session-Version: TLSv1.3

On 08/10/2026 21:48:16+0200, Wolfram Sang wrote:
> On Wed, Sep 16, 2026 at 11:31:08PM +0200, Wolfram Sang wrote:
> > Here are some fixes for issues I found in 'rtctest' while checking RTC
> > drivers. Details are in the patch descriptions. Patches 1+2 have been
> > tested on HW. Patch 3 has not been tested, just follows the pattern of
> > patch 2, but may need more discussion in general. Please read there.
> > Looking forward to comments!
> 
> I guess at least patches 1+2 are good to go? Who would pick them,
> Alexandre or Shuah?
> 

We discussed it at LPC, I'll take the patches.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
