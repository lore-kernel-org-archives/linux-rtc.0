Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A403655D4;
	Thu, 23 Jul 2026 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824094; cv=none; b=slt6Dfun2X7PDeOwJDK0hMz8ptbq23FsMGCFCp+cMLmMGSOHR3ojWw2PwqInJi3nyr+SIbsSh3PhPz5TRDG2+PlrGhbW8lR96AFVQKthg+gdcPvf/IgjtDkuxyCAE7RaerjKcB1NQb2EtIqL3i/ja8MPSe7LHGSiY8BjGoHfS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824094; c=relaxed/simple;
	bh=mgxu4Mi03LvYU1K7vYFWqNCS/c8LXlLZt7NndVDDaPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KFtwOK6ahYTJo2qQb1mxOPWSblwO+SSUz0KDJw8gmO6LH2Dw7iaT8LN2YZCkcwFxuUMwGQT65k8Fe3z0ko9dJl3RPSJfcs5norufDUBkZCU2Gz5ZeOf1nQ4b0ko2Jgo/BJcdTIzGOZGdkZdb9RGT8ERIpO7Ff2MtyQcByQ8m+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A6B1F000E9;
	Thu, 23 Jul 2026 16:27:53 +0000 (UTC)
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
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
Subject: Re: [PATCH v7 0/4] clk: sun6i-rtc: Add support for Allwinner A733
 SoC
Message-Id: <178482407296.3641802.877710077713530621.b4-ty@kernel.org>
Date: Fri, 24 Jul 2026 00:27:52 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 23 Jul 2026 11:39:50 +0200, Jerome Brunet wrote:
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

[1/4] clk: sunxi-ng: mux: fix determine helper rate propagation
      https://git.kernel.org/sunxi/linux/c/4bcba49984ff
[2/4] clk: sunxi-ng: div: add read-only operation support
      https://git.kernel.org/sunxi/linux/c/7bbbfcd4e495
[3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator div and gate
      https://git.kernel.org/sunxi/linux/c/176184e7f799
[4/4] clk: sunxi-ng: sun6i-rtc: add a733 support
      https://git.kernel.org/sunxi/linux/c/0a136efc0fc2

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

