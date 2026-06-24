Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CA3EC2E6;
	Wed, 24 Jun 2026 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337367; cv=none; b=JXn/c3JOh1oKrhn6led+Pg0HTamD9m9H1bPVPQaza6tNhh1AWh+RAfIDBpeI+Aoq0XHJwl351YoGbzbFftrMB+eza/VWS6lk0unqKOSSReotPrg7e0cZBBQ2biv5xqQ/5zv8D0NBWIEeL6Y5Ltab2Irr7HNDDPm0b5iEojkqwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337367; c=relaxed/simple;
	bh=mNXH0gPksALksOUSVR4xWJfeqrjverHGyRYbPxb5Lbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awjKK2mExXs+z/ANXfT3EvLJWkslVO/YvHN1eYl2iR3NFvr8IwkwBjleORIqrKcM6Yc22YUiEdslXgsrb3awBwMsRTRe1HwdHLM4n7mhzgji8fQCVcQ8P+stJnlMYo3T+CEWBYAqdF4HkdFuNv8dSE0tS+qPNcFS4F8zAbP7Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ef5AS1ej; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ef5AS1ej"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9B40E4E40838;
	Wed, 24 Jun 2026 21:42:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EE20601C5;
	Wed, 24 Jun 2026 21:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07B0A106C8077;
	Wed, 24 Jun 2026 23:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782337360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+29MxL+qYKYZTOhpZW5lzLw5Y43KvG5Hzj4+XJodO0Y=;
	b=ef5AS1ej8N8Aj9MuJnQCNMapBSkxKeLjRaultSIzPPtjY9J1XKEeJJyGyNZBcqgWen/Pls
	4g5SIVsDvjpDdbUoo6bFi5wFFl3ULbZGGorQ9VuicAOgXAG4inkvPKddYXB5yv3jQeOv9C
	8mt3vPtPe1CaiaVp9/SKQ8g+bw42hpgyB5UoeeCTxz5jVVMu06cyo+9PtURVfbL0BhiTIm
	HMwOo9RS/5QNXWTBmwmmeVXPnaDi3mcilQ+wQtsJuWfea3dy2W3CVg7Qm4wld8iaX+pVx6
	MAsK5YBgtimBd6Yi/8dfRC4/lbTVolzjbPIZw9xvY0gCpeAnAnZaBiqk+yiNJQ==
Date: Wed, 24 Jun 2026 23:42:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Fredrik M Olsson <fredrik.m.olsson@axis.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@mail.toshiba>
Subject: Re: (subset) [PATCH v2 0/3] rtc: ds1307: Add support for Epson
 RX8901CE
Message-ID: <178233723840.1527737.4950949208053608857.b4-ty@b4>
References: <20260520-ds1307-rx8901-add-v2-0-e069ea32e1db@axis.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-ds1307-rx8901-add-v2-0-e069ea32e1db@axis.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 20 May 2026 16:48:52 +0200, Fredrik M Olsson wrote:
> Add basic support for the Epson RX8901CE RTC.
> Datasheet: https://download.epsondevice.com/td/pdf/app/RX8901CE_en.pdf
> 
> Also includes a bug fix for an issue with reading the weekday from the
> RTC which affects both the existing rx8130 and this rx8901 driver.
> 
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: ds1307: Add epson,rx8901
      https://git.kernel.org/abelloni/c/cc387941c0a1
[2/3] rtc: ds1307: Fix off-by-one issue with wday for rx8130
      https://git.kernel.org/abelloni/c/6882aab3c661

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
