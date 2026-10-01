Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41B3C0637;
	Thu,  1 Oct 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848812; cv=none; b=XPDjRIobAFGqsrCX/Q/uiw5V4ks+mu9tRBH9L1rzTK8PVInTPM0+aiUahipE33/uv7/RX7nCrZ96XiBWvyhkFejw/D8C7w6EgENy1pCOzC7sF85SEDjYZgrpZLwROMibMs7ZaqdVS0DcrvqOCg88Ya22LUalofL9gOcnqQLdJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848812; c=relaxed/simple;
	bh=6J4QBj254gydO97EKA078vV4wdcXrgnYk2HaO082i5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+EQbbvci1gYCqyGyXQHjfPlt+V2LJuXpdUOaVDXv7yeCsJCNPw9jVXeurLEcwq9kdJb+tXuJFiKkhnjM15W4C9wt3iteM9Loz1kemwRbnU6yDeYJ2NF8eea2q4kaB5061rVhU4BjjoUMUgpfi5h4srjjv67wMOAaTmpv3G7aFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q5KiaogD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q5KiaogD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6071E4E40ECD;
	Thu,  1 Oct 2026 10:00:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 344C460341;
	Thu,  1 Oct 2026 10:00:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E84610329611;
	Thu,  1 Oct 2026 12:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790848805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dY76eQFJFbcYtTtHCHhdoCdyDWIvzzfDE47J+yUIxXE=;
	b=q5KiaogDA3ek6cAs+uG7cZ4CePZVBmJ52xqL7kEvFNBOcY421S3HVNlzyPaw9UKexYAw+W
	KlSq5KHMtBcXa1jCK8pzcW+nY72n5Y/yb3/mI+3uYozc2kpmc7fD7DYdgwa8ThokLg7aKB
	E5+iht4/uhKSG5fYwh2Z+WJ5/OtnrbqqpSixFRXcTzJsSF8RnzdZNSbX3AIF+egeVevFuf
	bIURk6g0zRtgDxeySFJg4FlRV0lGJ+LH9kNzKyLTAGw2bu3wKgQcYAxzaYPssh6yNmwFEp
	cru6mBaK71yTu0Y28N+bGFzp1doORDs+EgpwKUaNddnP0K46Ug8lwizhG/DazA==
Date: Thu, 1 Oct 2026 12:00:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Liu Dalin <liudalin@kylinsec.com.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: Re: [PATCH v2 0/3] rtc: ftrtc010: fix resource management and
 integer overflow
Message-ID: <179084877097.656441.12706042901770671456.b4-ty@b4>
References: <B61B30904C7ACEEF+20260827080320.3351155-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B61B30904C7ACEEF+20260827080320.3351155-1-liudalin@kylinsec.com.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 27 Aug 2026 16:03:17 +0800, Liu Dalin wrote:
> This series fixes three issues in the Faraday FTRTC010 RTC driver
> found by Sashiko AI static analysis:
> 
> Patch 1: Fixes a clock resource leak when devm_rtc_register_device()
> fails in ftrtc010_rtc_probe().
> 
> Patch 2: Replaces manual clock management with devm APIs to fix a
> use-after-disable vulnerability in ftrtc010_rtc_remove(). The RTC
> device is registered via devm_rtc_register_device() but clocks are
> manually disabled in .remove() before devres cleanup, creating a
> window where MMIO reads on clock-gated hardware can cause a
> synchronous external abort.
> 
> [...]

Applied, thanks!

[1/3] rtc: ftrtc010: fix clock resource leak on probe failure
      https://git.kernel.org/abelloni/c/c60478875a44
[2/3] rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
      https://git.kernel.org/abelloni/c/d41ee317c990
[3/3] rtc: ftrtc010: fix integer overflow in time calculation
      https://git.kernel.org/abelloni/c/8ef8e9839a23

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
