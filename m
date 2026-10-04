Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740A3F9268
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153651; cv=none; b=uyiHTiUgi2cURl+LSSowrtfu/RabX9BNdN6GbkXZCtxSNnnNk3gMnMk8XrQatJ2kFW0ec9Oc28fQaYLkmqngEOmtYbrUr8uSsax8riLPcga+bEaIIRooMSesLEszSuikgQJBTFjOl/k+w071ntDVGLCq7bJNxUwU6dVGNHExZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153651; c=relaxed/simple;
	bh=9vUs934bYfxLt6Do2Ukcu2nqdXUhkarRm3Vdnc5adtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RTbyEuXDOsygIrYFHHUNPBn3a32j+EeklGbFtYwgyEzsNGRNTb3vbHzE+/foySmr104PH+bUIJEcVDHAbQuZ0j83bIJWXttkzqKqnxN+OK3nIGwTg5hghvzoQiupSzSS4mlf48V2KVjne04JkpdRbG9JQtul4MWzS4FSYCqM0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/HEplyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/HEplyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057031F000FF;
	Sun,  4 Oct 2026 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791153650;
	bh=9vUs934bYfxLt6Do2Ukcu2nqdXUhkarRm3Vdnc5adtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/HEplyOgnTO8xpYD5yzbT9mON/Y7gxmaYbVMZwPvIScPIpxwHWG1nB+OVcOVmGoU
	 6CG0LHBAre+5IcYg2oyR1vGJqvhtT2MWAiroGhjhh11NWCXV15/I7Tvdxm2Z8RzFvd
	 bRU3iHtw+KzPokUedpR7krS39Vf9HXWStZrOkLuazqIo4Blpqf8afhCJLDLFmftIcy
	 /NamZEN6pGcJYAQT79kywE3czQVfYbp+wTGvnfeEIb2zKKZwyQYPlbzvUfNjrhlmN5
	 C3a79OKL2GbPwveSKaXZUpfXtet7R70Ftnru5/9W0GFmmw1Dk/YyITEa4jG3595crM
	 sahrcVGIcF1cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mpc5121: request IRQs after allocating the RTC
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261004222907.437878-1-rosenp@gmail.com>
References: <20261004222907.437878-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:40:49 +0000
Message-Id: <20261004224050.057031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Probe requests both IRQs with devm_request_irq() before
> devm_rtc_allocate_device(). Devres releases resources in reverse order,
> so on unbind or probe failure the RTC device is put before the IRQs
> are freed. A handler running in that window passes the stale rtc->rtc
> to rtc_update_irq(), which schedules work on the freed device.
>=20
> On unbind, remove() first disables the alarm and update interrupts, so
> only a handler already running on another CPU is affected. On a probe
> failure after the IRQs are requested, remove() does not run, and an
> alarm left pending, for example a wake alarm from before a reboot, can
> fire in that window.
>=20
> Request the IRQs after the RTC device is allocated and set up, right
> before registering it, so devres frees them and waits for running
> handlers before releasing the device. An interrupt arriving before
> registration is harmless, as rtc_update_irq() only schedules work on
> an allocated device.
>=20
> Fixes: d53d4ae981d0 ("rtc: mpc5121: simplify probe")
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004222907.4378=
78-1-rosenp@gmail.com?part=3D1

