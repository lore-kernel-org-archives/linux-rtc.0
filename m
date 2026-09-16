Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7E48C41F;
	Wed, 16 Sep 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554450; cv=none; b=qieCKbsB7piphEtmxdyZr2rfDnsnDq+8Ww92lZhzX/O1ixvvf1T3llnkEqgyz3WtqWlXkmdEh0YR6HcH0m8g8AhlsmXQKkMNXjwnV3k1CdIGm2CnQkZTrrozsxBlNr7haNnJCwglQiPNEeP4x0IZZCCWwSsDmCM6izvEwmI0tsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554450; c=relaxed/simple;
	bh=WiW34bLHwraRcEeS9NcgJMp/kYOGNGl56vUP9fUTVNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2tC76LpSqv9TjMwRzTRTRo4NFevmqRZ3eCHluZj0ADPQ226Vvroj9QzqVzVJjbieXKpLA9opkqRusUfWOoPUsVDXJzb/XgZb/7Skp/bjgZ//AB2KNprg06qALJxGCiuPG3A36iJrVYId1UZydUQU9Qs6emNNcs0nrFSoATBbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZMZbzYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZMZbzYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31261F000FF;
	Wed, 16 Sep 2026 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554435;
	bh=WiW34bLHwraRcEeS9NcgJMp/kYOGNGl56vUP9fUTVNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZMZbzYtw71bW9d2mlI74VbaBAX9hFidN1FwQS6Jot4YZ5cD1vhdec2NXcOpWoEvx
	 JwiRJMy3HPwrVCJB1zush8msAJ4bXY0SvXWPGI/NLfPtt+6PcOqLnI/EbCnMmji+VI
	 3azIrzEpe1YO+DicaoQq8FmyOMkMl5N1hBq3iQRmVKr3FL2KfeVft6IXy5Jq/Knn4b
	 +HsXTCouSIm8g9GrEUy+wWoZW2v9c6mpLA3XEBf7IMbU3Bd1UsRsvgZsHW2qMsdn7f
	 oVqJ3cltkghiI1xcfZHP5Z+UhYtILA/WG15qpjr74/aXoI3joDJQ4lHItJPmyvA1P/
	 wb+Iqoop3Ddfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: rtc: rzn1: add SoC names next to
 their IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260916102520.24288-3-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:27:14 +0000
Message-Id: <20260916102714.B31261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This helps maintaining because the numbers are easy to confuse.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916102520.2428=
8-1-wsa+renesas@sang-engineering.com?part=3D2

