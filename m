Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE583D6478
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818530; cv=none; b=P61kGDVIDxFzJyUTyp1JX10BpQ+WEn+X1WQguoBl97eRVz6YU026xIUihx9sm1ptmkfVBSdnwg6bzLOz1NjzIptUSJnyT6dn2QG056gy5xqKVpXt2WVBnoG3A3LbsWX+Q3Dgr6Ex6V6EIHnKnhvG+3Fuge1v7l9/q29MLa7AYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818530; c=relaxed/simple;
	bh=0wWtAZIY/a9htv0VDMP2wK9r+mbwkUsHndWxyW6Bv+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lTgM9InvKhVMe0zxSo2d8laT7SkIR2U+wtXSgWcXZpekNs4cAA6eMikzcZRh9vr+2PSAAXna0DujB/xYG2iCEqFY+C3fF4pW79QQNI/6h1drki5bTkcBxTMaACQzUBukHEGEhNAGZkXDNNU21XN3893XnUj1FsbUsnhjoZNW3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdtocId0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdtocId0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2481F000E9;
	Thu, 27 Aug 2026 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818528;
	bh=uJypqLZCpP52kK6YnXnzW85dGdYJfl5DfuPRSLLlBbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdtocId0iaZZ+k69VNeA4aWWZGtF2vGcRyFnQbGFE8QsOJKQ+x4MKWUajdja4daBf
	 +uRew3XInYUGfORG+fGMA2dSSKEjh6wYumeLIRU8jjVXXWeYXW8muODUXf61vEliW4
	 gLWeZxwshoMaBuj8TkrdQ6QdyVJb+FX/KFkivloQmf1Q4+zz4sxzhJwOfhLY3WJFxq
	 rFvzPar521GNBsKg7PiiyVlag6+NjXlXVUNoAGd7V9eFexfV518nhesk+h2J5G4TZu
	 u/aJHGRzNrC9SG0iWZF4o0BQUr5vhgCStdlv7D6o+VVRiM/2QZNHM+reR1iwEX+5kp
	 LtQfqir6XdnaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] rtc: ftrtc010: fix clock resource leak on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <AC51B5F2C5FFEBB0+20260827080320.3351155-2-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
 <AC51B5F2C5FFEBB0+20260827080320.3351155-2-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:15:28 +0000
Message-Id: <20260827081528.9D2481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared interrupt handler unconditionally returns IRQ_HANDLED, defe=
ating the kernel's spurious interrupt detection.
--

commit 8daf0ea14af5dc0abeba82e55b73ddd78a69f258
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: fix clock resource leak on probe failure

This commit fixes a clock resource leak during the RTC probe failure path.
It ensures that if devm_rtc_register_device() fails, the driver properly
jumps to the error handling path to release extclk and pclk resources.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index 02608d3784958..f398d6dc85ae4 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -181,7 +181,11 @@ static int ftrtc010_rtc_probe(struct platform_device=
 *pdev)
>  	if (unlikely(ret))
>  		goto err_disable_extclk;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but a pre-existing issue. The
handler is registered with the IRQF_SHARED flag just above this check:

	ret =3D devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
			       IRQF_SHARED, pdev->name, dev);

However, the interrupt handler unconditionally returns IRQ_HANDLED without
verifying the hardware status:

static irqreturn_t ftrtc010_rtc_interrupt(int irq, void *dev)
{
	return IRQ_HANDLED;
}

Can this cause a system lockup if an unhandled interrupt storm occurs on
the shared IRQ line?=20

If another device shares this line or if the bootloader leaves the RTC=20
interrupt enabled, the kernel might fail to disable the spurious interrupt=
=20
because this handler falsely claims it, starving the CPU.

> -	return devm_rtc_register_device(rtc_dev);
> +	ret =3D devm_rtc_register_device(rtc_dev);
> +	if (ret)
> +		goto err_disable_extclk;
> +
> +	return 0;
> =20
>  err_disable_extclk:
>  	clk_disable_unprepare(rtc->extclk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827080320.3351=
155-1-liudalin@kylinsec.com.cn?part=3D1
