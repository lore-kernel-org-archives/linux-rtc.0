Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B438E113;
	Mon,  6 Jul 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330895; cv=none; b=KoPp/pJ828CLsveweiMnpQDplcpDegz9OhO+yK+18K0ThiNJFvnKA11/ONZtMAn2zf6Wtoo6Fkp2Ohpo+CWfsECip8XCbB88YW7bhpnkCjImL+zzGt5+nGsXrf1ABfqrAsA0rF143o5tlZzB1KRNyT6WqjUZhBFMt2zWJA6Pi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330895; c=relaxed/simple;
	bh=lJoV7mN+tOPWEEgWwlqKCMyeoG/BqxRd+4Ge//xmaVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uKUPdRzDqv85bbIjGC5iLZ9mHNjzF6euVi1ff1Dl9slkca8NU07XfkurB2MpA9VYQ4Nm3tHqfB48soU+hzzj9PbDZWafz4ie25zmF+voiODgzRAIgC7bRfbRFmeRsJNP1VKdSt1aPdOk5hKvUWxgQaJ9Sipev+anmVOnsgxG1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZVtTVzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZVtTVzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9031B1F000E9;
	Mon,  6 Jul 2026 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330890;
	bh=lJoV7mN+tOPWEEgWwlqKCMyeoG/BqxRd+4Ge//xmaVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZVtTVzwE1PAH3YSHG5vVNL1nKUQ8KM6jZmgtw5TJpxVeRhT0D5D5uJiQFHBZG36x
	 T7vMFpTGEgGiSLAibBgYeNV4xpnPgmFn3bFxOnvY/Ic42sJ9zEsoxgcSsWmJds8ORq
	 K6atO6A/v5yc0c3uhDMHxaFAGmxcZQzgqcshap4KMwKTdj/qBLtNOKmMDTBgDeTCd7
	 46BtdvGuHB5hFuDEJDa8U2bTZ13UD/RAHhZwl5Bc5zsQGaMWJ6Y/h9mViIQLfcocf5
	 nRVbkLXbDzoNv2ttoKqwrxpmfy9Ia4nlBEMSFzBBAtvyC9mzyzhx31MOmEuWCNWcHg
	 By8LhjCZXSMuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: sun6i: add sun60i-a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260706-a733-rtc-v4-2-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-2-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:41:29 +0000
Message-Id: <20260706094129.9031B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add a new rtc compatible for the sun60i-a733 SoC and new IDs for the
> peripheral oscillator clock gates of this SoC.
>=20
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D2

