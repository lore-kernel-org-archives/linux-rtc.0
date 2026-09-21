Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE23AFD16
	for <linux-rtc@vger.kernel.org>; Mon, 21 Sep 2026 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025796; cv=none; b=ezQ5q+K67KWT3muXUPHdjfP3oSCVE1yMG9v7K+PYO/s8/QK6gAc+RZqr39khNiHKrp/3fenvf8B2hSbxma/udcyimV5x3C2aFqV4QTv8ZtOK/tWVFIBQ6WdPOzDVLjvUfgBHag3/w5hfzIBZ6h+NyNvDShdJwklzwK6aEbZ6kVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025796; c=relaxed/simple;
	bh=L55+K+zGgob15DOg2bZ7X1HFw/pppSeMHOgCdSK2GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNxYDTR8x4jHjfAFygnJsicEM/nx1zjQrrwpDJjOQgX0pb2bUbfC68V1KscItdRUG0z+XH4b+8Yz7Q59t96uuvRZcujkEeeqVhYy6XpKS4eb/quPKq9VsJF63wzmo58L6WtCTnTbRwBIrL7G9fU4lAKkRuDlo7xYylvqTgxfa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VWzy1U8R; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VWzy1U8R"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A430EC23D9D;
	Mon, 21 Sep 2026 21:23:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3635F5FFB2;
	Mon, 21 Sep 2026 21:23:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89C7F10328621;
	Mon, 21 Sep 2026 23:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790025784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ah7akZoMl1sujMBaEmjcTDpMpRFLs33NH0oQHW60O1Q=;
	b=VWzy1U8RXTeRsPgYx51KGB2hi3riCE+J52BsnMPrj2TcQsGWc+C1ih6pHnnF3d6bkY4noA
	FVWCABixTqso4iYVob9JHrIjN6Gl/hNuCazocOYiU66AhG6sEBvcMb6YT6p1hsPQMaEZuT
	IYRVbi2Ui3w3vvfGm4zsjVjMxeBBfK563rn14JeGxitXzkLYTbY3b88wGOteoA2YtFaIas
	M4dkV56KG5n0a7RgoUNFFwI3TzB11GgDBTSIMbeyf6JpNo4Ybr/UO701yjZfAB4FhiphkP
	zXXanee1zJ1J7iz79ADs9mOdQGyN2BvH7A83Rocw5b3JTzbDXZ3SPqfJF9n2tw==
Date: Mon, 21 Sep 2026 23:23:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH v3 2/2] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <202609212123007fb25aae@mail.local>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-3-sander.speetjens@gmail.com>
 <20260918-outrageous-myrtle-giraffe-80dfdc@quoll>
 <20260921185949d6debd17@mail.local>
 <9dd42965-f39b-49e5-aeef-5d03647b2005@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd42965-f39b-49e5-aeef-5d03647b2005@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 21/09/2026 21:36:27+0200, Sander Speetjens wrote:
> > This was my comment on the previous revision, I'm not sure why it was
> > ignored.
> Looks like that email got lost on my end, I found it in the archive.
> 
> > This undocumented sysfs interface has to be removed.
> Just to make sure I understand correctly: does "This undocumented
> sysfs interface has to be removed" mean that
>   a) the attributes themselves are not wanted and should be dropped, or
>   b) they are acceptable but must be properly documented under
>      Documentation/ABI/ before they can stay?
> 

This won't get in unless the ABI is proven to be useful to multiple
RTCs. As-is, this can go to debugfs if you think you really need it but
I doubt this is going to be used ever.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
