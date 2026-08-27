Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8D3DAACF
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818683; cv=none; b=d7YnAKShB3BHjKzLUtR+LZTG+dxZqkcmyPaCEvU4OGuco97B8WEwVUd7Wv7jGRqQFC98cmJtA4OuB3X3LlSEi7q1ZZrylf+PmxmSkp3EkClsfLdFxlBlINkrqgm6xRPq432s0fxfqewOa62eNfbE/6vP9ZzsPcv5crPCdxUrB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818683; c=relaxed/simple;
	bh=7rGsqsyXQmcY11ZLisRrHiIdb9ayHzewcX0OnknErTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HuJh/aSZfDcHAHUaf1zfvpRU4VVx+/REiGPRLsp+v4At+iyOmx2iKJ9Cp9dVNCk1dBuRvn9K1wQQ+GY4deetKYUah3Ze0YqC3eY4vbCvajxtZBu3mKH/8b7exHPrfl6ys3k1BbAFLVWz8QijHsuS9+mnJ9LXZdtCzWxwilBpmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy0VoSb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy0VoSb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C061F000E9;
	Thu, 27 Aug 2026 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818676;
	bh=qpklFZn8uurpjYMuIq3RkjKk/LE3kUkw+ggFfcGYm/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oy0VoSb903QCsoai3a1i+oOPpnQGPOshjM0Y41C4oLaPUFOtp60UynaL0I0CKyxej
	 Xjd815k5viqU7HjZhAJv9r1bcWk7T82W9FkfCbZis/SsxqoZ7CA1bjACY/Z6qM6rLe
	 zENvr23hML0OqdXfKMBGdf1jwI8KMbLBUDXw1izwwNNKvyrdikrB5Xl4akqV7cFeJf
	 E9AJDYsn+sd3an52GPwi2cDAkTbwAX/ZOFd1m1aTGRmtV/YnkKDpT8ZsYnJZvEvsIX
	 Kv7zcbpPP6m1Yq/E7ySOo008iPWcMO53iyOq4yzSwetOPcAmZhS+6Nw7PqQiNeRbS6
	 9G2bUUypbxctw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] rtc: ftrtc010: fix integer overflow in time
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <42C8FBD59AA34EA9+20260827080320.3351155-4-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
 <42C8FBD59AA34EA9+20260827080320.3351155-4-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:17:56 +0000
Message-Id: <20260827081756.73C061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch claims to fix the Y2106 integer overflow, but mathematic=
ally computes the exact same 32-bit truncated values as the original code, =
making it a completely ineffective placebo.

Pre-existing issues:
- [High] Unsynchronized sequential reads of the RTC time registers lack a l=
atching or retry mechanism, causing hardware tearing and persistent time co=
rruption.
- [High] Unconditional IRQ_HANDLED return in an IRQF_SHARED interrupt handl=
er breaks the kernel's spurious interrupt detector, causing a system hard l=
ockup.
--

commit 9a9a270ad0bf60c8a0b5860cccb3bb2994f4adcf
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix integer overflow in time calculation

This patch modifies the time calculation in the ftrtc010 driver to cast
variables to timeu64_t before calculating offsets and days. This is
intended to prevent 32-bit arithmetic wrapping for dates beyond year 2106.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 2f610a0fc6e9b..c989574b1fbc6 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -73,7 +73,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)
>  	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>  	offset =3D readl(rtc->rtc_base + FTRTC010_RTC_RECORD);

[Severity: High]
This is a pre-existing issue, but do the sequential reads in
ftrtc010_rtc_read_time() lack a software retry loop?

If an internal hardware counter rolls over while the registers are being
read (e.g., SECOND from 59 to 0), it seems the driver could acquire an
inconsistent temporal state. Would this expose the time computation to
transient corruption?

> -	time =3D offset + days * 86400 + hour * 3600 + min * 60 + sec;
> +	time =3D (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + s=
ec);

[Severity: High]
Does this explicit cast to timeu64_t in ftrtc010_rtc_read_time() actually
prevent the integer overflow?

Since offset and all counter variables are u32, this addition will be
evaluated in 32-bit arithmetic and wrap around (modulo 2^32) before the
result is cast to 64-bit. Because of this, it appears the final returned
time can never exceed 0xFFFFFFFF when reading an RTC time beyond year
2106, leaving the issue unfixed.

>  	rtc_time64_to_tm(time, tm);
> =20
[ ... ]
> @@ -93,7 +93,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
>  	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	day =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);

[Severity: High]
This is a pre-existing issue, but similar to ftrtc010_rtc_read_time(),
could a hardware tear occur during these sequential unlatched reads in
ftrtc010_rtc_set_time()?

If reading the hardware registers concurrently with an internal hardware
counter rollover, the torn state would be used to compute the epoch
offset. This offset is then permanently committed to the hardware RTC
record, corrupting the system RTC base.

> -	offset =3D time - (day * 86400 + hour * 3600 + min * 60 + sec);
> +	offset =3D time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
> +			 (timeu64_t)min * 60 + (timeu64_t)sec);

[Severity: High]
Does casting the operands to timeu64_t in ftrtc010_rtc_set_time()
successfully fix the truncation issue here?

The offset variable is declared as a u32. Assigning the 64-bit difference
to u32 offset instantly discards the upper 32 bits, making it
mathematically identical to the original 32-bit arithmetic. This seems to
prevent the driver from successfully setting an RTC time beyond year 2106.

>  	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
>  	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);

While reviewing this file, I noticed another pre-existing issue:

drivers/rtc/rtc-ftrtc010.c:ftrtc010_rtc_interrupt() {
    static irqreturn_t ftrtc010_rtc_interrupt(int irq, void *dev)
    {
        return IRQ_HANDLED;
    }
}

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditional
return of IRQ_HANDLED in an IRQF_SHARED interrupt handler break the
kernel's spurious interrupt detector?

By unconditionally claiming ownership of unhandled interrupts generated by
other devices on the same shared line, this could prevent the kernel from
disabling a malfunctioning IRQ line. Would this potentially lead to an
infinite interrupt loop and a system hard lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827080320.3351=
155-1-liudalin@kylinsec.com.cn?part=3D3
