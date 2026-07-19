Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A491394788;
	Sun, 19 Jul 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470428; cv=none; b=olzIK8I7TfRrSi/ZfDsWV2iCBUkzMfzvwToEfW1vcDSA4Mv2XR87Hug21twDcKLVn5mdmsG9zlvAR8JpdPMbzbIraNzppmIRm8Q4Atz4GFKNY6kBu0SAQNH1a4dVxlnzNIZgiowX/4prTvxpNBC+s8C9+17ibGWiOne2lo0IUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470428; c=relaxed/simple;
	bh=MqqJmn0eOffJaQX9JbAI72jmD9U/eUcFQ3310QUZSyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jut+Dalu1dwMJjplb0c5qoNPvrBgaqj0Y6N4WBzRNhKWkzerDyw397RGjGjxgiJlj1O8+Nfv9wliTiy/BH+OJAsMbZwvDqOSttWBl6in1RHePzIQ14CVyEpVr3DA2W+9OTTAzHhmnYaI62htrfvPUpoVesZotx063Dt2TCg6GYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLkY/z2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLkY/z2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B71F000E9;
	Sun, 19 Jul 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784470422;
	bh=MqqJmn0eOffJaQX9JbAI72jmD9U/eUcFQ3310QUZSyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLkY/z2CIV5npD2U5hcFwnoUyXXkhjPt2v4rIVHqNQNnkqRUeIMH5ke4S45FJng86
	 kN0qPOcAjOuUGWs/b+NLubU9jgBsiUpy0Gav54mu0nBe23qkx9WYujU+1Fp6wZHRXL
	 9QHQqiDtwgQ/7HyaxcNTMavUOafUTq+yuphPHKOQgsrvK/ZypFg4j+V/p4Z0M4Daky
	 CtNOtloSA0BHv0ijpXQXlcc9tz8jvLGy189Lz/16A8Co+PsBxxn9kBbmRZOC1FETJ4
	 ZLskS4JoVBaNOsdyD3y6B1+kCm1QFFq4JcALWDDx32g2TAvuywCBh16kfuJ/zt+KT/
	 glo99RfOc44xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti: omap: Fix Palmas RTC node names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260719141008.3562347-3-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
 <20260719141008.3562347-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 14:13:41 +0000
Message-Id: <20260719141342.125B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The core RTC Device Tree schema expects RTC nodes to be named generically
> ('rtc' or 'rtc@...').
>=20
> Update the tps659038_rtc nodes across the AM57xx device trees to use
> the generic 'rtc' node name to resolve dtbs_check warnings.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719141008.3562=
347-1-egbostina@gmail.com?part=3D2

