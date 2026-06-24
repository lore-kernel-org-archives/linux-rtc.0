Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80339BFE6;
	Wed, 24 Jun 2026 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337135; cv=none; b=EnVCoXn2g9BtyADYViiyLNKW8itbSPREw85Rb1asYwSJDFyRUxVKtstQtFu2uJ4fOOhcp8SZLn/8+k8583WeEJW3ES6MbeINGS3LI+UwHwGPkJ/Acwa9pIECGRNA9499XhagDT5bOnIEh5kEU2slHhx36YX+i4VFGWGsjCwF5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337135; c=relaxed/simple;
	bh=MGZettGHssBabJmqOrI+Kp8R+Itj5rYphI2e1bT2Qts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njAEDvu5dxIZjB39E2ukABCOv1xSvKSUzYBwPChuuCJIsjTWVwEo5aqGhXbwvVcoXcD1sF9CO9FFb5aYn+YrCyKFZvStWA58fBkzTgI6PG/gSYHc/6fudVaDlDzwOoKY9RY5HSPlg0BzpuVkwD7NWgOlJfGYgbTOx1i9xMc40Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rCfpZkxT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rCfpZkxT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7E3974E40832;
	Wed, 24 Jun 2026 21:38:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36A3B601C5;
	Wed, 24 Jun 2026 21:38:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8A99106C8077;
	Wed, 24 Jun 2026 23:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782337131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iX1wdA9Clv6JgVcxP1kwl5js7R90sghsXCikDhPBjNU=;
	b=rCfpZkxTq3VhZ5QsZQJP0QlxDmFJxEZ2gH228nd475pdcNFqnZCotqOdKNYHeJ4axPCCj+
	XaNaRosOp35Ouw5CTxxVp7rGGoBMzXQh/fwDFhlXjdgIkp9U1azXQSzVrxWRBYXPPyQPdE
	Kl7aIsiichlkwNTa1DX8+bASNwOnInOBzkFxBmW++pZVZ+1e2N2ZWPiDFhyXKJ640fUaBA
	A4hsI6O34lhtgVHASsuF+wh+z18rrkUq4RMfIAxpM9OZairBXIIoRr0iGFUhYiJl3LLEyX
	inkAHHJWJGVfzfi7Asg3rHYqhw6rfgPVf3rpweMFLfsFBYSo6hUyeCXRbIGdFg==
Date: Wed, 24 Jun 2026 23:38:47 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Fredrik M Olsson <fredrik.m.olsson@axis.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 3/3] rtc: ds1307: Add driver for Epson RX8901CE
Message-ID: <20260624213847b0e6c315@mail.local>
References: <20260520-ds1307-rx8901-add-v2-0-e069ea32e1db@axis.com>
 <20260520-ds1307-rx8901-add-v2-3-e069ea32e1db@axis.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-ds1307-rx8901-add-v2-3-e069ea32e1db@axis.com>
X-Last-TLS-Session-Version: TLSv1.3

On 20/05/2026 16:48:55+0200, Fredrik M Olsson wrote:
> +static int do_trickle_setup_rx8901(struct ds1307 *ds1307, u32 ohms __always_unused, bool diode)
> +{
> +	int ret;
> +	unsigned int setup;
> +
> +	ret = regmap_read(ds1307->regmap, RX8901_REG_PWSW_CFG, &setup);
> +	if (ret) {
> +		dev_err(ds1307->dev, "Failed to read PWSW_CFG register\n");
> +		return ret;
> +	}
> +
> +	/* Enable low battery voltage detection */
> +	setup |= RX8901_REG_PWSW_CFG_VBATLDETEN;
> +
> +	if (diode)
> +		setup |= RX8901_REG_PWSW_CFG_CHGEN;

When diode is false, you need to explicitly clear
RX8901_REG_PWSW_CFG_CHGEN so it is possible to actually disable trickle
charging once it has been enabled has the register is battery backed.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
