Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F2346A02
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813144; cv=none; b=CX8d8ZHJoiKByEjL2gtaEaPHW8pithrZWJzfC1XHDI1mJQ4t0pyAKQql25HgbmnaFKvhc0d+lxoCo35VO5kWWxcaCg+w4GMZAunAqlGpYXhoiifs1Jab1wCQswZg+QgFoY9VzJioJyRlgiGQVALE4f+p/6mUYciIXJ8Ca4udzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813144; c=relaxed/simple;
	bh=P48UoaSvPTSwrQfSbs832989tR7HVWkEVxVVnW6yRk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnLnNfBlEtDz7yVkZv7Dm+BjcOe8PuHCF++nVdGyJ/yn3ddEa5zBQLT2Bo3+ebmI4LWKNX0yVHQKb0HF0MjtIbwFb1I+4FhtQJSLLhW/kNGRE20CaQd8Yorgfw+2T/SYLNg5ZOh0oI2oaPEUiQSACQwge+dIVGuZDkGzUS6kZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeX0GMwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeX0GMwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B081F000E9;
	Thu, 27 Aug 2026 06:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813142;
	bh=1NCMg7tQ1W2prPYyprT0EaIyQRZAcpecUK7cm9oSDi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IeX0GMwE1JVj80q90bE7vatozshZfcji5xXzVNSr9YmlhYfoApRaENNkAQffOd3H8
	 cBov2ONwP1iF2NpuOmGnV+aQ8hv/rPQe93KL0weGIBb3bZI+wCeyDyiVsBjyBfJLsR
	 qRNu+RofueEzW29p0xGnjEqYKH3mhRVsVRjQRexEQOLEeUvP4YRwG7Cpcgv28SL3xg
	 lRDp+6w+2ZGhYFDJHuALV6s4eM83omFvnQMm4wv0HToyF2r8+DIEcXts/wegqmek13
	 f20wqWVGGQ/rLdks7z5P6+EvcvDM/JOo3J7RqMuPtw9XhkiMQmBnCHwx3Lmbck2hIf
	 tLtsCbkWQgKiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] rtc: ftrtc010: fix clock resource leak on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <16D871E1646724FD+20260827063019.3342085-2-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <16D871E1646724FD+20260827063019.3342085-2-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:45:42 +0000
Message-Id: <20260827064542.80B081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The interrupt handler unconditionally returns IRQ_HANDLED in a sha=
red IRQ setup, defeating spurious interrupt detection.
- [High] Sequential reads of distinct RTC hardware counters lack software r=
ollover protection, risking time corruption.
--

commit 6944a6b7d4e12941b5612ab5907724e5485e82a6
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix clock resource leak on probe failure

This commit addresses a resource leak in ftrtc010_rtc_probe() that occurs
when devm_rtc_register_device() fails. It captures the return value of the
registration function and jumps to an error handling path. This ensures
that the clocks obtained via clk_prepare_enable() are properly released.

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
This is a pre-existing issue, but I noticed the interrupt handler
unconditionally returns IRQ_HANDLED:

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_interrupt() {
	return IRQ_HANDLED;
}

Since this interrupt is requested as a shared line just prior to device
registration in ftrtc010_rtc_probe():

	ret =3D devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
			       IRQF_SHARED, pdev->name, dev);

Could this defeat spurious interrupt detection? If another device on the sa=
me
shared IRQ line asserts an interrupt but its handler fails or is not yet
registered, this driver will falsely claim to have handled it. This might
prevent the spurious interrupt detector from disabling the faulty line and
could result in an unrecoverable interrupt storm.

[Severity: High]
This is a pre-existing issue, but does ftrtc010_rtc_read_time() lack softwa=
re
rollover protection?

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_read_time() {
    ...
	sec  =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
	min  =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
    ...
}

If a hardware tick occurs asynchronously between these distinct readl() cal=
ls,
could it mix pre-tick and post-tick units and result in corrupted time? Sin=
ce
there is no hardware latching indicated and no software retry loop to verify
consistency, an asynchronous tick might cause an incorrect aggregated time =
to
be passed to the RTC subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827063019.3342=
085-1-liudalin@kylinsec.com.cn?part=3D1
