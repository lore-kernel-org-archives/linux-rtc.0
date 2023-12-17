Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B81E488;
	Sun, 17 Dec 2023 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FK2epVai"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB6AE1C0002;
	Sun, 17 Dec 2023 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702853033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnZqkhegsA1cj9MugdXRdfKH0UAjwSba61bjkdJKI5s=;
	b=FK2epVai1vGwovk+fTNCGKpMu3P1ZFy262Mrzb5+qgCfbhF+goJTg2rgUvdyiUX9gI8x5o
	j6jzg6e+xRoVArPWNGMVya1JBPRltDJk2JD08b58J2K3aGh72DAugU4FyBtfKokl3UwGqq
	Qib1yfk3mzftiJJhvG++FrO1TgjkbHx7o61lUku7lVQFFYe70Zb8MkFK8IHukuWrcxNOn7
	vQNEmcREx4eXBx6IMXE0hZjkUgRca0t/pNUKhqeDi9E08f/+8FxhyC1saiBPyep6jXEY2Y
	5eSYyf5fwOotGIawT9Kk/himzsukRGd+OFfNMu1gF3hRBHMDgS1dQOZFqC7H/A==
Date: Sun, 17 Dec 2023 23:43:52 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: a.zummo@towertech.it, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Jacky Huang <ychuang570808@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	mjchen@nuvoton.com, schung@nuvoton.com,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for Nuvoton ma35d1 rtc
 controller
Message-ID: <170285301016.27693.9578027782544960763.b4-ty@bootlin.com>
References: <20230925070251.28-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925070251.28-1-ychuang570808@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Mon, 25 Sep 2023 07:02:48 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This patch series adds the rtc driver for the nuvoton ma35d1 ARMv8 SoC.
> It includes DT binding documentation, the ma35d1 rtc driver, and device
> tree updates.
> 
> The ma35d1 rtc controller provides real-time and calendar messaging
> capabilities. It supports programmable time tick and alarm match
> interrupts. The time and calendar messages are expressed in BCD format.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: Add Nuvoton ma35d1 rtc
      commit: 3767bba698707d7bad5099371b797d0fd6d39709
[3/3] rtc: Add driver for Nuvoton ma35d1 rtc controller
      commit: dc0684adf3b6be6b20fec9295027980021d30353

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
