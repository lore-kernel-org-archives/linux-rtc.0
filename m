Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3C407CEF
	for <linux-rtc@vger.kernel.org>; Mon, 24 Aug 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577302; cv=none; b=stS6co0MQc/f/lhAymoHfeMugytfFRgtX/yHG+QCB6fvK8HOZssZVYw3XBEoaSy/4EepqpIiiiSB8KYM31G+gXCjJp8y8JQRD6QVi5hhrs/NjpmdoFuIyMTC8jYffv7QJn8yCEFovVuFzmDeVYsPL5b+GXTM84H+/Rr6/SBf/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577302; c=relaxed/simple;
	bh=0qSC25jBlLVjs7F7Xd9aCh9GTcTDSoodZQfRePCSF/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIiqgk6mNkfVlkK6SzAqvihFwr7CCBQjxAiAKMn1DCs8m1QJb77C3SH/wIWUl34Q2Wo3cSFHRZPR72SunT9DIM9JPM7yCGWvh4E/QO4WMsT+MCPDAOnCRbNorAfT5O8kjrsnDcGICJ9jg4aZ40ygPgP1yB4QdWAuNGW5pN0Lkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MDOe3Doq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MDOe3Doq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9465C1A17FE;
	Mon, 24 Aug 2026 13:14:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67C565FFC1;
	Mon, 24 Aug 2026 13:14:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3545111C794D1;
	Mon, 24 Aug 2026 15:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787577296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gGYCE53B7et3Ka3weKyk90919WO7s82jxuO+tQX46M8=;
	b=MDOe3Doqb9buNbp0ad+L98/lppIv3BAHYTImy8FsxBBUsWAGC96HYCpC0SnsCbocy2th8h
	ACej1C58J181jw6fHQlImtNgSAwZ6wlThoIgYKinkdKZxTZG7UZ92q9UwF8/T/Ogi4gj7m
	18VXVOAzGqO0/a/rnVgISsapuo91TuTB0CyKh3Kbq3FxehXHIJPyyK/khc0zXU137chhSc
	ip7IJ7Vv/70+8oIvtf2ZJ1bj0fuKGNk6UEVOMCN16f76ybPYSq3Kr5kj5nG3+xWF78+QTz
	TBtqj+TLvgF5xSszA7ROqNx00bVFOTUF3aJeth+qWcvXFja1iFu07zjnxqlGJw==
Date: Mon, 24 Aug 2026 15:14:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH] rtc: msc313: Select by default on MSTARV7
Message-ID: <178757728674.951153.1665005289125961391.b4-ty@b4>
References: <20260713133919.1356748-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713133919.1356748-1-daniel@thingy.jp>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 13 Jul 2026 22:39:19 +0900, Daniel Palmer wrote:
> All of the ARCH_MSTARV7 chips have this RTC so it's more likely
> ARCH_MSTARV7 wants it than doesn't.
> 
> At the same time fix up the indent on the depends on line that looks
> like it got converted from a tab to spaces at some point.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: msc313: Select by default on MSTARV7
      https://git.kernel.org/abelloni/c/c9e17e381e02

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
