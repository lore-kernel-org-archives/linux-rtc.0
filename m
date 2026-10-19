Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444997;
	b=29Vhg5pApQFHj7AgznTamVPjOOaBIPjJU9xOzQ2pg3lQwYxpFiZz3QcRhvDCoAIoQfEr
	 cn0VcFZn1qC5H6295HV23oyOk2b85l+RMdzxvVtlqPUEw9/TgAbxVi6kCJn8OzEo7b3ey
	 1eNC41CdJuJUI5R4AYtARDet+hs1bQFeJZVTF8Zddb3a5xQHfr6zOwK47AS6ew/bxaHOy
	 QsyA4hWXnCIVE5+D2/F21SCW4BjBDJUFLs0dsxKTAHxedPvwbsZ4qIXvCRi4QuobkBOHx
	 RTItrjkM0+ZWM/gNwfnLgzyllprVPSC24PloUSQXNa0pLfnteKRp5mWxqqiDc4oQTow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AEV75SmyeVUUmph0vrdjT5L0CsYkpjfEBfbuwyPqkxM=;
	b=t16ySCzcQ0p7Cs2KWxXqg9Db8iwQLL9hrfrG+Dqtftz2YniVRuWtnTMYkL7HtzYwJkWE
	 tRpQ9yRYZXxoK3mbdzowsENARAKHwL39PfkFtwn9FMZdloYqVLR2pSy8LG2anoOEhBpbN
	 3fEUBUtmUPMY4pdXfoS5zxydzO73IdRjYf3/bgDIhEC0BFT7XhCbNiotz6euJudg3o5Uq
	 es2YjeKlSDg4BqgZlcjC8oXUdcM64sCNiiN4IqfiSDr2aVevs8beeEqksuQtajsKbGVk8
	 mSk9TlV3grL/ml0WktDbgQHdz5dlrHgXr+cM27fwKqvkAmNbCOomnF+9abti/P3WfmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mc/fRDPW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23977606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mc/fRDPW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5431F000CE;
	Mon, 19 Oct 2026 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444996;
	bh=AEV75SmyeVUUmph0vrdjT5L0CsYkpjfEBfbuwyPqkxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mc/fRDPWN8BCe1RO+1LJH2nHCAgAesMY7BFeSXSz+Ps218rTH3aS/Jk1xzfMeqa2L
	 snED/w1YbyD0Scph7RkMdsSTN7kRakBjM+tUvK/KroC0ikvdLciAAA66BDYTbybL4u
	 I4TPhTDiX6ZeXVOnU2XTsOfCJxb02Z+jrwCxNzWniIKyibqOjeq/U6SiV3ZqosMmqd
	 s+DApvaHHd/npbsPrb0yzTLLENqI69rF1QTmpBz2x3kdYkzMrrJl1rQXo7gcSo96Yj
	 S9hXCZSRGJBxoANr56COWZK5/C/ORacwzoYtqpRb6gieVY6k9Rq29+7dFhuyQTYkG7
	 +NuBuNDL4+uwA==
Message-ID: <sashiko-outbox-178249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/19] rtc: ds1305: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-5-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:23:16 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D5

