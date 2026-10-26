Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010176;
	b=dOLZEIUlP4PbAuzrlwhhA3lER6VJ87r9mq/m4+AWu2KkZg+Hb2ez2zDWKpBe5JwVKPsV
	 saygg8FVoF5BHewbR1PMKSfns3UDuKjMiD8YIwtTbfB44JF1aoGPy6QMnlLTpm2XtwYhF
	 SwqMGQOTyxNDavqwkjeT3w6EE59p8EfpEU+SQEBKhABtzyqckD8mXfhBxHomacBo67Bri
	 bVyy+3LNaB7EhhZew0W2//MKeawhsH6SOQdLEbT96CQnz1sJJU6Mb7c+tQp7vTsyMFqza
	 i0JIInEqRCUt6XLuEvhSoKwvPKl78MDOoaRayvDmaaDl9wxn2gMxAYtvr6FmKvwH+SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MboplDwjGOzC77YsbmzFgFdC0v9eQoBAmteB0TlL/mc=;
	b=tXxUGvjwvjwrwgMEbwXXLgF95vvLMeeii+cv34nOURlpPSpNAHoF23tO7qlEBuIvFgIw
	 x8W8q567ckXpQJVzl5VmtZ9EpEsqyVt4Xv7SmM0LD/XDJ5PAL6XN7SrwLpfrBmrs3p5zI
	 ItqoKZ2pLp3GW2Z3SEk2fZys+bhEO2NyBrJEwoIdvSxdXcLabFPjz1zh3A8ej3cD08ZZH
	 E9khjhKzkrn+NUdvgVEOH5AWBZnSdtl1fcjRbX29uhlhfQ/7WCzniToL0FFKZkpw1TUeA
	 +foAbrPyQ9Ad7x8SEcfi2Rmw6sbKzHTF/C4t3dKZzd0CAqW5qcmPizlKtWVw/e6litQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlezXwT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36371606A328
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlezXwT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994021F031E2;
	Mon, 26 Oct 2026 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010175;
	bh=MboplDwjGOzC77YsbmzFgFdC0v9eQoBAmteB0TlL/mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlezXwT6SfvHfxCdpYuKHynbJqxj3N74VSDtEowtKqLSU1t5hb3pLobLKRs3lHEW0
	 XSAySXdX1eJRP41GICn/V539UNJtcHvS9ytpKbstc7Dcx/dJFxk9plrbOaHLZP8mqc
	 2RD+rApW57xHXKebwCaBvfIP51EFVAlMeTgbjYeqvS3Nqj4fOh4wHbknK5f2S373I4
	 6lPDIlisAxNz8PAkbqYXEBGXJVtbzUNuWMBSGEO0Sh26fenOQSAsUjzl/ndmJAFmIo
	 Oz4WDST/jyDYQlgfb1RBgjtU6tKVKn9A22OhEia7tpObrvADP7QYoQQwtvuC8BPP0I
	 SIIvQQiY0roAA==
Message-ID: <sashiko-outbox-184931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp
 mode config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026094712.205214-1-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:22:55 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> NXP PCF85263/PCF85363 provides three timestamp registers (TSR1-TSR3)
> which latch the current time when a selected event occurs. Add a
> vendor specific property, nxp,timestamp-mode, to select the event
> source for each register.
>=20
> Also introduce a new header 'pcf85363-tsr.h' to expose
> macros for timestamp mode fields, improving readability
> of device tree file.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026094712.2052=
14-1-lakshay.piplani@nxp.com?part=3D1

