Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2017FE;
	Sat,  6 Jul 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305300; cv=none; b=hoCS/7D2fhX9EyJJ2UJn/wYBKilqlWcO+xvVd0Ugad65X9pUtY+pTl91kWk1aXcDz2EUQBEIW5GjrurGlrexvFj93POvoY+QtBhVFT0Rg7YNp6hxsY9INjPpCnzKHnyXOHnQqoNsROJpeskjNMqvLBpf9Va6KCYRAA0KHICdvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305300; c=relaxed/simple;
	bh=bARlJ6USTZV53ZWJCY+lsMH0sCGJPt+SBpAdJyskwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT1B7Z83mK7TQhmOgR9JaJlc9ifl0gtz3u/OfbtrWoB1fT6is8QGZdjKkjw4BFplcci42mn1wvHEITv6+kiXxAa/JXIwN2tWGtaLyqiz6M5yYwhy1L5cen02Xfj4p9HH8pwXuhc/ZIx7Yq9wigTZDruFWkha0K7H/+0WvAd2uTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hBoUaMK4; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hBoUaMK4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1752C40002;
	Sat,  6 Jul 2024 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720305289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNBdVH7oh1U1ahjiTPKfi9UaJ6OlAMYgpiiCYOSqBbo=;
	b=hBoUaMK4fdFhjjjukTL58N+XYdtIRDlFGr26ksCA4eoML68pJ9xvjmvXN0CSptKhbux+Xj
	endnW46PEArtItVnh4Sfxc8adAUblNaA5Vvac/2yC5viJDIfxefp+KAapkuA4IViZoTqmD
	YZBMU/Gwphfv4sTPQyphHXOgrRgrewHsbtmSGajSQzRXmPffGUwgoEGlr7PD6sKM2qgFYQ
	CmeSxKww70fRVxGTrPVSv7riZGrIeJ45D5Tb6rsMly5GygmmkQKIu2vD2Z0McTvAT/8wnv
	4CyEt5++84vVDY2Wn/VhIo28t2xxLgmiihuFuipQVjGcSqPEs6sGxhaltV9dvA==
Date: Sun, 7 Jul 2024 00:34:48 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: =?iso-8859-1?Q?Szentendrei=2C_Tam=E1s?= <szentendrei.tamas@prolan.hu>
Subject: Re: [PATCH v2 1/2] rtc: ds1307: Detect oscillator fail on mcp794xx
Message-ID: <172030527564.498069.14930741368434942533.b4-ty@bootlin.com>
References: <20240611072411.671600-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611072411.671600-1-csokas.bence@prolan.hu>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 11 Jun 2024 09:24:08 +0200, Csókás, Bence wrote:
> This patch enables the detection of the oscillator failure on mcp794xx chips.
> 
> Co-developed-by:
> Signed-off-by:
> Signed-off-by:
> 

Applied, thanks!

[1/2] rtc: ds1307: Detect oscillator fail on mcp794xx
      https://git.kernel.org/abelloni/c/5ea60ba8007d
[2/2] rtc: ds1307: Clamp year to valid BCD (0-99) in `set_time()`
      https://git.kernel.org/abelloni/c/f825a15fc8ce

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
