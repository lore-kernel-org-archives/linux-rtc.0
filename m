Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915754;
	b=Po96gOlh0+PnZ6uqOd3a48b2yV0jTThI87HMYrtLYiUz6XIWUEQ64oyPJDVsciRmOt5O
	 QwNnDSaKKFnUHDbJ7dYMVw8z69wiNZd7HpazIOv0REHKHxaNawbiEKXNP07FUXYCwKpiY
	 5Rn3d4VBcz8j+C4um3CY6JptcRu6Y2JOYJl/xZF5+Xx5vh10vI3Bo+WjSQSH/B7Hy5Nde
	 VV6Tx2Kd55uRc2NTPlC6QLdUK5pVknQvFn8DjTcrEIwNXUyNN7e4c37Zd6K1tX2+aPBBk
	 1yQUTeOvdNw65wXWjk4dx12qGVgMcfntpSlQ8p6rXnG1NVipFq9GwFLGBGQVSOp5W8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M3kqTVswpF6gRsnTi4M7tKLTBY9ij1ts+EOfQSkFvWQ=;
	b=OMJh6gKIyDZ6pQ5Wi6kKAhc7m402uqdWTAbiL+8J08E40CcdPRhLQDI5XoWQj0HNw0d2
	 NKtJTnZXgmu7eXhqzFmAFa3HvpbgVybiW3E+gTHzYzAqVFjVw/4TnepUYxEeebUK32x/o
	 g22OvVXcjOIkZwRh/gRxeWp6FrbWlJ1zB252My4GWG6DE6im5yOsaSqWdoJ4kQLHUFqqR
	 jv428Nz8izcp1Wnm8cvurHfD2P5Q5FID6ku7HJJZbL3Sf3ew338D3H5Feh3Hp22K3xvcB
	 YP4NppJ9DkUv3Kii20fDfDKIqR1m3G+40T4aGKeUqhxKwPHE4Xhlqn55rwpW0WepLVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Asu9Qm2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A841606A31B
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Asu9Qm2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9571F1F008A1;
	Thu,  5 Nov 2026 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915753;
	bh=M3kqTVswpF6gRsnTi4M7tKLTBY9ij1ts+EOfQSkFvWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Asu9Qm2KwnEljpErKsKp39glkqlYXXrerFp5EAI9kh8zexoejOXR+dEVKxhD01N6S
	 pgbje7KZVlMNpJeFykIYdTI7dTF767ZP+LHKrzSWozWnn/S65uPyJv9uZaf5qxDFbC
	 ce/uveMlnNWgOGg5wZLILGYRq518O33p6IVNPCYlpW/r6LH05FQbDyrvE/iX+RNkBw
	 g+vt4PgLz4zvQhKuPpkRr/mvZgIiMzLd6kClNEZwxXqrVprfaitNl7t49bcrZhGhZB
	 6lAOkTErTaXWAly+GZV1yBuB0ffyiElHHxNcptjIOc/Y9B/0uzbgIh62LNbqi5jyKB
	 5Y5aMXoYKhZLw==
Message-ID: <sashiko-outbox-200278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: pcf85063: Add support for NXP PCA85074A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rodrigo Rea" <rodrigo.rea@marsrover.mx>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261105215204.2446733-3-rodrigo.rea@marsrover.mx>
References: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
 <20261105215204.2446733-3-rodrigo.rea@marsrover.mx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:55:53 +0000
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
> The PCA85074A uses the same register map as the PCA85073A, which
> already uses the PCF85063A configuration. Add I2C and OF match entries
> that reuse config_pcf85063a for the PCA85074A as well.
>=20
> Tested on i.MX91S and i.MX93 platforms.
>=20
> Link: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf
>=20
> Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105215204.2446=
733-1-rodrigo.rea@marsrover.mx?part=3D2

