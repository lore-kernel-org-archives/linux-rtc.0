Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95E48551E
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261343; cv=none; b=KXmd9VaRERvPfokDHf+5TVX4vV96no+pK2o4BHsXmFFHELyxMH8z2VwesmB83tuQihsfo0JKo3PflHuS1V9v/e5TW4dxDV6rHuAxi2BqNQDKeQwfMsjlKtH71YE07tiDLhh9vH9XgLdjf0K/PLn6gB2LHHopEFWWi4+qJwHh+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261343; c=relaxed/simple;
	bh=ovHe4uJbfswGxytSwu5Eklbh+3TLPEoDJIYwYMGVEC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFKp5sr8fPgqAn8pAd7OLxCkq5kvyH06vvuKh5GJ9oe7Mwg6e174hqBZGvblhTGJz3w3DgjlAEN51CZr11dNc68rQx1yrUyBhi+CVuTHAYoC/rYgkIOB684wTvJEQKr4NmfiNhiVAYNNhIASRYTgZWYr6tTSw/pwbnZMGdINquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FkLVE+bn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FkLVE+bn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 99CAA1A1778;
	Thu, 20 Aug 2026 21:29:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E2D05FF59;
	Thu, 20 Aug 2026 21:29:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E48EC11C76885;
	Thu, 20 Aug 2026 23:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RY0imCgnCA9nd0UROR1fRhHdSfXZEWvh9y0SXRPkVJc=;
	b=FkLVE+bnbPvYltDk/4lQFd/2hY1ldmVFuUadKNig0lTLqZxVdFnKPCUBO+WyRQuZy1sNrC
	nUoqMAhKJVO8LgRG9kilhMrvAX2E0aI5XbKGILb6+EYgp5yWvpMI4WqzPrRgRMZc8V8YJm
	RGi7CM/HDl6tD18VaFAnXXAbpNCP+DX3xuepdOpzcOnS0XPbBk0Q6/ESMP1ijgq+jvlq+I
	ZmOD+JW9q8X5HFmb1Dts0F5vulRDj4c8tt/rth6zXoCsLeeOxdLqu+fmJbMsrTOCNOiquR
	nz7umQCqoAL8gExzz4FudP/J/rvAhDK7HYbFpJzJix0ETN2zdWFb6qcJ3ErSsQ==
Date: Thu, 20 Aug 2026 23:28:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: gamecube: check return value of
 devm_rtc_register_device()
Message-ID: <178726066535.423710.16548526114827195430.b4-ty@b4>
References: <20260731080458.417532-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731080458.417532-1-gonglinkai@kylinos.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 31 Jul 2026 16:04:58 +0800, Linkai Gong wrote:
> gamecube_rtc_probe() ignored the return value of
> devm_rtc_register_device() and always returned success. Propagate the
> error so probe fails when RTC registration fails.

Applied, thanks!

[1/1] rtc: gamecube: check return value of devm_rtc_register_device()
      https://git.kernel.org/abelloni/c/ca45cfa74370

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
