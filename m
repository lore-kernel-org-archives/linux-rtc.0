Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC135AC0E
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335766; cv=none; b=YqA/L1ZG7zEEGNO32zmLxhKFSNlal9BdGhkbXVK3CjIn5xtkqkcpup+e+VyKGhovOILn7wNelbS7bjIlrWUFawbJxnxXAkJwBcxEOg7tFVnny5bJbjVtNVDH4+q3BeFNOPqLrvbEII6pVx8zsltn72WNoJhjhpZNcFb4UFMphZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335766; c=relaxed/simple;
	bh=uWvwBrcv81DxHYmdQM3GhMVk9yWDjSpJhFETQl03bs8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mmiBjnL9I7CYfUL11AsrdSmKSy2mYlr0NJ1SRmVgDk83FsAQi0w0uG66dlTf2EyHuYLdl5VXSgeZcmWSneYQd50MNZD8cBErXZ3j1L0W5ALXZgz4v54WzcAhJL4AH6FoWqc3/qnMdVeEgE4U4LYcTVKtcg5J0obGG6z2VZDFsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h91GpxcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h91GpxcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0341F000C4;
	Sun, 18 Oct 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792335765;
	bh=uWvwBrcv81DxHYmdQM3GhMVk9yWDjSpJhFETQl03bs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h91GpxcKvjBpkQGGYIBcpAySG0fRysnsXEOn/23tFQ/kSx1C1r4j1vm19QuVDw0ww
	 Qk+H+Dt8frSyj3jb1FF3bWCsOx+K9h0+pfrso/03KopDgiyvO7uEfqgEhQvy/y032C
	 GISdx9G8ksEu2uOp/UwaQLkfu65MGZmUvdb1W/ddCoinpeOHjFzI8GKDRINxuP89uO
	 m4jq+Vlww9GiIN3wDlsWsEX+0fqh8/SDXQswfjLbwJI2U2hGzIHaa1QlUGHkRLZa7U
	 KfSgg5kOnCi9Eos7PbMfOtJblQ0XF7s5fUJMBryWxpworRSvXvpAoCAd5k+Z7ck495
	 kOnXXDVhDQiQA==
Message-ID: <sashiko-outbox-176227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018150028.1047172-2-sander.speetjens@gmail.com>
References: <20261018150028.1047172-1-sander.speetjens@gmail.com>
 <20261018150028.1047172-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:02:44 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The trickle-voltage-millivolt property had no associated type.
> -millivolt is not a default property unit suffix, so the schema does
> not automatically infer uint32. Explicitly reference the uint32
> definition so the type is correctly declared.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018150028.1047=
172-1-sander.speetjens@gmail.com?part=3D1

