Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444946;
	b=JSgyvq72TqR4e9onh49u90lJansDbzC0v/VZUk+7ee9zjpcZ9aupsFSRt+RzTFCDNHIB
	 65Ci0AoGGWqEMSvgO0zFCi+ks9L4tsijKeoVRp+ye5oKmdo04cwPdkcWrwWExVvnW039b
	 MBcXbJ79WJqiPQ19UtQKAEQSHPtihe5nAvt2Tlv0WV+agMbvdN8QtMGJJLUjUb7dUdE1M
	 4lyPAJK8arU4HM+3MaOexBU8KdQi1FjY4cn5gZl3zrml/bMCO2q5Bjch9VlFDdZJrVROo
	 0FbY1Tnt5TXID4XkidIzrAwDGfNvXR2oRrqj1oXxfMUcJ7fsd9U26qoschoxV/0j0Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aTyK7IvFX/X21m++ku1Q/LX/eZp6v0fPf84xSAoGnnU=;
	b=VoqaD+QQLO67YS8hu4MjM+KFfoqiLT1UNWdBv6pFit2/ruGNlyPJumPoVpkruwtJaw/U
	 8jH+AImmf1GIaGR0tmhSrIcbIQ0WMzK81ukQnxbQuFcTg/8hJmSL0OiGXytd0XhCYJLt0
	 1HbGSqOc6GnEo949ubSW4BDyoXAOzkAoPwH/MUnkRgu2ywp40DPBXcuJkFr26GxcYza0k
	 k2QCpIxXZF0pRdVkMF2LY+VEOOP4Z03xS1fhAE1HqKoTKiah0O1KNCLZgflOVMX6YsmMs
	 /EOAKvDWli5u4uMSiJjO4Ii+/ARMhTK9gaBWW+v0BI5l5T4Vb/eYWQnw0Ki2Vpfuj+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXM2cSAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D936606A319
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXM2cSAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8971F000C4;
	Mon, 19 Oct 2026 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444946;
	bh=aTyK7IvFX/X21m++ku1Q/LX/eZp6v0fPf84xSAoGnnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXM2cSAMjRiKvg2CO8Iw6fMwH7BwB7ckFTEGwYK+F7XjSIECQ9x0dYPl6ylzUvK/b
	 WGdpy1uRy5V+TngXgwoEWFf3mRp0LnQUrK7kEizAV+FIG4EWanyxE/wuEIsBeiZ2eK
	 /dLbAbfNnrPNWfsp8rv7Qf9ytSgtDklNT8dbT44EvECsL6/L2Or15bEIwGCEVdHf82
	 2zNnzmp7hW6uzqnlJ/zriPhj1OYQDB2qScr3cNLhz+F3lVvY0sgFa/YH4a+7KdWsyW
	 dC0v9QnMfldx/Opxzppox4ssmuaH0mqwIRFL649LMCoYcY3jZjQ6QOdobdeS9FBsPH
	 3pd+5q5Kco3qQ==
Message-ID: <sashiko-outbox-178241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/19] rtc: ds3232: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-9-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-9-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:25 +0000
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
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D9

