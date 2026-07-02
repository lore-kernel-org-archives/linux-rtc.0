Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADD38AC6A;
	Thu,  2 Jul 2026 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980989; cv=none; b=fwCpkvUX2DVc5YAencK6evYKUEicrf6qHlS6Tlr0lFfBel11VsE6Y2ifzqM8poknIrIoKyZZ4OMh4ZwjlqI1cglRyBmZtrCPJjNxYd0v4DRanZ8uynkqTlVbGKS2LuDATmL8VNvoP3buR96EGldqmQG3J8yGbYWYkpfB8T7JZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980989; c=relaxed/simple;
	bh=yrMEMX3OmVYWzrymBeazAOguz3dnpqyzjY713ncy3ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U4oUne2Cw/whV11qM9unBs9mCJSIwQWmbXnPMjfytDI5r5DrYUDyBETFQx7YGsxab5pgG0Eayq9tgCXVZ320H7vUysckzvD3lKvTARvmHLp1kvTJS+tTw/YqmJQxaFctN+4qxZBheKdTva5+h8n2naOlF3O8Qh1767OO09F4BbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWybdUAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWybdUAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5AD1F000E9;
	Thu,  2 Jul 2026 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980988;
	bh=yrMEMX3OmVYWzrymBeazAOguz3dnpqyzjY713ncy3ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NWybdUAA8Gk8TKPgckOmu36dFMAi3epklCMSRAu2v6/p3OAN7t3MTMc/WuMAgxI9X
	 0E4PcKROHhCE5bYUfsl8vNvXPJ1anMFY56vYv27VhWOkRdBNOVz73SnnHQU4aGA+Hk
	 APqxbfvAZobKs3eTyuYDJtnjN3NA3TDwren5C3DNG6CSZu914xV8I4gsU0HjRHh8oT
	 YIHp6rq8YNTIlhUcBqScRQGUEPCmtb+DzytqnDXEzetFvOTxjU+/WU/JAI/vGpljC3
	 2SikaoCikKUEVQJAjNfIV5O412CGwAKOSLvCLcPNUll/HnXTATbJwrkP58qw+6vxdR
	 x47OyoUzFWThw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] clk: sunxi-ng: sun6i-rtc: add a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260702-a733-rtc-v3-8-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-8-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:29:47 +0000
Message-Id: <20260702082947.9B5AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add support for the sun60i a733 CCU RTC.
>=20
> Compared to the a523, this SoC has a different input oscillator divider
> which auto-detects the oscillator rate and select a divider to provide
> a fixed 32768Hz clock. It also provides several phy reference clocks
> with dedicated clock gates.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D8

