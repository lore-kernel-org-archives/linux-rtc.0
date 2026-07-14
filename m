Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B072627
	for <linux-rtc@vger.kernel.org>; Tue, 14 Jul 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989022; cv=none; b=WLVn6xMgMvA0ZTpRFHhY+6yVvIlsurUzewT/m5yN4MsbT9AxQEE/txh976f9vuEyC3nSbUXmR9KaPCfglrhjag87vzhSAjiVNb6I802Y52lXUMM1+ZfLu0lTuXzBj3w2XYeM7n+smuBcjW6pu5J6XMmmCA1xNqC5SOD87q9TB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989022; c=relaxed/simple;
	bh=+PLIABUlw9uHfDDSr/41jIhsFZPkUb7RuqrPprCJPmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zf8dVGVY/zqQdDIC+sz75WOqdqdP1afGKAJQXKMXu07FtCfkBGYCIMw56KM1C4gENTjctpdcjF/tXiQSurTdCyLcAau33FLKIpVtqKQV68o5/6Kl4/zbGI4QOgjLHD6Dmw/ugeg4ZekForbVlTJAaa3JcZvHO+HpjOHPPSTP1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcVWUhSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcVWUhSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142201F000E9;
	Tue, 14 Jul 2026 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783989021;
	bh=+PLIABUlw9uHfDDSr/41jIhsFZPkUb7RuqrPprCJPmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcVWUhSoYhlC725pIUQcnAWbIBU4vBNQeMDu+dfpbiEof+9+YDqPMSROtVT1mKkBn
	 rKHYJdvV2XIknky3C2juRpwobtxxSmahfpBfKl7vLam5M/QKEcpE2qK5tdKOfkeOSb
	 ink5NbEDRHQbeBp5x2HJeVWCrBSSni7Ya8OgrxaL1asVvbauDbZSinI3b9q4AyGIvM
	 EB+htIE9b3+UT3uPxmnHlKdhDQNKc4RzLtHMaOwvqt1GqECum9pjKl0VM3/L0nTsl0
	 YA/W1qdFHcU1jTQAnVecJwY7oA0VzY4dvz+Qystv6eUMaCdH6MIXyFc9pJBTkjOrfr
	 SPZFqhkbMBhjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: st-lpc: get IRQ via platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260714002259.1392655-1-rosenp@gmail.com>
References: <20260714002259.1392655-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:30:20 +0000
Message-Id: <20260714003021.142201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Replace irq_of_parse_and_map() with platform_get_irq(), which resolves
> the interrupt from pdev->dev.of_node directly and returns a positive IRQ
> or a negative errno (it never returns 0). Propagate the error on failure
> instead of the previous open-coded "IRQ missing or invalid" / -EINVAL
> message, so -EPROBE_DEFER is handled correctly. The rtc->irq field is a
> signed short, so the negative error code is preserved.
>=20
> np is still used by of_property_read_u32() for "st,lpc-mode", so it is
> not removed.
>=20
> Built for ARM (multi_v7_defconfig + CONFIG_RTC_DRV_ST_LPC) with LLVM=3D1;
> drivers/rtc/rtc-st-lpc.o compiles cleanly.
>=20
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714002259.1392=
655-1-rosenp@gmail.com?part=3D1

