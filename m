Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639255;
	b=CxAYCJbWFdcz8SlO5pTYw9Lo0vDbMM8FlaYUT4igpprayT1cctBSMhVn0l9AF42oskma
	 UZN4MEW/Eo7jxuu8DR+IIwpnqAfNTTe1m+u5sVC82KRadGnXNNaoST0Q4y6erA9vudfRJ
	 RiF37IAgLqJgDo1nHX1uP+sNs+YKKsvp08wh20kYLtKR23V2NKsg8b7U9kPFfcg9c5nDP
	 xUgwPVG92Qdld5d34Fs6hX/w0OYB2HdYro5EOESx/2WMfbA3dujJeEGVF8hP9fiVwCetD
	 oEVOzbbBwaouAANDXIxwQfy6fo6SrsA+DWCVL5uvIoZmjCtZeV2qs8fdxTUOf+ck1ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zt80XBXg1TwFWV+PcsV10M11dZBPCL8Hn5VMLb191Eo=;
	b=gS71i5To0g26fI0lgf3N9mLB5sT2O0xw8fpArQCMFCjL/5G5LVXjPHFVujBtIoJZMxNS
	 pvpAzpDs/7lGzk4ZoTeXI93C1VnqImx5uzL8Dh1ftHAlcn5S/PEVSYCpqHLE6R+TUiRlN
	 CmSDQHOVaAiINzs/q/xHvSaqz2lOSFoXYr6stgRnxQNVPl5pD7etbl+hbuLYoino9FLWs
	 Q/QqWuFocID75EeiR9hfLTpp6u2CGswQGAoC9+Foqj0IvcfkZP9fzJidkn2NnJiC3sC3u
	 2T/8oh33xfDurNMiE57YLenFaomoThVVn5T43Vvnz2zCFBayninxfm12nD1pCyWURPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8ZZXJie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BD606A905
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8ZZXJie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938921F00A1E;
	Mon,  2 Nov 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793639254;
	bh=zt80XBXg1TwFWV+PcsV10M11dZBPCL8Hn5VMLb191Eo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8ZZXJieAyqca9XViiue9+GZnEhxEtLPmNlE3l+7f/hsogLEc4C4QlbhKBZDCj80f
	 Q5l+bmxgHNThnL5Hj47CDqaKPbcZ45BDEiYkfepv2nvbOY2f8W8NGH4yVw4aVHUJVx
	 jeuLkD1Ss9VV2FxM6AFcAgVgtdTDCbkCUH0v2JbMZpuNL2OBnGR+QXsXHr26jRR92W
	 OxT3v1zMvFuv8zBje56dqcxEoZnK2TC2Kskr8hqZvYjFL395y1Il6d+yDUb5gXpYrP
	 5uXRbadjg4Ab5Kiq0JSg4sBfLl4GlhTD03r9JIKgsr16HUSpIYFeg4Z89BZQIgUTZj
	 RfM0cQqVKxvIQ==
Message-ID: <sashiko-outbox-193800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] firmware: raspberrypi: Add bcm2712 revD compatible
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Robinson" <pbrobinson@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261102170227.1719206-1-pbrobinson@gmail.com>
References: <20261102170227.1719206-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:07:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The bcm2712 revD doesn't contain the base SoC compatible of the revC
> because they're not fully compatible, we need to check both else we
> don't match for newer devices and the RTC doesn't get enumerated.
>=20
> Fixes: dba67294e2151 ("rtc: Add Raspberry Pi 5 RTC driver")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102170227.1719=
206-1-pbrobinson@gmail.com?part=3D1

