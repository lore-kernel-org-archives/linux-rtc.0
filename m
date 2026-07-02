Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469B4229D5;
	Thu,  2 Jul 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980255; cv=none; b=cAIvsZc0OUKICz7MxHrQ/lxu2v8IBHmsE/nXOBNnvLoEy03FximXrLr8zfkCJzS7ZqduR5WRVl3nopDPSeAFOgXfKbyZb4qVqL5wu/lk+LwGx3POOHOmf4e3h9kMWDqnfrbZ1iWK3fBRlWox5nF4aULUYTt1p1VWb682TSKTg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980255; c=relaxed/simple;
	bh=8D5LSqK+z2f3VLsg3f1FFeEXv/A53X9q9TKyhu0IynQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j6cJdo5wu+1ovMYcuonGwNOvxOZaPtGhmc9epVdes45V7h6GOb8KzLri8qkSkhS/slWfBu8/OV0vH/HWQPGMRq8rOnP9+A17Rj7klaqNWh7CSj3LcLiZ9ugQ0TduZN7tTIOfZyR7i2AwVk+oDCiBTqy1GTzC0xaPx4KrBI4+9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF9F1OzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF9F1OzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B0F1F000E9;
	Thu,  2 Jul 2026 08:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980254;
	bh=8D5LSqK+z2f3VLsg3f1FFeEXv/A53X9q9TKyhu0IynQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OF9F1OzLm9tFSQBMtHEzib5UEousNKQqu4XbgGkCTKg3Ew42fjiK19sOhqw6aDmVq
	 BrksV4ewNFHH868HSzIeTy/6Esf3UzwvZ06n71UQqGMemZVa/TGaOMmBxKLULCUMuf
	 X++jLtP9I46sVXnJYDD7hMgaCdtcHL/X1a/Zht0H/lzjJf+ShBv4h83HlqvQKYah1M
	 BMAiWk/4GDD0J+79BrXNqbk1aV6Y9imYkKeEF3KJJfqMNd3dnkubgpckmvv+4Fxn5c
	 eW0dmoUG3RkAjshp4yFL7kBiLHdbMCINcyE5BtAgZ0cxgk2bJaWuQqi1Z/2+Qu10Fz
	 NKkBfG0noWqDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: rtc: sun6i: no clock-output-names
 on h616/r329
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:17:33 +0000
Message-Id: <20260702081733.B2B0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On h616 and r329 chips, clock output names are never defined through DT a=
nd
> are not meant to be. Just disallow the property for those chips.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: http://lore.kernel.org/r/20260629125305.0DF981F000E9@smtp.kernel.=
org
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D1

