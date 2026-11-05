Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915976;
	b=CbxOmPkGMFPmPccaANZ9jGrnLmNGZQVI8jLUPoOqxbmWUW4YjxKCPkM5SGfVcNd+hU/l
	 jML4KGKlK3c9ocQPOEN+xq+DZcMAE0albVLXyvuwSQppN1bZN5B1/u0IOFURYj37xZ6xZ
	 l3wgNRfCWrrezsNUNL/jYqWCjzNk81bLnUFY1XPJeotaFMy5oUUHhOZl8m6LfpxtKe2dg
	 fZ6vMOPvN9NGReFE0N7jGbVGqg+BCmoK0blXZjAIRRvhVuJKzwPLH0XI1WSGP6L419TXV
	 rtHOlAR7UKxN6oAc3itNgiI1mRNzNIB1h6ju1SKkulBF6DAwI7Uw3Rs8jNvg1L3OvrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zvwBA5ZFrCqHodULKSEvgZv14yJ2CBlX4DtJ3W+aPik=;
	b=e99LHNgN0fVbss9LNv90yLGWGl4/p961zujNYBnTq7U7bwC6N3+/99J6PittjLq38Wti
	 Rj3L0FlcLfFGm43QalbjJ33eMkxXSDRUTtD1/ACUmvxKOFA1+DvaEKZ1Z2p5hxIQQ+2KP
	 I2nV4U+owNpmKyz5SD2Bn1KakNfCtaAPC8dhlbABK3DgEhL2uyoKUSzf0lTOXQUPae4hM
	 zcXL7T3+v0ROtEvdjgeB+IE+8CI6Rc4UDr6arftLvTgAplA7zd4Ccp7JYs7YgcNIbUROs
	 8cNwVeUHkPwU1ooJTsHw/BKfkD3OBwRQrjJO7yB0kKMoPYPk/FxsqgI6mnqCD/c164A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJkUpjZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FA606A326
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJkUpjZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50FE1F0089F;
	Thu,  5 Nov 2026 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915975;
	bh=zvwBA5ZFrCqHodULKSEvgZv14yJ2CBlX4DtJ3W+aPik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJkUpjZHY4PzaRF4aRerSnpbF4BoY9Avdz4K2xH7eojfTvJnckr+jT2afVC9TVZEn
	 BzjYs7D+FChaUFbs8z/n6wYwcje3a7TMoTnimU043bCFhnPb4QU0lgEDj+vfVAhnqH
	 cJZzM4L/BYS0hvOVVTuZxaLCsgjT/feFT/sFH0MN93SzORi64L+5YC7Op+TTAiRn6u
	 /FfDVvML6wMEUJ+Lc7pJ7ZKcAa/TF7M8cQxAKQc3kCtkuUDrltZdPUOL0AgirhSQtq
	 HRwf2nM+PYnK1Mf0JGr9borbGbbLo1hiXXRh+HQMR2iVUGizqPAZy2JB3XidurUSbw
	 IWOnrdP0TQFqw==
Message-ID: <sashiko-outbox-200285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rodrigo Rea" <rodrigo.rea@marsrover.mx>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>
References: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
 <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:59:35 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Rodrigo Rea <rodrigo.rea@nxp.com>
>=20
> Document the NXP PCA85074A real-time clock compatible.
>=20
> Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105215204.2446=
733-1-rodrigo.rea@marsrover.mx?part=3D1

