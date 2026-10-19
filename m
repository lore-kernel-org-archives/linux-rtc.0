Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444965;
	b=X22ugu5uIf2qjnnT9a7XCIetVAu9Gd6miVNSKaYPFAphFPJ91d1FvdpQ1KboUckinaNB
	 QrJXokSuuhMs7EGw3N+SXTucbcMZklCZJKzTkYx/y04Ev+gUk/RYUsmaqKXW3NiUj4sSc
	 Y32a5fve+D9Pn7L/uWU27bX1G+nEo1889oGhJAODk4hH5byzo2WgAM/4pyug1QzvQUB9D
	 KGeCo4VYe/m+DfyGjqBbWS4Ke62otpdNPzkMmx20SVmp4xyAtkmp3hD0NCreM6bz8shw0
	 V+SPhQN4fUGsglFycapXbNUaZMKpsVL4mxSCITI1ftR+WXKB2RA2FYEhQFqp4k3Gy8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Grf75QqlgJA9a8GpEhvZjK2ZUQ7I+c1OgFK6+i5l8HM=;
	b=FzWFY7qJiDyfdI8zxcDKpTOb/DP8mKlpJK1r6n4bYrEH/Dson1l0I9LdTRo7g7iw5pNa
	 kMoCaXRXt2r/yvOGEJN/pEds/CgEY5Nb8uEz37Z1kiCI4HPFYfkY2uaoW5djkoxBzjBao
	 wwh0sD1GXMc0ai1DizRyli4JP1nu5mBBG/KIRUoDlfnpOqshYTulHkNZA9cQaHKSkzExi
	 FjNUm39Jhdm27LYaz3XAT0SX9BnpOtdzKHC+0Fr+mjdn0A1lzKmOxxBZ7uDGlONmOzjvO
	 Gnqfbeatt980IGmMtbc4RA9yfu32E/IgkkR+W9DV0qXsx5o8K8x+sUDpNu6403z1VnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVzoDu+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE0606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVzoDu+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CE1F000C9;
	Mon, 19 Oct 2026 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444964;
	bh=Grf75QqlgJA9a8GpEhvZjK2ZUQ7I+c1OgFK6+i5l8HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVzoDu+x5+fNPaoVzjuWg9gmxRy3XmOx2uwskEyIZ0UbeXMV8+N1Q88UGrh0xxcv/
	 8hQ8SKTIvEwaTWX46NqNqkJ6zawJivtAG5Y57II4MCo/6POOs0aZOr3e2AoMlf8ptF
	 Gz+ddoghcfJ6a14MVVLaaX/XuDFJXGagF0BgFATo4QA3lG9ZkECz9UjXeuJICWdOBO
	 f+KO0aV0ILn/rZZxCRuZBU37q1nJAoWe7UJSgQxLr2/+JlaJRvj5YBnjS02xQmntoc
	 gRi7dMQITKBtsB9TQ+rt19uG4cJvu9RAywq2bZv/4hVKKYvL8xte7yUyc3mu1duFzB
	 6ic9aJvdm2B9A==
Message-ID: <sashiko-outbox-178247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/19] rtc: stm32: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-18-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-18-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:44 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify locking
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D18

