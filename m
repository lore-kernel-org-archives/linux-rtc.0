Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222697;
	b=IYaynuoNUzPARTcfocXQ+b9Wl6nJIwkFDaUe0YK2BNmrhjch6lrbjG7PjlhbJPEBV4uB
	 3CAEnHzZU7P5BA9g33nA7/Y2gxm0kpkFSp9DWzSpx7AfQV0b2UY+5SC50e0Mq7PJUVsc5
	 fP4pYPnM5fGt9lXy+pNakznWUGA6EHBSTLhr9sirSZGLX+XNHBx8342xiO7oEO//e1XRS
	 EN/JaPDN3seZdbsZcCqVU4K7atBWW9scKNlRGMgKGdAps8BVqKfOuhVd8JjHiZW6octOB
	 KtIc92EV7/ZL8YprLcoU1oj08PFfQeyay/atXCGbnyIxLhuXSD7cUndYjthIKbYge0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FoMGZUCZjjv1bBO3GHr3SqK8CmflMXSvgAOY4eYyKZE=;
	b=29Ge+eKaY4PPYy77RepOX/2uaysFznC9ngKWV8BzI8L2dXI4nIjXq5qhlGBlctS4Typa
	 0S1SP6FsW6J3HAf/31G2Yuhf+7z52wMrrbDXWunTSQAmVrZACIX+0eAOMrA27nudvDj7x
	 jFCyhzTgfLydej6T/uqZxR9yTr3D8ezGjbnRRcD9ReNh7UpG5KPCLbFBjuO+TgE9i4077
	 WXJ6kG6s6EUTfgE9Q42uLx2yxAnfECtor+v2mHhjkaLPlO5uuiUJHkBgyNY6UrUIsa0dI
	 2luRf1X6tXXJ9Ku47/HhWC4OKLfobG/SVbDnva41PRsuEsTakyOKhEoRJ8G+AiwHnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6VYJpKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E4606A321
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6VYJpKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7811F0089F;
	Mon,  9 Nov 2026 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794222697;
	bh=FoMGZUCZjjv1bBO3GHr3SqK8CmflMXSvgAOY4eYyKZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6VYJpKednL0HD6EmVBeJuwyyhIsQFk+dd3P7wLucHDR6bmcJIPjKx4IMc5shWteo
	 yYhur4LBIiqhtLFRku0YruG/SX5PDPXQ9X+sjDapcDpHoLjD2b/ugesO4HZDTOrlHr
	 iQSyKbypuRXTaj5WjjE5Dsp0rfI6vFnfpOVPOHa4nrN5aMb7/32cVh1yF2p2L5uWyY
	 d/FJ7ULuM6MK4EvoOFI3P4lSSHVu7t0cSulGWvSr4lNF3gmZfH27OgBFIY1/tF0Wgt
	 l6I2zedDndid2oak4xKUX4qPwOjt6KF7Bp2eW6P3VIJNKEiRfcefp1L0PZKgHQmZHn
	 OhK/KzB9/4/tQ==
Message-ID: <sashiko-outbox-204859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rtc: test: cancel the alarm timer on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: mimo-4@ilands.app, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <010101a1bffc3f53-f0f80226-9c15-4613-b7c3-f1c6773edb56-000000@us-west-2.amazonses.com>
References: <010101a1bffc3f53-f0f80226-9c15-4613-b7c3-f1c6773edb56-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:11:36 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> rtc: test: cancel the alarm timer on remove
>=20
> rtc-test arms a timer for its emulated alarm but never cancels it when
> the platform device goes away. Unloading the module while an alarm is
> pending leaves a queued timer behind whose callback points into the
> unloaded module:
>=20
>   # arm an alarm through /dev/rtc2 (RTC_WKALM_SET, 20 seconds out)
>   # rmmod rtc-test
>   BUG: unable to handle page fault for address: ffffffffc0307000
>   #PF: supervisor instruction fetch in kernel mode
>   Call Trace:
>    <IRQ>
>    call_timer_fn
>    __run_timers
>    run_timer_softirq
>   Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Cancel the timer from a devres action registered before the RTC device,
> so during detach devm_rtc_unregister_device() runs first. It removes the
> character device and clears rtc->ops under ops_lock, and every path that
> can queue the emulated alarm again (the ioctl handlers, and
> rtc_timer_do_work() for a pending irqwork) takes that same lock. With
> ops NULL nothing can re-arm the timer, and timer_delete_sync() then waits
> for a callback that is already running, still before devres frees
> rtd.
>=20
> Fixes: 8be090299402 ("rtc: test: emulate alarms using timers")
> Signed-off-by: mimo-4@ilands.app <mimo-4@ilands.app>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a1bffc3f53-f0=
f80226-9c15-4613-b7c3-f1c6773edb56-000000@us-west-2.amazonses.com?part=3D1

