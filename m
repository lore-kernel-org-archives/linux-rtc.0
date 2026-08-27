Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA364381AE7
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787796656; cv=none; b=HU9fAMFjVBX7HLqHThT/+d53puk3KxFksQypyP2etMffgSvzndn+aA7TaIGr74+5FQBpD0kx82tCI+Yy1QLXyUpg1/wwBSjFVIS8+EDqcvuPp9xwFiUQyfkoDMUekrJ9AOOxkC0B+dhQOGzE+Hn4tpOdkkD+u1TxLb4uZZ235Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787796656; c=relaxed/simple;
	bh=gOhpJMpJF9XN1Cqrvusoc04kySNXS0nUloeOVqHNSl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s01iLozYW0B1mZ7mUQQlD9nN1UusG6JvUxykwfKsUgNGdO+WdgcoAOTzJk8AQsQHQbiGD0EYc81Rxo5xu2IeKGx+n6/f4ZSaPD0LYEVrf71TjxZp/TFQBYlYnPNuIthB2Pb1SwuYmHUUCxPa0Viwik12JJHYfZOto8a6RYbAQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5RnG0fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5RnG0fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963C1F000E9;
	Thu, 27 Aug 2026 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787796654;
	bh=+tTBAehgwWk7RAcaNjykDoBNYRHB29XrYvcp6XxwMh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5RnG0fmvCtMe645JKe5X3d4y+ykz/pvXmOHKR4st3dmU442x+nUxMB6W4lTqT6j8
	 XWy6rmmJq1mnITuIYilK/wezFdnya9+i/hyGsAKfjOqYPlVpQj+9TffTQiZyOuc6ET
	 PfD72G1LSEbOrdYBa8XnqCrAcaeEu8JLs8fpbvUBUZr/ZTC4ktljA3+4NkUiw8z4P2
	 wB04v+WEbkFWaGD3Ennfm+FfQDuspytyD/SJkvgMeSKzDV/sIyEiPBacteSobsuCSN
	 fK+3dyaX0isIjPC3rlXIABUkS41n+FBYkmMu4AaCo62TaSLldNCeEoV50lQGV1lIxr
	 fsEOsTpuM8Pzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ftrtc010: fix clock resource leak on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <6A7910FC22A9FEF1+20260827015739.3314298-1-liudalin@kylinsec.com.cn>
References: <6A7910FC22A9FEF1+20260827015739.3314298-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 02:10:53 +0000
Message-Id: <20260827021054.0963C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mixing devm_rtc_register_device() with manual clock disabling in .=
remove causes a use-after-disable vulnerability.
- [High] Shared interrupt handler unconditionally returns IRQ_HANDLED witho=
ut checking hardware registers.
- [High] Integer overflow in `ftrtc010_rtc_read_time` due to 32-bit arithme=
tic wrapping.
--

commit 7252ea4ab6d10cb6ebbf156a3c7aa20a2dbb7aa7
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix clock resource leak on probe failure

When devm_rtc_register_device() fails, ftrtc010_rtc_probe() returns the err=
or
directly without releasing clocks obtained via clk_prepare_enable(). This
patch captures the return value and jumps to the error handling path to
properly release clocks via clk_disable_unprepare().

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 02608d3784958..f398d6dc85ae4 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -181,7 +181,11 @@ static int ftrtc010_rtc_probe(struct platform_device=
 *pdev)
>  	if (unlikely(ret))
>  		goto err_disable_extclk;
> =20
> -	return devm_rtc_register_device(rtc_dev);
> +	ret =3D devm_rtc_register_device(rtc_dev);
> +	if (ret)
> +		goto err_disable_extclk;
> +
> +	return 0;
> =20
>  err_disable_extclk:
>  	clk_disable_unprepare(rtc->extclk);

[Severity: High]
This isn't a bug introduced by this patch, but mixing
devm_rtc_register_device() with manual clock disabling in ftrtc010_rtc_remo=
ve()
causes a use-after-disable issue.

In ftrtc010_rtc_remove(), the hardware clocks are manually disabled before
devres cleans up the RTC character device:

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_remove() {
    ...
	if (!IS_ERR(rtc->extclk))
		clk_disable_unprepare(rtc->extclk);
	if (!IS_ERR(rtc->pclk))
		clk_disable_unprepare(rtc->pclk);
}

Because the RTC device was registered with devm_rtc_register_device(), it
remains registered until devres cleanup runs after the .remove callback
returns.

Could an unprivileged process with an open file descriptor to /dev/rtc0 iss=
ue
an ioctl(RTC_RD_TIME) during this window?  Wouldn't this invoke
ftrtc010_rtc_read_time() which performs MMIO reads on the clock-gated
hardware, resulting in a synchronous external abort and crashing the system?

Should the clocks be managed with devm_clk_get_enabled() or
devm_add_action_or_reset(), tying their lifecycle to devres and eliminating
the need for manual teardown in ftrtc010_rtc_remove()?

[Severity: High]
This is a pre-existing issue, but the shared interrupt handler unconditiona=
lly
returns IRQ_HANDLED without checking hardware registers.

The driver explicitly registers the interrupt as shared in
ftrtc010_rtc_probe():

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_probe() {
    ...
	ret =3D devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
			       IRQF_SHARED, pdev->name, dev);
    ...
}

However, the handler blindly claims the interrupt, masking 'nobody cared'
warnings for the shared line:

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_interrupt() {
	return IRQ_HANDLED;
}

If another device shares this IRQ line and asserts an interrupt, the IRQ co=
re
calls all registered handlers.  Since ftrtc010_rtc_interrupt() unconditiona=
lly
returns IRQ_HANDLED without checking device-specific registers, won't the
IRQ core incorrectly assume the interrupt was legitimately handled?

If the actual interrupting device is level-triggered and its driver is
unbound or fails to clear the interrupt, couldn't this cause an endless
interrupt loop that completely freezes the system because the IRQ line
remains asserted and the IRQ core will not disable it?

Should the interrupt handler read a status register to verify if the RTC
actually generated the interrupt and return IRQ_NONE if it did not?

[Severity: High]
This isn't a bug introduced by this patch, but there is an integer overflow=
 in
ftrtc010_rtc_read_time() due to 32-bit arithmetic wrapping.

In ftrtc010_rtc_read_time(), the calculation for time evaluates entirely in
32-bit math:

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_read_time() {
    ...
	u32 days, hour, min, sec, offset;
	timeu64_t time;
    ...
	time =3D offset + days * 86400 + hour * 3600 + min * 60 + sec;
    ...
}

Since offset, days, hour, min, and sec are all 32-bit unsigned integers,
won't this silently overflow and wrap around U32_MAX before being assigned =
to
the 64-bit result?

If a privileged user sets the RTC time to a value near or beyond
the year 2106 (U32_MAX seconds), wouldn't the reported time wrap around
incorrectly, causing data corruption and contradicting the driver's
rtc_dev->range_max configuration?

Should one of the operands be cast to u64 before the arithmetic operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6A7910FC22A9FEF1+20=
260827015739.3314298-1-liudalin@kylinsec.com.cn?part=3D1
