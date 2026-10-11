Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67E46A5E3
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759879; cv=none; b=SpjL/HNd0a0PeZimiofs5vGDcposGZ+HCgiMwm49Y2XAuC/obFuf5u7OlVQ1lZObECFX57ISeLJN5rN8nVS7JRgpfrrel1P8Y1Gm3Pql3Wu/ftD5LpUEG7bu2Ngrmi+V6WgVk30pvaac709nKu2S8iWCZC63r/I8VX3ss6yzhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759879; c=relaxed/simple;
	bh=AnMTzz2JasYxILnlKdXK25B12y/SE/iq60pfGqBtMiM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PHe0Uw62Z0XUXnFj+tqZiGcUJ2iOqLi7M4VjSv+PSfmj36V3RPw0Oil/PC5FVjJIslOD0LtWzwayXnS48Pw0E8CLChZNPfGm4S5aqtTGybbBIyduM78mrmIRb/CYKHbuagU8hs1KxZ/RBzCMFt7PluFSVOeCiEmjOBGo04xjjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlqm1As4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlqm1As4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591B71F0089B;
	Sun, 11 Oct 2026 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791759877;
	bh=cH+MAIpCc9u1nXueYhx+Wl3r3pWRL9sxjUt7dpt6uOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlqm1As49fv0ssWqPmMHtC9kUnRtvwCsqw7v0mPl4rn31gaCf1gGeYMlKvr7xcOas
	 tTPH7gcCNMciz4F2DwHgj4xVf/+5oncyTIo9AvxHJa/0B8xCJC26bWvlKZW6CUlKc2
	 Wl5ZEvmO3ff6JkbKUtBLA/nRMpjbOnSNk6gG5DQqvHoh5jZsslajQUrHgM91JVgmoA
	 7vJaB98HMFJCEKjN056R9RGS9co5yDJRl2flMTFBTtHViO2xp0lIX3yU7RQWAFoUs/
	 cj1MBzbyWlb8f9IrrOl/RmGDOvuTow+M8KXzIh/BX7K0t96Ai9+TxWKk9opRsgBQWN
	 5tbYjpiF48mZw==
Message-ID: <sashiko-outbox-167505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: renesas-rtca3: Join interrupt handlers before
 unregistering the RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261011225657.rtca3-irq-ordering.2@gmail.com>
References: <20261011225657.rtca3-irq-ordering.0@gmail.com>
 <20261011225657.rtca3-irq-ordering.2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:04:36 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rtc: renesas-rtca3: mixing goto and scoped_guard in rtca3_set_alarm=
()
--

commit 847b7d6e6378d6cee33935541f2c60ff982bf01d
Author: Myeonghun Pak <mhun512@gmail.com>

rtc: renesas-rtca3: Join interrupt handlers before unregistering the RTC

This commit addresses an issue where interrupt handlers might still run
after the RTC operations have been cleared. It tracks a stopping state
to reject setup requests and disables IRQs synchronously during removal.

> diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rt=
ca3.c
> index c304ed60edc6c..9b177a131c272 100644
> --- a/drivers/rtc/rtc-renesas-rtca3.c
> +++ b/drivers/rtc/rtc-renesas-rtca3.c
[ ... ]
> @@ -392,6 +399,9 @@ static int rtca3_set_alarm(struct device *dev, struct=
 rtc_wkalrm *wkalrm)
>  	int ret;
> =20
>  	scoped_guard(spinlock_irqsave, &priv->lock) {
> +		if (priv->stopping)
> +			return -ENODEV;
> +

[Severity: Low]
Does this mix goto-based error handling and scope-based cleanup helpers in
the same function?

According to include/linux/cleanup.h and subsystem guidelines, usage of
"goto" and cleanup helpers should never be mixed in the same function. All
resources that need a "goto" cleanup should either be converted to
scope-based cleanup or remain manually managed.

In this case, rtca3_set_alarm() uses
scoped_guard(spinlock_irqsave, &priv->lock) here, but later relies on:

    if (ret)
        goto setup_failed;

which violates the cleanup helper guidelines and creates confusing ownership
and control flow semantics during alarm setup failures.

>  		tmp =3D readb(priv->base + RTCA3_RCR2);
>  		if (!(tmp & RTCA3_RCR2_START))
>  			return -EPERM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011225657.rtca=
3-irq-ordering.0@gmail.com?part=3D2
