Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501916;
	b=156QfZlBAhWooXF4AymRltjoZgK0a2JF8EU39dimweqAFIzRRWWTsNU3/DA2qUlqhDhv
	 f8ASeRcdSmH2VPwcykSIkAONQSRVR7WExCoj4YEp2NUH+K7BWQceuuebDQoHya/AdlQyi
	 CahZGrOeylfBfSwQqVPfvy3VcGVX29XVaJrz660h9f2BP87TKulIzHRsmnYcObDYDGWZI
	 IHqimmonypi93S2kmpqzkRjFjGR7V3Zl4ibsC4yh7HfnS0sLuGILgdABok5ioIwP8jc0a
	 g03zyknWCeypJwdtIYcsPqDGLjlNr/1weV1PsXASnNbpCTFLWpSIIfjcsijwUF6TyHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501916;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=tJ8nTSPCmAC6BvEgKT+sWHbCVoSa4SpkOmcEa+00obE=;
	b=IpzKgUVVMvotZVI9PyGTVzv2krJI7uvGcDLGN3C/JdCCzax+7qkjCifhRUyX6kEAVDw9
	 8jSbxfdwcHY0mtowvLfm8H5tddKda6ySmc5CCdkvBhAecslkD73H1HUChkJrjudeTTX+X
	 ANT54yli3Dz5NjOGo2nxQyu6s7i4W8qhQuon2lKUL1zbXchQjGLCs0tGd4Q03YZ+JnI6y
	 IAiUeqymny0UH4rixU+5rPE5NPUoL1pSF7Fuo5Fl8wi7UtwAJoBTs6ruykuXVV6WhrPf1
	 yz4KZxtnrVub+eGxMaAlUfI/YvRRj/hHVBTGH6nmguM8CLWpzyT6dO+Xy2b3XQpTffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ixYqoWv+;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3637606A334;
	Tue, 20 Oct 2026 13:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3637606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ixYqoWv+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 52B734E41223;
	Tue, 20 Oct 2026 13:11:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FED260393;
	Tue, 20 Oct 2026 13:11:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E50610328934;
	Tue, 20 Oct 2026 15:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792501908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tJ8nTSPCmAC6BvEgKT+sWHbCVoSa4SpkOmcEa+00obE=;
	b=ixYqoWv+AOcvdmX5ShAV7dKwjNu8mWxwaWNCov7paTontzaDPdQs1htnWozPg/KnihEzku
	h1h9x6OcGF5o07eLgLdA8Z4Ta+HiX/d+UcLjSvUsOd2xK06xgSaD+iwpP/9X6Xk23ksKrE
	u+pXDTXGQZpsU0Ia0O0aLUdgRU4kA09ZBF7wAoRGFB4M02M6KkLEobiz3yt58/e0fZcG7S
	j6yskcODUFEFkzy8E5h043QDhxOol9ZDitPfL5LOtPc50WI7eOB79q3j5R1rnfneJSJt14
	Jnuzs/SHJXKzK515pYeXvBAoXagR1r196J+8v6Ouqa8z2YcEY9ux4CLVkhZpkw==
Date: Tue, 20 Oct 2026 15:11:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Linus Walleij <linusw@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Message-ID: <179250189821.311412.6158630374610654795.b4-ty@b4>
References: <20261020080026.2461578-1-arnd@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020080026.2461578-1-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 20 Oct 2026 09:59:21 +0200, Arnd Bergmann wrote:
> The RTC_HCTOSYS feature faces an impossible dilemma on 32-bit systems:
> 
>  a) systemd requires RTC_HCTOSYS=y with the correct timestamp
>     for its intended operation
> 
>  b) broken RTC hardware can produce random future timestamps
>     beyond 2038 at boot time
> 
> [...]

Applied, thanks!

[1/1] rtc: class: Make the time32 hctosys limit configurable
      https://git.kernel.org/abelloni/c/b253c2e96a80

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
