Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AE356771;
	Wed, 22 Jul 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732250; cv=none; b=lsrnJKT4aMqwdMPH8okmI+yTPJnwD8RaAotDuMulWKc81PQkyaLA/pxawb3ibK/11/Jzs8e49yJ7FJysIVW301OUxEx0xwIuD0xPHZV1NzxVQCFHKOIwEOJ13vDlbaMtbB7Uy0cjVEP5KlIhpXJLCIMfkkQjyQ7hUeE1xSenmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732250; c=relaxed/simple;
	bh=5ubU7oCZsKsPufjcMhV+XeEP4jkIYjjRaOyPe96u9PE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XO1dRkIImdh1gG+FGd3OCPWPuhjoDbIQZFr8JWjrWAeO2NdeFsrCzre/XVLaNx0TsHKsE+yCEYIVGmJ7D83WYCchp91xN2C3ilKXDdzMgN19c2iAzUlCCkD4zlb7ney1uvV9Ny19Yq4iMhXImb3cfYhFGBAc+BTPG31sFiV2Prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+sfSwmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+sfSwmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C31F000E9;
	Wed, 22 Jul 2026 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732249;
	bh=5ubU7oCZsKsPufjcMhV+XeEP4jkIYjjRaOyPe96u9PE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+sfSwmSzcLSz5cq6UO33eRtjbzAca2rhYYYU5tzK8+TL6Np34wl6eBxaZ0EC6iEy
	 Z6/pBhih+9vxDLz65AWjK96hatN/W9rLKr5JYakA1IgIZVJKBvHwpswjAQ43Je7uU+
	 xV0plZvfWS7fVc/0Iq9V6KM4hdJatRpmcL9f07HToa55oWMznYfVmyg25NPf9pPjem
	 CLLbZsJCjL+KRmYaQnY+1KxTV/pzjyNw9hBvr5T6fEfuj4qYWfJiflC9Vd7kKTdsZN
	 YRqCYXx1FtmqstiEdXyqmI6xhXhuy4yFC/PcMfSsbRRLMIgSSwRj00YhNMW+D53gT5
	 jBSLNiyWLMn6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] clk: sunxi-ng: sun6i-rtc: add a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260722-a733-rtc-v6-4-631cca28cc9a@baylibre.com>
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
 <20260722-a733-rtc-v6-4-631cca28cc9a@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:57:28 +0000
Message-Id: <20260722145728.D73C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add support for the sun60i a733 CCU RTC.
>=20
> Compared to the a523, this SoC has a different input oscillator divider
> which auto-detects the oscillator rate and select a divider to provide
> a fixed 32768Hz clock. It also provides several phy reference clocks
> with dedicated clock gates.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-a733-rtc-v=
6-0-631cca28cc9a@baylibre.com?part=3D4

