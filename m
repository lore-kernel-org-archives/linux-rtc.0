Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638687;
	b=bAkLrv8o53e3ldicOnxzygVgJ/koll++kOVytmTeDzR3ac/CKMPiLtOuP8ImSkHImjGg
	 ap0iE0Rivbz5zYfMqDrgHf1iCIPXJRYdwyZC7eZNJMkMaBHbH3gntYzKU0kItNdjZUIOH
	 wq+ijoCC6IrlYKiqRaCUDf+lW5Droq3Dvs+6NFESwyKDzOEedvgQdftq/1JJ/fBIc7MGR
	 GKOKrFvpaGc7s/uG112Odc50JB2fXVGXyiexTa7ppiUbFP9JvQq+vOaHzqH18LpANtCnH
	 W0sJ5VaQ/Lzr9oc2BTyFjFEWLaCU4SnanJaZ+9flH85syDYWn6FOvbidmKmmcmVj6qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k71NgeXMbmWzsNPppqTrWctMJw9jc+AbxLtS9JlwlKk=;
	b=Qeq+GBLlPcTqKBBgVtONt7Ge4AZnTg1rTjWaGwTMOYoDkle7aXyU8J2Q/Qq4ipjmnF/A
	 r6jcV2P4JgYqzZy6rfN/2dbnttUiz4Z0Z5J8SD0Pm9fYboYj1rdh+e8o4paZ2VGZ7KUWo
	 pHBffykaIx94hWn23EeaokRpP0xZkp5X00IYPfCrv6LUIBV5ojcL5AhoHuLtBo5sZ7+Rb
	 Ji9cLN7m5n/aIsIL/N5ves3lkYL4F4YH3HOczHuxhXkZHNuZkFrRvUhRVGqKoWrU7vmZR
	 oTX1qW5ZIxrXyT8bggmf7m+K7NOjQDP69+Da8OnYaw0AIlhcA9cMQwbCtQ0Ku1LlS+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oTP4J/Ta";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F0607B47A;
	Mon,  2 Nov 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTP4J/Ta
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6681C1F01804;
	Mon,  2 Nov 2026 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793638686;
	bh=k71NgeXMbmWzsNPppqTrWctMJw9jc+AbxLtS9JlwlKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTP4J/Tazl2rNy4TZ9b2mXGYJNQK3lyawdSi6Al7d+jVihcGy5q+lldhquQlrsF7v
	 xGYTCZyy66sxWxaGWy/UfK+cpZVDSocPocIonxCGxpjiUryj+CkSEz73Ghi3ox4pZU
	 QfPRlt+YvVi8um1B3G4wlWDbCiJNuM+QclPTNBpVq6JoX22qPZrpk5sJN7ASMHv+wT
	 YO4LkApEg6cnp2dTk+3l2eA9IKxgbJ5+VpPz+2IKTZJhlk6pR1lIKNLC6QepjzPDHI
	 DNaafmLxNK/LRVJuey5c6NoGi+Uwz3dEQK4sHFGouSlzWxigSuWwMYgUVFe6LNOqUV
	 BWcxCb9p+iW3Q==
Message-ID: <sashiko-outbox-193787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's 32 kHz output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-1-19ca72815374@gmail.com>
References: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
 <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-1-19ca72815374@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:58:05 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
> use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
> is off unless something turns it on.
>=20
> Let the RTC node provide it as a clock.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com?part=3D1

