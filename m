Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228642D739C;
	Sun, 23 Aug 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513292; cv=none; b=hGb3RbmjWX4QnTmXHusuGMBWucJchji0OwRkusw1dxrR+O10eF+FhmsFqsuHsWyo1kepnF5ZEazVpqan+Hj7Yw19BaBJ0YNE8I3jlFdS+Q+QTbgWYomoJMBByo4YC8kbU+85QV5Cn64VvfQEfhMAKrnAcqq5AJzz2XLgRI+GqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513292; c=relaxed/simple;
	bh=Xyu++SJOi+a3aYTtKVgNn4xmzspRA5cr1q25ZYCu4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mORLYC1KdJjThrSB8qxpsDEFns3KTnwrZdG2nVY5Ojm65wielpm42+nYEnqeNMJB1Hx6tbypAAKBaXeYz+5S6hn6802PqfDSQu1q3lis5phEoAUMw6/QOIiumqI0UzWSbDz7Mrgdh7pxJFYO6cHlWn57FUTAfbrO4HR/9fzxAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tQHIIO09; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tQHIIO09"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5AEF11A17D2;
	Sun, 23 Aug 2026 19:28:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E3C460378;
	Sun, 23 Aug 2026 19:28:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEE4411C78552;
	Sun, 23 Aug 2026 21:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787513274; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=X/CY+Q5KwPD7iPjdJOTwPbS6HjELxq+ezGaZFw25SNM=;
	b=tQHIIO09m6AuJtcW0Ov/zMHW+6/6fsHvQ13a6MPWgozDIH4BVaY/YAyg8Pjbp6OkdcbSzD
	5aamc2+69S645w1MF1xCRi2M788VaxPJP9pcojH9Hsjnz7x3UIx6Y8+s4nGQoClhcE13IM
	XB979omXqgQcJ/3Kc10wo7rLq9mGHXhpYofVnAtPKX1PPcFnvhrThBwU/JBNoiMCufK+9o
	qwHxk0EFEvIs/jCM+HcKYzpbiTUR4WaDn1SSO3Lxh9pzMmz8Jmqj9UB9HP9uNpUbsj7jy3
	MHujLukUnzQahuFvwBuMWNt3304kwr5VUXZYepH0W10pSm9tf0+6CtGMewFDHw==
Date: Sun, 23 Aug 2026 21:27:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 00/17] Add RTC support for Renesas RZ/T2H and RZ/N2H
 SoCs
Message-ID: <178751320985.803208.13800880301925482074.b4-ty@b4>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 21 Aug 2026 22:10:15 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This series adds support for the RTC IP found on the Renesas RZ/T2H and
> RZ/N2H SoCs.
> 
> [...]

Applied, thanks!

[01/17] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
        https://git.kernel.org/abelloni/c/1ffb5be3e4be
[02/17] rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
        https://git.kernel.org/abelloni/c/708546aa3956
[03/17] rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
        https://git.kernel.org/abelloni/c/022a2839a520
[04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
        https://git.kernel.org/abelloni/c/457b5dbce312
[05/17] rtc: rzn1: Fix alarm range check truncation on 32-bit systems
        https://git.kernel.org/abelloni/c/c3e735e9f620
[06/17] rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers
        https://git.kernel.org/abelloni/c/51458d5b0a1c
[07/17] rtc: rzn1: Fix malformed MODULE_AUTHOR string
        https://git.kernel.org/abelloni/c/cd54d8f09d9b
[08/17] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
        https://git.kernel.org/abelloni/c/960987abe58d
[09/17] rtc: rzn1: Use pm_runtime_put_sync()
        https://git.kernel.org/abelloni/c/ea0ef2e7f83b
[10/17] rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
        https://git.kernel.org/abelloni/c/6e0d7d480f2d
[11/17] rtc: rzn1: Dynamically calculate synchronization delay based on clock rate
        https://git.kernel.org/abelloni/c/afb8972b9e36
[12/17] rtc: rzn1: Use temporary variable for struct device
        https://git.kernel.org/abelloni/c/b587001387c1
[13/17] rtc: rzn1: Consistently use dev_err_probe()
        https://git.kernel.org/abelloni/c/0e1ae8c654f0
[14/17] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
        https://git.kernel.org/abelloni/c/5ae93269d3e5
[15/17] rtc: rzn1: Add OF match data to gate SUBU register access
        https://git.kernel.org/abelloni/c/38a3a3b09958
[16/17] rtc: rzn1: Drop trailing comma from OF match table sentinel
        https://git.kernel.org/abelloni/c/8af6331c6e7a
[17/17] rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
        https://git.kernel.org/abelloni/c/b418fa370ea6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
