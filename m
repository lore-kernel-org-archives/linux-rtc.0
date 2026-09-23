Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEB488202;
	Wed, 23 Sep 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159800; cv=none; b=oexUskdxbrHV+tRKN9GxAwfDYXHrf0t1oCTjJ5CSbLLDA8Rc7fLAFW/t5cRoFehYQg3HvOGv0k5D7o8gKFOUVrPJUEEKoxoRX7F82TWMBm/K9qQjXNk4PpvDQl/qbAgnwCRDRYuTYiubmPFTTOSLNBN5azxNzP8/bjtswaIb4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159800; c=relaxed/simple;
	bh=CLdTDB/WpNLr78DyexGX5uASbUlHi5t9VwwA71qel6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/rPUun+6+mwdG5uMze8zuW0XuCWzYpgq1ZlS+byEpO5dTWqfRBBz9th86kx3LcimFcy1uPtXTYs+F0RAom5DVq+uZ4E1k9IPVX1mAf3SzEDdksw9XLXIJ81+xPpR512KnCW/EEWKdfuqY9esp86MAilmksU7BlEgLU4uzeL4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxCv/ikS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxCv/ikS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67601F000FF;
	Wed, 23 Sep 2026 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790159783;
	bh=nkPTpbuH9dvJXiUii9udo8nVwjKFJwkoHaRJtEgMwsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZxCv/ikSjOAkOJrb05bJlB4EUaZotxQGw8V6vHZ4SqhiCQrJFdE9xj9uL9RJjnqwe
	 rDon9ixm5MY2uZ1hWBaeiS0tqwva8ZTTM1YfpTBPM9Qeu68eJk/Gogw1AfEKGccytk
	 204veZ4Ia5Y8K8yN+LpTTw0eC0nE0JwTapGLx37DkzJPwIOaDGNXXfMI5NYP4DRxXZ
	 tECPgmZ65QRxtUmlVhGXE8xPai1Hk7F3AH617vccmoujSLpwq3NCZf3xJjQHpyt453
	 tTi2g+9VE0swiNPE7wNUvUNmwP2kYhIyR0PVp1UzIgLcyanuf1dryPYlZNyNt4tP0I
	 3yiejIHUPrMzw==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-rtc@vger.kernel.org
In-Reply-To: <2aff89e15aa5b03c955760e5dc50b5e2f17081e3.1785838585.git.mazziesaccount@gmail.com>
References: <2aff89e15aa5b03c955760e5dc50b5e2f17081e3.1785838585.git.mazziesaccount@gmail.com>
Subject: Re: (subset) [PATCH v2 05/10] mfd: Support for ROHM BD73800 PMIC
 core
Message-Id: <179015977961.3959854.10449911449922087290.b4-ty@b4>
Date: Wed, 23 Sep 2026 11:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 04 Aug 2026 13:21:58 +0300, Matti Vaittinen wrote:
> The BD73800 integrates regulators, ADC (intended for accumulating current /
> voltage / power values), a real-time clock (RTC), clock gate and GPIOs.
> 
> Add core support for ROHM BD73800 Power Management IC.

Applied, thanks!

[05/10] mfd: Support for ROHM BD73800 PMIC core
        commit: 6f6ebfdd38126edc6cd3f1427ee261d57a83fff9

--
Lee Jones [李琼斯]

