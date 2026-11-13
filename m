Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609749;
	b=ghorZmtfmvTiCRvwWMUTsD+nKa5Cy3EQgAwx+ftR6bKVKZAL2R2uynsnsP1KhIL9Bq7X
	 SYR22THH7ZqeipFxByRBrzGssrGP0VHOZSclPnBpbPP+pPSwAiEHEMsBVnfNXovWQ797e
	 A1nmIS9zto5Yzvl4YPCCGx6sRoD1k6wzb8asDZWpWMMiKIH05P1E2+1vNZlFM+s+MlTEz
	 SoFjRQNDhJc+2U2/PIm5QSfB9LTzHIE1361hHEz54fllme8c73cGWXPUMtXeT3xra8/q2
	 E9ueXrzyTO8vxPGlUsiKAEIPgczBqWNaqGWHnxphDACe7cwkQz4mS7bXnATQvSWN4Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y/MN5nyARerMBWYnG1SJ+IQ/k9yZwzR+lW7a3u12EEw=;
	b=ZING9XtiTsFtN5Z9RuAnok1htIIPy2I6PYisgCjiiIagQuFKGeq4SthdB9LHzAn7BSCM
	 szwoT8jXRZNVXxFY2FCwF441EE6+dQBZNr3sMeNOMRimMBsrIB4QtXRIXqexJt22OMySE
	 gBGwoMgsTzv2qiR3JDiEFpH2X+JggZbn5CX0NU6qLnLr9OgqlzEP09a+UmQ2JIMNOCPiH
	 xjOfiFqAmM3GTxoY9bK3VMmy7kxTYYwa+QU2l2iAmKZ591w9rC8bM01DrguyVLek9d7Lx
	 Mzo9fTbv1Ai0lqylCfm38JS/HZftpFdlyW4sVSjDV/Rn3iulYX5GmYtwVMmXdxHt49g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNhYkVB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78836606A33D
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNhYkVB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3F31F000C4;
	Fri, 13 Nov 2026 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609749;
	bh=y/MN5nyARerMBWYnG1SJ+IQ/k9yZwzR+lW7a3u12EEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNhYkVB6JGwvXLVEJNhqAQsxJNk9q+p/zj5vocpxlLY1058mvHXLNJ73saUjU32Da
	 bAuDYuQnX5UEgHuMd7xyrws1AhQAu3g55Nf/b++PVVRQWYxkh4f0gXJRJsA+QDkr6j
	 1hCzfMsalT/YapqDqvKJ0i1TIzvJ7u1xtA4e0ooKktcmViWkLSEGMQzwhdwPzEljmJ
	 52vo+D2C3KuOILKMjTBELlgkva4oKBro/z2N3SNjPtzrCklj96HWVsoIVYDME3dh6g
	 LDWdyCOW5bSoWGdJ0ECJieijMzhvptRa0SOEb59PKuiNSAoKO6pUdr/vyzhKl8UP3Q
	 MTpCHuazTH95w==
Message-ID: <sashiko-outbox-213837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/19] pinctrl: sunxi: add support for the Allwinner
 V861 PIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-14-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-14-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:42:28 +0000
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
> Add the V861 main pin controller driver, using the DT based function
> tables.
>=20
> The 1.8 V mode of bank PF is not supported, as none of the existing I/O
> bias variants handles its control register.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D14

