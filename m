Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1613F1066
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152318; cv=none; b=huWNrZdStEK79BZJup/pF1qmlbWfB85y+d9EnrDMD8UEfesGpJafYNXG0X/kHl5dPWhOs1ahXFG4ccd86q+Qg7a6HtbJJyZMJavy7AqAfP17Hqq2W3MCa9dTy8L9WfKTGZUn0ihCnTIA+N/4IGLdTbYchcjr8xTn0Ej8taEIts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152318; c=relaxed/simple;
	bh=pumwwbxkIEYUWlvdYrTuD2GS75ML4FpVSIUcykToXpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEyM7p8iXitnMKEoIP9hmL/JNTyu3zwgjBX1nx7szgLrhYF3jOwlxji6JrNjWJ0EwPfDTOi8UrWhk48tQk/VmEJaa9QOqVTNMS1MQE3LYu7uEqV28FUh3vQFUwoyyAmr3mf/W4Fsr8ONc/exPNzZfaQ1p4O6RytpMR6g0TYj0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPXAnu/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPXAnu/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FF1F000FF;
	Sun,  4 Oct 2026 22:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791152316;
	bh=pumwwbxkIEYUWlvdYrTuD2GS75ML4FpVSIUcykToXpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPXAnu/vvpJ+W0VGkXG2t3QmfL0XEXoIpHvR5iVwmWKcgamERLRAb4wuH/PMajMzf
	 Do/8PzqH7VlBeCWcmBUaZg2f2TENCf7WclFfk3iZLu7HtorUAV38pVoq8LpDNEsT4e
	 AKldykOU6gd3F11H+iuXl3D3tfwYhmNoz5kdAMbx7ePYzOSYceaSLegqA/fFJt5HOk
	 sy58qR/kv14SCgiJH4A0CAiHy5mx8Z8/Us6gYxwKNFJrntYqgrZ/DfQa7ob3VOSe0K
	 V0djC6HEB7aPt2/QndINSYUEtj4Sd2q6FUNNbRhWH/mbqtol+kgkwjnK0TeOZY6ZkW
	 MhvtzAN8p3E9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261004221327.416323-1-rosenp@gmail.com>
References: <20261004221327.416323-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:18:35 +0000
Message-Id: <20261004221836.613FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with a single devm_platform_ioremap_resource() call, which folds
> the resource lookup and mapping into one step and returns an ERR_PTR on
> failure, checked with IS_ERR() and propagated via PTR_ERR().
>=20
> Move the mapping ahead of the devm_kzalloc() so that an error or deferred
> probe is handled before the rtc_data allocation, avoiding needless work.
>=20
> The fsl,stmp3xxx-rtc nodes in imx23.dtsi (reg =3D <0x8005c000 0x2000>) and
> imx28.dtsi (reg =3D <0x80056000 0x2000>) each provide a single
> non-overlapping IORESOURCE_MEM window, so the region reservation now
> performed by devm_platform_ioremap_resource() introduces no conflict.
>=20
> Keep the alarm IRQ in a local, as it is only used in probe, and fail
> probe on a platform_get_irq() error instead of passing it to
> devm_request_irq(). Drop the open-coded error messages, as
> devm_platform_ioremap_resource() and devm_request_irq() already
> report failures.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004221327.4163=
23-1-rosenp@gmail.com?part=3D1

