Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E83F54DD;
	Thu, 23 Jul 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800183; cv=none; b=HmMa0R9hOHVyqfmHOBFMiP6z1oB/wok6OYtX6RgAMX0oBWL6/sWfsn6jYzfb0wKXLmZp9ftaH8qT1nelMyJkxzYADcdFMRjEcqHNDmnQLrEuRH0qjrcyAdVdUIeAFn4WpLiB7Pt2oGoKtkfJZnJRv6eXd2J+C3jb/3qdXcznVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800183; c=relaxed/simple;
	bh=bx2SlZSANi5rNdNFueAm5pRcCOpXCQHDFIlIL/lTm28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X6BSeGvVoUC3eiroEibRv3u/97J8S1vUCBznab0aTt4W5DZowzWOpSt8XtGZgrkHtJZ1xPyrk18516LBcmSb9fU7EuU1aeKBxyV97G6DS8mf1o7EzqW414gwC/3kS6S8dcwsHMhC3bRfZiA7kXJyFKLxnT7/LZ8mUhYzQmpaze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSPgoSaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSPgoSaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0691F000E9;
	Thu, 23 Jul 2026 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800181;
	bh=bx2SlZSANi5rNdNFueAm5pRcCOpXCQHDFIlIL/lTm28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSPgoSaAE9yhxZlGjIqykB6ih4kdkCd6J50ywuSI+Gs5skwCYIGnSG1JAq30vBRXk
	 jdWkdZJjhfPseJT3hoUB6c3/1Y6ZnScH6YnB67egEYPqNOoPwX8JEjrHKhhqQUlI7d
	 LjKSkjXiUwcs5ocbMCpEsVU0hC4G07x/s2YydZw/5Q+GYOl016wgcFIM8FUF7Q3w76
	 USDWCcxWYGY/HRsNqPHd4FbqCk+yMwn+NFRxazs5mfkbCh5379eeYSyjExUQdTqMGp
	 1JdeDvVZOXbuyxrm2Z6rdX4Bxoqy+ngBuKEFhzW5R9IhZFw1FXcXIzmSYZEW6hKlRV
	 YdYQhL56nmulg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator
 div and gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260723-a733-rtc-v7-3-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
 <20260723-a733-rtc-v7-3-8fd68aab94ae@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:49:39 +0000
Message-Id: <20260723094941.1F0691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On the a733 the "osc24M-32k" clock has the same gate bits as the previous=
ly
> supported SoC but a different divider implementation.
>=20
> Instead of a fixed 750 divider, the divider is selected based on the
> rate of the oscillator. It can be seen as a simple read-only divider.
>=20
> On the A733 the gate and the divider are on different register which is
> not supported by sunxi combined clocks. These element will be split on the
> A733. Split them for the older SoC as well to keep on sharing the gate
> definition.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-a733-rtc-v=
7-0-8fd68aab94ae@baylibre.com?part=3D3

