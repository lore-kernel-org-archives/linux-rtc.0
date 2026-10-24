Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840059;
	b=0IrLGr4WlKFiw0L9eYnVEf+d8VMwZPZ/5OAdpGUVXnCPNEHFnjYdQfdhgQWlMh5MsZub
	 +z1TAlz6B/wPdfHNiPod6k+PYLw6Ds3tvcZEk1uK01PAhSvr+kQTYVkmeqCalYnM/n4Ip
	 nU3K/4tMs6ulooxxnVWSxM0J5Kha6qs0HtGVCMyUdbV0TLjf8PjLbUGAMKZgsZ1jDrqCo
	 0116gvSkJb8ZlYwPfX/BRjPdkZPyFe6dJon+xLvZTxA33YW8JcFaWiZnomuDKCx0H8CgB
	 AU1Oni3G+WdV2gkc9W1oVkXQhyHbIpl6UNU2ASihREuwvDRZ0P0hjJDkY6nOmqfB5+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+JlZOX9OOdAW6qM3ywIrGsBrT5lcn8Ow0XAew1p3MRY=;
	b=Ep3/JIbg8D05akS5tqHWTlmkWrBXuE+Qj2QlQngGIvDhfF5awhKXu4TqIztqZ+GaUZT8
	 Oo0QHNe41/oyd47TNRgrrrtZ1NP+0SnUDc+G3j1Lac5qbbBJ+Eqe7+op/CkXjuAOsb4TW
	 +j7UrN8BWUMyRh99mZi7RaDyQcDEqn9mQyTAKIS7b9nRRF2Y7nW7+Qqj8r5k+2nVgWMkP
	 a4gKKzUfyHT1lnp8FFqdr1TLhUfMtpFtrEFVmsZzMaolHW+pVeZVFYuGYJukFlKqNPu1g
	 XAU91PpqANeYrMjYMyPeSOE7E1PqzFy80S+3v8FQG5ZN3UwZMQTnxz612ApdhDE2VUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RE20HDiz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93658606A31A
	for <linux-rtc@vger.kernel.org>; Sat, 24 Oct 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RE20HDiz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49411F01825;
	Sat, 24 Oct 2026 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840059;
	bh=+JlZOX9OOdAW6qM3ywIrGsBrT5lcn8Ow0XAew1p3MRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RE20HDizbmLaugq+5kVqhBe+Axo7dMEqLLp4WAO7ID34r0U0yExv96nb2j7BDYguM
	 /Ui/CHYUwMDC3pfu/j9enBQVq7UtihpPrMeTREsg0VwyLR/rD8k+2u+BY2nfG0KVtA
	 hzDMiHCGnGROkVjRfySv44WGbG9YSuCRm2ut0gXsTpH9F4FQgkZHSae8DU0IdQxExQ
	 2U2xSjo1WgMZNpOWphrsw8O88113MbGlJRXylTEXOQKIKFhMGgVhXUBIyVSzxecVh/
	 Om0xAQcUkH3ziDfMgqT3JQKIbsdHVLo0cB7Wh+HQYls8lsA5mKV/VqrpFQVIi5H7j/
	 MWlqwbHJjPQpA==
Message-ID: <sashiko-outbox-183674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] dt-bindings: rtc: Add pcf85053 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
References: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:07:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Add device tree bindings for NXP PCF85053 RTC chip.
>=20
> Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024110437.2851=
275-1-lakshay.piplani@nxp.com?part=3D1

