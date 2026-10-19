Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442516;
	b=LXbOoHkC4gfP4ZBJnof8Mgzf9EbOWhKi7Rdih5Hnin+X1hIHOMHx06Bx4FX2trrtX/1k
	 edr6ldtZFq73yVqaQ15teScEwXjS5M9RmIVmTgOW+Ve7tciYnQXpoULyWRU+Whsi5JAWI
	 nYbybX3Y+etDoTaKWQc5QB+8hGlUFlEacVfCPBVkW8DQaOBuQQnus/AZOSgDkLAsYhqKz
	 KSTwTCQtLewlQ4Bvih51cXsKJpWAl+l8kF7qqEu8LEGtUJl190a5Kb4rbMGJqVmBvMgZz
	 OVa/2thk1LGnUbeewDz38nvHZHQa4WDYZojSy/y3LjtfZaTy+k8XsycY9cOdPvw2meQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442516;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=1OqCBZEU+Pd0NjT6IFooBVYOMysmau4mF1Iu3HMfa8Q=;
	b=Al00jd+IBmKrAxzi2RxccqPsr8iUeBaPyLg0BI8rZwry+Onr2cJSU04cVsCOiWBfN0co
	 L8IB0G7qgXMCOa5IAn61c5c8HWvfvH1n5xrOIJyN5mTqjWwXujusqwtkexWNpOabDYs+m
	 10jXfcvHihLytR7OyQdwxMf0OhtJbKiWAT9osm1EDLO5gZFtFEFNRqWaZ+XYqAcC82f68
	 2FYImXOdeIBnL7/bjYoyd9CTyOHnFyExmHo9XRPZW380iHoOA6fx2p75He1Y7H0e0XkR0
	 WQcw7sJQjEEbfX+xXevWvuW/zwZunSCD2FDo9XZ2OdtL3RbIV3LQsn7fw7ufpI5+5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=125FkxPy;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD4606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 20:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=125FkxPy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8DB954E4127B;
	Mon, 19 Oct 2026 20:41:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5666960582;
	Mon, 19 Oct 2026 20:41:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A21210328C22;
	Mon, 19 Oct 2026 22:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792442507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1OqCBZEU+Pd0NjT6IFooBVYOMysmau4mF1Iu3HMfa8Q=;
	b=125FkxPyq337Vh1OA3wc096MpieQslVvspAetPhiqRNcfzezjW8yUqNWb293H6KYbEBRnq
	drquXFkIIeHoGijkogfsWs79lJjio0WYQvdD6t4Ip5emGPb2FNufxi322MXRIDgAp99R4A
	Oy80AR0N78yCHFBW1lB16b/vndjauepmv15KiDJkXZkNBoUnD31ltEMksLjY9U13CUA/Yk
	wwRGtIpgn5VzrDwHtXpw1tgFgDqA2wlwVrzy/VkxMO4BcNwkgA84M0DRfHoMnV57dj99+x
	BiziaCGzUuDt73HouW/lLhFFAAouMpYXA+B4luzKS+w5/piUCkaDKK7B+V5rCA==
Date: Mon, 19 Oct 2026 22:41:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com
Subject: Re: [PATCH v14 0/3] Raspberry Pi 5 RTC driver
Message-ID: <179244249433.112512.16719708376827736602.b4-ty@b4>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
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
In-Reply-To: <20261018151056.1051330-1-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 18 Oct 2026 17:10:53 +0200, Sander Speetjens wrote:
> The Raspberry Pi 5 has a battery-backed RTC located
> on the DA9091 PMIC accessed via the I2C bus[1].
> Access to the RTC is provided exclusively through the VideoCore firmware
> mailbox interface (not via a direct I2C register interface).
> 
> As stated by jamesh on the Rasperry Pi forum [2],
> "There are no plans to release a public datasheet for the DA9091."
> So we are stuck with the firmware interface for now.
> PhilE also states that "The firmware needs full control of the DA9091,
> sometimes with extremely low latency,
> otherwise there's a risk the supply could just cut the power."
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
      https://git.kernel.org/abelloni/c/09399a7cd932
[2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
      https://git.kernel.org/abelloni/c/58db0fbeef2a
[3/3] rtc: Add Raspberry Pi 5 RTC driver
      https://git.kernel.org/abelloni/c/dba67294e215

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
