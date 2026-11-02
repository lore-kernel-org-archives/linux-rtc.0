Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586332;
	b=BnkzvCYuIDl4ULRRdJdk//8Ydk+Ynr8sIz7Pswx+EkWE8s+RJv3KUBZ9iOFdlDSNl6Fu
	 Y/EsEk9PrWlHksg7frGIsInAcj2Fwwe1ufHMypjd+V4wEZt0tmS1yRDWLENh1XJvn6VvZ
	 N5gjF1X/yI6zcNdLIJBToRhrrkz6CCVvstPTkchtRqeYD8doixOJ//VA96avbi5xPhs2X
	 H9E4lDFvdLW1rbvsbwtx8I9Rg2tKiwwQR9XRp1BCUiROcv1nuPyXbPuC9ZdWK58EbHKe4
	 DQf+uXXS0GIziLtNLz/SxEbUqSXUPBK16zC1hZljcyCkc6k7sQTpWnHUNg0fqtNmS7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8MJQT0a9mL4rKnl/ETGTvrqpAfc4h4Ih8SK4u45hoyc=;
	b=FYRoLZkKce4sdPtlsoyiXLNJ4LvJkcoJbbByoh6e/kcANesrs93gHcjP5dhw4GQzgcoN
	 6WHCkoHD9pRMmqAC+aPjHu9JvN6PYFcTvCt5nZ5AFR9/bvmxoLdnyuEh0zMY6xT52dJjQ
	 JbK96r7M9uaZCcCRTKxkuLoSqaqWHSXu9uKVncVflGonC/+humf8s3N91Bz3bG7ap5213
	 C56VuDlPZ3O2Tt7ut1s2//nSdrpDm4vTpFN+YHEynvHND5kxIAWfKPGkUVESxdOT5s/Ke
	 36Y5FZ395EcqrAaAwYUgYYVyzcqcL7CXa6mruKX1r5RkzdslcNdwhu759K4w3onuSUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxU7EMAv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC9606A324
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxU7EMAv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6496C1F000C1;
	Mon,  2 Nov 2026 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793586331;
	bh=8MJQT0a9mL4rKnl/ETGTvrqpAfc4h4Ih8SK4u45hoyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxU7EMAvGRw1vCkjPhx67uzfCOqUf2f2IYS567Rdl8Ths8HGKeD1Z+VA0U0C0wTNK
	 GT8WBBtecGT8dx8Bpgw2bZvQSZNslxJKaXi0fiVANXektxzOQYDDkvFmE4MYtOaIb2
	 dvtd875QipHso+EcfIikylzfULqT47OwfVwomdOCv738AfTJvS/yOqpmrCQ5hMbUsI
	 5ZFdjE12TLi+U8AIzqUQdigTw0TuWVgKRjG5DUf/cTooEO3k/bTFPRHFNzV65cDauJ
	 ruTt0Ib2/i1oORGZs7OTuu0P6X1Xhtjq96IwX8I3dQLc2f95SqM3jOIB++aEmmxTba
	 P+U5EJk5bEzKA==
Message-ID: <sashiko-outbox-192834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: gamecube: Fix supported time range in
 gamecube_rtc_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261102022110.206609-2-blum@kernel.org>
References: <20261102022110.206609-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 02:25:30 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> gamecube_rtc_read_time() adds the SRAM bias to the 32-bit RTC counter.
> However, gamecube_rtc_probe() sets the supported time range from 0 to
> U32_MAX without taking the bias into account.
>=20
> gamecube_rtc_set_time() subtracts the bias from the timestamp, and if
> the timestamp is smaller than the bias, the result is negative and wraps
> when passed to regmap_write(), storing the wrong time.
>=20
> Add the bias to the supported range to match gamecube_rtc_read_time()
> and gamecube_rtc_set_time(). Setting a time below the bias now returns
> -ERANGE. This also allows setting dates beyond the 2106 limit. Update
> the comment accordingly.
>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102022110.2066=
09-2-blum@kernel.org?part=3D1

