Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D044D022;
	Mon,  6 Jul 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331022; cv=none; b=UpiHFP/2G3LCsNq6TruZBTCFhGZZohwaGJkjRXCkbhinjt1KfZzbGqTCzJEyKfL9PBEpm+TSVfXb3cdkVKrJdhzC4c1dnKHlZsvwDUWz4o2DEZMUfPZFvdVSlxvrzjeayAFHvkeiXZZFHzqSLnMofM/V1zs9nMnJ8XwJ6Zz4a6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331022; c=relaxed/simple;
	bh=QUrNVelZjB6gfX6pLv5bcQ1wXb4sZSkUjHyYy5GNnO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHlC/PDdcTsGeC2Y+Tvm8yISAb7TZxGMZWPWDT8oopxAPf5b3sCx4FgBIt3n20hZr+oKG3CyR7BzeLEyVy3qXmrYAQAv/Ia9bFHU4Vq8Hp3wOkrdbaT9RORJoKHGepGAuSuPD99IDE21SQRco/XRaS3nv+j5He4MUgsJ2zc3gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl2vJMiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl2vJMiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B031F000E9;
	Mon,  6 Jul 2026 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331014;
	bh=QUrNVelZjB6gfX6pLv5bcQ1wXb4sZSkUjHyYy5GNnO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rl2vJMiG6jxO/opTDc75kFEe0BHFM9o38mHitIEG5ESTicnk9SwegZGDRQqeJcVzx
	 mje3N6N3PthTulEarFrBYuj9w4PigV924LDE0jeU7X25Qd+HxeJGqdsCOtkM7sSNtJ
	 9c7v1DK++afQkRBfxJMvE9SZ9/E8DpAm5VXDieXR+5v/Yj2RZwZu//FwV2V63t2k/r
	 U6OcsVmE+xqsIazOnguj+weVoZP6pS+Kc5OeMsHyrJ1dqGrgo0oZ/DTqY1b/Q9kTwc
	 sQ3H3IFg+WcsLqNbokZmH/MjBSQsqcvUyg0j5goaJCzxGFFZvotEWuAF/XiQ4XiOiN
	 SRXindJDZb6wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] clk: sunxi-ng: fix ccu probe clock unregister on
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
In-Reply-To: <20260706-a733-rtc-v4-3-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-3-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:43:33 +0000
Message-Id: <20260706094334.78B031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> When registering clocks with sunxi_ccu_probe(), the number of ccu_clocks
> and the number of hw clocks might be different, eventhough they usually a=
re
> the same.
>=20
> If they are different, it could lead to out-of-bound access or registered
> clock left behind on error.
>=20
> Use a different variable when iterating on hw clocks so every registered
> clock, and only those, gets unregistered on error.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260629131254.7E34C1F00A3A@smtp.kernel=
.org
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D3

