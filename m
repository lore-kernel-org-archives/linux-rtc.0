Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15E3E8C55;
	Wed, 24 Jun 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337362; cv=none; b=LV0M0Hn6hzgeuo4Crm7bwmdxU9yeK5hMNxRJsNFd27ZXEE9nnEKBfP5yM26IUOQZVevMnGPyaOPQdYDpx7ukifbs5CxbWfe51WA8QYod8FXtrHkqvRWTJ9200S66rtkYCRAGYr2fCdCctB7wfcmpkt6SPfBcO/Rm3G25F1CcjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337362; c=relaxed/simple;
	bh=0RMM/boG+GaB588kmZxoY56SjoqBvNVJ+cICVOp23jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G70fDor8bjboMcOU8QsJX4Unz8XHWTbLUzS01fr2HhltlucjOM4Z1lC8Cs/EM1paPEj9yaJzT49ZuNRDDKMEN36tyuqdwXF1MuPQHX3WCFf+6rc8pcgJvtzWaG+n5wPvUE/xntMyg6Gsx9roZSkl5T62soN3vpeMh7i+g+ulcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pZl2biYd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pZl2biYd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 831104E40832;
	Wed, 24 Jun 2026 21:42:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 420DD601C5;
	Wed, 24 Jun 2026 21:42:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE5C7106C8077;
	Wed, 24 Jun 2026 23:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782337352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Py+lZqkgIXqXX6fzyMcdekYsc+HT7S1N5nEntrkRFqs=;
	b=pZl2biYdGQwMIEvHwAt9tU70J5DNwLHP9I2xBh336qsU/n0sp+dEYP7OoOV8UXvoWmXFt6
	tgfV6N4ibKi2C8rcBAMKOdYIT0g+EppKkjrZ7y9dkIALIG+XCk5KMVOBlRtKFKqRBXfwFS
	LGwoADnGgxYOuKn1F8B/AAXwpzIBqeTuGJxHiJUn4ox5flkFae5V5XJg/0VNCJDtG4vexh
	eTUYRkwWUVDxRxI1JhbUoHDjdgO3+Bl/uvs2zzYlh718dXitx3t1HEyJn4cFGY/iOX6LrZ
	mXJjHIw1PD9hNIMK1eCzU4/mXI8Yls9SbPyz8bAcQyELrmZsCI6lKx2Fzpwx5w==
Date: Wed, 24 Jun 2026 23:42:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Adriana Stancu <adriana@arista.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3] rtc: bq32000: add configurable delay between RTC reads
Message-ID: <178233723837.1527737.15397795714342862411.b4-ty@b4>
References: <20260416142151.3385827-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416142151.3385827-1-adriana@arista.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 16 Apr 2026 07:21:51 -0700, Adriana Stancu wrote:
> When the RTC is used on systems without a interrupt line, userspace
> tools like `hwclock` fall back to a frequent polling loop to synchronize
> with the edge of the next second.
> 
> On the BQ32000, this aggressive polling can temporarly lock the register
> refresh cycle, because the continuous transfers prevent the hardware from
> updating the buffer. This results in stale data reads or select() timeouts
> in userspace.
> 
> [...]

Applied, thanks!

[1/1] rtc: bq32000: add configurable delay between RTC reads
      https://git.kernel.org/abelloni/c/d4992b7050a1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
