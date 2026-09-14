Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76847798A;
	Mon, 14 Sep 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393709; cv=none; b=jKYYTsqCO8tNq5gswtYUVg9YZffQEtXhfl4F4SvE9a29/MhIMbf6ZEjb1xH5a6Q3TehdWmxPn0hZEoh4sUwpeiypibZLt+XN6rZ6VM8tLMKtm/SzzXdLRZlzc1DTECmVtCGZpSEmF8UgnZY/vTe6j0JqWzA7yJkKXXvQQK8J52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393709; c=relaxed/simple;
	bh=7l8418HHcwfLELCMgIPWtH7XfymmUReWSdO0peU4+lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKnLiw7zVuJiONu+NeEOtK3kcdC0FOXU7CJ1yPI3oTXPgMXZiAVHYyU8/m0j94W426oC03BircschJGmDzaQJUR3uWxZ5QMYFEFqs8ut/dPJc7oVb936Nj1wTz6xBJ7745zr+lUtnJqgDmqxnjM8YD6LK2Dxz5wUzeUANnzXSWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLEIx9Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLEIx9Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC26D1F000FF;
	Mon, 14 Sep 2026 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393707;
	bh=4vvoJR1/lgkKcx8/sHEEFwMZ6ot2QFP3SPh6At6AiVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLEIx9GggMUgHydmpuMuM08l2JoB84ncZynzIpvsaAovCeimBmBeoqJtLo1xIhquk
	 0ZR76gJJcHnfAQcEmGWNbD6h8oXlRnnxlFy3ZPnjjDPvRn5bmudeydkOC4RCV3cdep
	 O83hSSxbHfz5Srua81KjHOReET+qjDyVdthy2MlFmawXI95iAnLn2QKSB7/fcY9LOS
	 pX/fo3aZ+5+XV3phBSmnKJ9dUnRrRfSruBap1OU2AVqHtEOxgvUc+nP8dJXOayDPQC
	 0I5cmsBocrGAKBoFjX6rxlSr0igXW8pVJvpHGxP/g1IhORR0HEwcHhIPKQjCNc6EHv
	 sfZ53uDsnQyAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mxc_v2: fix clk enable-count underflow warning in
 remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: linux-rtc@vger.kernel.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, imx@lists.linux.dev
In-Reply-To: <20260914132505.2356970-1-congnt264@gmail.com>
References: <20260914132505.2356970-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:48:26 +0000
Message-Id: <20260914134826.EC26D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for dev_pm_set_wake_irq() leading to a memory leak=
 and dangling wake IRQ on probe failure or device removal.
- [High] Premature unprepare of the clock in remove() causes a use-after-di=
sable race with devres-managed resources.
--

commit 3311fdd80d87e5108fcbeddc8974c58c3e0da127
Author: Cong Nguyen <congnt264@gmail.com>

rtc: mxc_v2: fix clk enable-count underflow warning in remove()

After probe, the clock is left prepared but disabled, so calling
clk_disable_unprepare() in remove() hits an already disabled warning.
This commit changes it to clk_unprepare() to match the probe-failure paths.

> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
> index 570f27af4732e..ab2ab61017f57 100644
> --- a/drivers/rtc/rtc-mxc_v2.c
> +++ b/drivers/rtc/rtc-mxc_v2.c
> @@ -366,7 +366,7 @@ static void mxc_rtc_remove(struct platform_device *pd=
ev)
>  {
>  	struct mxc_rtc_data *pdata =3D platform_get_drvdata(pdev);
> =20
> -	clk_disable_unprepare(pdata->clk);
> +	clk_unprepare(pdata->clk);

[Severity: High]
This is a pre-existing issue, but does unpreparing the clock here cause a
use-after-disable race with devres-managed resources?

The IRQ handler is registered via devm_request_irq() in mxc_rtc_probe(),
which means it stays active after mxc_rtc_remove() returns. If an RTC
interrupt fires after the clock is unprepared (for example, during the
devres cleanup window), the interrupt handler mxc_rtc_interrupt() calls
clk_enable() on an unprepared clock:

drivers/rtc/rtc-mxc_v2.c:mxc_rtc_interrupt() {
    ...
    if (clk_enable(pdata->clk)) {
        spin_unlock(&pdata->lock);
        return IRQ_NONE;
    }
    ...
}

This can trigger a kernel warning for enabling an unprepared clock, and
cause the interrupt handler to return IRQ_NONE without clearing the hardware
status, which could lead to an interrupt storm.

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup for the wake I=
RQ
when removing the device?

The unmanaged wake IRQ is allocated and attached in mxc_rtc_probe():

drivers/rtc/rtc-mxc_v2.c:mxc_rtc_probe() {
    ...
    ret =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
    ...
}

However, mxc_rtc_remove() completes without clearing the wake IRQ. This can
lead to a memory leak and leave a dangling wake IRQ on driver unbind.
Subsequent probe attempts could hit an -EEXIST error and trigger a warning
if probe is retried after a failure or during a rebind.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914132505.2356=
970-1-congnt264@gmail.com?part=3D1
