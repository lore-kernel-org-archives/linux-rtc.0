Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1B409298
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151817; cv=none; b=eBeFWAZaf8irt3uvqFGELtI4HcS8iDJgTpq8xdN/D+uP0o3KOVP7gr819lsuTLlXbMc39rSOgeSelmGbZniAkDhlRJSE+1sFBDRFUWCYRRJ2L1tSWuTMU9chsHw7GfhCg73lHUVndsqepF83YCwQRN5IO2hx5bioZaIPdMDcR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151817; c=relaxed/simple;
	bh=VO9KoyIY7+LrMAVXwdLQJcD5dSkq/G2zTk0vCg6gfiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NLjXcmZtAzefn8Xpciq6Cfm4kviQscQzvqdvkK/23V2H9jyf08E94V7WxIE6i07xnNAve2rhvIAK+lxv5+fwNRg0mefwhA18onq+GhfBW4iPXcLoHv7fPukTkvQOzdL41k1KaKr1+2LewubC/cLhe3hekbKzO5d/LpcGPNYp9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gza90UEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gza90UEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E521F000FF;
	Sun,  4 Oct 2026 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151815;
	bh=VO9KoyIY7+LrMAVXwdLQJcD5dSkq/G2zTk0vCg6gfiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gza90UEIUY0M+E6x4FeMA/ZwWgC3C/izUsUVdf1S/0w8kH39xx3yv5RSs0CiRxFU6
	 VFTxsDnUPP0v0bhoRUQvFomgBI7nbGSVnUTZMblRRfSlEKz7QCxWH8+q7UZmRq/a7j
	 Mpb3vKYZVCs9nSTTwpNzYVUNGFHbZDTHMgbqdF0SNCBWoT/VxwTlPZv0EO3cBCypWA
	 tftVFy0buR+tAGgu303P63hIa6uck9Atv42tzK/JsoLThxmTXlYK2wNLws60UUsms6
	 2qYfuw2rtnPMQRGuMfZQACEWCDTws6LoX2poAInOkvSuqfaEI8YoWRtGV8G6j4m4Ks
	 zEL1gBUwsCE6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: omap: fail rtc-only suspend without a power-off
 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261004215843.396867-1-rosenp@gmail.com>
References: <20261004215843.396867-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:10:15 +0000
Message-Id: <20261004221015.84E521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> omap_rtc_power_off_program() dereferences omap_rtc_power_off_rtc
> unconditionally, but that pointer is only set when an RTC with the
> "system-power-controller" property probed while pm_power_off was still
> free, and it is cleared again when that RTC is removed.
>=20
> pm33xx uses the function for rtc-only suspend whenever off mode is
> enabled and an "rtc0" class device exists, which guarantees none of
> that. Without the property, with another driver owning pm_power_off,
> or with a different RTC registered as rtc0, suspending to mem
> dereferences NULL in the cpu_suspend() finisher.
>=20
> Return -ENODEV when no power-off RTC is set up, and propagate it from
> am33xx_rtc_only_idle(). A non-zero return from the finisher makes
> cpu_suspend() abort, so pm33xx reports a suspend failure instead of
> oopsing.
>=20
> Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in s=
elf-refresh support")
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004215843.3968=
67-1-rosenp@gmail.com?part=3D1

