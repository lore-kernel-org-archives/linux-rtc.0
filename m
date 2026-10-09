Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD23BBFDD;
	Fri,  9 Oct 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558424; cv=none; b=fnDp9yROX12bOQ4hiRWcXKBezUBKcUVlwdO4IHJHnc6Ruby4HMIjjA97TsZ8xzMoAXaQCXVMxsOHTOZvEMp71ZvqM0Rf0z35azi82F5MFO/fcE3AWwugmd9Zwm+bM+aoH9XIvu1Ae3/ItlG7Ch0My6V0Kvmpfynkrbm3CtDLYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558424; c=relaxed/simple;
	bh=syDXF0AioumUFpHMrKgYwR5vPezhWmd4BlaBPHWX4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCgv6dqB/q7Xddi0XJZbrPZ95VT2DMiR89OH8RWbfqTqApHZs4xU5B4pF7yTAXWlITLJfpSGQVZHNhqVBkwG8Hj2kqokMaKUQKl1qRy4Ox5p6+7UftrA0YQ2VyhsvTKga3T3Ry/1jDymBuedgqdYstl9uVIkKeOkhGY+6E1BNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wFc7OAmY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wFc7OAmY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC8781A11AF;
	Fri,  9 Oct 2026 15:06:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B575E60754;
	Fri,  9 Oct 2026 15:06:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B5ED11D708AF;
	Fri,  9 Oct 2026 17:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791558417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vB6F8gVRv6cs22SSGpo1/RFu98lnOw2jLJ3nHA3QKNU=;
	b=wFc7OAmYHc66rvEuPys7D9osHIaK7zW3U1iLjK2Zikib9x88BNkMsHPpbMkenaReakBAVq
	Cqy9Cz/05xniWrIcCRo7eBQp8wrs6jA9aR2tuviDBY0LLSY051XlhtA9AqPYK5B+mlw2Bx
	V097LOffWzTlS+mPEzXf+olUoDk5wC+/ktFfaFrp16oxRQfyEqRny114juJYR/E0nZN/le
	JBlIyoDJXZj18kGV2q40Z6CyM578wz3wbAXjw+lcyRFd8j5GhtACvHwt5i9DHHskpuimhY
	KY3oZnj7NPEXGB/X4hBnRDKW6yJn/KwRylrzd5hIazpgCN6oKHlwwlyKwLyzIA==
Date: Fri, 9 Oct 2026 17:06:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/9] rtc: abx80x: add support for abx81x
Message-ID: <179155837260.478260.9249464271707316286.b4-ty@b4>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916205138.16771-1-apokusinski01@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 16 Sep 2026 22:51:29 +0200, Antoni Pokusinski wrote:
> This patch series adds support for the ABX81X RTCs, which are essentially
> SPI versions of the ABX80X RTCs. The first patches (P2-P4) contain bug fixes
> (added after sashiko's review in v1-v5), then (P5-P8) we have some cleanup and
> reorganization changes (converting the driver to use the regmap API was
> needed for this), followed by the actual ABX81X support.
> 
> Kind regards,
> Antoni Pokusinski
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
      https://git.kernel.org/abelloni/c/953c3d2b5836
[2/9] rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      https://git.kernel.org/abelloni/c/07c57022afb3
[3/9] rtc: abx80x: add mutex protection for register writes
      https://git.kernel.org/abelloni/c/74bff654a4ce
[4/9] rtc: abx80x: properly handle shared IRQs
      https://git.kernel.org/abelloni/c/632916c7bde3
[5/9] rtc: abx80x: add irq to struct abx80x_priv
      https://git.kernel.org/abelloni/c/00b978f8008e
[6/9] rtc: abx80x: use regmap instead of I2C specific API
      https://git.kernel.org/abelloni/c/724320a61325
[7/9] rtc: abx80x: replace read-modify-write pattern with regmap helpers
      https://git.kernel.org/abelloni/c/0ba70c2b1e3e
[8/9] rtc: abx80x: create abx80x_i2c_probe()
      https://git.kernel.org/abelloni/c/3fcf5a97957b
[9/9] rtc: abx80x: add support for ABX81X
      https://git.kernel.org/abelloni/c/8a017ab98412

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
