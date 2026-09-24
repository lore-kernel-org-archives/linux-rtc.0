Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0913BD22E
	for <linux-rtc@vger.kernel.org>; Thu, 24 Sep 2026 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234990; cv=none; b=EQH9gQJKM7sygJKBOp/+psoJyj4U7N0+4Gr8A7wr5ErmU89Uel0S6WsAJYT1yl2vcGbr7empgIQGLnWOHIQBM6BWddIDTMvj+7ky60Uf9B/Hx/XO0R1L/WVQ1FbbbRvVpbddWx74EW5UIpP2LQcib1uqVjM9omGxOF3NasmOMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234990; c=relaxed/simple;
	bh=FJCQDqTQAF/0+9+VJ/T0kOUuf6O6HkaJ8MhiT3Tbw/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=loz2NvWtR3d15xsHtm9g+izC0AKB81BOcSkfO51Lb8Lwd8JWTVXKcvqM/K1R04YBo7eV+BR18z4FbyoxR5NHiKGYlNTfQsv+BMxHyyc/4CG4/tU2IN7EyPHFQbQ/KJjJgHb0xif9GFXSXE0j5vpivtL8xTwePhss5rKzkQDvBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt07yeLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt07yeLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C41F000FF;
	Thu, 24 Sep 2026 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790234989;
	bh=FJCQDqTQAF/0+9+VJ/T0kOUuf6O6HkaJ8MhiT3Tbw/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nt07yeLzKb5hU1td2M/IPj5iy3GoC4jmnI+MNruzeGK/q+fdCSk4gk2yxVe7kVW6U
	 r3gcdklDJoogSsr0SvDTaUeVAo0GcX1lF3VK48lc7orCpwPaCxGgci6vF/rC0zggwv
	 NNHoNMqbDCZGvnUhYu2dOV1goHDV8HGiaYrkkt2G9CZtv2Myfh7UY37xbfCovL/ce7
	 rGC0qTqX+VfYzF5Wyn2Zg7RLq91h7w2uOy0szL/TUMqq0wiu/iHB0XPy7pBlHLJPbK
	 s2GC2oWqFXRq/rF58288+TaKdncRzQhXgALjWS6P4ClHnHZaI918W+OOqJxJb6rLUB
	 XYY4TTNGs0udg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: zynqmp: Enable crystal oscillator in
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGFuaWVsIFZpYcOxbw==?= <danividanivi@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260924071917.80004-1-danividanivi@gmail.com>
References: <20260924071917.80004-1-danividanivi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:29:48 +0000
Message-Id: <20260924072948.E14C41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Enable the RTC crystal oscillator bit in the control register (RTC_CTRL,
> offset 0x40) during driver initialization.
>=20
> Although the RTC_OSC_EN macro was defined when the driver was originally
> introduced, it was never asserted in xlnx_init_rtc(). On cold boots, after
> battery exhaustion, or on platforms where firmware does not pre-initialize
> RTC_CTRL, the oscillator remains disabled and the counter never ticks.
>=20
> Asserting RTC_OSC_EN alongside RTC_BATT_EN ensures the oscillator starts
> without relying on bootloader initialization. Per the Zynq UltraScale+
> TRM (UG1085), bit 24 (OSC_CNTRL) is a static level enable for the crystal
> inverter rather than an edge-triggered reset; re-asserting it when the
> oscillator is already running is a non-destructive no-op that does not
> glitch or reset the ticking counters.
>=20
> Tested on Zynq UltraScale+ hardware, confirming that the counter freezes
> when RTC_OSC_EN is cleared, advances reliably once enabled, and is
> unaffected when re-asserted while running.
>=20
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Via=C3=B1o <danividanivi@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924071917.8000=
4-1-danividanivi@gmail.com?part=3D1

