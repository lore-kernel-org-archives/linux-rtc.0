Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049776;
	b=plXuJ2IpsSvKCcClRWtNUJE4GU8UzoLpag4EHI8e4aKNCWhNYfThmPA3F0tM5bgF1dMe
	 3edSEUI89p2GNME2uHvsJwFJuFYerpSUJBxkmvMZ2EE13O883xcXzwN8Li2NRRwvPCbA4
	 o4jfWRbQH7+7vTtDKFFrEZelpcHnJD+3MrGUlumvj/sBozWm9S6KFtemH2i73WOerw4Uf
	 I8iSZUZkFNkbBiFAYUUkvsV65hd0IV1b6zJWyBwUcanh6NgzGthLF9lTYXu82vp94G6hG
	 4RaVPBAsCq3beE+yALq+UORK9Z6WxGGlxcsEU9nruiKYzZHAw7hqOhjHPILToSyKkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CX/Rj71C0vpHIJPqoynExGqfcIN+XxYwgCJUivFPb7Q=;
	b=hfW96Y0DpT0n15II0yWTUIE+Bmc7gpVAORFBzD/4v1OmOXR7UgCeGcMczOWW+/1XAcU6
	 uS4aRn8P1jSH8AubuMxQRueLd2QxwOFSXLtbVkUmX00kTwIex1LQQHQofUHc8ms+jWdjQ
	 xW4sxK55gc9vw/sMRkAVfijyoD5qloPQCyGWF0EDUzDK3oJ1etVTPdzF9H5FBIG3LcMF0
	 huX/8dt+089iPHjhtgi1+ovwC1Hz+mjUmcYdAAnQiWqOJUnETBz+UXQLWPhmErtIlF+2y
	 ZYJC5nDQDpv5Fd1p8f2H4Ko2xFGxBvkDq05tZBu6PTl1biZIu+k7Ns4g/E8xhUm3z9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSksttxk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A2606A326
	for <linux-rtc@vger.kernel.org>; Sat,  7 Nov 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSksttxk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9671D1F008A1;
	Sat,  7 Nov 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049775;
	bh=CX/Rj71C0vpHIJPqoynExGqfcIN+XxYwgCJUivFPb7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSksttxkNDNy3jAdrjnHgBZUAVKQnBjR+IRNuceeNWFslV00YfPZek5Izicz0P7g8
	 YKXHCFa9etIvPZGvQ1mkXdskTPaLzjhwER/El+m6qS4oHuoBaMy/2DMhd3ApbsgKP1
	 h4UI/FV1dJxWIwtjcHNOXc0p+YrM52g2m6hpQGjmGBQZmcoEhyAihI1G7jeKoIAawv
	 38pRevqbgVmXgGF+MPHcYTOrVhNkha5XZQoHoffVxtlmDrK56hw00k6g+FqtGzYUts
	 C8a73wN/6rfXeXlndD3jnGNsUxV9QE1ACpTbRxMmuz0PHzxWRfwBuNJisruJnuyNzt
	 DqCZcHzLi4xqQ==
Message-ID: <sashiko-outbox-202845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: test: cancel the alarm timer on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: mimo-4@ilands.app, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <010101a1b5ac6a36-59cf97c9-edab-4e21-8d9c-dbf0062c8011-000000@us-west-2.amazonses.com>
References: <010101a1b5ac6a36-59cf97c9-edab-4e21-8d9c-dbf0062c8011-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 11:09:35 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rtc: test: missing Fixes trailer for alarm timer bug in
  test_probe()
--

commit 294f0a1b29055329469b616665ef82f35df69c49
Author: mimo-4@ilands.app <mimo-4@ilands.app>

> rtc: test: cancel the alarm timer on remove
>
> rtc: test: cancel the alarm timer on remove
>
> rtc-test arms a timer for its emulated alarm but never cancels it when
> the platform device goes away. Unloading the module while an alarm is
> pending leaves a queued timer behind whose callback points into the
> unloaded module:
>
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
>
> Cancel the timer from a devres action registered before the RTC device,
> so during detach devm_rtc_unregister_device() runs first. It removes the
> character device and clears rtc->ops under ops_lock, and every path that
> can queue the emulated alarm again (the ioctl handlers, and
> rtc_timer_do_work() for a pending irqwork) takes that same lock. With
> ops NULL nothing can re-arm the timer, and timer_delete_sync() then waits
> for a callback that is already running, still before devres frees
> rtd.
>
> Signed-off-by: mimo-4@ilands.app <mimo-4@ilands.app>

[Severity: Low]
This fixes a bug introduced when timer-based alarm emulation was added
without a teardown handler.  Should this include:

  Fixes: 8be090299402 ("rtc: test: emulate alarms using timers")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a1b5ac6a36-59=
cf97c9-edab-4e21-8d9c-dbf0062c8011-000000@us-west-2.amazonses.com?part=3D1
