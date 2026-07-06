Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726441D4E0;
	Mon,  6 Jul 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352327; cv=none; b=gWi2cY5jzG3rfpcNnP+cHN+U8HpWwnQopofoIyMsjxeLkKkqXN3nEPN6Sd7To2QUuKaydDRAGaYnXfHQ+fA433otfZbo2kBU0n9c/8SGSkvGMqi7Bh+/KtkoJ9PQ7bc/+fOdDqvZ1/Ux0wwjAd04OzjVuFw9OabO6iXE+gi6M+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352327; c=relaxed/simple;
	bh=LAXozm5gc1YwylcjaE4ISSaDXB57GpYDiTTghofaIKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mT3W6dKdJPTm/G0aibPOxdfeck9E16XuBbv0sVIl6ym4tzcSzgbDuyaaiOkLZIPeNLsbtETaXMHMlRjrGQ00Co7iPX28iY2fsOUj9QORvIsNtv+L9uggMhPPvEEYYPCB8lIu+awXaAgyLeEqQKnHbVWB5rOVcMMFxRl1eWHol3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPY9l92B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPY9l92B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE51F000E9;
	Mon,  6 Jul 2026 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783352326;
	bh=RSikxvuz0fdarLrs2WLzUhq/9C36cPYevojeibE+zuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EPY9l92BO8O5jYYnl7h9lLRbSlM0BEJa0uue0aFoOPStybvib7DPxEXFDhCT+/87B
	 yFDDSSH4qFc8BCqDrkinXt+2bQ4aLt5Y5iSoigcYq4fFFmmCEhIC1kseBeMaLAyZ8v
	 gFuMzofG6T70blVK6EPNMTncsGWWv/WjzDMB9DQgHdcfFyJEsuhclX92JoFgrDLhaf
	 WhcUfPJez+GKPnMMvuQKkL+kXGW9ZmeZOJKbF0z8yx7t71U/aeVfPiTnLUdk8IRw4v
	 QbGps9GIFsnFluaOH2xyhsq879YyNdu/TZ/VwmHRR/yrbxz+7Y/hnZImqhCuxN8pEG
	 FlCpnEx4ehuKw==
From: Chen-Yu Tsai <wens@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
Subject: Re: (subset) [PATCH v4 0/9] clk: sun6i-rtc: Add support for
 Allwinner A733 SoC
Message-Id: <178335232274.3929059.7231678940771555249.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 23:38:42 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 06 Jul 2026 11:32:08 +0200, Jerome Brunet wrote:
> Add support for the Allwinner A733 RTC and its internal Clock Control
> Unit (CCU). Reuse the rtc-sun6i rtc driver while introducing a new
> SoC-specific RTC CCU driver to handle the hardware's evolved clock
> structure.
> 
> The A733 implementation supports hardware detection of three external
> crystal frequencies (19.2MHz, 24MHz and 26MHz), which is represented in
> the driver via read-only divider operations. Implement logic to derive a
> normalized 32kHz reference from these DCXO sources using fixed
> pre-dividers. Additionally, provide several new DCXO gate clocks for
> peripherals, including SerDes, HDMI, and UFS.
> 
> [...]

Applied to sunxi/clk-for-7.3 in sunxi, thanks!

[1/9] dt-bindings: rtc: sun6i: no clock-output-names on h616/r329
      https://git.kernel.org/sunxi/linux/c/7b9f8fe9c9e0
[2/9] dt-bindings: rtc: sun6i: add sun60i-a733 support
      https://git.kernel.org/sunxi/linux/c/38d6b194a21c
[3/9] clk: sunxi-ng: fix ccu probe clock unregister on error
      https://git.kernel.org/sunxi/linux/c/81f4ddc9f7e0
[4/9] clk: sunxi-ng: sun6i-rtc: clean up DT usage
      https://git.kernel.org/sunxi/linux/c/192c6220e14d
[5/9] clk: sunxi-ng: sun6i-rtc: Add feature bit for IOSC calibration
      https://git.kernel.org/sunxi/linux/c/d2fcd82ca07d
[7/9] clk: sunxi-ng: mux: remove unneeded export
      https://git.kernel.org/sunxi/linux/c/c52b5090bf1e

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

