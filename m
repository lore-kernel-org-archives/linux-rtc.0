Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609412;
	b=kVqaCqBhFdvftOlho1phh8MjLBFzyUDUcDULqzeJNHYrG0EUbTn7omwJZF15E+phtS5d
	 sbex+J4pIiu+PkBMF1751/W2sDhJjojHhfFxnP4SzBiuWd38wr0oHkO4/Kh7rgHhl97iF
	 +iKBa0Q9FpVv/Nc2e3QBLN3lRxEIrl2qhZ5YEhleSrrc6eBpFwIQhnfxkffIu8fqEXZq4
	 US5dJtX92A8c7VJ10tJmvZNPDqAdtEbjV2npmwwULm2u5S1WucI2qSd0/m+NZYaHsNEF8
	 7llFe2LxR4Bz+JYINOsalTXIW1n+bY/IroYk7UeT8GA16HmrgXSiUrJW6FByFHi+VkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JAKH8VMmskaDqzcvn2sYSOYXWRbHAXcSgMnheK17mYU=;
	b=KhGd5wYoLnoQGR2aQ8PEAhhqu3Tiou2G9PwIVBLMHHdXG+xn16Icj2ocNqF+yZLgoSfl
	 nBGbkW6fg5ulAjWBKa5l7xI2vCGYLaS6uVKX10PQgS5Dp6LEFtllYoTpPkYlUNDG2FcaY
	 Z0E0dPjuoVcU3C769n5nx49/cf2y49Ew4VGAiOuFV3STZnPRe5rYHAG/tNoe7fP6Trx5L
	 wTuq5A3xOENpw+8sOo2ZKXcinLbYRtqpdmEBAWfVcRJl45gTNEO8CU+alLokc7P7Gy5A3
	 7Zz/du/AJfyAPP50SqhwjlO0UhOoqhPqJ/9u7YDOY6knteLndh70q5YpUTbsE9MwDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VP1t8/sP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F9606A551
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VP1t8/sP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502851F000C4;
	Fri, 13 Nov 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609412;
	bh=JAKH8VMmskaDqzcvn2sYSOYXWRbHAXcSgMnheK17mYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VP1t8/sPkLbRcdCJhLcJbCARUkNSXKiFdyZRsSsH7xrhQQqNHIS7V1rb9ktdT42jN
	 Z0Scl5R0DPpTEgyKBUsLPBjLsDNN6Cv6mgGj2/KmCXUCO5F3/uK2eNVu6tYyQ1iNB0
	 U83wzKRhcyXwBnxIwVINlYnUSFI9WTkU7EYk82L8a92ifkjxW/0BhQ3xXHxNFGYz0O
	 9qY5NXCEL1O0gJOs+fA1aLjxagCNQixpKCBXGfjHdbmCI1C93cKm+e0BFgyIB65wzq
	 Cjnx3wJfpg1AXH6TvU6HQIO0ezBizd3++xk+BTPeQvZnATasF68LathXwNlkASMw10
	 lGuMqGLeVNbUQ==
Message-ID: <sashiko-outbox-213822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/19] clk: sunxi-ng: sun6i-rtc: allow another 24 MHz to
 32k divider ratio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-10-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-10-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:36:51 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The fixed 24 MHz to 32 kHz divider does not divide by 750 on all
> variants. Allow the match data to override its multiplier and divider.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D10

