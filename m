Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609454;
	b=DrZRdNw8Ls257RLa1tniyvGS/L4oSMX3KOir7jb3eEtFX2mXp2RS9o/nyT5bWHwSXkia
	 K76nbRVFHeqMswgCWIQYQIJLZ9X2bWJB0ZyQ/m9TKBp1yZl2ugPAf09gIrD/PpcflIP5D
	 agSYmZy6AL3NPhZy0qv8REKAEMQeNsB6aJPPSV4us6swFJ2H0AUxCYt8Z4bcHGS9PoVMc
	 VK5Ca2L7Pc8Hn9YIQDTq8tEuiQfkmfhzm6ogs3OmhDm2hxInSvQrTFhbfZKyf2Gdt0jpd
	 Ck4IslaKU9y8LSBDqTEKInQRjEIEShSKBYkK4aiAgiWH5Ap9mTFDtVzx9Zd3+YVftqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6u0JSIcCS7cG+WZMjnrobx2B7F282oTgrzfP1Sf7FlE=;
	b=pArP6JIBQFuASE7oA5zw5kadzvtQOHfmRKnslIWi1IZhDQIwGbao/W+/mGflKWHEJZDd
	 mJlWttXHhQ4DUrsQFigAwdXhW2jfwk4zO5V1RUlgUNXxVThQW0xNTf0A2d2PbAbGurdeP
	 llGjHb0UEgjex10+4ZL8/4HPTWpNJMZSxFJqeB0WBLst6jsqLfOxEhsFNwgORrNtLV6fp
	 VM1wHb6najRRcX8oWbFyHaUQ63gcdMtv8+DqqHIU77rPYzV3bDZh9g/Bm8N2ab+c8Hsa2
	 YBCnRVAsXrcBqe30xvX9YlVDWdbYlyH9SUx1FzPdnvpgPhJAhu+dMdZ0CgjJH2PKg/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9klMMW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0F606A54A
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9klMMW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31711F000C4;
	Fri, 13 Nov 2026 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609454;
	bh=6u0JSIcCS7cG+WZMjnrobx2B7F282oTgrzfP1Sf7FlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PV9klMMWC2fPpdP3+Ht0lEbJTa7hOxT11TpYpcZBuG7i4l5ApCCC/UImGnHeY3rHK
	 XavLaaLOPEhgbyTjf5jab9Pjufn+gHqjPE57tYjKuee/s3+SCIamguqAF0Bxzy0imI
	 JboObt1BMljdybtTotkHNx1+NxB1l6/cHNmJ9qId2EPpy747qC6wX45Gt2Xehh1pC5
	 E59wOJZUKG1teWPS96BXEVNzBZ5SLDHK4KTo+7T6eX8AEXaEKuuadBhicVl2C/Fjec
	 yNZp7q7gtdc64Mz6zwmYA/tyMht4NbmvGyS5e1gbsRmY6v1l28Swdzy7WLUI53kMea
	 MONM4EEv5a4Ww==
Message-ID: <sashiko-outbox-213824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/19] dt-bindings: rtc: sun6i: add the Allwinner V861
 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-8-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-8-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:37:33 +0000
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
> The V861 RTC is compatible with the R329 one. Add a compatible with the
> R329 one as fallback.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D8

