Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F83DB310
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192916; cv=none; b=MaOxQREf7p8YqFLrCRNf37iPsS3lxQI1JyCiFNJCu622F83uZPOCeq6Yu2bVCYCSphXPY0ugJeLlBjV6WuQM7LghcU6CHnIu0TDPkr6FLVbUdXWKt43wsOOUVMQnF0GToVpS6PyZPMxnvD7+HtaRe3b054uJ/ruvUmLtPqHplFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192916; c=relaxed/simple;
	bh=sDd9/5nDxfTVMGipflU3E/0Gsin1Y9XRBYg++9dOos8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=teh6YDYcTSdwnvLmy9nK8BQPS2BlnIzwCvDi4J6Z0/sx0wdW3ZjJrr25vf6JekrEOUXaKtw1zxszkob0w3ZGGhhy7cad5TBZjirYZSzTvzDH8b1AtED1UxZZIKILve391KemdIvrFm3jzDFdk5HYOJbZ+caGAyBstYIs2sKu+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM+m/qbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM+m/qbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CF31F00A3E;
	Mon, 31 Aug 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192914;
	bh=DMLIdLoorXwuxClEkrkB3WGPF1Wbf26AxSWTQE6TNO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XM+m/qbklsrjF1+XfrXTiUFlNDaz9AyzvqWXKgWFgKNTeEwtbCxNmuJqG4MqIU6P/
	 6QMEMkAG6S/gnnzzDazZlyLYH9hMEBu6Mds7tUwhbJzWBr2jTAVCW784T1FdpX26Jh
	 5p/f2cuxdhr3I3fNj6uSwuauAbSZb0c+Kol1UdwITzlxOxKM/BwSBy4KVojFkBaA43
	 QyLuMuBSXmjBqriOKXPAIKfAr3KbXwILWcKPUPgLjsXNI3JzdBGQk8ae66qtUiQhYS
	 ogWQWdlylogdnL0rk+F3thCYzkCQ4VRQDyHvK0LH3r+N7+/YafSVXVNWlCeCyYMmrh
	 mkwBnPJ7/finQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] rtc: bq32000: add delay between RTC
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831133314.4125787-423-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-423-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:15:14 +0000
Message-Id: <20260831161514.A3CF31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The delay workaround is bypassed if `client->irq > 0`, but becau=
se the driver lacks IRQ handling, userspace will always poll and trigger th=
e hardware bug.
--

commit 50c036b36c688887d406f6107b0ade6653a75e5c
Author: Adriana Stancu <adriana@arista.com>

rtc: bq32000: add delay between RTC reads

This patch adds a delay before reading the BQ32000 RTC registers to prevent
stale reads or select timeouts during aggressive polling. The hardware needs
idle time to refresh its register buffer, which is starved when tools like
hwclock continuously poll on systems without an interrupt line.

Link: https://patch.msgid.link/20260416142151.3385827-1-adriana@arista.com

> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> index 7ad34539be4d2..245e5e45d6a16 100644
> --- a/drivers/rtc/rtc-bq32k.c
> +++ b/drivers/rtc/rtc-bq32k.c

[ ... ]

> @@ -89,9 +90,17 @@ static int bq32k_write(struct device *dev, void *data,=
 uint8_t off, uint8_t len)
> =20
>  static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> +	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct bq32k_regs regs;
>  	int error;
> =20
> +	/*
> +	 * When the device doesn't have the interrupt connected, prevent
> +	 * userpace from polling the RTC registers too frequently.
> +	 */
> +	if (client->irq <=3D 0)

[Severity: Medium]
Will this condition incorrectly skip the delay workaround on systems that h=
ave
an interrupt defined in the device tree?

Because the BQ32000 driver itself lacks IRQ handling (RTC_FEATURE_ALARM is =
not
set and no alarm_irq_enable callback exists), the RTC core will always fall
back to UIE emulation. This emulation aggressively polls rtc_read_time()
regardless of whether client->irq > 0.

If client->irq > 0, the workaround is bypassed, but the hardware is still
subject to the exact same aggressive polling from userspace. Does this leave
these systems vulnerable to the same hardware register lockup (stale reads =
and
select timeouts) that this patch intends to fix?

> +		usleep_range(2000, 2500);
> +
>  	error =3D bq32k_read(dev, &regs, 0, sizeof(regs));
>  	if (error)
>  		return error;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-423-sashal@kernel.org?part=3D1
