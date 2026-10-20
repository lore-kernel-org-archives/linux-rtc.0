Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500087;
	b=kQxw3BhmlT1jCuzjFjxFjVSv4jHF829c0aNs5wHjCBHQQJ0DSEb9eTFtleSSMiq31bg8
	 lQy75JHAaXw2/ie6bq4BTx9UeVbl/WjeYotv5wT2iJkEGx6/rLnKYM9ia0GswVo40KN5E
	 dGhxTChI4lvMFg2+7RN1gl3gWXatDey+uFV0Gs4p038125ifA5tqexiMt3j6Tn1G3gVpX
	 pIqh0Hre3a5lPt9WhaL7Bq1GmQwhTLv7RF1lACnmjqYwDuFf49BRGgLrSi7keVA89mPUP
	 xdiN57r4uf7e7E1vsMTAJCFte5lpQ1hHU2Z2zjpkmhrFjzjsUsuSfpVJ0XCudN/8jnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500087;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=cCQtOg6Y7MZjLhYmi+fpS5EWVnteI9TG9obXYcVMP/4=;
	b=yBMEn9zX0KB2DXApFEepoJOWAlZhF01jug3uc+nS6tz3ER/hXRaVOlX6HwPRnh+sxGdS
	 5yhVDUqhEkXTrclNscIwS2jYyvpRxUoiCqZVFhpgXUcf6gdglvVVXAKrPDD/tlayoAX8u
	 +vcRi9La0anQRbNsK7GblI3igm+q/AfzlqJOnfFv1Uh9CqfZG4EQ1unpu4zOJ8XV9KGJR
	 H/YYT+/RzxgMALXJvu9/qwdwRpDRnl/PAfcGZN9xh2hPz5QtYbZNKNUzdkaBO1MvH/GqZ
	 PM2UsnDodUjlQn6shOGyLrMOBWSbREAXYsz2OeYKFR/WdJZRmh5rm2DSO5lXMemKeAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cjfPdTZG;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D42606A31C;
	Tue, 20 Oct 2026 12:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cjfPdTZG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 184691A1246;
	Tue, 20 Oct 2026 12:41:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D86FF60393;
	Tue, 20 Oct 2026 12:41:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E52C10328C52;
	Tue, 20 Oct 2026 14:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792500078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cCQtOg6Y7MZjLhYmi+fpS5EWVnteI9TG9obXYcVMP/4=;
	b=cjfPdTZGWbI7kobCzZP3/M/Y59jf88KfZnZHbA4KI+yM+q6IpuNeQCHWt6inBU5Smx+KzO
	3U/3jftAGPXUaDnJZ2Ub7WhVQSWq8PVIeUyIJw8hoGW+BYDmE+rsmKVV7TfjRQs8c3aO3l
	YsV8/grT8UFjTkCrNwVzPlcfArFhtdoSKC2qrC7XWwphGOI/FlRsyLvqJ0uQgh4ob1WNkg
	rT7ol1xSGJSBpeHzDgpKZU+ChWG+lPX15sNrJK598kNsV45QIszDgzFhUX7748Slsqockd
	bIfuJibvsWhtfq4axhFD+LF55Q/JZ0KB+TWzpcpMgQ4+mTHFS/N6e3t32+mMfA==
Date: Tue, 20 Oct 2026 14:41:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: Fix alarm register word order
Message-ID: <179250004574.303413.14716075663642251592.b4-ty@b4>
References: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
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
In-Reply-To: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 20 Oct 2026 00:10:24 +0900, Baek Kyu, Kim wrote:
> mpfs_rtc_readalarm() swaps the low and high words of the alarm time.
> The RTC core reads this value during device registration to initialize
> its alarm timer. This can populate the cached alarm and timer queue
> with an incorrect expiry time, or leave an enabled hardware alarm out
> of the timer queue if the decoded time appears to be in the past.
> 
> Read the low 32 bits from ALARM_LOWER_REG and place the masked high
> 11 bits from ALARM_UPPER_REG in bits 42:32. This matches the layout
> used by mpfs_rtc_setalarm() and the low/high assembly in
> mpfs_rtc_readtime(), so the RTC core imports the programmed alarm
> time correctly during device registration.
> 
> [...]

Applied, thanks!

[1/1] rtc: mpfs: Fix alarm register word order
      https://git.kernel.org/abelloni/c/d691a96370b6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
